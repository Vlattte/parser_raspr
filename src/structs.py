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
