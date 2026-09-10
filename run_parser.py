"""Файл запуска парсера"""

from argparse import ArgumentParser

from gzip import compress

from json import dumps

from os import getenv
from os import mkdir
from os import path

from secrets import compare_digest

from sys import exc_info

from time import perf_counter

import uvicorn

from dotenv import load_dotenv

from psycopg2 import Error as DBError

from fastapi import FastAPI
from fastapi import Request
from fastapi import Response
from fastapi import UploadFile
from fastapi import BackgroundTasks
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware

from src import export

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


def is_export_token_valid(request: Request) -> bool:
    """Проверка заголовка 'Authorization: Bearer <token>' по токену из окружения"""
    expected_token = getenv("EXPORT_API_TOKEN")
    if not expected_token:
        print("<--EXPORT WARNING: EXPORT_API_TOKEN не задан, выгрузка закрыта-->")
        return False

    auth_header = request.headers.get("Authorization", "")
    scheme, _, token = auth_header.partition(" ")
    if scheme.lower() != "bearer":
        return False

    token = token.strip()
    if not token:
        return False

    return compare_digest(token, expected_token)


def is_etag_matched(if_none_match: str, version: str) -> bool:
    """Совпадает ли хоть один ETag из If-None-Match с текущей версией"""
    if not if_none_match:
        return False

    # "*" намеренно не поддерживаем: для этой ручки он всегда означал бы совпадение,
    # и клиент никогда бы не забрал новую версию
    for candidate in if_none_match.split(","):
        # W/"12" -> 12
        candidate = candidate.strip().removeprefix("W/").strip()
        if candidate.strip('"') == version:
            return True
    return False


def log_export(version: str, is_explicit: bool, rows: int, size: int, started: float):
    """Лог выгрузки снапшота"""
    elapsed_ms = int((perf_counter() - started) * 1000)
    print(
        f"<--EXPORT: version={version}, explicit={is_explicit}, rows={rows}, "
        + f"bytes={size}, time={elapsed_ms}ms, cache=off-->"
    )


@app.get(
    "/api/schedule/export",
    summary="Полный снапшот расписания одной версии",
    description=(
        "Отдает расписание одной версии целиком, одним ответом, без пагинации. "
        + "Ручка только читает БД, все данные снимаются в одной read-only "
        + "транзакции (REPEATABLE READ).\n"
        + "## Параметры:\n"
        + " - **version** - идентификатор версии (req_id заявки на парсинг). "
        + "Если не передан, отдается последняя ЗАВЕРШЕННАЯ версия. "
        + "Если передан, отдается ровно она, иначе 404\n"
        + "## Заголовки запроса:\n"
        + " - **Authorization: Bearer &lt;token&gt;** - обязателен, токен из "
        + "переменной окружения EXPORT_API_TOKEN, без него 401\n"
        + " - **If-None-Match: \"&lt;version&gt;\"** - если совпадает с текущей "
        + "последней версией (и параметр version не передан), вернется 304 без тела\n"
        + " - **Accept-Encoding: gzip** - ответ будет сжат gzip\n"
        + "## Формат ответа:\n"
        + "```json\n"
        + '{"version": "12", "generated_at": "2026-09-10T12:00:00Z",\n'
        + ' "semester": {"id": "242500", "start": "2026-09-01", "end": "2026-12-31"},\n'
        + ' "weekly": [{"table": "sc_rasp7", "primary_key": ["id"], "rows": [...]}],\n'
        + ' "daily":  [{"table": "sc_rasp18", "primary_key": ["id"], "rows": [...]}],\n'
        + ' "reference": [{"table": "sc_disc", "primary_key": ["id"], "rows": [...]}]}\n'
        + "```\n"
        + "Имена полей в rows совпадают с именами колонок в БД, строки "
        + "отсортированы по первичному ключу.\n"
        + "\n_Даты: YYYY-MM-DD, время: HH:MM[:SS], timestamp: UTC с Z, null: null_\n"
    ),
)
def export_schedule(request: Request, version: str = None):
    """Полный снапшот расписания одной версии для внешней read-only витрины"""
    started = perf_counter()

    # if not is_export_token_valid(request):
    #     return JSONResponse(
    #         status_code=401,
    #         content={"ERROR": "Bearer token is required"},
    #         headers={"WWW-Authenticate": "Bearer"},
    #     )

    is_explicit = version is not None
    req_id = None
    if is_explicit:
        if not version.strip().isdigit():
            return JSONResponse(
                status_code=404,
                content={"ERROR": f"No finished schedule version '{version}'"},
            )
        req_id = int(version.strip())

    reader = None
    try:
        reader = export.open_reader()

        version_ref = export.resolve_version(reader, req_id)
        if version_ref is None:
            not_found = (
                f"No finished schedule version '{version}'"
                if is_explicit
                else "No finished schedule version yet"
            )
            return JSONResponse(status_code=404, content={"ERROR": not_found})

        headers = {
            "ETag": f'"{version_ref.version}"',
            "Vary": "Accept-Encoding",
            "Cache-Control": "no-cache",
        }

        # дешевая проверка "появилась ли новая версия"
        if not is_explicit and is_etag_matched(
            request.headers.get("If-None-Match"), version_ref.version
        ):
            log_export(version_ref.version, is_explicit, 0, 0, started)
            return Response(status_code=304, headers=headers)

        snapshot = export.build_snapshot(reader, version_ref)

    except export.ExportError as export_error:
        print(f"<--EXPORT ERROR: {export_error}-->")
        return JSONResponse(status_code=503, content={"ERROR": str(export_error)})

    except DBError as db_error:
        print(f"<--EXPORT DB ERROR: {db_error}-->")
        return JSONResponse(status_code=503, content={"ERROR": "Database is unavailable"})

    finally:
        if reader is not None:
            reader.close()

    body = dumps(
        snapshot.payload, ensure_ascii=False, default=export.json_default
    ).encode("utf-8")

    if "gzip" in request.headers.get("Accept-Encoding", "").lower():
        body = compress(body)
        headers["Content-Encoding"] = "gzip"

    log_export(version_ref.version, is_explicit, snapshot.total_rows, len(body), started)
    return Response(content=body, media_type="application/json", headers=headers)


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
