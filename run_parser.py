"""Файл запуска парсера"""

from argparse import ArgumentParser
from os import getenv

from dotenv import load_dotenv

from src.parser import VegaRaspParser
from src.structs import CmdParams


load_dotenv()

def is_params_good(cmd_params: CmdParams) -> bool:
    """Проверка на корректность переданных аргументов"""
    if cmd_params.sem_filename is None and cmd_params.session_filename is None:
        print("Не заданы файлы для парсинга, будет использован .env для парсинга")
        return False

    if cmd_params.start_date is None or cmd_params.end_date is None:
        print("Не задана одна или обе даты периода обучения, будет использован .env для парсинга")
        return False

    return True

def parse_cmd_argument() -> CmdParams| None:
    """Извелечение параметров из командной строки"""
    # если не указано использовать аргументы комндной строки, вернем None
    is_cmd = getenv("IS_CMD")
    if is_cmd is None or int(is_cmd) != 1:
        return None

    parser = ArgumentParser(description='Парсер расписания кафедры БК-536')
    parser.add_argument('--pre_clear', action="store_true",
                        help='Полная очистка таблиц перед запуском')
    parser.add_argument('--sem_rasp', type=str,
                        help='Путь до файла с расписанием занятий семестра')
    parser.add_argument('--exam_rasp', type=str,
                        help='Путь до файла с расписанием сессии')
    parser.add_argument('--start_date', type=str,
                        help='Дата первого дня первой недели ИЛИ первый день сессии')
    parser.add_argument('--end_date', type=str,
                        help='Дата последнего дня последней недели ИЛИ последний день сессии')
    parser.add_argument('--magic_start', type=str,
                        help='Первый день обучения магистров (для сессии не нужен)')
    parser.add_argument('--write_start', type=str,
                        help='День, с которого будет записано расписание')
    parser.add_argument('--write_end', type=str,
                        help='День, на котором закончится запись расписания')
    args = parser.parse_args()

    cmd_params = CmdParams()
    cmd_params.pre_clear = args.pre_clear
    cmd_params.sem_filename = args.sem_rasp
    cmd_params.session_filename = args.exam_rasp
    cmd_params.start_date = args.start_date
    cmd_params.end_date = args.end_date
    cmd_params.magic_start_date = args.magic_start
    cmd_params.overwrite_date_start = args.write_start
    cmd_params.overwrite_date_end = args.write_end

    if is_params_good(cmd_params):
        return cmd_params
    return None

def run_parser():
    """Запускает парсинг"""
    cmd_params = parse_cmd_argument()
    parser = VegaRaspParser(cmd_params)
    parser.parse()

if __name__ == "__main__":
    run_parser()
