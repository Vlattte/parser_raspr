"""Файл запуска парсера"""

from argparse import ArgumentParser

from os import getenv
from os import mkdir
from os import path

from datetime import datetime

from re import sub as regex_sub

import uvicorn
import asyncio

from dotenv import load_dotenv

from fastapi import FastAPI
from fastapi import UploadFile
from fastapi import BackgroundTasks
from fastapi.responses import JSONResponse

from src.parser import VegaRaspParser
from src.db_class import Database

from src.structs import CmdParams
from src.structs import RaspType
from src.structs import ReqStatus

load_dotenv()

app = FastAPI(title="API парсера расписания")
root_path = getenv("DOMEN_ROOT_PATH") if not None else "rasp_parse"


def is_params_good(cmd_params: CmdParams) -> bool:
    """Проверка на корректность переданных аргументов"""
    print(cmd_params.sem_filename)
    print(cmd_params.session_filename)
    if cmd_params.sem_filename is None and cmd_params.session_filename is None:
        print("Не заданы файлы для парсинга, будет использован .env для парсинга")
        return False

    if cmd_params.start_date is None or cmd_params.end_date is None:
        print(
            "Не задана одна или обе даты периода обучения, будет использован .env для парсинга"
        )
        return False

    return True


def parse_cmd_argument() -> CmdParams | None:
    """Извелечение параметров из командной строки"""
    # если не указано использовать аргументы комндной строки, вернем None
    is_cmd = getenv("IS_CMD")
    if is_cmd is None or int(is_cmd) != 1:
        return None

    parser = ArgumentParser(description="Парсер расписания кафедры БК-536")
    parser.add_argument(
        "--pre_clear", action="store_true", help="Полная очистка таблиц перед запуском"
    )
    parser.add_argument(
        "--sem_rasp", type=str, help="Путь до файла с расписанием занятий семестра"
    )
    parser.add_argument(
        "--exam_rasp", type=str, help="Путь до файла с расписанием сессии"
    )
    parser.add_argument(
        "--start_date",
        type=str,
        help="Дата первого дня первой недели ИЛИ первый день сессии",
    )
    parser.add_argument(
        "--end_date",
        type=str,
        help="Дата последнего дня последней недели ИЛИ последний день сессии",
    )
    parser.add_argument(
        "--magic_start",
        type=str,
        help="Первый день обучения магистров (для сессии не нужен)",
    )
    parser.add_argument(
        "--write_start", type=str, help="День, с которого будет записано расписание"
    )
    parser.add_argument(
        "--write_end", type=str, help="День, на котором закончится запись расписания"
    )
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


@app.post(
    f"/{root_path}/sem",
    summary="Парсинг расписания семестра",
    description=(
        "Парсинг расписания в БД и сохранение файла с ним в папке rasp_files. "
        + "Принимает файл в формате xlsx\n"
        + "## Обязательные параметры:\n"
        + " - **start_date** - день первого семестра для БАКАЛАВРИАТА\n"
        + " - **end_date** - день последнего учебного дня\n"
        + " - **file** - файл семестра, который нужно распарсить\n"
        + "\n_Даты писать в строковом виде в формате YYYY-MM-DD (год-месяц-день)_\n"
        + "\n_Все даты включительно [start_date, end_date]_\n"
        + "\n## Не обязательные параметры:\n"
        + " - **magic_start_date** - первый день обучения магистров "
        + "(если не задан расписание магистров начнется как у бакалавров)"
    ),
)
async def parse_sem(
    background_tasks: BackgroundTasks,
    file: UploadFile,
    start_date: str,
    end_date: str,
    magic_start: str = None,
):
    """Парсинг расписания семестра"""
    file_path = await download_file(file)
    if not file_path:
        print("Ошибка загрузки файла расписания")
        return JSONResponse(content={"ERROR": "No upload file sent"}, status_code=400)

    status = await parse_file(
        file_path=file_path,
        rasp_type=RaspType.SEMESTR,
        start_date=start_date,
        end_date=end_date,
        magic_start_date=magic_start,
        background_tasks=background_tasks,
    )
    return status


@app.post(
    f"/{root_path}/exam",
    summary="Парсинг расписания сессии",
    description=(
        "Парсинг расписания сессии в БД и сохранение файла с ним в папке rasp_files. "
        + "Принимает файл в формате xlsx\n"
        + "## Обязательные параметры:\n"
        + " - **start_date** - день первого семестра для БАКАЛАВРИАТА\n"
        + " - **end_date** - день последнего учебного дня\n"
        + " - **file** - файл семестра, который нужно распарсить\n"
        + "\n_Даты писать в строковом виде в формате YYYY-MM-DD (год-месяц-день)_\n"
        + "\n_Все даты включительно [start_date, end_date]_\n"
        + "\n## Не обязательные параметры:\n"
        + " - **magic_start_date** - первый день обучения магистров "
        + "(если не задан расписание магистров начнется как у бакалавров)"
    ),
)
async def parse_exam(
    background_tasks: BackgroundTasks,
    file: UploadFile,
    start_date: str,
    end_date: str,
    magic_start: str = None,
):
    """Парсинг расписания сессии"""
    file_path = await download_file(file)
    if not file_path:
        print("Ошибка загрузки файла расписания")
        return JSONResponse(content={"ERROR": "No upload file sent"}, status_code=400)

    status = await parse_file(
        file_path=file_path,
        rasp_type=RaspType.EXAM,
        start_date=start_date,
        end_date=end_date,
        magic_start_date=magic_start,
        background_tasks=background_tasks,
    )
    return status


