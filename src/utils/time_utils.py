"""Вспомогательные методы для работы с временем: даты, часы, время пары"""

import re

from copy import deepcopy

from datetime import time
from datetime import datetime

from src.utils.utils import Patterns
from src.structs import TimeFromLessonCell


def get_stud_years():
    """Получить год начала и конца учебного года"""
    today = datetime.now()
    start_year = today.year
    end_year = start_year + 1
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


def get_order_by_time(time_start: time):
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


def get_time_by_order(order: int):
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


def get_lesson_count_str(timestart: str, timeend: str) -> int:
    """Получить количество пар в промежутке времени"""
    h, m = timestart.split(":")
    t_start = time(hour=int(h), minute=int(m))
    h, m = timeend.split(":")
    t_end = time(hour=int(h), minute=int(m))

    start_order = get_order_by_time(t_start)
    end_order = get_order_by_time(t_end)
    lesson_count = end_order - start_order + 1
    return lesson_count


def get_time_from_lesson(lesson_cell: str) -> list[TimeFromLessonCell]:
    """Если в названии пары есть время, вытаскиваем"""
    time_parts = []

    all_times = re.finditer(Patterns.WEEK_AND_TIME, lesson_cell, re.VERBOSE)
    for t in all_times:
        cur_time = TimeFromLessonCell()
        timestart = t.group(3)

        # если время имеет вид "_9:30" -> делаем "09:30"
        if re.match(Patterns.SINGLE_HOUR_TIME, timestart):
            timestart = f"0{timestart}"

        cur_time.timestart = timestart
        cur_time.timeend = t.group(4)
        cur_time.weeks = t.group(2)

        time_parts.append(cur_time)
    return time_parts


def semcode_for_date(day: datetime) -> int:
    """Семкод учебного года, к которому относится дата:
    - февраль-июнь - весенний семестр (01)
    - иначе - осенний семестр текущего учебного года (00)
    """
    year = day.year
    month = day.month

    if 2 <= month <= 6:
        return int(f"{str(year - 1)[-2:]}{str(year)[-2:]}01")
    return int(f"{str(year)[-2:]}{str(year + 1)[-2:]}00")


def get_current_semcode() -> int:
    """Получает текущий семкод на основе текущей даты"""
    return semcode_for_date(datetime.now())


def make_lesson_duration(
    order: int, special_start: str = None, special_end: str = None
) -> tuple[str, str]:
    """Определить начало и конец пары"""
    # время пары
    time_start = get_time_by_order(order)
    time_end = time_in_90_minutes(time_start)

    # если было указано какое-то особое время, то записываем
    if special_start is not None:
        # если поставили НАЧАЛО пары пораньше
        time_start = deepcopy(special_start)

        # если поставили КОНЕЦ пары пораньше
        h, m = special_end.split(":")
        t_end_buf = time(hour=int(h), minute=int(m))
        time_end = min(t_end_buf, time_end)
    return time_start, time_end
