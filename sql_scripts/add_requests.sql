DELETE FROM parser_meta.status WHERE req_id in (40, 41, 42, 43);
DELETE FROM parser_meta.requests WHERE req_id in (40, 41, 42, 43);


INSERT INTO parser_meta.status (req_id, status, status_percent) VALUES(40, 'PARSING', 40);
INSERT INTO parser_meta.requests (req_id, rasp_filename, start_date, end_date, magic_start, report_dttm) 
    VALUES(40, '', '2026-11-06', '2027-11-06', '2026-11-06', '2026-11-06');
INSERT INTO parser_meta.status (req_id, status, status_percent) VALUES(41, 'PARSING', 40);
INSERT INTO parser_meta.requests (req_id, rasp_filename, start_date, end_date, magic_start, report_dttm) 
    VALUES(41, '', '2026-11-06', '2027-11-06', '2026-11-06', '2026-11-06');
INSERT INTO parser_meta.status (req_id, status, status_percent) VALUES(42, 'PARSING', 40);
INSERT INTO parser_meta.requests (req_id, rasp_filename, start_date, end_date, magic_start, report_dttm) 
    VALUES(42, '', '2026-11-06', '2027-11-06', '2026-11-06', '2026-11-06');
INSERT INTO parser_meta.status (req_id, status, status_percent) VALUES(43, 'PARSING', 40);
INSERT INTO parser_meta.requests (req_id, rasp_filename, start_date, end_date, magic_start, report_dttm) 
    VALUES(43, '', '2026-11-06', '2027-11-06', '2026-11-06', '2026-11-06');