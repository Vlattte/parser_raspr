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
            # TODO multidict
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
                if len(return_data) > 0:
                    return_data = return_data[0][0]
                else:
                    return_data = None
                return return_data
        except psycopg2.Error as error:
            print(f"PostgreSQL error occured {error} after request:\n{query}")
        finally:
            if conn:
                conn.commit()
                cur.close()
                conn.close()

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

        # delete_query = "DELETE FROM sc_rasp18_days;"
        # self.send_request(delete_query)
        date = datetime.datetime.strptime(start_date, "%Y-%m-%d").date()
        cur_week = 1
        while str(date) != end_date:
            cur_weekday = (date.weekday()+1) % 7
            self.set_rasp18_days(
                    semcode=semcode, day=str(date), weekday=cur_weekday, week=cur_week
                )
            date += datetime.timedelta(days=1)
            if date.weekday() == 0:  # если новый понедельник
                cur_week += 1

        # fill_query = f"\
        # INSERT INTO sc_rasp18_days (semcode, day, weekday, week)\
        # SELECT\
        #     {semcode},\
        #     d::date,\
        #     EXTRACT(DOW FROM d)::integer,\
        #     FLOOR(EXTRACT(EPOCH FROM (d::timestamp - '{start_date}'::timestamp)) / 604800) + 1 \
        # FROM generate_series('{start_date}'::date, '{end_date}'::date, '1 day'::interval) d;"
        # self.send_request(fill_query)

    def set_rasp18_days(self, semcode: int, day: str, weekday: int, week: int):
        """Таблица соответствия дня в неделе и даты"""
        table_name = "sc_rasp18_days"

        # если такой день уже есть, то добавляет его не нужно
        params = {"semcode" :semcode, "day": day, "weekday": weekday, "week": week}
        day_id = self.get_id(table_name, params)
        if day_id is not None:
            return day_id

        query = f" \
                INSERT INTO {table_name} (semcode, day, weekday, week) \
                VALUES ({semcode}, '{day}', {weekday}, {week})  \
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
        rasp18_id = self.send_request(query, True)
        return rasp18_id

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
        query = f"SELECT MAX(id) FROM {table_name}"
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

    def get_id(self, table_name, params: dict):
        """Получить id, если запись существует"""
        where_statements = ""
        for key, val in params.items():
            if val is None:
                continue
            if isinstance(val, str):
                where_statements += f"{key} = '{val}' AND "
            elif isinstance(val, datetime.datetime):
                where_statements += f"{key} = '{val}' AND "
            elif isinstance(val, list):
                where_statements += f"{key} = ARRAY{val} AND "
            else:
                where_statements += f"{key} = {val} AND "

        where_statements = where_statements[:-4]
        query = f"""\
            SELECT id FROM {table_name} WHERE {where_statements};
        """
        return_id = self.send_request(query, is_return=True)

        if return_id is None:
            return None

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
        return week

    def fill_departments(self):
        """Заполняет таблицу кафедр"""
        query = "INSERT INTO sc_department (id, title) VALUES(1, 'ВЕГА') ON CONFLICT DO NOTHING;;\
                 INSERT INTO sc_department (id, title) VALUES(2, 'ВМ') ON CONFLICT DO NOTHING;;\
                 INSERT INTO sc_department (id, title) VALUES(3, 'только для ВЕГИ') ON CONFLICT DO NOTHING;;\
                 INSERT INTO sc_department (id, title) VALUES(4, 'только для ВМ') ON CONFLICT DO NOTHING;;\
                 INSERT INTO sc_department (id, title) VALUES(5, 'другая') ON CONFLICT DO NOTHING;;"
        self.send_request(query)
