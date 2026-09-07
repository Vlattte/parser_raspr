"""
Скрипт по очистки заявок в очереди (со статусом PARSING и WAITING)
Настройки подключения к БД берутся из env
"""

from os import getenv
from dotenv import load_dotenv

from psycopg2 import connect


def get_next_req(next_req_id):
    """Получить запрос для установки статуса заявки в DELITING"""
    return f"\
        INSERT INTO parser_meta.status (req_id, status) \
        VALUES ({next_req_id}, 'DELITING') \
            ON CONFLICT(req_id) DO UPDATE SET \
            status = 'DELITING';"


load_dotenv()
db_host = getenv("DB_HOST")
db_name = getenv("DB_NAME")
db_user = getenv("DB_USER")
db_password = getenv("DB_PASSWORD")
db_port = getenv("DB_PORT")


conn = connect(
    database=db_name,
    user=db_user,
    host=db_host,
    port=db_port,
    password=db_password,
)

cur = conn.cursor()

REQUEST = "SELECT reqs.req_id, reqs.rasp_filename, reqs.report_dttm, st.status \
            FROM parser_meta.requests reqs \
            INNER JOIN parser_meta.status st \
            ON reqs.req_id = st.req_id \
            WHERE (st.status = 'PARSING' OR st.status = 'WAITING')"
cur.execute(REQUEST)
running_reqs = cur.fetchall()

RUNNING_REQS_STR = "\n\t".join(map(str, running_reqs))
print(f"Были запущены следующие заявки:\n\t{RUNNING_REQS_STR}")

for req in running_reqs:
    req_id = req[0]
    cur.execute(get_next_req(req_id))
    print(f"Удалил заявку номер {req_id}")

conn.commit()
cur.close()
conn.close()
