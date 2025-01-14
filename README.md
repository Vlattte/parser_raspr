# VEGA_rasp_parser

Парсер загруженного с сайта ВЕГИ расписания

## Подготовка

### ФАЙЛ КОНФИГУРАЦИИ

Для соединения с нужной базой данных нужно создать файл ".env" со следующими полями подключения к БД:

```
APP_HOST='0.0.0.0'
APP_PORT='8099'

DB_USER='postgres'
DB_NAME='postgres'
DB_PASSWORD='postgres'
DB_HOST='localhost'
DB_INTERNAL_PORT='5432'
DB_PORT='5432'

FILENAME="2024autD.xlsx"
PARSE_TYPE="DEFAULT"

START_DATE="2024-09-02"
END_DATE="2025-02-02"
```

Также нужно добавить переменную "FILENAME", в которой указать имя файла скачанного расписания
И переменную "PARSE_TYPE", в которой указывается тип файла, который парсится:
    либо "DEFAULT" (пары в семестре), либо "SESSION" - расписание сессии


#### Создание таблиц

psql -U postgres -d postgres -a -f [путь_до_файла_rasp.sql]

#### Установка зависимостей:

pip install -r requirements.txt


## Запуск

python parser.py
