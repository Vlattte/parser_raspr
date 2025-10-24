"""Файл запуска парсера"""

from argparse import ArgumentParser

from os import getenv
from os import mkdir
from os import path

from sys import exc_info

import uvicorn

from dotenv import load_dotenv

from psycopg2 import Error as DBError

from fastapi import FastAPI
from fastapi import UploadFile
from fastapi import BackgroundTasks
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware

from src.parser import VegaRaspParser
from src.db_class import Database

from src.structs import CmdParams
from src.structs import RaspType
from src.structs import ReqStatus

load_dotenv()
root_path = getenv("DOMEN_ROOT_PATH") if not None else "rasp_parse"

app = FastAPI(
    title="API парсера расписания",
    root_path=root_path,
    servers=[{"url": f"/{root_path}"}],
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def is_params_good(cmd_params: CmdParams) -> bool:
    """Проверка на корректность переданных аргументов"""

    if cmd_params.filename is None:
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
    "/sem",
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
    "/exam",
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
    background_tasks: BackgroundTasks | None,
) -> JSONResponse:
    """Парсит файл по переданным параметрам в фоне"""
    cmd_params = CmdParams()
    cmd_params.is_sem = True if rasp_type == RaspType.SEMESTR else False
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
    if background_tasks is None:
        parser.parse()
    else:
        background_tasks.add_task(parser.parse)

    return JSONResponse(content={"request_id": req_id}, status_code=200)


def save_new_request(
    filename: str, start_date: str, end_date: str, magic_start: str = None
) -> tuple[int, float]:
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


@app.get("/{req_id}")
async def reparse_by_req_id(
    req_id: int, background_tasks: BackgroundTasks
) -> JSONResponse:
    """Запустить повторный парсинг по номер заявки"""
    db = Database()
    db.set_conn()

    req_data = db.get_req_data(req_id)
    if isinstance(req_data, dict):
        return JSONResponse(content=req_data, status_code=400)

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


@app.get("/")
async def get_req_statuses() -> JSONResponse:
    """Получить статусы заявок на парсинг в формате:\n
    {\n
        req_id: {\n
            status: ReqStatus,\n
            parsing_percent: int,\n
            file_name: str,\n
            report_dttm: date,\n
            is_latest: bool\n
        }, \n
        ...\n
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


@app.delete("/{req_id}")
async def delete_request_data(req_id: int) -> JSONResponse:
    """Удалить данные по заявке"""
    status_code = 200
    try:
        db = Database()
        db.set_conn()

        del_result = db.clear_req_data(req_id)

        db.close_conn()
    except DBError as db_error:
        print(f"DBException triggered: {db_error}")
        status_code = 400
        del_result = {"ERROR": "Can't delete due to exception"}

        db.set_conn()
        db.update_req_status(req_id, ReqStatus.ERROR)
    except Exception as error:
        status_code = 400
        del_result = {"ERROR": "Can't delete due to exception"}

        exc_type, _, tb = exc_info()
        filename = tb.tb_frame.f_code.co_filename
        line_number = tb.tb_lineno
        print(f"Exception in file: {filename}, line: {line_number}.", end=" ")
        print(f"Exception type: {exc_type.__name__}, message: {error}")
        db.set_conn()
        db.update_req_status(req_id, ReqStatus.ERROR)

    finally:
        db.close_conn()

    return JSONResponse(status_code=status_code, content=del_result)


def parse_env():
    """Берем параметры из env"""
    load_dotenv()
    cmd_params = CmdParams()

    # доп флаги
    cmd_params.pre_clear = getenv("PRE_CLEAR")
    cmd_params.pre_clear = bool(int(cmd_params.pre_clear))

    # файл для парсинга
    filename = getenv("DEFAULT_FILENAME")
    if filename is None:
        filename = getenv("SESSION_FILENAME")

    cmd_params.filename = filename

    # дата начала и конца семестра
    cmd_params.start_date = getenv("START_DATE")
    cmd_params.end_date = getenv("END_DATE")

    # период для перезаписи расписания
    cmd_params.overwrite_date_start = getenv("OVERWRITE_DAY_START")
    cmd_params.overwrite_date_end = getenv("OVERWRITE_DAY_END")

    # первый день обучения магистров
    cmd_params.magic_start_date = getenv("MAGIC_START_DATE")
    is_env_good = is_params_good(cmd_params)
    if not is_env_good:
        print(
            "Параметры в .env не корректны (нет имени файла или дат начала/конца семестра)"
        )
        return None

    return cmd_params


def run_local_parser(is_cmd: bool):
    """Запускает парсинг локально, используя параметры из env"""
    if is_cmd:
        cmd_params = parse_cmd_argument()
    else:
        cmd_params = parse_env()

    if cmd_params is None:
        return

    # создаем новую заявку на парсинг расписания
    req_id, req_time = save_new_request(
        cmd_params.filename,
        cmd_params.start_date,
        cmd_params.end_date,
        cmd_params.magic_start_date,
    )

    parser = VegaRaspParser(cmd_params, req_id, req_time)
    parser.parse()


if __name__ == "__main__":
    #####################
    # ЗАПУСК ВЕБ ВЕРСИИ #
    #####################
    uvicorn.run("run_parser:app", host="0.0.0.0", port=8000, reload=True)

    #####################
    # ЗАПУСК ИЗ КОНСОЛИ #
    #####################
    # False, будет использовать .env файл, иначе параметры из консоли
    # run_local_parser(False)
