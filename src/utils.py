"""Вспомогательные методы"""

from re import search
from re import fullmatch
from re import sub
from re import finditer

from enum import Enum

from copy import deepcopy
from datetime import datetime, time

from src.structs import ListData


class Patterns(str, Enum):
    """Часто используемые паттерны для регулярок"""
    WEEK_AND_TIME = r".*(\d{1,2}:\d{1,2})(\D)*(\d{1,2}:\d{1,2})"


def get_group_parts(group_cell: str) -> dict:
    """Получить название и доп информацию по группе"""
    group_name = group_cell
    group_parts = {"course": -1, "name": "", "sub_group": -1}

    # если есть подстрока с курсов, вытаскиваем
    kurs = search(r"\d курс", group_cell)
    if kurs is not None:
        group_parts["course"] = kurs.group()
        group_name = group_name.removeprefix(kurs)

    # если есть подстрока с кафедрой, пишем как подгруппу
    dep = search(r"\((\w)*\)", group_cell)
    if dep is not None:
        dep_name = dep.group().upper()
        if "ВЕГА" in dep_name:
            group_parts["sub_group"] = 1
        elif "ВМ" in dep_name:
            group_parts["sub_group"] = 2
        group_name = group_name.removesuffix(dep.group())

    group_name = group_name.replace(" ", "")
    group_parts["name"] = group_name
    return group_parts


def get_max_row(ws):
    """Находим последнюю значимую строку"""
    max_row = None
    legend_pattern = r"(\w)*егенд[\w\s]*"
    kurs_pattern = r"\d курс"

    for row in range(ws.max_row, 1, -1):
        for col in range(ws.max_column, 1, -1):
            cur_cell = ws.cell(row, col).value
            if cur_cell is None:
                continue
            # если нашли строку со словом "легенда", то далее ищем первую значимую строку
            legend_substr = search(legend_pattern, ws.cell(row, col).value)
            kurs_substr = search(kurs_pattern, ws.cell(row, col).value)
            if legend_substr is not None or kurs_substr is not None:
                max_row = row
                break
        if max_row is not None:
            break

    if max_row is None:
        max_row = ws.max_row

    for row in range(max_row - 1, 1, -1):
        if not is_hsplitter(ws, row):
            return row
    return max_row


def get_lesson_type(lesson: str) -> str:
    """Вытащить тип пары (лк, пр, лб)"""
    lesson_type = "пр"
    lesson_copy = deepcopy(lesson)

    # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел
    # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
    lesson_copy = lesson_copy.replace(". ", ".")
    # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
    lesson_copy = lesson_copy.replace(".", ". ")

    if search(r"лк", lesson) is not None:
        lesson_type = "лк"
    if search(r"лб", lesson) is not None:
        lesson_type = "лб"
    return lesson_type


def get_stud_years(title: str):
    """Получить год начала и конца учебного года"""
    today = datetime.now()
    start_year = today.year
    end_year = start_year + 1

    year_pattern = r"20\d\d/\d\d"
    stud_years = search(year_pattern, title)

    if stud_years is not None:
        years_str = stud_years.group()
        start_year = years_str[:4]
        end_year = "20" + years_str[5:]
    return start_year, end_year


def get_stud_period(semcode: int):
    """Формируем границы учебного семестра"""
    season = str(semcode)[:2]
    start_year = str(semcode)[2:4]
    end_year = str(semcode)[4:]
    start_date = ""
    end_date = ""
    # если осенний семестр
    if season == "00":
        start_date = f"20{start_year}-09-01"
        end_date = f"20{end_year}-02-07"
    else:
        start_date = f"20{start_year}-02-07"
        end_date = f"20{end_year}-07-07"
    return start_date, end_date


def get_order_by_time(time_start):
    """Определение номера пары по ее времени"""
    order = 1
    if time_start < time(10, 30):
        order = 1
    elif time_start < time(12, 10):
        order = 2
    elif time_start < time(14, 10):
        order = 3
    elif time_start < time(15, 50):
        order = 4
    elif time_start < time(17, 50):
        order = 5
    elif time_start < time(19, 30):
        order = 6
    else:
        order = 7
    return order


def get_time_by_order(order):
    """Получить время начала пары"""
    time_start = "null"
    match order:
        case 1:
            time_start = time(9, 00)
        case 2:
            time_start = time(10, 40)
        case 3:
            time_start = time(12, 40)
        case 4:
            time_start = time(14, 20)
        case 5:
            time_start = time(16, 20)
        case 6:
            time_start = time(18, 00)
        case 7:
            time_start = time(19, 40)
    return time_start


