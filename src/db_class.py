"""
Здесь класс БД
"""

from os import getenv
from datetime import datetime
from datetime import timedelta

import re

from psycopg2 import connect
from psycopg2 import Error
from dotenv import load_dotenv

from src.utils.str_utils import filepath_to_filename

from src.structs import ReqStatus
from src.structs import Rasp18Data


class Database:
    """Класс работы в БД"""

    def __init__(self) -> None:
        """Инициализирует БД"""
        super().__init__()

        load_dotenv()
        self.db_host = getenv("DB_HOST")
        self.db_name = getenv("DB_NAME")
        self.db_user = getenv("DB_USER")
        self.db_password = getenv("DB_PASSWORD")
        self.db_port = getenv("DB_PORT")

        self.conn = None
        self.cur = None

    def set_conn(self):
        """Установка соединения"""
        try:
            self.conn = connect(
                database=self.db_name,
                user=self.db_user,
                host=self.db_host,
                port=self.db_port,
                password=self.db_password,
            )
            # TODO multidict
            self.cur = self.conn.cursor()
            # настройка формата дат
            self.send_request("SET datestyle = 'ISO, DMY';")
        except Error as error:
            print("Set connection error occured", error)
            self.conn = None
            self.cur = None
            raise error

    def close_conn(self):
        """Закрыть соединение с базой"""
        # если соединение открыто, закрываем
        if self.conn:
            self.cur.close()
            self.conn.close()

    def send_request(self, query: str, is_return: bool = False):
        """отправка запроса query и возврат данных, если is_return == True"""
        try:
            self.cur.execute(query)

            if is_return:
                return_data = self.cur.fetchall()
                if len(return_data) == 1 and len(return_data[0]) == 1:
                    return_data = return_data[0][0]
                elif len(return_data) < 1:
                    return_data = None
                return return_data
            return None
        except Error as error:
            print(f"PostgreSQL error occured {error} after request:\n{query}")
            raise error
        finally:
            if self.conn:
                self.conn.commit()

    def clear_tables(self):
        """ОЧИЩАЕТ ВСЕ ТАБЛИЦЫ"""
        print("<--TABLES CLEARED-->")
        with open(
            "sql_scripts/clear_script.sql", "r", encoding="utf-8"
        ) as clear_script:
            query = clear_script.read()
            query = query.replace("\n", "")
            self.send_request(query)

    def set_prep(
        self, fio: str, chair: str = None, degree: str = None, photo: str = None
    ):
        """Заполнение таблицы преподавателей"""
        if fio == "null" or fio is None:
            return None

        table_name = "sc_prep"

        # второго такого же препода быть не может
        params = {"fio": fio, "chair": chair, "degree": degree, "photo": photo}
        prep_id = self.get_id(table_name, params)
        if prep_id is not None:
            return prep_id

        query = f"\
            INSERT INTO {table_name} (fio, chair, degree, photo) \
            VALUES ('{fio}', '{chair}', '{degree}', '{photo}') \
            ON CONFLICT DO NOTHING RETURNING id;"
        prep_id = self.send_request(query, is_return=True)
        return prep_id

    def set_group(self, group: str):
        """Заполнение таблицы групп"""
        table_name = "sc_group"

        # второй такой же группы быть не может
        params = {"title": str(group)}
        group_id = self.get_id(table_name, params)
        if group_id is not None:
            return group_id

        query = f"""INSERT INTO {table_name} (title)
                    VALUES ('{group}')
                    ON CONFLICT DO NOTHING RETURNING id;"""
        group_id = self.send_request(query, is_return=True)
        return group_id

    def set_disc(self, title: str, shorttitle: str, department_id: int, varmask: str):
        """
        добавить дисциплину:
        title - полное название дисцилпины
        shorttilte - короткая версия названия дисциплины
        department_id - кафедра, соответствует таблице sc_department
        varmask - маска полного названия дисциплины

        return: disc_id
        """
        table_name = "sc_disc"
        if title is None and shorttitle is None or department_id == -1:
            print(
                f"""ОШИБКА при записи дисциплины: title: {title},
                    shorttitle: {shorttitle}, department_id: {department_id}"""
            )

        # вторая такая же дисциплина может быть, только если у них не совпадает department_id
        # поэтому проверяем на повтор
        params = {
            "title": title,
            "shorttitle": shorttitle,
            "department_id": department_id,
            "varmask": varmask,
        }
        disc_id = self.get_id(table_name, params)
        if disc_id is not None:
            return disc_id

        query = f" \
                INSERT INTO {table_name} (title, shorttitle, department_id, varmask) \
                VALUES ('{title}', '{shorttitle}', {department_id}, '{varmask}')  \
                ON CONFLICT DO NOTHING RETURNING id;"
        disc_id = self.send_request(query, is_return=True)
        return disc_id

    def set_rasp7(
        self,
        semcode: int,
        version: int,
        disc_id: int,
        weekday: int,
        pair: int,
        weeksarray: list[int],
        weekstext: str,
    ) -> int:
        """Заполнение таблицы sc_rasp7"""
        table_name = "sc_rasp7"

        query = f" \
                INSERT INTO {table_name} (semcode, version, disc_id, weekday, pair, weeksarray, weekstext) \
                VALUES ({semcode}, {version}, {disc_id}, {weekday}, {pair}, ARRAY{weeksarray}, '{weekstext}') \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp7_id = self.send_request(query, True)
        return rasp7_id

    def set_rasp7_groups(self, rasp7_id: int, group_id: int, sub_group: int):
        """Добавить запись в семидневное расписание"""
        table_name = "sc_rasp7_groups"

        params = {"rasp7_id": rasp7_id, "group_id": group_id, "subgroup": sub_group}
        rasp7_groups_id = self.get_id(table_name, params)
        if rasp7_groups_id is not None:
            return rasp7_groups_id

        query = f"\
                INSERT INTO {table_name} (rasp7_id, group_id, subgroup) \
                VALUES ({rasp7_id}, {group_id}, {sub_group}) \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp7_groups_id = self.send_request(query, True)
        return rasp7_groups_id

    def set_rasp7_preps(self, rasp7_id: int, prep_id: int):
        """Преподователи для семидневного расписания"""
        table_name = "sc_rasp7_preps"
        if prep_id is None or prep_id == "null":
            return None

        query = f"\
                INSERT INTO {table_name} (rasp7_id, prep_id) \
                VALUES ({rasp7_id}, {prep_id}) ON CONFLICT DO NOTHING RETURNING id;"
        rasp7_preps_id = self.send_request(query, True)
        return rasp7_preps_id

    def set_rasp7_rooms(self, rasp7_id: int, room: str):
        """Аудитории для семидневного расписания"""
        table_name = "sc_rasp7_rooms"

        query = f" \
                INSERT INTO {table_name} (rasp7_id, room) \
                VALUES ({rasp7_id}, '{room}') ON CONFLICT DO NOTHING RETURNING id;"
        rasp7_rooms_id = self.send_request(query, True)
        return rasp7_rooms_id

    def clear_rasp_data_between_weeks(
        self, semcode: int, is_semestr: bool, start_date: datetime, end_date: datetime
    ):
        """
        Очистка промежутка недель от данных, чтобы в них залить новую версию
        Затрагивает таблицы, которые зависят от rasp18_id и саму sc_rasp18
        """
        # включает в себя пр, лк, лб
        worktype_clause = "< 3"
        if not is_semestr:
            # включает в себя экз, зач, зач-д, к/р, к/п
            worktype_clause = "> 9"

        day_params = {"semcode": semcode, "day": start_date}
        start_day_id = self.get_id("sc_rasp18_days", day_params)
        day_params = {"semcode": semcode, "day": end_date}
        end_day_id = self.get_id("sc_rasp18_days", day_params)

        if start_date > end_date or start_day_id is None or end_day_id is None:
            raise ValueError(
                f"Ошибка параметров OVERWRITE_DAY: начало {start_date}, конец {end_date}"
            )

        query = f"""DELETE FROM sc_rasp18
        where semcode = {semcode} AND worktype {worktype_clause}  
        AND day_id >= {start_day_id} AND day_id <= {end_day_id} RETURNING id;"""
        return_ids = self.send_request(query=query, is_return=True)
        if return_ids is None:
            return

        return_ids = [day_id[0] for day_id in return_ids if day_id is not None]

        del_r18_where_clause = f"""WHERE rasp18_id IN 
        ({", ".join(str(rasp18_id) for rasp18_id in return_ids)});"""

        del_r18_groups = f"DELETE FROM sc_rasp18_groups {del_r18_where_clause}"
        self.send_request(del_r18_groups)

        del_r18_preps = f"DELETE FROM sc_rasp18_preps {del_r18_where_clause}"
        self.send_request(del_r18_preps)

        del_r18_rooms = f"DELETE FROM sc_rasp18_rooms {del_r18_where_clause}"
        self.send_request(del_r18_rooms)

    # ------------------------ #
    # ---------rasp18--------- #
    # ------------------------ #

    def fill_rasp18_for_period(self, semcode: int, start_date: str, end_date: str):
        """Заполнение дней с start_date до end_date"""

        duration = datetime.strptime(end_date, "%Y-%m-%d") - datetime.strptime(
            start_date, "%Y-%m-%d"
        )
        if duration.days < 0:
            raise ValueError("Начальная дата позже конечной, ошибка входных данных")

        # fill_days_bar = PixelBar("Заполнение rasp18_days", max=duration.days)
        # fill_days_bar.check_tty = False
        # fill_days_bar.start()

        date = datetime.strptime(start_date, "%Y-%m-%d").date()

        cur_week = 1
        while str(date) <= end_date:
            cur_weekday = (date.weekday() + 1) % 7
            self.set_rasp18_days(
                semcode=semcode, day=str(date), weekday=cur_weekday, week=cur_week
            )
            date += timedelta(days=1)
            if date.weekday() == 0:  # если новый понедельник
                cur_week += 1
        #     fill_days_bar.next()
        # fill_days_bar.finish()

        # логгируем, что заполнили дни
        days_filles_msg = (
            f"<--Таблица sc_rasp18_days заполнена c {start_date} " + f"по {end_date}"
        )
        print(days_filles_msg)

    def is_days_period_filled(
        self, semcode: int, start_date: str, end_date: str
    ) -> bool:
        """Проверяем, заполнены ли уже даты на этот период или нет"""
        table_name = "sc_rasp18_days"
        query = f"\
        SELECT COUNT(id) FROM {table_name} \
        WHERE semcode = {semcode} \
        AND date('{start_date}') <= day \
        AND date('{end_date}') >= day"

        written_days_n = self.send_request(query, is_return=True)
        return True if written_days_n > 0 else False

    def set_rasp18_days(self, semcode: int, day: str, weekday: int, week: int):
        """Таблица соответствия дня в неделе и даты"""
        table_name = "sc_rasp18_days"

        # если такой день уже есть, то добавляет его не нужно
        params = {"semcode": semcode, "day": day, "weekday": weekday, "week": week}
        day_id = self.get_id(table_name, params)
        if day_id is not None:
            return day_id

        query = f" \
                INSERT INTO {table_name} (semcode, day, weekday, week) \
                VALUES ({semcode}, date('{day}'), {weekday}, {week})  \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp18_days_id = self.send_request(query, True)

        return rasp18_days_id

    def set_rasp18(self, data: Rasp18Data):
        """
        ячейка в таблице расписания
        worktype integer -– 0пр,1лк,2лб,
            -- 11экз,12зач,13зач-д,
            -- 14кр,15кп
        """
        # у одной и той же группы у такой же подгруппы не может
        # быть две пары одновременно
        table_name = "sc_rasp18"

        if data.day_id is None:
            raise ValueError("id дня оказался None (такого нет в БД)")

        # только часы и минуты, секунды образаем
        hm_format = r"(\d{1,2}[:\-.]\d\d)[:\-.]\d\d"
        timestart_hm = re.sub(hm_format, r"\1", data.timestart)
        timeend_hm = re.sub(hm_format, r"\1", data.timeend)

        # 0 обычное,1 перенос,2 повтор
        pair_kind = 0

        if data.prep_id is not None and data.room is not None:
            exists_query = f"""
        SELECT r18.id FROM sc_rasp18 r18
            INNER JOIN sc_rasp18_preps p ON r18.id = p.rasp18_id
            INNER JOIN sc_rasp18_rooms r ON r18.id = r.rasp18_id
        WHERE semcode = {data.semcode} AND day_id = {data.day_id} 
            AND pair = {data.pair} AND kind = {pair_kind} 
            AND worktype = {data.worktype} AND disc_id = {data.disc_id}
            AND timestart = '{timestart_hm}' AND timeend = '{timeend_hm}'
            AND p.prep_id = {data.prep_id} AND r.room = '{data.room}' 
            AND r18.time_ver = {data.time_ver};
        """
            rasp18_id = self.send_request(exists_query, is_return=True)
            if rasp18_id is not None:
                return rasp18_id

        query = f"\
                INSERT INTO {table_name} \
                (semcode, day_id, pair, kind, worktype, disc_id, timestart, timeend, time_ver) \
                VALUES \
                ({data.semcode}, {data.day_id}, {data.pair}, \
                {pair_kind}, {data.worktype}, {data.disc_id}, \
                '{timestart_hm}', '{timeend_hm}', {data.time_ver}) \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp18_id = self.send_request(query, True)
        return rasp18_id

    def set_rasp18_groups(self, rasp18_id: int, group_id: int, subgroup: int):
        """Таблица сооветствия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_groups"

        # у одной группы не может быть 2 пары одновременно
        params = {"rasp18_id": rasp18_id, "group_id": group_id, "subgroup": subgroup}
        rasp18_groups_id = self.get_id(table_name, params)
        if rasp18_groups_id is not None:
            return rasp18_groups_id

        query = f" \
                INSERT INTO {table_name} (rasp18_id, group_id, subgroup) \
                VALUES ({rasp18_id}, {group_id}, {subgroup})  \
                ON CONFLICT DO NOTHING RETURNING id;"

        rasp18_groups_id = self.send_request(query, True)
        return rasp18_groups_id

    def set_rasp18_preps(self, rasp18_id: int, prep_id: int):
        """Таблица сооветсвия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_preps"

        if prep_id == "null" or prep_id is None:
            return None

        params = {"rasp18_id": rasp18_id, "prep_id": prep_id}
        rasp18_preps_id = self.get_id(table_name, params)
        if rasp18_preps_id is not None:
            return rasp18_preps_id

        query = f" \
                INSERT INTO {table_name} (rasp18_id, prep_id) \
                VALUES ({rasp18_id}, {prep_id})  \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp18_preps_id = self.send_request(query, True)
        return rasp18_preps_id

    def set_rasp18_rooms(self, rasp18_id: int, room: str):
        """Таблица сооветсвия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_rooms"

        params = {"rasp18_id": rasp18_id, "room": room}
        rasp18_rooms_id = self.get_id(table_name, params)
        if rasp18_rooms_id is not None:
            return rasp18_rooms_id

        query = f" \
                INSERT INTO {table_name} (rasp18_id, room) \
                VALUES ({rasp18_id}, '{room}')  \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp18_rooms_id = self.send_request(query, True)
        return rasp18_rooms_id

    # --------------------

    def get_prev_id(self, table_name: str) -> int:
        """получение id последней записи в таблице"""
        query = f"SELECT MAX(id) FROM {table_name};"
        prev_id = self.send_request(query, True)

        if prev_id is None:
            prev_id = 0
        else:
            prev_id += 1
        return prev_id

    def row_exists(self, table_name: str, params: dict) -> bool:
        """есть ли уже такая запись"""
        returned_id = self.get_id(table_name, params)
        return returned_id is not None

    def get_id(self, table_name: str, params: dict):
        """Получить id, если запись существует"""
        query = self.get_id_request(table_name, params)
        return_id = self.send_request(query, is_return=True)
        return return_id

    @staticmethod
    def get_id_request(table_name: str, params: dict) -> str:
        """Возвращает запрос для получения id"""
        where_statements = ""
        for key, val in params.items():
            if val is None:
                continue
            if key == "day":
                where_statements += f"{key} = date('{val}') AND "
            elif isinstance(val, str):
                where_statements += f"{key} = '{val}' AND "
            elif isinstance(val, list):
                where_statements += f"{key} = ARRAY{val} AND "
            else:
                where_statements += f"{key} = {val} AND "

        where_statements = where_statements[:-4]
        query = f"""\
            SELECT id FROM {table_name} WHERE {where_statements};
        """
        return query

    def get_week_by_date(self, date: str):
        """Получить учебную неделю по дате"""
        table_name = "sc_rasp18_days"
        query = f"SELECT week FROM {table_name} WHERE day = '{date}';"
        week = self.send_request(query=query, is_return=True)
        return week

    def fill_departments(self):
        """Заполняет таблицу кафедр"""
        query = "INSERT INTO sc_department (id, title) VALUES(1, 'ВЕГА') ON CONFLICT DO NOTHING;\
                 INSERT INTO sc_department (id, title) VALUES(2, 'ВМ') ON CONFLICT DO NOTHING;\
                 INSERT INTO sc_department (id, title) VALUES(3, 'только для ВЕГИ') ON CONFLICT DO NOTHING;\
                 INSERT INTO sc_department (id, title) VALUES(4, 'только для ВМ') ON CONFLICT DO NOTHING;\
                 INSERT INTO sc_department (id, title) VALUES(5, 'другая') ON CONFLICT DO NOTHING;"
        self.send_request(query)

    def fill_worktypes(self):
        """Заполняет таблицу типов пар"""
        # - 0-пр, 1-лк, 2-лб
        # - 10-конс, 11-экз, 12-зaч, 13-зaч-д
        # - 14-кр, 15-кп
        worktypes = {
            "пр": 0,
            "лк": 1,
            "лб": 2,
            "конс": 10,
            "экз": 11,
            "зач": 12,
            "зач-д": 13,
            "кр": 14,
            "кп": 15,
        }
        table_name = "sc_worktypes"

        # проверка на наличие такой таблицы
        create_query = f"""CREATE TABLE IF NOT EXISTS public.{
        table_name} (id SERIAL PRIMARY KEY, title text);"""
        self.send_request(create_query)

        query = ""
        for wt_name, wt_id in worktypes.items():
            already_exists = self.row_exists(
                table_name, {"id": wt_id, "title": wt_name}
            )
            if not already_exists:
                query += f"INSERT INTO {table_name} (id, title) VALUES({wt_id},\
                        '{wt_name}') ON CONFLICT DO NOTHING;"
        if query != "":
            self.send_request(query)

    def get_week(self, day: str, semcode: int) -> int:
        """Получить номер недели"""
        query = f"""
        SELECT week FROM sc_rasp18_days WHERE day = date('{day}') AND semcode = {semcode};
        """
        week = self.send_request(query=query, is_return=True)
        return week

    def get_dates(self, semcode: int):
        """Получить даты начала и конца семестра"""
        query = f"""
        SELECT MIN(day), MAX(day) FROM sc_rasp18_days WHERE semcode = {semcode};
        """
        res_list = self.send_request(query=query, is_return=True)
        start_date, end_date = map(str, res_list[0])

        return start_date, end_date

    ########################
    # META TABLES REQUESTS #
    ########################

    def save_new_request(
        self, filename: str, start_date: str, end_date: str, magic_start: str = None
    ) -> tuple[int, float]:
        """Загрузка новой заявки в БД"""
        self.create_meta_tables()

        table_name = "parser_meta.requests"

        # безумный трюк, чтобы убрать дробные числа у секунд
        # 2025-09-01 23:59:59.192837 --> 2025-09-01 23:59:59
        req_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        req_time = datetime.fromisoformat(req_time)

        if magic_start is None:
            magic_start = start_date

        query = f"\
            INSERT INTO {table_name} \
            (rasp_filename, start_date, end_date, magic_start, report_dttm) \
            VALUES('{filename}', date('{start_date}'), \
            date('{end_date}'), date('{magic_start}'), '{req_time.ctime()}') \
            RETURNING req_id;"
        req_id = self.send_request(query=query, is_return=True)
        return req_id, req_time.timestamp()

    def update_req(
        self, req_id: int, new_status: ReqStatus, cur_percent: float
    ) -> None:
        """Обновить все данные по заявке"""
        table_name = "parser_meta.status"

        query = f"\
        INSERT INTO {table_name} (req_id, status, status_percent) \
        VALUES ({req_id}, '{new_status}', {cur_percent}) \
            ON CONFLICT(req_id) DO UPDATE SET \
            status = '{new_status}', \
            status_percent = {cur_percent};"
        self.send_request(query)

    def update_req_status(self, req_id: int, new_status: ReqStatus) -> None:
        """Обновить только статус заявки"""
        table_name = "parser_meta.status"

        query = f"\
        INSERT INTO {table_name} (req_id, status) \
        VALUES ({req_id}, '{new_status}') \
            ON CONFLICT(req_id) DO UPDATE SET \
            status = '{new_status.value}';"
        self.send_request(query)

    def get_meta_statuses(self) -> dict:
        """Получить текущее состояние ВСЕХ заявок"""
        if not self.is_meta_good():
            return {"Warning": "No requests yet"}

        table_name = "parser_meta.status"
        query = f"SELECT * FROM {table_name};"

        statuses = self.send_request(query, is_return=True)
        keys = ("status", "parsing_percent")

        # {req_id: {req_data}, ...}
        statuses = {stat[1]: dict(zip(keys, stat[2:])) for stat in statuses}

        table_name = "parser_meta.requests"
        query = f"SELECT * FROM {table_name};"
        req_data = self.send_request(query, is_return=True)

        if not req_data:
            return {"WARNING": "no data in database"}

        stat_list = {
            (req_id): {
                **statuses[req_id],
                **{
                    "file_name": filepath_to_filename(file_nm),
                    "report_dttm": str(report_dttm),
                    "is_latest": False,
                },
            }
            for req_id, file_nm, _, _, _, report_dttm in req_data
        }

        latest_req = max(
            stat_list.items(),
            key=lambda vals: (
                vals[1]["report_dttm"] if vals[1]["status"] == "FINISHED" else ""
            ),
        )
        stat_list[latest_req[0]]["is_latest"] = True

        return stat_list

    def get_reqs_before(self, req_id: int) -> list | None:
        """Получить заявки до выбранной (сравниваются по времени регистрации заявки)"""
        if not self.is_meta_good():
            return {"Warning": "No requests yet"}

        table_reqs = "parser_meta.requests"
        query_cur_req = f"SELECT report_dttm FROM {table_reqs} WHERE req_id = {req_id};"
        cur_req_reg_time = self.send_request(query_cur_req, is_return=True)
        if not cur_req_reg_time:
            return None

        table_stats = "parser_meta.status"
        query_reqs_before = f"\
            SELECT reqs.req_id, reqs.rasp_filename, reqs.report_dttm, st.status \
            FROM {table_reqs} reqs \
            INNER JOIN {table_stats} st \
            ON reqs.req_id = st.req_id \
            WHERE reqs.report_dttm < '{cur_req_reg_time}' \
            AND (st.status = '{ReqStatus.PARSING}' OR st.status = '{ReqStatus.WAITING}');"
        reqs_before = self.send_request(query_reqs_before, is_return=True)

        return reqs_before

    def is_meta_good(self) -> bool:
        """Проверить мета таблицы на корректность"""
        if not self.check_meta_exists() or self.is_meta_empty():
            return False
        return True

    def create_meta_tables(self):
        """Создать мета таблицы"""
        if self.check_meta_exists():
            return

        with open("sql_scripts/meta_tables.sql", "r", encoding="utf-8") as create_meta:
            query = create_meta.read()
            self.send_request(query)

    def check_meta_exists(self):
        """Проверить наличие мета таблиц"""
        check_query = "SELECT EXISTS (\
                       SELECT FROM information_schema.tables \
                       WHERE  table_schema = 'parser_meta' \
                       AND    table_name   = 'status')"
        tables_exists = self.send_request(check_query, is_return=True)
        return tables_exists

    def is_meta_empty(self):
        """True, если еще нет записей в мета таблицах"""
        check_requests_req = "SELECT * FROM parser_meta.requests;"
        check_status_req = "SELECT * FROM parser_meta.status;"
        is_requests_empty = self.send_request(check_requests_req, is_return=True)
        is_status_empty = self.send_request(check_status_req, is_return=True)

        if is_requests_empty is None or is_status_empty is None:
            return True
        return False

    def get_req_data(self, req_id: int):
        """
        Получить данные по заявке:
        - rasp_filename - имя файла расписания
        - start_date - первая дата, загруженная в заявке
        - end_date - последняя дата, загруженная в заявке
        - magic_start - первый день, записанный для магистров
        """
        if not self.is_meta_good():
            return {"Warning": "No requests yet"}

        table_name = "parser_meta.requests"
        req_query = f"SELECT rasp_filename, start_date, end_date, magic_start FROM {table_name} \
                    WHERE req_id = {req_id};"
        data = self.send_request(req_query, is_return=True)

        if data is None:
            return {"ERROR": "Bad request id"}

        return data[0]

    def clear_req_data(self, req_id: int):
        """Очистить данные по заявке"""
        if not self.is_meta_good():
            return {"Warning": "No requests yet"}

        self.update_req_status(req_id, ReqStatus.DELETING)

        req_time_request = f"""
        SELECT report_dttm FROM parser_meta.requests 
        WHERE req_id = {req_id};
        """
        req_time_ver = self.send_request(req_time_request, is_return=True)
        if req_time_ver is None:
            return {"WARNING": "No such request"}

        req_time_ver = req_time_ver.timestamp()

        def delete_table_data(rasp_table: str) -> list[int]:
            """Удаляет таблицу и возвращет id удаленных записей"""
            del_req = f"""
            DELETE FROM public.{rasp_table}
            WHERE time_ver = {req_time_ver}
            RETURNING id;
            """
            ids = self.send_request(del_req, is_return=True)
            if ids is None:
                return None
            ids = list(map(lambda id_tuple: id_tuple[0], ids))
            return ids

        def del_req_by_ids(table_name: str, id_field: str, ids: list[int]):
            return f"""
            DELETE FROM public.{table_name}
            WHERE {id_field} in {*ids,};
            """

        rasp18_ids = delete_table_data("sc_rasp18")
        if rasp18_ids is not None:
            self.send_request(del_req_by_ids("sc_rasp18_groups", "rasp18_id", rasp18_ids))
            self.send_request(del_req_by_ids("sc_rasp18_rooms", "rasp18_id", rasp18_ids))
            self.send_request(del_req_by_ids("sc_rasp18_preps", "rasp18_id", rasp18_ids))

        rasp7_ids = delete_table_data("sc_rasp7")
        if rasp7_ids is not None:
            self.send_request(del_req_by_ids("sc_rasp7_groups", "rasp7_id", rasp7_ids))
            self.send_request(del_req_by_ids("sc_rasp7_rooms", "rasp7_id", rasp7_ids))
            self.send_request(del_req_by_ids("sc_rasp7_preps", "rasp7_id", rasp7_ids))

        del_meta_status = f"DELETE FROM parser_meta.status WHERE req_id = {req_id};"
        del_meta_requests = f"DELETE FROM parser_meta.requests WHERE req_id = {req_id};"
        self.send_request(del_meta_status)
        self.send_request(del_meta_requests)

        return {
            "time_ver": req_time_ver,
            "Deleted from rasp18": 0 if rasp18_ids is None else len(rasp18_ids),
            "Deleted from rasp7":  0 if rasp7_ids is None else len(rasp7_ids),
        }
