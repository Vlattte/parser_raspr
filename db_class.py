"""
Здесь класс БД
"""

import os
import psycopg2
from psycopg2._psycopg import cursor, connection
from dotenv import load_dotenv
import datetime

load_dotenv()


class Database:
    def __init__(self) -> None:
        """
        Инициализирует БД.
        НЕ МЕНЯЙТЕ НАЗВАНИЕ СХЕМЫ public на другое!!!
        """
        super().__init__()
        self.db_host = "localhost"
        self.db_name = os.getenv("DB_NAME")
        self.db_user = os.getenv("DB_USER")
        self.db_password = os.getenv("DB_PASSWORD")
        self.db_port = os.getenv("DB_INTERNAL_PORT")

    def set_conn(self) -> tuple[connection, cursor]:
        """Установка соединения"""
        try:
            conn = psycopg2.connect(
                database=self.db_name,
                user=self.db_user,
                host=self.db_host,
                port=self.db_port,
                password=self.db_password,
            )
            cur = conn.cursor()
        except psycopg2.Error as error:
            print("connection error occured", error)
            conn, cur = (None, None)
        return conn, cur

    def send_request(self, query: str, is_return: bool = False):
        """отправка запроса query и возврат данных, если is_return == True"""
        conn = None
        try:
            conn, cur = self.set_conn()
            cur.execute(query)
            if is_return:
                return_data = cur.fetchall()
                return return_data
        except psycopg2.Error as error:
            print("PostgreSQL error occured", error)
        finally:
            if conn:
                conn.commit()
                cur.close()
                conn.close()

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
        params = {
            "semcode": semcode,
            "version": version,
            "disc_id": disc_id,
            "weekday": weekday,
            "pair": pair,
            "weeksarray": weeksarray,
            "weekstext": weekstext,
        }

        rasp7_id = self.get_id(table_name, params)
        if rasp7_id is not None:
            return rasp7_id

        rasp7_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, semcode, version, disc_id, weekday, pair, weeksarray, weekstext) \
                VALUES ({rasp7_id}, {semcode}, {version}, {disc_id}, {weekday}, {pair}, ARRAY{weeksarray}, '{weekstext}') \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return rasp7_id

    def set_prep(
        self, fio: str, chair: str = None, degree: str = None, photo: str = None
    ):
        """Заполнение таблицы преподавателей"""
        if fio == "null" or fio is None:
            return None

        table_name = "sc_prep"
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
        params = {"title": str(group)}

        group_id = self.get_id(table_name, params)
        if group_id is not None:
            return group_id

        group_id = self.get_prev_id(table_name)
        query = f"\
        INSERT INTO {table_name} (id, title) \
        VALUES ({group_id}, '{group}') ON CONFLICT DO NOTHING;"
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
        params = {
            "title": title,
            "shorttitle": shorttitle,
            "department_id": department_id,
            "varmask": varmask,
        }
        disc_id = self.get_id(table_name, params)
        # если id уже есть, ничего не вставляем, возвращаем id
        if disc_id is not None:
            return disc_id

        disc_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, title, shorttitle, department_id, varmask) \
                VALUES ({disc_id}, '{title}', '{shorttitle}', {department_id}, '{varmask}')  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return disc_id

    def set_rasp7_groups(self, rasp7_id: int, group_id: int, sub_group: int):
        """добавить запись в семидневное расписание"""
        table_name = "sc_rasp7_groups"
        params = {"rasp7_id": rasp7_id,
                  "group_id": group_id, "subgroup": sub_group}
        if self.row_exists(table_name, params):
            return

        rasp7_groups_id = self.get_prev_id(table_name)
        query = f"\
                INSERT INTO {table_name} (id, rasp7_id, group_id, subgroup) \
                VALUES ({rasp7_groups_id}, {rasp7_id}, {group_id}, {sub_group}) \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)

    def set_rasp7_preps(self, rasp7_id: int, prep_id: int):
        """преподователи для семидневного расписания"""
        table_name = "sc_rasp7_preps"
        params = {"rasp7_id": rasp7_id, "prep_id": prep_id}
        if self.row_exists(table_name, params):
            return

        rasp7_preps_id = self.get_prev_id(table_name)
        query = f"\
                INSERT INTO {table_name} (id, rasp7_id, prep_id) \
                VALUES ({rasp7_preps_id}, {rasp7_id}, {prep_id}) ON CONFLICT DO NOTHING;"
        self.send_request(query)

    def set_rasp7_rooms(self, rasp7_id: int, room: str):
        """аудитории для семидневного расписания"""
        table_name = "sc_rasp7_rooms"
        params = {"rasp7_id": rasp7_id, "room": room}
        if self.row_exists(table_name, params):
            return

        rasp7_rooms_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, rasp7_id, room) \
                VALUES ({rasp7_rooms_id}, {rasp7_id}, '{room}') ON CONFLICT DO NOTHING;"
        self.send_request(query)

    # ------------------------ #
    # ---------rasp18--------- #
    # ------------------------ #

    def fill_rasp18_for_period(self, start_date: str, end_date: str):
        """Заполнение дней с start_date до end_date"""

        delete_query = "DELETE FROM sc_rasp18_days;"
        self.send_request(delete_query)

        cur_semcode = 1
        fill_query = f"\
        INSERT INTO sc_rasp18_days(semcode, day, weekday, week) \
            SELECT \
                {cur_semcode}, \
                d::date, \
                EXTRACT(DOW FROM d)::integer, \
                EXTRACT(WEEK FROM d)::integer - EXTRACT(WEEK FROM'{start_date}'::date) + 1 \
            FROM generate_series('{start_date}'::date, '{end_date}'::date, '1 day'::interval) d;"
        self.send_request(fill_query)


    def set_rasp18_days(self, semcode: int, day: str, weekday: int, week: int):
        """Таблица соответствия дня в неделе и даты"""
        table_name = "sc_rasp18_days"
        params = {"semcode": semcode, "day": day,
                  "weekday": weekday}
        rasp18_days_id = self.get_id(table_name, params)
        # если id уже есть, ничего не вставляем, возвращаем id
        if rasp18_days_id is not None:
            return rasp18_days_id

        rasp18_days_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (semcode, day, weekday, week) \
                VALUES ({semcode}, '{day}', {weekday}, {week})  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return rasp18_days_id

    def set_rasp18(self,
                   semcode: int, day_id: int, pair: int, kind: int,
                   worktype: int, disc_id: int, timestart: str, timeend: str):
        """
            kind integer  -- 0обычное,1перенос,2повтор
            worktype integer -– 0пр,1лк,2лб,
                -- 11экз,12зач,13зач-д,
                -- 14кр,15кп
        """
        table_name = "sc_rasp18"
        params = {"semcode": semcode, "day_id": day_id, "pair": pair,
                  "kind": kind, "worktype": worktype, "disc_id": disc_id,
                  "timestart": timestart, "timeend": timeend}
        rasp18_id = self.get_id(table_name, params)
        # если id уже есть, ничего не вставляем, возвращаем id
        if rasp18_id is not None:
            return rasp18_id

        rasp18_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, semcode, day_id, pair, kind, worktype, disc_id, timestart, timeend) \
                VALUES ({rasp18_id}, {semcode}, {day_id}, {pair}, {kind}, {worktype}, {disc_id}, '{timestart}', '{timeend}')  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return rasp18_id

    def set_rasp18_groups(self, rasp18_id: int, group_id: int, subgroup: int):
        """Таблица сооветсвия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_groups"
        params = {"rasp18_id": rasp18_id,
                  "group_id": group_id, "subgroup": subgroup}
        rasp18_groups_id = self.get_id(table_name, params)
        # если id уже есть, ничего не вставляем, возвращаем id
        if rasp18_groups_id is not None:
            return rasp18_groups_id

        rasp18_groups_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, rasp18_id, group_id, subgroup) \
                VALUES ({rasp18_groups_id}, {rasp18_id}, {group_id}, {subgroup})  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return rasp18_groups_id

    def set_rasp18_preps(self, rasp18_id: int, prep_id: int):
        """Таблица сооветсвия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_preps"
        params = {"rasp18_id": rasp18_id, "prep_id": prep_id}
        rasp18_preps_id = self.get_id(table_name, params)
        # если id уже есть, ничего не вставляем, возвращаем id
        if rasp18_preps_id is not None:
            return rasp18_preps_id

        rasp18_preps_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, rasp18_id, prep_id) \
                VALUES ({rasp18_preps_id}, {rasp18_id}, {prep_id})  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return rasp18_preps_id

    def set_rasp18_rooms(self, rasp18_id: int, room: str):
        """Таблица сооветсвия групп и пары в 18 недельном  расписании"""
        table_name = "sc_rasp18_rooms"
        params = {"rasp18_id": rasp18_id, "room": room}
        rasp18_rooms_id = self.get_id(table_name, params)
        # если id уже есть, ничего не вставляем, возвращаем id
        if rasp18_rooms_id is not None:
            return rasp18_rooms_id

        rasp18_rooms_id = self.get_prev_id(table_name)
        query = f" \
                INSERT INTO {table_name} (id, rasp18_id, room) \
                VALUES ({rasp18_rooms_id}, {rasp18_id}, '{room}')  \
                ON CONFLICT DO NOTHING;"
        self.send_request(query)
        return rasp18_rooms_id
    # --------------------

    def get_prev_id(self, table_name: str) -> int:
        """получение id последней записи в таблице"""
        query = f"SELECT MAX(id) FROM {table_name}"
        prev_id = self.send_request(query, True)

        prev_id = prev_id[0][0]
        if prev_id is None:
            prev_id = 0
        else:
            prev_id += 1
        return prev_id

    def row_exists(self, table_name: str, params: dict) -> bool:
        """есть ли уже такая запись"""
        returned_id = self.get_id(table_name, params)
        return returned_id is not None

    def get_id(self, table_name, params: dict):
        """Получить id, если запись существует"""
        where_statements = ""
        for key, val in params.items():
            if val is None:
                continue
            if isinstance(val, str):
                where_statements += f"{key} = '{val}' AND "
            elif isinstance(val, list):
                where_statements += f"{key} = ARRAY{val} AND "
            else:
                where_statements += f"{key} = {val} AND "

        where_statements = where_statements[:-4]
        query = f"""\
            SELECT id FROM {table_name} WHERE {where_statements};
        """
        return_data = self.send_request(query, is_return=True)

        if return_data is None:
            return None
        if len(return_data) < 1:
            return None

        return_id = return_data[0][0]
        return return_id

    def get_last_week(self):
        table_name = "sc_rasp18_days"
        query = f"""\
            SELECT MAX(week) from {table_name};
        """
        last_week = self.send_request(query, True)
        return last_week

    def get_week_by_date(self, date: str):
        """Получить учебную неделю по дате"""
        table_name = "sc_rasp18_days"
        query = f"SELECT week FROM {table_name} WHERE day = '{date}';"
        week = self.send_request(query=query, is_return=True)
        week = week[0][0]
        return week