def time_in_90_minutes(time_start):
    """Получить время через 1.5 часа"""
    end_minutes = (time_start.minute + 30) % 60
    end_hour = time_start.hour + 1

    # если перешли в следующий час
    if end_minutes < 30:
        end_hour += 1
    time_end = time(end_hour, end_minutes)
    return time_end


def is_hsplitter(ws, row) -> bool:
    """Является ли строка горизонтальным разделителем"""
    min_col = ws.min_column
    max_col = ws.max_column
    for col in range(min_col, max_col):
        if ws.cell(row, col).value is not None:
            return False
    return True


def get_version(rasp_title: str):
    """Получить версию расписания из главного заголовка"""
    version_begin = rasp_title.index("версия")
    version_str = rasp_title[version_begin:]  # версия 13 от 27.10.2024
    VERSION_NUM_POS = 1
    version = version_str.split(" ")[VERSION_NUM_POS]
    return version


def get_worktype(disc_type: str):
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


def swap_with_prev_value(prev_val, cur_val):
    """Если текущее значение None, присвоить ему предыдущее, иначе сохранить в предыдущее"""
    prev = prev_val
    cur = cur_val
    if not cur:
        cur = prev
    else:
        prev = cur
    return prev, cur


def get_lesson_count(merged_cells, coord) -> int:
    """Если это пара как НИР или военка(смерджено около 4-5 пар), то вернуть число пар"""
    merged_range = None
    if coord in merged_cells:
        coord_pattern = coord + r":\w+\d+"
        merged_cells_list = merged_cells.sorted()
        merged_range = None
        for cell_range in merged_cells_list:
            if fullmatch(coord_pattern, cell_range.coord):
                merged_range = cell_range
                break
    if merged_range is None:
        return 1

    # смотрим нижнюю строку, чтобы посчитать сколько нужно пар
    lesson_count = merged_range.max_row - merged_range.min_row
    if lesson_count > 2:
        lesson_count += 1
        # делим на 2, так как каждая ячейка содержит четную и нечетные недели
        return int(lesson_count / 2)
    return 1


def get_time_from_lesson(lesson_cell: str) -> list:
    """Если в названии пары есть время, вытаскиваем"""
    return []
    time_parts = []

    replace_pattern = r"\1-\3"
    week_pattern = r"I{1,2}н"

    all_times = finditer(Patterns.WEEK_AND_TIME, lesson_cell)
    for t in all_times:
        time_dict = {"timestart": None, "timeend": None, "weeks": None}
        lesson_duration = sub(Patterns.WEEK_AND_TIME, replace_pattern, t.group())
        timestart, timeend = lesson_duration.split("-")

        time_dict["timestart"] = timestart
        time_dict["timeend"] = timeend
        time_dict["weeks"] = search(t, week_pattern)

        time_parts.append(time_dict)
    return time_parts


def get_week_parity(lesson: str) -> int:
    """Получить четность недели"""
    parity_list = ListData.PARITY.value
    for i in reversed(parity_list):
        if i in lesson:
            return parity_list.index(i) + 1
    return 0


def get_disc_name(lesson: str, lesson_parts: dict) -> str:
    """Убрать лишнее из названия дисциплины и вернуть только само название"""
    disc_name = lesson

    # убираем недели
    if lesson_parts["parity"] == 0 and len(lesson_parts["weeks_list"]) < 16:
        disc_name = disc_name.removeprefix(lesson_parts["weeks_text"])
    elif lesson_parts["parity"] > 0:
        parity_list = ListData.PARITY.value
        parity_str = parity_list[lesson_parts["parity"] - 1]
        disc_name = disc_name.removeprefix(parity_str)

    # убираем тип пары
    if lesson_parts["worktype"] != "пр":
        disc_name = disc_name.removesuffix("лк")

    # убираем подгруппу
    if lesson_parts["sub_group"] != 0:
        subgroups = ListData.SUBGROUPS.value
        sub_group_str = subgroups[lesson_parts["sub_group"] - 1]
        disc_name = disc_name.removesuffix(sub_group_str)

    # убираем лишние данные про время
    disc_name = sub(Patterns.WEEK_AND_TIME, "", disc_name)    

    # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел

    # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
    disc_name = disc_name.replace(". ", ".")
    # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
    disc_name = disc_name.replace(".", ". ")

    # убираем лишние пробелы по краям
    disc_name = disc_name.removeprefix(" ")
    disc_name = disc_name.removesuffix(" ")

    return disc_name


def is_magic_group(group_name: str):
    """Группа магистров или нет"""
    if "КММО" in group_name:
        return True
    return False
