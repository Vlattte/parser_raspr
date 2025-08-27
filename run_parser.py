"""Файл запуска парсера"""

from argparse import ArgumentParser

from os import getenv
from os import mkdir
from os import path

from re import sub as regex_sub

import uvicorn
import asyncio

from dotenv import load_dotenv

from fastapi import FastAPI
from fastapi import UploadFile
from fastapi.responses import Response

# from fastapi import

from src.parser import VegaRaspParser
from src.structs import CmdParams

load_dotenv()

# swagger_ui_default_parameters: Annotated[
#     dict[str, Any],
#     Doc(
#         """
#         Default configurations for Swagger UI.

#         You can use it as a template to add any other configurations needed.
#         """
#     ),
# ] = {
#     "dom_id": "#swagger-ui",
#     "layout": "BaseLayout",
#     "deepLinking": True,
#     "showExtensions": True,
#     "showCommonExtensions": True,
# }

app = FastAPI(title="API парсера расписания")


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
    "/upload",
    summary="Загрузка расписания",
    description=(
        "Загрузка файла расписания и сохранение его в папке rasp_files. "
        + "Принимает файл в формате xlsx"
    ),
)
async def upload_file(file: UploadFile):
    """Загрузка файла для чтения"""
    print(f"Получил новый файл {file.filename}")
    status = await download_file(file)
    return status


async def download_file(file: UploadFile):
    """Скачиваем файл в папку rasp_files"""
    if file is None:
        return Response(content="No upload file sent", status_code=400)

    folder_path = "rasp_files"
    if not path.isdir(folder_path):
        mkdir(folder_path)

    file_data = file.file.read()
    file_path = path.join(folder_path, file.filename)
    with open(file_path, "wb") as new_file:
        new_file.write(file_data)

    return Response(status_code=200)


@app.post("/parse_exam", summary="Парсинг файла экзамена")
async def parse_exam(
    start_date: str, end_date: str, file_path: str = None, file: UploadFile = None
):
    """
    # Парсинг файла экзамена

    ## Обязательные параметры:
    - **start_date** - день первого ЗАЧЕТА
    - **end_date** - день последнего ЭКЗАМЕНА

    _Даты писать в строковом виде в формате YYYY-MM-DD (год-месяц-день)_
    
    _Все даты включительно_

    ## Параметры на выбор (если ни один не указан, вернется ошибка. Если загружены оба, то **file_path** возьмется у **file**)
    - **file_path** - путь до файла с расписанием экзаменов
    - **file** - файл экзаменов, который нужно распарсить, если он будет загружен, то **file_path** будет взят у него
    """
    if file is None and file_path is None:
        print("Не выбран ни путь до файла, ни сам файл")
        return Response(status_code=400)

    file_name = file_path
    if file is None:
        download_status = download_file(file)
        if download_status.status_code != 200:
            return download_status

        file_name = file.filename

    cmd_params = CmdParams()
    cmd_params.is_sem = False
    cmd_params.start_date = start_date
    cmd_params.end_date = end_date
    cmd_params.filename = file_name

    parser = VegaRaspParser(cmd_params)
    parser.parse()
    return Response(status_code=200)


@app.post("/parse_sem", summary="Парсинг файла расписания семестра")
async def parse_sem(
    start_date: str,
    end_date: str,
    file_path: str = None,
    file: UploadFile = None,
    magic_start_date: str = None,
):
    """
    # Парсинг файла экзамена

    ## Обязательные параметры:
    - **start_date** - день первого семестра для БАКАЛАВРИАТА
    - **end_date** - день последнего учебного дня

    _Даты писать в строковом виде в формате YYYY-MM-DD (год-месяц-день)_
    
    _Все даты включительно_

    ## Параметры на выбор (если ни один не указан, вернется ошибка. Если загружены оба, то **file_path** возьмется у **file**)
    - **file_path** - путь до файла с расписанием семестра
    - **file** - файл семестра, который нужно распарсить, если он будет загружен, то **file_path** будет взят у него

    ## Не обязательные параметры:
    - **magic_start_date** - первый день обучения магистров (если не задан расписание магистров начнется как у бакалавров)
    """
    if file is None and file_path is None:
        print("Не выбран ни путь до файла, ни сам файл")
        return Response(status_code=400)

    file_name = file_path
    if file is None:
        download_status = download_file(file)
        if download_status.status_code != 200:
            return download_status

        file_name = file.filename

    cmd_params = CmdParams()
    cmd_params.is_sem = True
    cmd_params.start_date = start_date
    cmd_params.end_date = end_date
    cmd_params.filename = file_name
    if magic_start_date is not None:
        cmd_params.magic_start_date = magic_start_date

    parser = VegaRaspParser(cmd_params)
    parser.parse()
    return Response(status_code=200)

