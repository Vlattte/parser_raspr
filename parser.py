"""Парсер расписания с сайта vega.mirea.ru"""

import re
import json
import copy
import datetime
import openpyxl

import db_class

"""
Здесь основной функционал, мы парсим excel файл.
"""

WEEKS = 17
AUTUMN_SUBSTR = "ОСЕН"
SPRING_SUBSTR = "ВЕСЕН"


class XParser:
    """Парсер excel расписания"""

    def __init__(self, file_obj=None) -> None:
        """
        file - либо путь к файлу в формате str, либо байтовое представление самого файл
        """
        self.db = db_class.Database()

        self._FILE = file_obj
        self.group_row = 2
        self.weekday_col = 1
        self.para_col = 2
        self.subgroups = ["(1пг)", "(2пг)"]
        self.parity = ["Iн", "IIн"]
        self.week_strs = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]

        self.version = 0
        self.end_table_pattern = r"(\w* )?\d курс"

        today = datetime.datetime.now()
        self.cur_year = today.year

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
        ws = openpyxl.load_workbook(filename=self._FILE, read_only=True).active
        # ------------------Определяем границы расписания------------------
        min_col = ws.min_column
        max_col = ws.max_column
        max_row = ws.max_row
        # -----------------------------------------------------------------

        # получение версии расписания
        rasp_title = ws.cell(1, 1).value
        self.get_version(title=rasp_title)

        # ---------------Парсим расписание в цикле по группам--------------
        groups = {}
        for col in range(min_col, max_col + 1):
            group = ws.cell(self.group_row, col).value

            # если не группа, идем дальше
            if not group:
                continue

            # заполняем БД данными по группе
            group_id = self.db.set_group(group)
            groups[group] = self.parse_group_col(
                col, ws, max_row, rasp_title, group, group_id
            )

        return groups

    def parse_group_col(self, col, ws, max_row, title, group, group_id):
        """Парсит колонку занятия"""
        weekday_params = {}

        prev_order = 1
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

            order = ws.cell(row, self.para_col).value
            lesson_cell = ws.cell(row, col).value
            teacher = ws.cell(row, col + 1).value
            room = ws.cell(row, col + 2).value

            # если смешаная клетка
            prev_order, order = self.swap_with_prev_value(prev_order, order)
            prev_teacher, teacher = self.swap_with_prev_value(prev_teacher, teacher)
            prev_room, room = self.swap_with_prev_value(prev_room, room)

            if lesson_cell:
                if re.fullmatch(self.end_table_pattern, lesson_cell):
                    print("END OF TABLE")
                    break

                lesson_data, lesson_parts = self.make_lesson_dict(
                    lesson_cell, teacher, order, room
                )
                weekday_params[weekday].append(lesson_data)

                # заполнение БД новыми данными
                semcode = self.get_semcode(title, group)
                self.fill_db(lesson_parts, teacher, order, weekday, semcode, group_id, room)

        return weekday_params

    def get_version(self, title):
        """получить версию расписания из главного заголовка"""
        version_begin = title.index("версия")
        version_str = title[version_begin:]  # версия 13 от 27.10.2024
        VERSION_NUM_POS = 1
        self.version = version_str.split(" ")[VERSION_NUM_POS]

    def make_lesson_dict(self, lesson_cell, teacher, order, room) -> dict:
        """Создает словарь по данным пары"""
        lesson_parts = self.get_lesson_parts(lesson_cell)
        teacher_fio = teacher

        lesson_data = {
            "Порядок": order,
            "Пара": lesson_parts["disc_name"],
            "Преподаватель": teacher_fio,
            "Подгруппа": lesson_parts["sub_group"],
            "Недели": lesson_parts["weeks_list"],
            "Четность": lesson_parts["parity"],
            "Аудитория": room,
        }
        return lesson_data, lesson_parts

    def get_lesson_parts(self, lesson_cell: str) -> dict:
        """
        Разделяет пару на название дисциплины и доп информацию:
        подгруппа, недели, тип пары (лк, семинар)
        """
        lesson_parts = {
            "disc_name": "",
            "sub_group": 0,
            "parity": 0,
            "weeks_list": "null",
            "weeks_text": "null",
            "lesson_type": "null",
        }

        # получаем подгруппу
        lesson_parts["sub_group"] = self.get_subgroup(lesson_cell)
        # получаем данные по неделям
        weeks_parts = self.get_weeks_parts(lesson_cell)
        lesson_parts["parity"] = weeks_parts["parity"]
        lesson_parts["weeks_list"] = weeks_parts["weeks_list"]
        lesson_parts["weeks_text"] = weeks_parts["weeks_text"]
        # получаем тип пары (лк, семинар)
        lesson_parts["lesson_type"] = self.get_lesson_type(lesson_cell)

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
        """Вытащить тип пары (лк, семинар)"""
        lesson_type = "семинар"
        lesson_copy = copy.deepcopy(lesson)

        # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел
        # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
        lesson_copy = lesson_copy.replace(". ", ".")
        # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
        lesson_copy = lesson_copy.replace(".", ". ")

        type_pattern = r"лк"
        substring = re.search(type_pattern, lesson)
        if substring:
            lesson_type = "лекция"
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

    @staticmethod
    def get_titles(lesson_cell):
        """Получить длинное и короткое название дисциплины"""
        return "null", "null"

    # TODO переименовать
    def fill_db(
        self,
        lesson_parts: dict,
        teacher_fio: str,
        order: int,
        weekday: str,
        semcode: int,
        group_id: int,
        room: str
    ):
        """заполнение основных таблиц базы данных"""
        # таблица преподавателей
        prep_id = self.db.set_prep(fio=teacher_fio)

        # таблица дисциплин
        title, _ = self.get_titles(lesson_parts["disc_name"])
        disc_id = self.db.set_disc(
            title=title,
            shorttitle=lesson_parts["disc_name"],
            department_id=-1,  # нельзя узнать кафедру по excel расписанию
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
        if prep_id is not None:
            self.db.set_rasp7_preps(rasp7_id=rasp7_id, prep_id=prep_id)

        # заполнение аудиторий
        self.db.set_rasp7_rooms(rasp7_id=rasp7_id, room=room)

    def get_semcode(self, title: str, group: str) -> int:
        """Получение номера семестра по заголовку и названию группы"""
        # парсим заголовок и получаем четность семестра:
        # если осень - нечетный, весная - четный
        semcode = 0
        is_spring = title.find(SPRING_SUBSTR)
        if is_spring != -1:
            semcode += 1
        semcode += 1

        # получаем курс группы по ее названию и текущему году
        # КММО-01-23 - год, это последние два числа
        enter_year = group.split("-")[-1]
        group_course = self.cur_year - int(f"20{enter_year}")
        semcode += group_course * 2
        return semcode


if __name__ == "__main__":
    FILENAME = "2024autD.xlsx"
    parser = XParser(FILENAME)
    with open("shedule.json", "w", encoding="utf-8") as file:
        data = parser.parse()
        json.dump(data, file, ensure_ascii=False, indent=4)
