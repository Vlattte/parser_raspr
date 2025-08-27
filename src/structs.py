"""Вспомогательные структуры"""

from enum import Enum
from openpyxl.styles.colors import Color

from dataclasses import dataclass

from pydantic import BaseModel


class CmdParams(BaseModel):
    """Параметры командной строки, тоже самое, что в .env"""

    # очистка ВСЕХ таблиц перед запуском
    pre_clear: bool = False

    # файлы для парсинга
    is_sem: bool = True
    filename: str = None

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
        Color(rgb="FF000000")
    ]  # ведут другие кафедры
    VM_DEP_COLORS = [Color(rgb="FFFFF56D"), Color(rgb="FFFFE15A")]  # ведет ВМ
    VEGA_DEP_COLORS = [
        Color(rgb="FFEAFF9F"),
        Color(rgb="FFF1FF67"),
        Color(rgb="FFF4FF67"),
        Color(rgb="FFF0FF29"),
        Color(rgb="FFE5FF99"),
        Color(rgb="FFF79646")
    ]  # ведет ВЕГА/только для ВЕГИ
    ONLY_VM_DEP_COLORS = [Color(rgb="FFFFCCFF")]  # только для подгруппы ВМ
    ONLY_VEGA_DEP_COLORS = [Color(rgb="FFCCFF66")]  # только для подгруппы ВЕГИ


class ListData(Enum):
    """Строковые данные"""

    SUBGROUPS = ["(1пг)", "(2пг)"]
    PARITY = ["Iн", "IIн"]
    WEEK_STRS = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]

@dataclass
class GroupParts:
    """Части ячейки названия группы"""
    course: str = None
    name: str = None
    sub_group: int = -1

@dataclass
class LessonParts:
    """Части ячейки названия пары"""

    disc_name: str = None
    sub_group: int = 0
    parity: int = 0
    weeks_list: list[str] = None
    weeks_text: str = None
    worktype: int = 0

    timestart: str = None
    timeend: str = None


@dataclass
class WeeksParts:
    """Сведения по неделям"""

    parity: int = 0
    weeks_list: list[str] = None
    weeks_text: str = None


@dataclass
class TimeFromLessonCell:
    """Время и недели из сложных ячеек пар (например, НИР Iн 9:00-13:00)"""
    timestart: str = None   # начало пары
    timeend: str = None     # конец пары

    weeks: str = None       # недели, по которым пара в это время