@app.post("/overwrite_sem", summary="Переписать промежуток дат на новое расписание")
async def overwrite_sem(
    start_date: str,
    end_date: str,
    overwrite_start_date: str,
    overwrite_end_date: str,
    file_path: str = None,
    file: UploadFile = None,
    magic_start_date: str = None,
):
    """
    # Парсинг файла экзамена

    ## Обязательные параметры:
    - **start_date** - день первого семестра для БАКАЛАВРИАТА
    - **end_date** - день последнего учебного дня
    - **overwrite_start_date** - день, С КОТОРОГО переписать расписание на указанное
    - **overwrite_end_date** - день, ДО КОТОРОГО переписать расписание на указанное

    _Даты писать в строковом виде в формате YYYY-MM-DD (год-месяц-день)_
    
    _Все даты включительно_

    ## Параметры на выбор (если ни один не указан, вернется ошибка. Если загружены оба, то **file_path** возьмется у **file**)
    - **file_path** - путь до файла с расписанием семестра
    - **file** - файл семестра, который нужно распарсить, если он будет загружен, то **file_path** будет взят у него

    ## Не обязательные параметры:
    - **magic_start_date** - первый день обучения магистров (если не задан расписание магистров начнется как у бакалавров)
    """
    if file is None and file_path is None:
        print("Не выбран ни путь до файла, ни сам файл")
        return Response(status_code=400)

    file_name = file_path
    if file is None:
        download_status = download_file(file)
        if download_status.status_code != 200:
            return download_status

        file_name = file.filename

    cmd_params = CmdParams()
    cmd_params.is_sem = True
    cmd_params.start_date = start_date
    cmd_params.end_date = end_date
    cmd_params.overwrite_start_date = overwrite_start_date
    cmd_params.overwrite_end_date = overwrite_end_date
    cmd_params.filename = file_name
    if magic_start_date is not None:
        cmd_params.magic_start_date = magic_start_date

    parser = VegaRaspParser(cmd_params)
    parser.parse()
    return Response(status_code=200)

@app.post("/overwrite_exams", summary="Переписать промежуток дат экзаменов на новое расписание")
async def overwrite_exams(
    start_date: str,
    end_date: str,
    overwrite_start_date: str,
    overwrite_end_date: str,
    file_path: str = None,
    file: UploadFile = None
):
    """
    # Парсинг файла экзамена

    ## Обязательные параметры:
    - **start_date** - день первого ЗАЧЕТА
    - **end_date** - день последнего ЭКЗАМЕНА
    - **overwrite_start_date** - день, С КОТОРОГО переписать расписание на указанное
    - **overwrite_end_date** - день, ДО КОТОРОГО переписать расписание на указанное

    _Даты писать в строковом виде в формате YYYY-MM-DD (год-месяц-день)_
    
    _Все даты включительно_

    ## Параметры на выбор (если ни один не указан, вернется ошибка. Если загружены оба, то **file_path** возьмется у **file**)
    - **file_path** - путь до файла с расписанием семестра
    - **file** - файл семестра, который нужно распарсить, если он будет загружен, то **file_path** будет взят у него
    """
    if file is None and file_path is None:
        print("Не выбран ни путь до файла, ни сам файл")
        return Response(status_code=400)

    file_name = file_path
    if file is None:
        download_status = download_file(file)
        if download_status.status_code != 200:
            return download_status

        file_name = file.filename

    cmd_params = CmdParams()
    cmd_params.is_sem = False
    cmd_params.start_date = start_date
    cmd_params.end_date = end_date
    cmd_params.overwrite_start_date = overwrite_start_date
    cmd_params.overwrite_end_date = overwrite_end_date
    cmd_params.filename = file_name

    parser = VegaRaspParser(cmd_params)
    parser.parse()
    return Response(status_code=200)


