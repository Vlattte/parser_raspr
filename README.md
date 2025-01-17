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

# имена файлов для парсинга расписания
# если какого-то нет, то такое расписание не парсим
# DEFAULT_FILENAME - расписание пар в семестре
# SESSION_FILENAME - расписание пар в сессию
DEFAULT_FILENAME="2024autD.xlsx"
SESSION_FILENAME="zex202425win4.xlsx"

START_DATE="2024-09-02"
END_DATE="2025-02-02"
```

#### Создание таблиц

psql -U postgres -d postgres -a -f [путь_до_файла_rasp.sql]

#### Установка зависимостей:

pip install -r requirements.txt


## Запуск

python parser.py

## Дополнительные сведения

### Worktypes (типы пар)

    - 0-пр, 1-лк, 2-лб
    - 10-конс, 11-экз, 12-зaч, 13-зaч-д
    - 14-кр, 15-кп
