"""Файл запуска парсера"""

from argparse import ArgumentParser

from os import getenv
from os import mkdir
from os import path

import uvicorn
import asyncio

from dotenv import load_dotenv

from fastapi import FastAPI
from fastapi import UploadFile
from fastapi.responses import Response

from src.parser import VegaRaspParser
from src.structs import CmdParams

app = FastAPI()

load_dotenv()

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


# @cbv(router)
# class Server:
#     """Получение запросов для работы парсера"""

# def __init__(self):
#     """Инициализация"""
#     print("INIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIT")
#     self.cmd_params = CmdParams()
#     self.sem_filename = None
#     self.exam_filename = None

#     if not path.isdir(self.folder_path):
#         mkdir(self.folder_path)


@app.post("/upload-rasp-file")
async def upload_file(file: UploadFile):
    """Загрузка файла для чтения"""
    print(f"Получил файл семестра {file.filename}")
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


@app.post("/run_parser")
async def run_parser(cmd_params: CmdParams, file: UploadFile = None):
    """Установка параметров парсера и запуск"""
    if not is_params_good(cmd_params):
        return Response(status_code=400)

    if file is not None:
        download_status = download_file(file)
        if download_status.status_code != 200:
            return download_status

    parser = VegaRaspParser(cmd_params)
    parser.parse()
    return Response(status_code=200)


# def run_parser(cmd_params: CmdParams = None):
#     """Запускает парсинг"""
#     if cmd_params is None:
#         cmd_params = parse_cmd_argument()
#     parser = VegaRaspParser(cmd_params)
#     parser.parse()


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
    uvicorn.run("run_parser:app", host="127.0.0.1", port=8000, reload=True)
