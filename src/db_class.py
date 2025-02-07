"""
Здесь класс БД
"""

from os import getenv
from datetime import datetime
from datetime import timedelta

from psycopg2 import connect
from psycopg2 import Error
from dotenv import load_dotenv
from progress.bar import PixelBar


class Database:
    """Класс работы в БД"""

    def __init__(self, pre_clear: bool = None) -> None:
        """Инициализирует БД"""
        super().__init__()

        load_dotenv()
        self.db_host = getenv("DB_HOST")
        self.db_name = getenv("DB_NAME")
        self.db_user = getenv("DB_USER")
        self.db_password = getenv("DB_PASSWORD")
        self.db_port = getenv("DB_PORT")
        self.is_pre_clear = pre_clear

        self.requests_file_name = "sql_scripts/sql_dump.sql"

        self.conn = None
        self.cur = None

        # очищать ли базу перед работой
        if self.is_pre_clear:
            self.set_conn()
            self.__clear_tables()
            print("<--TABLES CLEARED-->")
            self.close_conn()

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
                if 0 < len(return_data) < 2:
                    return_data = return_data[0][0]
                elif len(return_data) < 1:
                    return_data = None
                return return_data
        except Error as error:
            print(f"PostgreSQL error occured {error} after request:\n{query}")
        finally:
            if self.conn:
                self.conn.commit()

    def __clear_tables(self):
        """ОЧИЩАЕТ ВСЕ ТАБЛИЦЫ"""
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

    def clear_rasp_data_between_weeks(self, semcode: int, is_semestr: bool, 
                                      start_date: datetime, end_date: datetime):
        """Очистка промежутка недель от данных, чтобы в них залить новую версию
        Затрагивает таблицы, которые зависят от rasp18_id и саму sc_rasp18"""
        # включает в себя пр, лк, лб
        worktype_clause = "< 3"
        if not is_semestr:
            # включает в себя экз, зач, зач-д, к/р, к/п
            worktype_clause = "> 9"

        day_params = {"semcode": semcode, "day": start_date}
        start_day_id = self.get_id("sc_rasp18_days", day_params)
        day_params = {"semcode": semcode, "day": end_date}
        end_day_id = self.get_id("sc_rasp18_days", day_params)

        if start_date > end_date or \
             start_day_id is None or end_day_id is None:
            raise ValueError(f"Ошибка параметров OVERWRITE_DAY: начало {start_date}, конец {end_date}")

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
            raise ValueError(
                "Начальная дата позже конечной, измените файл конфигурации"
            )

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
        prep_id: int,
        room: str
    ):
        """
        ячейка в таблице расписания
        kind integer  -- 0обычное,1перенос,2повтор
        worktype integer -– 0пр,1лк,2лб,
            -- 11экз,12зач,13зач-д,
            -- 14кр,15кп
        """
        # у одной и той же группы у такой же подгруппы не может
        # быть две пары одновременно
        table_name = "sc_rasp18"

        if day_id is None:
            raise ValueError("Ошибка в датах! Невозможно продолжать парсинг, устраните ошибки с параметрами START_DATE и END_DATE")

        # только часы и минуты, секунды образаем
        timestart_hm = timestart[:-3]
        timeend_hm = timeend[:-3]

        if prep_id is not None and room is not None:
            exists_query = f"""
        SELECT r18.id FROM sc_rasp18 r18
            INNER JOIN sc_rasp18_preps p ON r18.id = p.rasp18_id
            INNER JOIN sc_rasp18_rooms r ON r18.id = r.rasp18_id
        WHERE semcode = {semcode} AND day_id = {day_id} AND pair = {pair}
            AND kind = {kind} AND worktype = {worktype} AND disc_id = {disc_id}
            AND timestart = '{timestart_hm}' AND timeend = '{timeend_hm}'
            AND p.prep_id = {prep_id} AND r.room = '{room}';
        """
            rasp18_id = self.send_request(exists_query, is_return=True)
            if rasp18_id is not None:
                return rasp18_id

        query = f"""
                INSERT INTO {table_name} 
                (semcode, day_id, pair, kind, worktype, disc_id, timestart, timeend)
                VALUES 
                ({semcode}, {day_id}, {pair}, {kind}, {worktype}, 
                {disc_id}, '{timestart_hm}', '{timeend_hm}')
                ON CONFLICT DO NOTHING RETURNING id;"""
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

    def get_week(self, day: datetime, semcode: int) -> int:
        """Получить номер недели"""
        query = f"""
        SELECT week FROM sc_rasp18_days WHERE day = date('{day}') AND semcode = {semcode};
        """
        week = self.send_request(query=query, is_return=True)
        return week