async def parse_file(
    file_path: str,
    rasp_type: RaspType,
    start_date: str,
    end_date: str,
    magic_start_date: str,
    background_tasks: BackgroundTasks,
) -> JSONResponse:
    """Парсит файл по переданным параметрам в фоне"""
    cmd_params = CmdParams()
    cmd_params.is_sem = True if rasp_type == RaspType.SEMESTR else RaspType.EXAM
    cmd_params.start_date = start_date
    cmd_params.end_date = end_date
    cmd_params.filename = file_path
    if magic_start_date is not None:
        cmd_params.magic_start_date = magic_start_date

    # создаем новую заявку на парсинг расписания
    req_id, req_time = save_new_request(
        file_path, start_date, end_date, magic_start_date
    )

    parser = VegaRaspParser(cmd_params, req_id, req_time)
    background_tasks.add_task(parser.parse)

    return JSONResponse(content={"request_id": req_id}, status_code=200)


def save_new_request(
    filename: str, start_date: str, end_date: str, magic_start: str = None
) -> int:
    """Записать в БД новую заявку"""
    db = Database()
    db.set_conn()

    req_id, req_time = db.save_new_request(filename, start_date, end_date, magic_start)
    db.update_req(req_id, ReqStatus.CREATED, 0)

    db.close_conn()
    return req_id, req_time


async def download_file(file: UploadFile) -> str | None:
    """Скачиваем файл в папку rasp_files (если еще такого нет)"""
    if file is None:
        return None

    folder_path = "rasp_files"
    if not path.isdir(folder_path):
        mkdir(folder_path)

    file_data = file.file.read()
    file_path = path.join(folder_path, file.filename)
    if not path.exists(file_path):
        with open(file_path, "wb") as new_file:
            new_file.write(file_data)

    return file_path


@app.get(f"/{root_path}/")
async def reparse_by_req_id(
    req_id: int, background_tasks: BackgroundTasks
) -> JSONResponse:
    """Запустить повторный парсинг по номер заявки"""
    db = Database()
    db.set_conn()
    
    req_data = db.get_req_data(req_id)
    if isinstance(req_data, dict):
        return req_data
    
    file_path, start_date, end_date, magic_start = req_data

    if not path.isfile(file_path):
        return JSONResponse(
            content={"ERROR": f'Chosen file doesn\'t exists by path "{file_path}"'},
            status_code=400,
        )

    db.close_conn()
    status = await parse_file(
        file_path=file_path,
        rasp_type=RaspType.EXAM,
        start_date=str(start_date),
        end_date=str(end_date),
        magic_start_date=str(magic_start),
        background_tasks=background_tasks,
    )
    return status


@app.get(f"/{root_path}")
async def get_req_statuses() -> JSONResponse:
    """Получить статусы заявок на парсинг в формате:
    {
        req_id: {
            status: ReqStatus,
            parsing_percent: int,
            file_name: str,
            report_dttm: date,
            is_latest: bool
        }
    }
    """
    db = Database()
    db.set_conn()

    statuses = db.get_meta_statuses()
    if statuses is None:
        return JSONResponse(
            content={"WARNING": "No requests yet"},
            status_code=400,
        )

    db.close_conn()
    return JSONResponse(status_code=200, content=statuses)


def run_local_parser(cmd_params: CmdParams = None):
    """Запускает парсинг локально"""
    if cmd_params is None:
        cmd_params = parse_cmd_argument()

    # создаем новую заявку на парсинг расписания
    req_id, req_time = save_new_request(
        cmd_params.filename,
        cmd_params.start_date,
        cmd_params.end_date,
        cmd_params.magic_start,
    )

    parser = VegaRaspParser(cmd_params, req_id, req_time)
    parser.parse()


if __name__ == "__main__":
    #####################
    # ЗАПУСК ВЕБ ВЕРСИИ #
    #####################
    uvicorn.run("run_parser:app", host="127.0.0.1", port=8000, reload=True)

    #####################
    # ЗАПУСК ИЗ КОНСОЛИ #
    #####################
    # если в консоли ничего не передали, будет использовать .env файл
    # params = parse_cmd_argument()
    # run_local_parser(params)
