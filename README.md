# VEGA_rasp_parser

Парсер загруженного с сайта ВЕГИ расписания

## Подготовка

### ФАЙЛ КОНФИГУРАЦИИ

Для соединения с нужной базой данных нужно создать файл ".env" со следующими полями подключения к БД:

```ini
DB_USER='postgres'
DB_NAME='postgres'
DB_PASSWORD='postgres'
DB_HOST='localhost'
DB_PORT='5432'

# запуск с аргументами командной строки или из файла
# 1 - командная строка, 0 - файл (подключение в базе все равно в файле)
IS_CMD=1

#################################################################################################################
# ПРИ ЗАПУСКЕ ДВУХ РАЗНЫХ СЕМЕСТРОВ НЕ МИНУЕМА ОШИБКА, так как будет использован семестр из DEFAULT_FILENAME!!! #
#################################################################################################################

# делать очистку таблиц - 1, другие значения, либо отсутствие параметра
# не делать
PRE_CLEAR=0

# писать ли статус работы в консоль или нет
# в консольном режиме всегда будет выключено
IS_DEBUG=1

# имена файлов для парсинга расписания
# если какого-то нет, то такое расписание не парсим
# DEFAULT_FILENAME - расписание пар в семестре
# SESSION_FILENAME - расписание пар в сессию
DEFAULT_FILENAME="test_rasp_files/2024autD.xlsx"
SESSION_FILENAME="test_rasp_files/zex202425win4.xlsx"

# даты в формате "год-месяц-день"
# START_DATE - первый день семестра(сессии), END_DATE - последний день семестра(сессии)
# нужны для генерации таблицы дней и должны начинаться в день начала обучения бакалавров и кончаться последним днем учебы магистров
# для сесси просто день первого зачета это START_DATE, день последнего экзамена - END_DATE
# если парсятся сразу и семестр и сессия, то можно поставить началом первый день семестра, а последним днем поставить последний день сессии
START_DATE="2024-09-02"
END_DATE="2025-02-02"

# первый день обучения для магистров
MAGIC_START_DATE="2024-09-09"

# промежуток, который перезапишется в базе
OVERWRITE_DAY_START="2024-09-09"
OVERWRITE_DAY_END="2024-12-28"
```

__либо передать аргументы в командную строку:__

Пример запуска:
```cmd
python run_parser.py --sem_rasp 2024autD.xlsx --exam_rasp zex202425win4.xlsx --start_date 2025-02-10 --end_date 2025-08-31
```
- __pre_clear__ - полная очистка таблиц перед запуском (если не указан, то не чистится)
- __sem_rasp__ - путь до файла с расписанием занятий семестра
- __exam_rasp__ - путь до файла с расписанием сессии
- __start_date__ - дата первого дня первой недели ИЛИ первый день сессии
- __end_date__ - дата последнего дня последней недели ИЛИ последний день сессии
- __magic_start__ - первый день обучения магистров (для сессии не нужен)
- __write_start__ - день, с которого будет записано расписание
- __write_end__ - день, на котором закончится запись расписания

#### Создание таблиц

psql -U postgres -d postgres -a -f [путь_до_файла_rasp.sql]

#### Установка зависимостей

pip install -r requirements.txt


## Дополнительные сведения

### Worktypes (типы пар)

```python
    - 0-пр, 1-лк, 2-лб
    - 10-конс, 11-экз, 12-зaч, 13-зaч-д
    - 14-кр, 15-кп
```
