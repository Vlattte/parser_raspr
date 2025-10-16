"""Вспомогательные методы"""

from enum import Enum

from src.structs import ListData


class Patterns(str, Enum):
    """Часто используемые паттерны регулярок"""

    WEEK_AND_TIME = r"""((I{1,2}н).*)?      # если указан номер недели
                        (\d{1,2}:\d{2})     # время начала пары
                        \D*                 # если формат ".. с .. до ..", то тут будет ".. до .."
                        (\d{2}:\d{2})       # время конца пары
                    """  # использовать с re.VERBOSE
    SINGLE_HOUR_TIME = r"\d[:\-.]\d\d"  # время до 10 часов (одна цифра в часах)

    EXCEPT_WEEKS = r"кр.(\d(,\d))*н "
    ONLY_STUD_WEEKS = (
        r"\d+([,-](\s)?\d+)*н"  # если выбраны оперделенные недели для этой пары
    )

    ANOTHER_SUBGROUPS = r"(\d*пг)"


def swap_with_prev_value(prev_val, cur_val):
    """Если текущее значение None, присвоить ему предыдущее, иначе сохранить в предыдущее"""
    prev = prev_val
    cur = cur_val
    if not cur:
        cur = prev
    else:
        prev = cur
    return prev, cur


def get_week_parity(lesson: str) -> int:
    """Получить четность недели"""
    parity_list = ListData.PARITY.value
    for i in reversed(parity_list):
        if i in lesson:
            return parity_list.index(i) + 1
    return 0
