"""Вспомогательные структуры"""

from enum import Enum
from openpyxl.styles.colors import Color


class CellColors(Enum):
    """Цвета ячеек"""

    # общее оформление
    BORDER = Color(rgb="FF595959")
    TITLE = Color(rgb="FF000000")
    ORDER = Color(rgb="FFD9D9D9")
    # кафедры
    OTHERS_DEP = Color(rgb="FFD1F3FF")  # ведут другие кафедры
    VM_DEP = Color(rgb="FFFFF56D")  # ведет ВМ
    VEGA_DEP = Color(rgb="FFEAFF9F")  # ведет ВЕГА/только для ВЕГИ
    ONLY_VM_DEP = Color(rgb="FFFFCCFF")  # только для подгруппы ВМ


class ListData(Enum):
    """Строковые данные"""

    SUBGROUPS = ["(1пг)", "(2пг)"]
    PARITY = ["Iн", "IIн"]
    WEEK_STRS = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]
