"""
Экспорт полного снапшота расписания для внешнего сервиса-витрины (сервис B).

Одна версия расписания == одна ЗАВЕРШЕННАЯ заявка на парсинг
(parser_meta.requests.req_id со статусом FINISHED в parser_meta.status).
Строки расписания на каждый день помечены версией через sc_rasp18.time_ver
(время регистрации заявки в секундах с EPOCH).

Все данные снапшота читаются в ОДНОЙ read-only транзакции (REPEATABLE READ),
то есть в одном снимке БД, без побочных эффектов.

ВАЖНО про области видимости версии:
    - sc_rasp18 и зависимые от нее таблицы отфильтрованы ПО ВЕРСИИ (time_ver);
    - sc_rasp7* (недельный шаблон) и sc_rasp18_days версией НЕ помечаются
      (колонку time_ver в sc_rasp7 перестали заполнять, в init.sql ее нет вовсе),
      поэтому они отдаются ПО СЕМЕСТРУ (semcode) целиком;
    - справочники отдаются целиком.
"""

from dataclasses import dataclass
from dataclasses import field

from datetime import date
from datetime import datetime
from datetime import time as dtime
from datetime import timezone

from decimal import Decimal

import re

from psycopg2 import connect

from src.db_class import Database

# схема, в которой лежат таблицы расписания
SCHEMA = "public"

# таблицы недельного шаблона расписания (пары по четным/нечетным неделям)
WEEKLY_TABLES = (
    "sc_rasp7",
    "sc_rasp7_groups",
    "sc_rasp7_preps",
    "sc_rasp7_rooms",
)

# таблицы развернутого расписания на каждый день семестра
DAILY_TABLES = (
    "sc_rasp18_days",
    "sc_rasp18",
    "sc_rasp18_groups",
    "sc_rasp18_preps",
    "sc_rasp18_rooms",
    "sc_rasp18_info",
    "sc_rasp18_move",
)

# справочники, общие для обоих представлений
REFERENCE_TABLES = (
    "sc_department",
    "sc_disc",
    "sc_group",
    "sc_prep",
    "sc_worktypes",
)

# колонки, которыми дочерние таблицы ссылаются на строку расписания
RASP18_PARENT_COLUMNS = ("rasp18_id", "rasp18_dest_id", "rasp18_src_id")
RASP7_PARENT_COLUMNS = ("rasp7_id",)

# статусы завершенной заявки:
# ReqStatus писался в БД и как value, и как repr енама (f"{ReqStatus.FINISHED}")
FINISHED_STATUSES = ("FINISHED", "ReqStatus.FINISHED")

# имена таблиц/колонок, которые мы подставляем в запрос напрямую
IDENT_PATTERN = re.compile(r"^[a-z_][a-z0-9_]*$")


class ExportError(Exception):
    """Снапшот не может быть собран из-за состояния БД"""


@dataclass
class VersionRef:
    """Ссылка на версию расписания (завершенную заявку на парсинг)"""

    req_id: int
    report_dttm: datetime
    time_ver: int
    rasp_filename: str = None
    start_date: date = None
    end_date: date = None

    @property
    def version(self) -> str:
        """Публичный идентификатор версии"""
        return str(self.req_id)


@dataclass
class Snapshot:
    """Собранный снапшот и статистика по нему (для логов)"""

    payload: dict
    version: VersionRef
    row_counts: dict = field(default_factory=dict)

    @property
    def total_rows(self) -> int:
        """Общее число выгруженных строк"""
        return sum(self.row_counts.values())


def quote_ident(name: str) -> str:
    """Экранирование имени таблицы/колонки (имена берем из своих констант и из БД)"""
    if not IDENT_PATTERN.match(name):
        raise ExportError(f"Недопустимое имя объекта БД: {name}")
    return f'"{name}"'


def all_rows_filter() -> dict:
    """Фильтр 'вся таблица целиком'"""
    return {"kind": "all"}


def column_eq_filter(column: str, value) -> dict:
    """Фильтр 'колонка равна значению'"""
    return {"kind": "eq", "column": column, "value": value}


