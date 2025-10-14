CREATE SCHEMA IF NOT EXISTS parser_meta;

CREATE SEQUENCE IF NOT EXISTS parser_meta.seq_status_id INCREMENT 1 START 1;

CREATE TABLE parser_meta.status (
    id integer NOT NULL DEFAULT nextval('parser_meta.seq_status_id'),
    req_id integer,             -- id заявки
    status text,                -- текущий статус загрузки
    status_percent integer,     -- процент загрузки расписания
    CONSTRAINT unique_status_req_id UNIQUE (req_id)
);

COMMENT ON TABLE parser_meta.status IS 'Информация о статусе парсинга расписания ВЕГИ';

ALTER SEQUENCE parser_meta.seq_status_id OWNED BY parser_meta.status.id;


CREATE SEQUENCE IF NOT EXISTS parser_meta.seq_requests_id INCREMENT 1 START 1;

CREATE TABLE parser_meta.requests (
    req_id integer NOT NULL DEFAULT nextval('parser_meta.seq_requests_id'),
    rasp_filename text,         -- название файла с расписанием
    start_date date,            -- первый день, записанный по данной версии расписания
    end_date date,              -- последний день, записанный по данной версии расписания
    magic_start date,           -- первый день для магистров, записанный по данной версии расписания
    report_dttm TIMESTAMP,      -- время, когда оставили заявку
    CONSTRAINT unique_requests_req_id UNIQUE (req_id)
);

COMMENT ON TABLE parser_meta.requests IS 'Заявки для парсинга';
ALTER SEQUENCE parser_meta.seq_requests_id OWNED BY parser_meta.requests.req_id;
