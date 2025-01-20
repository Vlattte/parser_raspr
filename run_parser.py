"""Файл запуска парсера"""

from src.parser import VegaRaspParser

def run_parser():
    """Запускает парсинг"""
    parser = VegaRaspParser()
    parser.parse()

if __name__ == "__main__":
    run_parser()
