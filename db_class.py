"""
Здесь класс БД
"""

import os
import psycopg2
from psycopg2._psycopg import cursor, connection
from dotenv import load_dotenv

load_dotenv()


class Database:
    def __init__(self) -> None:
        """
        Инициализирует БД.
        НЕ МЕНЯЙТЕ НАЗВАНИЕ СХЕМЫ public на другое!!!
        """
        super().__init__()
        self.DB_HOST = "localhost"
        self.DB_NAME = os.getenv("DB_NAME")
        self.DB_USER = os.getenv("DB_USER")
        self.DB_PASSWORD = os.getenv("DB_PASSWORD")
        self.DB_PORT = os.getenv("DB_INTERNAL_PORT")

    def set_conn(self) -> tuple[connection, cursor]:
        try:
            conn = psycopg2.connect(
                database=self.DB_NAME,
                user=self.DB_USER,
                host=self.DB_HOST,
                port=self.DB_PORT,
                password=self.DB_PASSWORD,
            )
            cur = conn.cursor()
        except:
            conn, cur = (None, None)
        finally:
            return conn, cur

    def reset_data(self):
        """
        Удаляет все записи в БД.
        НЕ МЕНЯЙТЕ НАЗВАНИЕ СХЕМЫ public на другое!!!
        """
        query = "DROP SCHEMA public CASCADE;" + " " + self.init_query
        try:
            conn, cur = self.set_conn()
            cur.execute(query)
        except (Exception, psycopg2.Error) as error:
            print("PostgreSQL error occured", error)
        finally:
            if conn:
                conn.commit()
                cur.close()
                conn.close()

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
        params = {"rasp7_id": rasp7_id, "group_id": group_id, "subgroup": sub_group}
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