def parent_filter(parent: str, columns: tuple, parent_where: dict) -> dict:
    """Фильтр 'ссылается на строку родительской таблицы, попавшую в снапшот'"""
    return {
        "kind": "parent",
        "parent": parent,
        "columns": columns,
        "parent_where": parent_where,
    }


def referenced_filter(child: str, column: str, child_where: dict) -> dict:
    """Фильтр 'на строку ссылается дочерняя таблица, попавшая в снапшот'"""
    return {
        "kind": "referenced",
        "child": child,
        "column": column,
        "child_where": child_where,
    }


def section_specs(semcode: int, time_ver: int) -> dict:
    """
    Описание разделов снапшота: какие таблицы и по какому условию выгружаются.

    semcode может быть None, если по версии не нашлось ни одной строки sc_rasp18.
    Тогда:
        - недельный шаблон отдавать не от чего, он будет пустым;
        - дни все равно нужны, иначе day_id в sc_rasp18 не на что будет разрешить,
          поэтому берем ровно те дни, на которые ссылается версия.
    """
    daily_root = column_eq_filter("time_ver", time_ver)

    # sc_rasp7* и sc_rasp18_days версией не помечаются, они привязаны к семестру
    semester_root = None
    if semcode is not None:
        semester_root = column_eq_filter("semcode", semcode)

    weekly_root = semester_root if semester_root else {"kind": "none"}
    days_root = (
        semester_root
        if semester_root
        else referenced_filter("sc_rasp18", "day_id", daily_root)
    )

    return {
        "weekly": [
            ("sc_rasp7", weekly_root),
            ("sc_rasp7_groups", parent_filter("sc_rasp7", RASP7_PARENT_COLUMNS, weekly_root)),
            ("sc_rasp7_preps", parent_filter("sc_rasp7", RASP7_PARENT_COLUMNS, weekly_root)),
            ("sc_rasp7_rooms", parent_filter("sc_rasp7", RASP7_PARENT_COLUMNS, weekly_root)),
        ],
        "daily": [
            ("sc_rasp18_days", days_root),
            ("sc_rasp18", daily_root),
            ("sc_rasp18_groups", parent_filter("sc_rasp18", RASP18_PARENT_COLUMNS, daily_root)),
            ("sc_rasp18_preps", parent_filter("sc_rasp18", RASP18_PARENT_COLUMNS, daily_root)),
            ("sc_rasp18_rooms", parent_filter("sc_rasp18", RASP18_PARENT_COLUMNS, daily_root)),
            ("sc_rasp18_info", parent_filter("sc_rasp18", RASP18_PARENT_COLUMNS, daily_root)),
            ("sc_rasp18_move", parent_filter("sc_rasp18", RASP18_PARENT_COLUMNS, daily_root)),
        ],
        "reference": [(table, all_rows_filter()) for table in REFERENCE_TABLES],
    }


