"""Вспомогательные методы для работы с ячейками таблицы"""

import re
from copy import deepcopy

from src.structs import GroupParts


def split_grouped_cells(s: str, delim: str) -> list[str]:
    """
    Разделяет объединенных преподов/аудитории на несколько
    Также убираются:
        - лишние пробелы
        - переносы строки
        - ВСЕ запятые
    """
    if s is None:
        return [None]
    if s.find(delim) == -1:
        return [s]

    parts = s.split(delim)
    symbs_to_del = [",", "\n"]
    parts = list(map(lambda part: part.strip(), parts))
    for symb in symbs_to_del:
        parts = list(map(lambda part: part.replace(symb, ""), parts))
    return parts


def separate_group_cell(group_cell: str) -> list[str]:
    """Разделяет совмещенные названия групп"""
    if "," in group_cell:
        pref = group_cell[:4]
        gr_year = group_cell[-2:]
        group_cell = group_cell.split(",")
        group_cell[0] += f"-{gr_year}"
        group_cell[1:] = list(map(lambda gr: f"{pref}-{gr}", group_cell[1:]))
    else:
        group_cell = [group_cell]

    return group_cell


def get_group_parts(group_cell: str) -> GroupParts:
    """Получить название и доп информацию по группе"""
    group_name = group_cell
    group_parts = GroupParts()

    # если есть подстрока с курсов, вытаскиваем
    kurs = re.search(r"\d курс", str(group_cell))
    if kurs is not None:
        group_parts.course = kurs.group()
        group_name = group_name.removeprefix(kurs)

    # если есть подстрока с кафедрой, пишем как подгруппу
    dep = re.search(r"\((\w)*\)", str(group_cell))
    if dep is not None:
        dep_name = dep.group().upper()
        if "ВЕГА" in dep_name:
            group_parts.sub_group = 1
        elif "ВМ" in dep_name:
            group_parts.sub_group = 2
        group_name = group_name.removesuffix(dep.group())

    group_name = group_name.replace(" ", "")
    group_parts.name = group_name
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
            legend_substr = re.search(legend_pattern, ws.cell(row, col).value)
            kurs_substr = re.search(kurs_pattern, ws.cell(row, col).value)
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


def is_hsplitter(ws, row) -> bool:
    """Является ли строка горизонтальным разделителем"""
    min_col = ws.min_column
    max_col = ws.max_column
    for col in range(min_col, max_col):
        if ws.cell(row, col).value is not None:
            return False
    return True


def get_lesson_type(lesson: str) -> str:
    """Вытащить тип пары (лк, пр, лб)"""
    lesson_type = "пр"
    lesson_copy = deepcopy(lesson)

    # чтобы избежать опечаток с пробелами, добавляем после всех точек пробел
    # Лин. алг.и ан. геом. -> Лин.алг.и ан.геом.
    lesson_copy = lesson_copy.replace(". ", ".")
    # Лин.алг.и ан.геом.   -> Лин. алг. и ан. геом.
    lesson_copy = lesson_copy.replace(".", ". ")

    if re.search(r"лк", lesson) is not None:
        lesson_type = "лк"
    if re.search(r"лб", lesson) is not None:
        lesson_type = "лб"
    return lesson_type



def get_cell_color(ws, row, col):
    """Получить цвет ячейки"""
    cell = ws.cell(row=row, column=col)
    fill = cell.fill

    color = fill.start_color

    if isinstance(color.rgb, str):
        # Это обычный RGB цвет
        if isinstance(color.rgb, str):
            return color.rgb
        return str(color.rgb)

    # Проверяем, является ли цвет тематическим
    if isinstance(color.theme, int):
        # Это тематический цвет - получаем через тему
        return get_theme_color(color.theme, color.tint)

    return None


def get_theme_color(theme_index, tint=0):
    """Преобразует тематический цвет в RGB"""
    # Стандартная палитра тематических цветов Excel
    theme_colors = [
        "FF000000",  # 0: Dark 1
        "FFFFFFFF",  # 1: Light 1
        "FFEEECE1",  # 2: Dark 2 (персиковый обычно здесь)
        "FF1F497D",  # 3: Light 2
        "FF4F81BD",  # 4: Accent 1
        "FFC0504D",  # 5: Accent 2
        "FF9BBB59",  # 6: Accent 3
        "FF8064A2",  # 7: Accent 4
        "FF4BACC6",  # 8: Accent 5
        "FFF79646",  # 9: Accent 6
    ]
    if theme_index < len(theme_colors):
        return theme_colors[theme_index]
    return "FFFFFFFF"  # Белый по умолчанию


def get_lesson_count(merged_cells, coord) -> int:
    """Если это пара как НИР или военка(смерджено около 4-5 пар), то вернуть число пар"""
    merged_range = None
    if coord in merged_cells:
        coord_pattern = coord + r":\w+\d+"
        merged_cells_list = merged_cells.sorted()
        merged_range = None
        for cell_range in merged_cells_list:
            if re.fullmatch(coord_pattern, cell_range.coord):
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