@app.post("/run_parser", summary="Установка параметров парсера и запуск")
async def run_parser(cmd_params: CmdParams, file: UploadFile = None):
    """
    # Запуск парсера с заданными параметрами:

    ## Обязательные параметры:

    - **pre_clear: bool** (default: False) - очистка таблиц связанных с расписанием перед загрузкой расписания. Чтобы изменить скрипт очистки, нужно изменить скрипт в файле `sql_scripts/clear_script.sql`
    - **is_sem: bool** (default: True) - выбранный файл будет расписанием учебного семестра
    - **filename: str** - путь до файла, который будет распаршен (если файл был загружен через функцию `download_file`, то достаточно указать путь `__rasp_files/file_name.xslx__`)
    - **start_date: str** - дата первого учебного дня в семестре(в сессии). От него будет считаться учебные недели, он будет считаться первм учебным днем у бакалавров(и у магистров, если не задан параметр `magic_start_date`), будет днем, от которого будут писаться дни семестра из файла в таблицу `sc_rasp18_days`
    - **end_date: str** - дата последнего учебного дня(последнего экзамена). До этой даты будут записаны дни в таблицу `sc_rasp18_days`, после этой даты не будут записаны никакие пары или экзамены.

    ## Дополнительные параметры:

    - **magic_start_date: str** - первый учебный день магистров. У групп магистров пары в БД будут писаться начиная от этой даты + 16 недель

    - **overwrite_date_start: str** (default: start_date) - дата, С которой нужно переписать уже имеющее расписание(или написать новое).
    - **overwrite_date_end: str** (default: end_date) - дата, ДО которой нужно переписать уже имеющее расписание(или написать новое).

    _Вне промежутка [`overwrite_date_start`, `overwrite_date_end`] никаких записей (кроме `sc_rasp18_days`, которая пишется строго по [`start_date`, `end_date`])._
    """
    if not is_params_good(cmd_params):
        return Response(status_code=400)

    if file is not None:
        download_status = download_file(file)
        if download_status.status_code != 200:
            return download_status

    parser = VegaRaspParser(cmd_params)
    parser.parse()
    return Response(status_code=200)


def run_local_parser(cmd_params: CmdParams = None):
    """Запускает парсинг"""
    if cmd_params is None:
        cmd_params = parse_cmd_argument()
    parser = VegaRaspParser(cmd_params)
    parser.parse()


async def main():
    """Запуск"""
    # server = Server()
    # app.add_route("/file/upload-sem-file", server.upload_sem_file, ["POST"])
    # app.add_route("/file/upload-exam-file", server.upload_exam_file, ["POST"])
    # app.add_route("/run_parser", server.run_parser, ["POST"])

    # специализированные запросы
    # app.add_route("/run_parser", server.run_parser, ["POST"])
    # app.add_route("/run_parser", server.run_parser, ["POST"])
    # app.add_route("/run_parser", server.run_parser, ["POST"])
    # app.add_route("/run_parser", server.run_parser, ["POST"])

    print("Connection established")
    # run_parser()


if __name__ == "__main__":
    #####################
    # ЗАПУСК ВЕБ ВЕРСИИ #
    #####################
    # uvicorn.run("run_parser:app", host="127.0.0.1", port=8000, reload=True)

    #####################
    # ЗАПУСК ИЗ КОНСОЛИ #
    #####################
    # если в консоли ничего не передали, будет использовать .env файл
    params = parse_cmd_argument()
    run_local_parser(params)