class SnapshotReader:
    """
    Read-only чтение снапшота расписания.

    Открывает собственное соединение (параметры берутся из того же .env,
    что и у Database) и держит все чтения в одной REPEATABLE READ транзакции.
    """

    def __init__(self):
        params = Database()
        self.conn = connect(
            database=params.db_name,
            user=params.db_user,
            host=params.db_host,
            port=params.db_port,
            password=params.db_password,
        )
        # ручка только читает: снапшот на всю транзакцию и запрет на запись
        self.conn.set_session(readonly=True, isolation_level="REPEATABLE READ")
        self.cur = self.conn.cursor()

        self.table_columns = {}
        self.table_pkeys = {}
        self.has_meta_tables = False
        self._load_schema()

    def close(self):
        """Откат read-only транзакции и закрытие соединения"""
        if self.conn is None:
            return
        try:
            self.conn.rollback()
            self.cur.close()
        finally:
            self.conn.close()
            self.conn = None
            self.cur = None

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()
        return False

    # ---------------------------------------------------------------- #
    # ------------------------ метаданные схемы ---------------------- #
    # ---------------------------------------------------------------- #

    def _load_schema(self):
        """Читаем реальные колонки и первичные ключи таблиц расписания"""
        tables = list(WEEKLY_TABLES + DAILY_TABLES + REFERENCE_TABLES)

        self.cur.execute(
            """
            SELECT table_name::text, column_name::text
            FROM information_schema.columns
            WHERE table_schema = %s AND table_name::text = ANY(%s)
            ORDER BY table_name, ordinal_position;
            """,
            (SCHEMA, tables),
        )
        for table_name, column_name in self.cur.fetchall():
            self.table_columns.setdefault(table_name, []).append(column_name)

        self.cur.execute(
            """
            SELECT c.relname::text, a.attname::text
            FROM pg_index i
            JOIN pg_class c ON c.oid = i.indrelid
            JOIN pg_namespace n ON n.oid = c.relnamespace
            CROSS JOIN LATERAL unnest(i.indkey) WITH ORDINALITY AS k(attnum, ord)
            JOIN pg_attribute a ON a.attrelid = c.oid AND a.attnum = k.attnum
            WHERE i.indisprimary AND n.nspname = %s AND c.relname::text = ANY(%s)
            ORDER BY c.relname, k.ord;
            """,
            (SCHEMA, tables),
        )
        for table_name, column_name in self.cur.fetchall():
            self.table_pkeys.setdefault(table_name, []).append(column_name)

        # мета таблицы создаются при первой заявке на парсинг, их может не быть
        self.cur.execute(
            """
            SELECT count(*)
            FROM information_schema.tables
            WHERE table_schema = 'parser_meta'
              AND table_name::text IN ('requests', 'status');
            """
        )
        self.has_meta_tables = self.cur.fetchone()[0] == 2

    def has_column(self, table: str, column: str) -> bool:
        """Есть ли колонка в развернутой схеме"""
        return column in self.table_columns.get(table, [])

    def order_columns(self, table: str) -> list:
        """
        Колонки для детерминированной сортировки.
        Первичный ключ, иначе id, иначе все колонки таблицы.
        """
        pkey = self.table_pkeys.get(table)
        if pkey:
            return list(pkey)

        columns = self.table_columns.get(table, [])
        if "id" in columns:
            return ["id"]
        return list(columns)

    # ---------------------------------------------------------------- #
    # -------------------------- версии ------------------------------ #
    # ---------------------------------------------------------------- #

    def find_version(self, req_id: int = None) -> VersionRef:
        """
        Найти завершенную версию расписания.
        req_id is None -> последняя завершенная (по времени регистрации заявки).
        Возвращает None, если подходящей завершенной версии нет.
        """
        if not self.has_meta_tables:
            print("<--EXPORT WARNING: мета таблиц parser_meta еще нет-->")
            return None

        where_req = ""
        params = [list(FINISHED_STATUSES)]
        if req_id is not None:
            where_req = "AND reqs.req_id = %s "
            params.append(req_id)

        query = (
            "SELECT reqs.req_id, reqs.report_dttm, reqs.rasp_filename, "
            "reqs.start_date, reqs.end_date "
            "FROM parser_meta.requests reqs "
            "INNER JOIN parser_meta.status st ON reqs.req_id = st.req_id "
            "WHERE st.status = ANY(%s) " + where_req + "ORDER BY reqs.report_dttm DESC, "
            "reqs.req_id DESC LIMIT 1;"
        )
        self.cur.execute(query, params)
        row = self.cur.fetchone()
        if row is None:
            return None

        found_id, report_dttm, filename, start_date, end_date = row
        return VersionRef(
            req_id=found_id,
            report_dttm=report_dttm,
            # так же, как парсер считает time_ver при записи расписания
            time_ver=int(report_dttm.timestamp()),
            rasp_filename=filename,
            start_date=start_date,
            end_date=end_date,
        )

    def expected_time_vers(self, exclude_req_id: int) -> set:
        """Ожидаемые (по report_dttm) метки версий всех ОСТАЛЬНЫХ заявок"""
        self.cur.execute(
            "SELECT report_dttm FROM parser_meta.requests WHERE req_id <> %s;",
            (exclude_req_id,),
        )
        return {
            int(report_dttm.timestamp())
            for (report_dttm,) in self.cur.fetchall()
            if report_dttm is not None
        }

    def find_time_ver(self, version: VersionRef) -> int:
        """
        Определить, какая метка версии РЕАЛЬНО стоит на строках расписания.

        Парсер до be7d7d3 писал в report_dttm время, обрезанное до секунды
        (ctime()), а в time_ver - дробный timestamp, который Postgres при
        вставке в bigint округлял. Из-за этого у части заявок time_ver строк
        на секунду больше, чем дает report_dttm. Округление всегда вверх,
        поэтому кандидатов ровно два.
        """
        expected = version.time_ver
        candidates = [expected, expected + 1]

        self.cur.execute(
            f"SELECT DISTINCT time_ver FROM {SCHEMA}.sc_rasp18 WHERE time_ver = ANY(%s);",
            (candidates,),
        )
        existing = {found[0] for found in self.cur.fetchall()}

        # метку, которую ожидает другая заявка, забирать себе нельзя
        taken = self.expected_time_vers(version.req_id)

        for candidate in candidates:
            if candidate not in existing:
                continue
            if candidate != expected and candidate in taken:
                continue
            if candidate != expected:
                print(
                    f"<--EXPORT WARNING: у заявки {version.req_id} строки помечены "
                    + f"time_ver={candidate}, а report_dttm дает {expected} "
                    + "(старый парсер округлял time_ver при вставке)-->"
                )
            return candidate

        return expected

    def get_semcode(self, time_ver: int) -> int:
        """Код семестра, к которому относится версия (по строкам sc_rasp18)"""
        self.cur.execute(
            f"SELECT MIN(semcode) FROM {SCHEMA}.sc_rasp18 WHERE time_ver = %s;",
            (time_ver,),
        )
        row = self.cur.fetchone()
        return None if row is None else row[0]

    def get_semester_dates(self, semcode: int) -> tuple:
        """Первый и последний день семестра (по таблице дней)"""
        if semcode is None or "sc_rasp18_days" not in self.table_columns:
            return None, None

        self.cur.execute(
            f"SELECT MIN(day), MAX(day) FROM {SCHEMA}.sc_rasp18_days WHERE semcode = %s;",
            (semcode,),
        )
        row = self.cur.fetchone()
        if row is None:
            return None, None
        return row[0], row[1]

    # ---------------------------------------------------------------- #
    # --------------------------- строки ----------------------------- #
    # ---------------------------------------------------------------- #

    def fetch_table(self, table: str, table_filter: dict) -> dict:
        """
        Прочитать таблицу целиком по фильтру.
        Возвращает None, если такой таблицы нет в развернутой схеме.
        """
        if table not in self.table_columns:
            print(f"<--EXPORT WARNING: таблицы {table} нет в БД, пропускаем-->")
            return None

        where_sql, params = self.build_where(table, table_filter)
        order_sql = ", ".join(
            quote_ident(column) for column in self.order_columns(table)
        )

        query = f"SELECT * FROM {SCHEMA}.{quote_ident(table)}{where_sql}"
        if order_sql:
            query += f" ORDER BY {order_sql}"
        query += ";"

        self.cur.execute(query, params)
        columns = [description[0] for description in self.cur.description]
        rows = [dict(zip(columns, values)) for values in self.cur.fetchall()]

        return {
            "table": table,
            "primary_key": self.order_columns(table),
            "rows": rows,
        }

    def build_where(self, table: str, table_filter: dict) -> tuple:
        """Собрать WHERE по декларативному фильтру"""
        predicate, params = self.build_predicate(table, table_filter)
        if predicate is None:
            return "", []
        return f" WHERE {predicate}", params

    def build_predicate(self, table: str, table_filter: dict) -> tuple:
        """Собрать условие фильтрации (None, если фильтровать не нужно)"""
        kind = table_filter["kind"]

        if kind == "all":
            return None, []

        if kind == "none":
            return "FALSE", []

        if kind == "eq":
            column = table_filter["column"]
            if not self.has_column(table, column):
                print(
                    f"<--EXPORT WARNING: в {table} нет колонки {column}, "
                    + "таблица отдается целиком-->"
                )
                return None, []
            return f"{quote_ident(column)} = %s", [table_filter["value"]]

        if kind == "parent":
            parent = table_filter["parent"]
            parent_predicate, parent_params = self.build_predicate(
                parent, table_filter["parent_where"]
            )
            parent_where = "" if parent_predicate is None else f" WHERE {parent_predicate}"

            conditions = []
            params = []
            for column in table_filter["columns"]:
                if not self.has_column(table, column):
                    continue
                conditions.append(
                    f"{quote_ident(column)} IN "
                    + f"(SELECT id FROM {SCHEMA}.{quote_ident(parent)}{parent_where})"
                )
                params.extend(parent_params)

            if not conditions:
                print(
                    f"<--EXPORT WARNING: в {table} нет ссылки на {parent}, "
                    + "таблица отдается пустой-->"
                )
                return "FALSE", []

            return "(" + " OR ".join(conditions) + ")", params

        if kind == "referenced":
            child = table_filter["child"]
            column = table_filter["column"]
            if not self.has_column(child, column):
                print(
                    f"<--EXPORT WARNING: в {child} нет колонки {column}, "
                    + f"{table} отдается пустой-->"
                )
                return "FALSE", []

            child_predicate, child_params = self.build_predicate(
                child, table_filter["child_where"]
            )
            child_where = "" if child_predicate is None else f" WHERE {child_predicate}"

            return (
                f"id IN (SELECT {quote_ident(column)} "
                + f"FROM {SCHEMA}.{quote_ident(child)}{child_where})",
                child_params,
            )

        raise ExportError(f"Неизвестный тип фильтра: {kind}")


