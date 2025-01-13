INSERT INTO sc_rasp18_days (semcode, day, weekday, week)
SELECT
 1,
    d::date,
    EXTRACT(DOW FROM d)::integer,
    EXTRACT(WEEK FROM d)::integer - EXTRACT(WEEK FROM '2024-09-02'::date) + 1
FROM generate_series('2024-09-02'::date, '2025-02-02'::date, '1 day'::interval) d;