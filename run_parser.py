"""Файл запуска парсера"""

from argparse import ArgumentParser

from os import getenv
from os import mkdir
from os import path

import uvicorn

from dotenv import load_dotenv

from fastapi import FastAPI
from fastapi import UploadFile
from fastapi.responses import Response
from fastapi_utils.cbv import cbv
from fastapi_utils.inferring_router import InferringRouter

from src.parser import VegaRaspParser
from src.structs import CmdParams

app = FastAPI()
router = InferringRouter()

load_dotenv()

buf_cmd_params = CmdParams()

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

@cbv(router)
class Server:
    """Получение запросов для работы парсера"""

    folder_path = "rasp_files"

    def __init__(self):
        """Инициализация"""
        print("INIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIT")
        self.cmd_params = CmdParams()

        if not path.isdir(self.folder_path):
            mkdir(self.folder_path)

    @router.post("/file/upload-sem-file")
    async def upload_sem_file(self, file: UploadFile):
        """Загрузка файла для чтения"""
        print(f"Получил файл семестра {file.filename}")
        self.cmd_params.sem_filename = file.filename
        if status.status_code == 200:
            status = await self.download_file(file)
        return status

    @router.post("/file/upload-exam-file")
    async def upload_exam_file(self, file: UploadFile):
        """Загрузка файла для чтения"""
        print(f"Получил файл сессии {file.filename}")
        status = await self.download_file(file)
        if status.status_code == 200:
            self.cmd_params.session_filename = file.filename
        return status

    async def download_file(self, file: UploadFile):
        """Скачиваем файл в папку rasp_files"""
        if not file:
            return Response(content="No upload file sent", status_code=400)

        file_data = file.file.read()
        file_path = path.join(self.folder_path, file.filename)
        with open(file_path, "wb") as new_file:
            new_file.write(file_data)

        return Response(status_code=200)

    @router.post("/parser_params")
    async def set_params(self, cmd_params: CmdParams):
        """Установка параметров парсера"""
        global buf_cmd_params
        if is_params_good(cmd_params):
            self.cmd_params = cmd_params
            buf_cmd_params = cmd_params
            return Response(status_code=200)
        # return Response(status_code=400)
        return Response(status_code=400)

    @router.post("/run_parser")
    async def run_parser(self):
        """Установка параметров парсера"""
        global buf_cmd_params
        self.cmd_params = buf_cmd_params
        if not is_params_good(self.cmd_params):
            return Response(status_code=400)
        parser = VegaRaspParser(self.cmd_params, is_web=True)
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
    server = Server()
    print("Connection established")
    while True:
        await server
    # run_parser()

app.include_router(router)
if __name__ == "__main__":
    uvicorn.run("run_parser:app", host="127.0.0.1", port=8000, reload=True)