def open_reader() -> SnapshotReader:
    """Точка входа для создания читателя (подменяется в тестах)"""
    return SnapshotReader()


def resolve_version(reader: SnapshotReader, req_id: int = None) -> VersionRef:
    """
    Определить версию для выгрузки: указанную или последнюю завершенную.
    Возвращает None, если подходящей ЗАВЕРШЕННОЙ версии нет.
    """
    if not reader.has_column("sc_rasp18", "time_ver"):
        raise ExportError(
            "В развернутой схеме у sc_rasp18 нет колонки time_ver, "
            "версионная выгрузка невозможна"
        )

    return reader.find_version(req_id)


def build_snapshot(reader: SnapshotReader, version: VersionRef) -> Snapshot:
    """Собрать полный снапшот одной версии расписания"""
    # метку версии берем из самих данных, а не из report_dttm
    version.time_ver = reader.find_time_ver(version)

    semcode = reader.get_semcode(version.time_ver)
    start_date, end_date = reader.get_semester_dates(semcode)
    if start_date is None:
        start_date, end_date = version.start_date, version.end_date

    payload = {
        "version": version.version,
        "req_id": version.req_id,
        "time_ver": version.time_ver,
        "generated_at": utc_now(),
        "semester": {
            "id": None if semcode is None else str(semcode),
            "start": start_date,
            "end": end_date,
        },
    }

    row_counts = {}
    for section, specs in section_specs(semcode, version.time_ver).items():
        tables = []
        for table, table_filter in specs:
            table_data = reader.fetch_table(table, table_filter)
            if table_data is None:
                continue
            row_counts[table] = len(table_data["rows"])
            tables.append(table_data)
        payload[section] = tables

    return Snapshot(payload=payload, version=version, row_counts=row_counts)


def utc_now() -> datetime:
    """Текущее время в UTC, без дробных секунд"""
    return datetime.now(timezone.utc).replace(microsecond=0)


def json_default(value):
    """
    Приведение типов БД к форматам контракта:
    date -> YYYY-MM-DD, time -> HH:MM:SS, timestamp -> UTC с Z.
    Наивный timestamp считается локальным временем (так же, как time_ver у парсера).
    """
    if isinstance(value, datetime):
        if value.tzinfo is None:
            value = value.astimezone()
        return value.astimezone(timezone.utc).isoformat().replace("+00:00", "Z")

    if isinstance(value, date):
        return value.isoformat()

    if isinstance(value, dtime):
        return value.isoformat()

    if isinstance(value, Decimal):
        return float(value)

    raise TypeError(f"Тип {type(value).__name__} не сериализуется в JSON")
