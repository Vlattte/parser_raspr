"""
Здесь класс БД
"""

from os import getenv
from datetime import datetime
from datetime import timedelta

from psycopg2 import connect
from psycopg2 import Error
from dotenv import load_dotenv
from progress.counter import Stack


class Database:
    """Класс работы в БД"""

    def __init__(self, is_dump=True) -> None:
        """Инициализирует БД"""
        super().__init__()

        load_dotenv()
        self.db_host = getenv("DB_HOST")
        self.db_name = getenv("DB_NAME")
        self.db_user = getenv("DB_USER")
        self.db_password = getenv("DB_PASSWORD")
        self.db_port = getenv("DB_PORT")
        self.is_dump = getenv("DB_DUMP")
        self.is_pre_clear = getenv("PRE_CLEAR")

        # если не заполнили
        if self.is_dump is None:
            self.is_dump = is_dump
        else:
            self.is_dump = bool(self.is_dump)

        self.requests_file_name = "sql_scripts/sql_dump.sql"

        self.conn = None
        self.cur = None
        self.sql_requests = None

        # очищать ли базу перед работой
        if int(self.is_pre_clear) == 1:
            self.set_conn()
            self.__clear_tables()
            print("<--TABLES CLEARED-->")
            self.close_conn()

    def set_conn(self):
        """Установка соединения"""
        try:
            self.sql_requests = open(
                self.requests_file_name, "w", encoding="utf-8")

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

    def close_conn(self):
        """Закрыть соединение с базой"""
        # если файл открыт, закрываем
        if self.sql_requests:
            self.sql_requests.close()

        # если соединение открыто, закрываем
        if self.conn:
            self.cur.close()
            self.conn.close()

    def send_request(self, query: str, is_return: bool = False):
        """отправка запроса query и возврат данных, если is_return == True"""
        try:
            self.cur.execute(query)

            # записываем историю запросов
            if "select" not in query.lower() and self.is_dump:
                self.sql_requests.write(query)

            if is_return:
                return_data = self.cur.fetchall()
                if len(return_data) > 0:
                    return_data = return_data[0][0]
                else:
                    return_data = None
                return return_data
        except Error as error:
            print(f"PostgreSQL error occured {error} after request:\n{query}")
        finally:
            if self.conn:
                self.conn.commit()

    def __clear_tables(self):
        """ОЧИЩАЕТ ВСЕ ТАБЛИЦЫ"""
        with open("sql_scripts/clear_script.sql", "r", encoding="utf-8") as clear_script:
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

        prep_id = self.get_prev_id(table_name)
        query = f"\
            INSERT INTO {table_name} (id, fio, chair, degree, photo) \
            VALUES ({prep_id}, '{fio}', '{chair}', '{degree}', '{photo}') ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return prep_id

    def set_group(self, group: str):
        """Заполнение таблицы групп"""
        table_name = "sc_group"

        # второй такой же группы быть не может
        params = {"title": str(group)}
        group_id = self.get_id(table_name, params)
        if group_id is not None:
            return group_id

        group_id = self.get_prev_id(table_name)
        query = f"""INSERT INTO {table_name} (id, title)
                    VALUES ({group_id}, '{group}')
                    ON CONFLICT DO NOTHING;"""
        self.send_request(query)
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
            print(f"""ОШИБКА при записи дисциплины: title: {title},
                    shorttitle: {shorttitle}, department_id: {department_id}""")

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

        disc_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, title, shorttitle, department_id, varmask) \
                VALUES ({disc_id}, '{title}', '{shorttitle}', {department_id}, '{varmask}')  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
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
        """добавить запись в семидневное расписание"""
        table_name = "sc_rasp7_groups"

        params = {
            "rasp7_id": rasp7_id,
            "group_id": group_id,
            "subgroup": sub_group
        }
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
        """преподователи для семидневного расписания"""
        table_name = "sc_rasp7_preps"
        if prep_id is None or prep_id == "null":
            return None

        query = f"\
                INSERT INTO {table_name} (rasp7_id, prep_id) \
                VALUES ({rasp7_id}, {prep_id}) ON CONFLICT DO NOTHING RETURNING id;"
        rasp7_preps_id = self.send_request(query, True)
        return rasp7_preps_id

    def set_rasp7_rooms(self, rasp7_id: int, room: str):
        """аудитории для семидневного расписания"""
        table_name = "sc_rasp7_rooms"

        query = f" \
                INSERT INTO {table_name} (rasp7_id, room) \
                VALUES ({rasp7_id}, '{room}') ON CONFLICT DO NOTHING RETURNING id;"
        rasp7_rooms_id = self.send_request(query, True)
        return rasp7_rooms_id

    # ------------------------ #
    # ---------rasp18--------- #
    # ------------------------ #

    def fill_rasp18_for_period(self, semcode: int, start_date: str, end_date: str):
        """Заполнение дней с start_date до end_date"""

        duration = datetime.strptime(
            end_date, "%Y-%m-%d") - datetime.strptime(start_date, "%Y-%m-%d")
        fill_days_bar = Stack('Заполнение rasp18_days', max=duration.days)
        fill_days_bar.check_tty = False
        fill_days_bar.start()

        date = datetime.strptime(start_date, "%Y-%m-%d").date()
        cur_week = 1
        while str(date) != end_date:
            cur_weekday = (date.weekday()+1) % 7
            self.set_rasp18_days(
                semcode=semcode, day=str(date), weekday=cur_weekday, week=cur_week
            )
            date += timedelta(days=1)
            if date.weekday() == 0:  # если новый понедельник
                cur_week += 1
            fill_days_bar.next()
        fill_days_bar.finish()

    def set_rasp18_days(self, semcode: int, day: str, weekday: int, week: int):
        """Таблица соответствия дня в неделе и даты"""
        table_name = "sc_rasp18_days"

        # если такой день уже есть, то добавляет его не нужно
        params = {"semcode": semcode, "day": day,
                  "weekday": weekday, "week": week}
        day_id = self.get_id(table_name, params)
        if day_id is not None:
            return day_id

        query = f" \
                INSERT INTO {table_name} (semcode, day, weekday, week) \
                VALUES ({semcode}, date('{day}'), {weekday}, {week})  \
                ON CONFLICT DO NOTHING RETURNING id;"
        rasp18_days_id = self.send_request(query, True)
        return rasp18_days_id

    def set_rasp18(
        self,
        semcode: int,
        day_id: int,
        pair: int,
        kind: int,
        worktype: int,
        disc_id: int,
        timestart: str,
        timeend: str,
        is_execute_req: bool = True
    ):
        """
        kind integer  -- 0обычное,1перенос,2повтор
        worktype integer -– 0пр,1лк,2лб,
            -- 11экз,12зач,13зач-д,
            -- 14кр,15кп
        """
        table_name = "sc_rasp18"

        # только часы и минуты, секунды образаем
        timestart_hm = timestart[:-3]
        timeend_hm = timeend[:-3]
        # если id уже есть, ничего не вставляем, возвращаем id
        query = f" \
                INSERT INTO {table_name} (semcode, day_id, pair, kind, worktype, disc_id, timestart, timeend) \
                VALUES ({semcode}, {day_id}, {pair}, {kind}, {worktype}, {disc_id}, '{timestart_hm}', '{timeend_hm}')  \
                ON CONFLICT DO NOTHING RETURNING id;"
        if is_execute_req:
            rasp18_id = self.send_request(query, True)
            return rasp18_id

        # если не сказано выполнять запрос, то возвращаем его
        return query

    def set_rasp18_groups(self, rasp18_id: int, group_id: int, subgroup: int):
        """Таблица сооветствия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_groups"

        # у одной группы не может быть 2 пары одновременно
        params = {
            "rasp18_id": rasp18_id,
            "group_id": group_id,
            "subgroup": subgroup
        }
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

        params = {
            "rasp18_id": rasp18_id,
            "prep_id": prep_id
        }
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

        params = {
            "rasp18_id": rasp18_id,
            "room": room
        }
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

    def get_id_request(self, table_name: str, params: dict) -> str:
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
        worktypes = {"пр": 0, "лк": 1, "лб": 2,
                     "конс": 10, "экз": 11, "зач": 12, "зач-д": 13,
                     "кр": 14, "кп": 15}
        table_name = "sc_worktypes"

        # проверка на наличие такой таблицы
        create_query = f"""CREATE TABLE IF NOT EXISTS public.{
            table_name} (id SERIAL PRIMARY KEY, title text);"""
        self.send_request(create_query)

        query = ""
        for wt_name, wt_id in worktypes.items():
            already_exists = self.row_exists(
                table_name, {"id": wt_id, "title": wt_name})
            if not already_exists:
                query += f"INSERT INTO {table_name} (id, title) VALUES({wt_id},\
                        '{wt_name}') ON CONFLICT DO NOTHING;"
        if query != "":
            self.send_request(query)
