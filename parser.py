"""Парсер расписания с сайта vega.mirea.ru"""

import os
import re
import json
import copy
import datetime
import openpyxl
import openpyxl.styles.colors

import db_class

from dotenv import load_dotenv

load_dotenv()

WEEKS = 17
AUTUMN_SUBSTR = "осен"
SPRING_SUBSTR = "весен"
WINTER_SUBSTR = "зимн"
SUMMER_SUBSTR = "летн"

# TODO распараллелить, а то долго


class XParser:
    """Парсер excel расписания"""

    def __init__(self) -> None:
        """
        file - либо путь к файлу в формате str, либо байтовое представление самого файл
        """
        self.db = db_class.Database()

        # тип файла для парсинга
        # TODO пока идет как параметр в .env, а так фомжно брать из главного заголовка файла
        self.parse_type = os.getenv("PARSE_TYPE")
        if self.parse_type is None:
            self.parse_type = "DEFAULT"

        self.file_name = os.getenv("FILENAME")
        if self.file_name is None:
            raise ValueError("Не выбран файл для парсинга")

        if not os.path.exists(self.file_name):
            raise ValueError("Выбран несуществующий файл")

        self.group_row = 2
        self.weekday_col = 1
        self.para_col = 2

        # позиция ячейки с версией
        self.version_col = 1

        self.subgroups = ["(1пг)", "(2пг)"]
        self.parity = ["Iн", "IIн"]
        self.week_strs = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]

        self.version = 0
        self.end_table_pattern = r"(\w* )?\d курс"
        self.start_date = os.getenv("START_DATE")
        self.end_date = os.getenv("END_DATE")

        if self.parse_type == "SESSION":
            self.change_to_session_params()

    def change_to_session_params(self):
        """Меняет некоторые стандартные параметры на параметры расписания сессии"""
        self.version_col = 2
        self.group_row = 4

    @staticmethod
    def swap_with_prev_value(prev_val, cur_val):
        """Если текущее значение None, присвоить ему предыдущее, иначе сохранить в предыдущее"""
        prev = prev_val
        cur = cur_val
        if not cur:
            cur = prev
        else:
            prev = cur
        return prev, cur

    def parse(self) -> dict:
        """Парсим данные"""
        ws = openpyxl.load_workbook(filename=self.file_name, read_only=True).active
        # ------------------Определяем границы расписания------------------
        min_col = ws.min_column
        max_col = ws.max_column
        max_row = self.get_max_row(ws)
        # -----------------------------------------------------------------

        # получение версии расписания
        rasp_title = ""
        today = datetime.datetime.now()
        # Год начала и конца семестра
        rasp_years = [str(today.year), str(today.year + 1)]
        for row in range(1, max_row):
            rasp_title = ws.cell(row, self.version_col).value
            if rasp_title is None or not isinstance(rasp_title, str):
                continue

            # если учебный год есть
            stud_year_idx = rasp_title.find("учебного года")
            if stud_year_idx != -1:
                rasp_years.clear()
                str_years = rasp_title[stud_year_idx - 8 : stud_year_idx - 1]
                start_year = str_years[:4]
                end_year = "20" + str_years[5:]
                rasp_years.append(start_year)
                rasp_years.append(end_year)

            # если версия есть
            if rasp_title.find("версия") != -1:
                self.get_version(title=rasp_title)
                break

        # TODO ВНИМАНИЕ, костыль, надо убрать
        # заполняем кафедры
        self.db.fill_departments()
        # заполняем дни таблицы rasp18_days
        if self.parse_type == "SESSION":
            self.db.fill_rasp18_for_period(self.start_date, self.end_date)

        # ---------------Парсим расписание в цикле по группам--------------
        groups = {}
        for col in range(min_col, max_col + 1):
            group_name = ws.cell(self.group_row, col).value
            # если заголовок столбца пустой, пропускаем
            if not group_name:
                continue

            # temp
            print(group_name)

            if self.parse_type == "SESSION":
                group_name = self.get_group_name(group_name)

            # заполняем БД данными по группе
            group_id = self.db.set_group(group_name)
            group_data = {}
            if self.parse_type == "DEFAULT":
                group_data = self.parse_default_col(
                    col, ws, max_row, rasp_title, group_name, group_id
                )
            elif self.parse_type == "SESSION":
                self.parse_exam_col(
                    col, ws, max_row, rasp_title, group_name, group_id, rasp_years
                )
            groups[group_name] = group_data

        return groups

    def get_max_row(self, ws):
        """Находим последнюю значимую строку"""
        max_row = ws.max_row
        max_col = ws.max_column
        legend_pattern = r"(\w)*егенд[\w\s]*"

        for row in range(max_row, 1, -1):
            for col in range(max_col, 1, -1):
                cur_cell = ws.cell(row, col).value
                if cur_cell is None:
                    continue
                # если нашли строку со словом "легенда", то далее ищем первую значимую строку
                if re.fullmatch(legend_pattern, ws.cell(row, col).value):
                    max_row = row
                    break
            if max_row != ws.max_row:
                break

        for row in range(max_row - 1, 1, -1):
            if not self.is_hsplitter(ws, row):
                return row
        return max_row

    def get_version(self, title):
        """получить версию расписания из главного заголовка"""
        version_begin = title.index("версия")
        version_str = title[version_begin:]  # версия 13 от 27.10.2024
        VERSION_NUM_POS = 1
        self.version = version_str.split(" ")[VERSION_NUM_POS]

    @staticmethod
    def get_group_name(group_cell: str) -> str:
        """
        Делит ячейку группы на части:
        1 курс\nКМБО-47-25
        return: название группы(str)
        """
        _, group_name = group_cell.split("\n")
        return group_name

    def parse_default_col(self, col, ws, max_row, title, group, group_id):
        """Разбор колонки группы"""
        weekday_params = {}

        # TODO сюда (наверное) можно перенести просто order, weekday, teacher и room
        order = 1
        prev_weekday = "ПН"
        prev_teacher = "null"
        prev_room = "null"
        # проходимся по текущему столбцу по всем строкам
        for row in range(self.group_row + 1, max_row):
            weekday = ws.cell(row, self.weekday_col).value

            # если новый день недели
            if prev_weekday != weekday and weekday:
                prev_weekday = weekday
                prev_teacher = "null"
                prev_room = "null"

            weekday = prev_weekday
            if weekday not in weekday_params:
                weekday_params[weekday] = []

            # вытаскиваем данные по учебному дню этой группы
            cur_order = ws.cell(row, self.para_col).value
            lesson_cell = ws.cell(row, col).value
            teacher = ws.cell(row, col + 1).value
            room = ws.cell(row, col + 2).value

            # по цвету определяем пренадлежность к кафедре
            cur_color = ws.cell(row, col).fill.start_color.index
            department_id = self.get_dep_id(cel_color=cur_color)

            # если смешаная клетка
            if cur_order is not None:
                order = cur_order
            # prev_order, order = self.swap_with_prev_value(prev_order, order)
            prev_teacher, teacher = self.swap_with_prev_value(prev_teacher, teacher)
            prev_room, room = self.swap_with_prev_value(prev_room, room)

            if lesson_cell:
                if re.fullmatch(self.end_table_pattern, lesson_cell):
                    print("END OF TABLE")
                    break

                lesson_parts = self.get_lesson_parts(lesson_cell)
                lesson_data = self.make_lesson_dict(lesson_parts, teacher, order, room)
                weekday_params[weekday].append(lesson_data)

                # заполнение БД новыми данными
                semcode = self.get_semcode(title, group)
                self.fill_group_day_db(
                    lesson_parts,
                    teacher,
                    order,
                    weekday,
                    semcode,
                    group_id,
                    room,
                    department_id,
                )

        return weekday_params

    def parse_exam_col(self, col, ws, max_row, title, group, group_id, rasp_years):
        """Разбор колонки расписания экзаменов"""
        prev_date_cell = None
        row = self.group_row + 2

        # проходимся по текущему столбцу по всем строкам
        while row < max_row:
            date_cell = ws.cell(row, self.para_col).value
            # если следующий день
            prev_date_cell, date_cell = self.swap_with_prev_value(
                prev_date_cell, date_cell
            )
            exam_date, weekday = date_cell.split("\n")

            exam_type = ws.cell(row, col + 1).value
            lesson_name = ws.cell(row + 1, col).value
            teacher = ws.cell(row + 2, col).value
            room = ws.cell(row + 2, col + 1).value

            # время начала экзамена
            time_start = ws.cell(row, col).value
            time_end = time_start

            if time_start is None:
                # если только эта строка пустая, то это разделитель
                is_splitter_row = self.is_hsplitter(ws, row)
                if is_splitter_row:
                    row += 1
                    continue

                # если все ячейки данных по экзамену пустые
                if lesson_name is None and teacher is None:
                    row += 3
                    continue

                # если предмет не пустой, то ставим на 4 пары
                if teacher is None:
                    time_start = datetime.time(hour=9, minute=0)
                    time_end = datetime.time(hour=15, minute=50)

            # ставим длительность экзамена 1.5 часа (2 академ часа)
            else:
                time_end = self.time_in_90_minutes(time_start)

            cur_order = self.get_order_by_time(time_start)
            last_order = self.get_order_by_time(time_end)

            # Заполение таблиц
            month = int(exam_date[-2:])
            if month > 8:
                exam_date += "." + rasp_years[0]
            else:
                exam_date += "." + rasp_years[1]

            semcode = self.get_semcode(title, group)
            weekday_num = self.week_strs.index(weekday.upper())
            week = self.db.get_week_by_date(exam_date)
            worktype = self.get_worktype_id(exam_type)
            disc_id = self.get_disc_id(lesson_name)

            # если перепутали название дисциплины, добавим такую
            if disc_id is None:
                cur_color = ws.cell(row, col + 1).fill.start_color.index
                department_id = self.get_dep_id(cel_color=cur_color)

                disc_id = self.db.set_disc(
                    title="null",
                    shorttitle=lesson_name,
                    department_id=department_id,
                    varmask="null",
                )

            # если новый день, то добавляем
            rasp18_days_id = self.db.set_rasp18_days(
                semcode=1, day=exam_date, weekday=weekday_num, week=week
            )
            # set_rasp18
            # for pair in range(cur_order, last_order+1):
            rasp18_id = self.db.set_rasp18(
                semcode=semcode,
                day_id=rasp18_days_id,
                pair=cur_order,
                kind=0,
                worktype=worktype,
                disc_id=disc_id,
                timestart=str(time_start),
                timeend=str(time_end),
            )
            # set_rasp18_groups
            self.db.set_rasp18_groups(
                rasp18_id=rasp18_id, group_id=group_id, subgroup=0
            )
            # set_rasp18_preps
            if teacher is not None:
                # TODO добавить, когда можно будет делить преподов ведущих одну пару
                # teacher = teacher.replace(", ", ",")
                # if teacher.find("\n") != -1 or teacher.find(",\n") != -1:
                #     teachers = teacher.split(",\n")
                #     if len(teachers) < 2:
                #         teachers = teacher.split("\n")
                #     for t in teachers:
                #         t = t.replace("\n", "")
                #         params = {"fio": t}
                #         prep_id = self.db.get_id(
                #             table_name="sc_prep", params=params)
                #         # если перепутали имя препода, добавим такую
                #         if prep_id is None:
                #             prep_id = self.db.set_prep(fio=t, chair="null",
                #                                        degree="null", photo="null")
                #         self.db.set_rasp18_preps(
                #             rasp18_id=rasp18_id, prep_id=prep_id)
                # else:
                params = {"fio": teacher}
                prep_id = self.db.get_id(table_name="sc_prep", params=params)
                # если перепутали имя препода, добавим такую
                if prep_id is None:
                    prep_id = self.db.set_prep(
                        fio=teacher, chair="null", degree="null", photo="null"
                    )
                self.db.set_rasp18_preps(rasp18_id=rasp18_id, prep_id=prep_id)
            # set_rasp18_rooms
            if room is not None:
                self.db.set_rasp18_rooms(rasp18_id=rasp18_id, room=room)

            # пропускаем уже разобранные ячейки экзамена
            row += 3

    def make_lesson_dict(self, lesson_parts, teacher_fio, order, room) -> dict:
        """Создает словарь по данным пары"""
        lesson_data = {
            "Порядок": order,
            "Пара": lesson_parts["disc_name"],
            "Преподаватель": teacher_fio,
            "Подгруппа": lesson_parts["sub_group"],
            "Недели": lesson_parts["weeks_list"],
            "Четность": lesson_parts["parity"],
            "Аудитория": room,
        }
        return lesson_data

    def get_lesson_parts(self, lesson_cell: str) -> dict:
        """
        Разделяет пару на название дисциплины и доп информацию:
        подгруппа, недели, тип пары (лк, семинар)
        """
        lesson_parts = {
            "disc_name": "",
            "sub_group": self.get_subgroup(lesson_cell),
            "parity": 0,
            "weeks_list": "null",
            "weeks_text": "null",
            "worktype": "null",
        }

        # получаем тип пары (лк, семинар)
        lesson_type = self.get_lesson_type(lesson_cell)
        worktype = self.get_worktype_id(lesson_type)
        # получаем подгруппу
        # получаем данные по неделям
        weeks_parts = self.get_weeks_parts(lesson_cell)
        lesson_parts["parity"] = weeks_parts["parity"]
        lesson_parts["weeks_list"] = weeks_parts["weeks_list"]
        lesson_parts["weeks_text"] = weeks_parts["weeks_text"]
        lesson_parts["worktype"] = worktype

        # удаляем лишнее и получаем название дисциплины
        lesson_parts["disc_name"] = self.get_disc_name(lesson_cell, lesson_parts)

        return lesson_parts

    def get_subgroup(self, lesson: str) -> int:
        """Получить подгруппу"""
        for subgroup in self.subgroups:
            if subgroup in lesson:
                return self.subgroups.index(subgroup) + 1
        return 0

    def get_weeks_parts(self, lesson: str) -> dict:
        """Получить номера недель, когда будет пара"""
        all_weeks = list(range(1, WEEKS))
        weeks_text = ", ".join(map(str, all_weeks))

        weeks_parts = {"parity": 0, "weeks_list": all_weeks, "weeks_text": weeks_text}

        parity = self.get_week_parity(lesson)
        weeks_parts["parity"] = parity
        # генирируем массив всех недель
        if parity != 0:
            weeks_parts["weeks_list"] = list(range(parity, WEEKS, 2))
            weeks_parts["weeks_text"] = self.parity[parity - 1]
            return weeks_parts

        pattern = r"\d+(,(\s)?\d+)*н"
        substring = re.search(pattern, lesson)
        if substring:
            # проверяем наличие недельного распределения
            weeks_parts["weeks_text"] = substring.group()
            substring = substring.group().removesuffix("н")
            weeks = substring.split(",")
            weeks_parts["weeks_list"] = list(map(int, weeks))
            return weeks_parts

        return weeks_parts

    def get_week_parity(self, lesson: str) -> int:
        """Получить четность недели"""
        for i in reversed(self.parity):
            if i in lesson:
                return self.parity.index(i) + 1
        return 0

    def get_lesson_type(self, lesson: str) -> str:
        """Вытащить тип пары (лк, пр, лб)"""
        lesson_type = "пр"
        lesson_copy = copy.deepcopy(lesson)

        # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел
        # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
        lesson_copy = lesson_copy.replace(". ", ".")
        # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
        lesson_copy = lesson_copy.replace(".", ". ")

        if re.search(r"лк", lesson):
            lesson_type = "лк"
        if re.search(r"лб", lesson):
            lesson_type = "лб"
        return lesson_type

    def get_disc_name(self, lesson: str, lesson_parts: dict) -> str:
        """Убрать лишнее из названия дисциплины и вернуть только само название"""
        disc_name = copy.deepcopy(lesson)

        # убираем недели
        if lesson_parts["parity"] == 0 and len(lesson_parts["weeks_list"]) < 16:
            disc_name = disc_name.removeprefix(lesson_parts["weeks_text"])
        elif lesson_parts["parity"] > 0:
            parity_str = self.parity[lesson_parts["parity"] - 1]
            disc_name = disc_name.removeprefix(parity_str)

        # убираем тип пары
        if lesson_parts["lesson_type"] != "семинар":
            disc_name = disc_name.removesuffix("лк")

        # убираем подгруппу
        if lesson_parts["sub_group"] != 0:
            sub_group_str = self.subgroups[lesson_parts["sub_group"] - 1]
            disc_name = disc_name.removesuffix(sub_group_str)

        # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел

        # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
        disc_name = disc_name.replace(". ", ".")
        # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
        disc_name = disc_name.replace(".", ". ")

        # убираем лишние пробелы по краям
        disc_name = disc_name.removeprefix(" ")
        disc_name = disc_name.removesuffix(" ")

        return disc_name

    def get_semcode(self, title: str, group: str) -> int:
        """Получение номера семестра по заголовку и названию группы"""
        # парсим заголовок и получаем четность семестра:
        # если осень - нечетный, весная - четный
        semcode = 0
        low_title = title.lower()
        is_spring = low_title.find(SPRING_SUBSTR)
        is_autumn = low_title.find(AUTUMN_SUBSTR)
        # если это весенний семестр, или летняя сессия, то четный семестр
        if is_spring != -1 or is_autumn != -1:
            semcode += 1
        semcode += 1

        # получаем курс группы по ее названию и текущему году
        # КММО-01-23 - год, это последние два числа
        enter_year = group.split("-")[-1]
        today = datetime.datetime.now()
        group_course = today.year - int(f"20{enter_year}")
        semcode += (group_course - 1) * 2
        return semcode

    @staticmethod
    def get_titles(lesson_cell):
        """Получить длинное и короткое название дисциплины"""
        return "null", "null"

    @staticmethod
    def get_order_by_time(time_start):
        """Определение номера пары по ее времени"""
        order = 1
        if time_start < datetime.time(10, 40):
            order = 1
        elif time_start < datetime.time(12, 40):
            order = 2
        elif time_start < datetime.time(14, 20):
            order = 3
        elif time_start < datetime.time(16, 20):
            order = 4
        elif time_start < datetime.time(18, 00):
            order = 5
        elif time_start < datetime.time(19, 40):
            order = 6
        else:
            order = 7
        return order

    @staticmethod
    def get_time_by_order(order):
        """Получить время начала пары"""
        time_start = "null"
        match order:
            case 1:
                time_start = datetime.time(9, 00)
            case 2:
                time_start = datetime.time(10, 40)
            case 3:
                time_start = datetime.time(12, 40)
            case 4:
                time_start = datetime.time(14, 40)
            case 5:
                time_start = datetime.time(16, 20)
            case 6:
                time_start = datetime.time(18, 00)
            case 7:
                time_start = datetime.time(19, 40)
        return time_start

    @staticmethod
    def time_in_90_minutes(time_start):
        """Получить время через 1.5 часа"""
        end_minutes = (time_start.minute + 30) % 60
        end_hour = time_start.hour + 1

        # если перешли в следующий час
        if end_minutes < 30:
            end_hour += 1
        time_end = datetime.time(end_hour, end_minutes)
        return time_end

    @staticmethod
    def is_hsplitter(ws, row) -> bool:
        """Является ли строка горизонтальным разделителем"""
        min_col = ws.min_column
        max_col = ws.max_column
        for col in range(min_col, max_col):
            if ws.cell(row, col).value is not None:
                return False
        return True

    # TODO переименовать
    def fill_group_day_db(
        self,
        lesson_parts: dict,
        teacher: str,
        order: int,
        weekday: str,
        semcode: int,
        group_id: int,
        room: str,
        department_id: int,
    ):
        """Заполнение таблиц по данным одного дня недели определенной группы"""
        # таблица дисциплин
        title, _ = self.get_titles(lesson_parts["disc_name"])
        disc_id = self.db.set_disc(
            title=title,
            shorttitle=lesson_parts["disc_name"],
            department_id=department_id,
            varmask="null",
        )

        # таблица расписания
        weekday_num = self.week_strs.index(weekday)
        rasp7_id = self.db.set_rasp7(
            semcode=semcode,
            version=self.version,
            disc_id=disc_id,
            weekday=weekday_num,
            pair=order,
            weeksarray=lesson_parts["weeks_list"],
            weekstext=lesson_parts["weeks_text"],
        )

        # таблица связи пары
        self.db.set_rasp7_groups(
            rasp7_id=rasp7_id, group_id=group_id, sub_group=lesson_parts["sub_group"]
        )

        # распределение пар по преподавателям
        disc_teachers = []
        if teacher.find("\n") != -1:
            disc_teachers = teacher.split("\n")
        else:
            disc_teachers.append(teacher)

        # если преподавателей несколько, делаем несколько записей
        prep_ids = []
        for t in disc_teachers:
            # таблица преподавателей
            prep_ids.append(self.db.set_prep(fio=t))

        for prep_id in prep_ids:
            if prep_id is not None:
                self.db.set_rasp7_preps(rasp7_id=rasp7_id, prep_id=prep_id)

        # заполнение аудиторий
        self.db.set_rasp7_rooms(rasp7_id=rasp7_id, room=room)
        self.fill_rasp18_for_disc(
            lesson_parts["weeks_list"],
            weekday,
            semcode,
            order,
            lesson_parts["worktype"],
            disc_id,
        )

    def fill_rasp18_for_disc(
        self, weeksarray, weekday, semcode, order, worktype, disc_id
    ):
        """Заполнение rasp18 для дисциплины на до конца семестра"""
        day = self.start_date
        day_order = (self.week_strs[weekday] - 1) % 7
        date = datetime.datetime.strptime(day, "%Y-%m-%d").date()
        if day_order != date.weekday:
            order_delta = abs(day_order - date.weekday)
            day += order_delta
            print(day)

        for week in weeksarray:

            params = {"semcode": semcode, "day": day, "weekday": weekday, "week": week}
            day_id = self.db.get_id(table_name="sc_rasp18_days", params=params)
            time_start = self.get_time_by_order(order)
            time_end = self.time_in_90_minutes(time_start)
            self.db.set_rasp18(
                semcode=semcode,
                day_id=day_id,
                pair=order,
                kind=0,
                worktype=worktype,
                disc_id=disc_id,
                timestart=time_start,
                timeend=time_end,
            )

    @staticmethod
    def get_worktype_id(disc_type: str):
        """Получить id типа дисциплины по строковому представлению:
        - 0-пр, 1-лк, 2-лб
        - 10-конс, 11-экз, 12-зaч, 13-зaч-д
        - 14-кр, 15-кп
        """
        # изначально без типа пары
        worktype_id = -1
        match disc_type:
            # просто пары
            case "пр":
                worktype_id = 0
            case "лк":
                worktype_id = 1
            case "лб":
                worktype_id = 2
            # экзамены
            case "конс.":
                worktype_id = 10
            case "экзамен":
                worktype_id = 11
            case "зачет":
                worktype_id = 12
            case "зачет-д":
                worktype_id = 13
            # сдача работ
            case "к/р":
                worktype_id = 14
            case "к/п":
                worktype_id = 15
        return worktype_id

    def get_disc_id(self, lesson_name: str) -> int:
        """Получить id дисциплины по названию"""
        params = {"shorttitle": lesson_name}
        disc_id = self.db.get_id(table_name="sc_disc", params=params)
        return disc_id

    def get_dep_id(self, cel_color: int) -> int:
        """Получить по цвету ячейки id кафедры"""
        department_name = "ВЕГА"
        match cel_color:
            case "FFCCFF66":
                department_name = "только для ВЕГИ"
            case "FFFFCCFF":
                department_name = "только для ВМ"
            case "FFFFE15A":
                department_name = "ВМ"
            case "FFF1FF67":
                department_name = "ВЕГА"
            case "FFE5FF99":
                department_name = "ВЕГА"
            case "FFB2ECFF":
                department_name = "другая"

        dep_params = {"title": department_name}
        department_id = self.db.get_id("sc_department", {dep_params})
        return department_id


if __name__ == "__main__":
    parser = XParser()
    with open("shedule.json", "w", encoding="utf-8") as file:
        data = parser.parse()
        # json.dump(data, file, ensure_ascii=False, indent=4)
