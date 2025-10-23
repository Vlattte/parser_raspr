"""Вспомогательные методы для работы со строковыми данными"""

import re

from src.structs import ListData
from src.structs import LessonParts

from src.utils.utils import Patterns
from src.utils.time_utils import get_stud_years

def get_disc_name(lesson: str, lesson_parts: LessonParts) -> str:
    """Убрать лишнее из названия дисциплины и вернуть только само название"""
    disc_name = lesson

    # убираем лишние данные про время
    disc_name = re.sub(Patterns.WEEK_AND_TIME, r"", disc_name, flags=re.VERBOSE)
    # убраем кр.1,2н (кроме таких-то недель)
    disc_name = re.sub(Patterns.EXCEPT_WEEKS, r"", disc_name)
    # убираем недели
    disc_name = re.sub(Patterns.ONLY_STUD_WEEKS, r"", disc_name)

    if lesson_parts.parity == 0 and len(lesson_parts.weeks_list) < 16:
        disc_name = disc_name.removeprefix(lesson_parts.weeks_text)
    elif lesson_parts.parity > 0:
        parity_list = ListData.PARITY.value
        parity_str = parity_list[lesson_parts.parity - 1]
        disc_name = disc_name.removeprefix(parity_str)

    # убираем тип пары
    if lesson_parts.worktype != "пр":
        disc_name = disc_name.removesuffix("лк")

    # убираем подгруппу
    if lesson_parts.sub_group != 0:
        subgroups = ListData.SUBGROUPS.value
        sub_group_str = subgroups[lesson_parts.sub_group - 1]
        disc_name = disc_name.removesuffix(sub_group_str)

    # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел

    # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
    disc_name = disc_name.replace(". ", ".")
    # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
    disc_name = disc_name.replace(".", ". ")
    # удаляем \n
    disc_name = disc_name.replace("\n", "")

    # убираем лишние пробелы по краям
    disc_name = disc_name.removeprefix(" ")
    disc_name = disc_name.removesuffix(" ")

    # костыль для подгрупп на ин.язе
    disc_name = disc_name.replace("(1*пг)", "(1*пг)\n")

    return disc_name


def is_magic_group(group_name: str):
    """Группа магистров или нет"""
    if "КММО" in group_name:
        return True
    return False


def get_worktype(disc_type: str) -> int:
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


def filepath_to_filename(filename: str):
    """Преобразовать путь до файла в название"""
    parts = filename.split("\\")
    return parts[-1]


def get_stud_years_from_title(title: str):
    """Получить год начала и конца учебного года по заголовку файла"""
    start_year, end_year = get_stud_years()

    year_pattern = r"20\d\d/\d\d"
    stud_years = re.search(year_pattern, title)

    if stud_years is not None:
        years_str = stud_years.group()
        start_year = years_str[:4]
        end_year = "20" + years_str[5:]
    return start_year, end_year


def get_version(rasp_title: str):
    """Получить версию расписания из главного заголовка"""
    version_begin = rasp_title.index("версия")
    version_str = rasp_title[version_begin:]  # версия 13 от 27.10.2024
    VERSION_NUM_POS = 1
    version = version_str.split(" ")[VERSION_NUM_POS]
    return version
