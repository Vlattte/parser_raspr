"""Вспомогательные структуры"""

from enum import Enum
from dataclasses import dataclass
from openpyxl.styles.colors import Color


@dataclass
class CmdParams:
    """Параметры командной строки, тоже самое, что в .env"""

    # очистка ВСЕХ таблиц перед запуском
    pre_clear: bool = False

    # файлы для парсинга
    sem_filename: str = None
    session_filename: str = None

    # даты для заполнения sc_rasp18_days
    # start_date СОВПАДАЕТ с первым днем первой недели
    start_date: str = None
    end_date: str = None

    # первый день учебы магистров
    magic_start_date: str = None

    # промежуток, который нужно перезаписать
    overwrite_date_start: str = None
    overwrite_date_end: str = None


class CellColors(list, Enum):
    """Цвета ячеек"""

    # КАФЕДРЫ
    OTHERS_DEP_COLORS = [
        Color(rgb="FFD1F3FF"),
        Color(rgb="00000000"),
    ]  # ведут другие кафедры
    VM_DEP_COLORS = [Color(rgb="FFFFF56D"), Color(rgb="FFFFE15A")]  # ведет ВМ
    VEGA_DEP_COLORS = [
        Color(rgb="FFEAFF9F"),
        Color(rgb="FFF1FF67"),
        Color(rgb="FFF4FF67"),
        Color(rgb="FFF0FF29"),
        Color(rgb="FFE5FF99"),
    ]  # ведет ВЕГА/только для ВЕГИ
    ONLY_VM_DEP_COLORS = [Color(rgb="FFFFCCFF")]  # только для подгруппы ВМ
    ONLY_VEGA_DEP_COLORS = [Color(rgb="FFCCFF66")]  # только для подгруппы ВЕГИ


class ListData(Enum):
    """Строковые данные"""

    SUBGROUPS = ["(1пг)", "(2пг)"]
    PARITY = ["Iн", "IIн"]
    WEEK_STRS = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]
