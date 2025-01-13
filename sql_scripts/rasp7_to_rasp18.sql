INSERT INTO sc_rasp18 (semcode, day_id, pair, kind, disc_id, timestart, timeend)
SELECT 
    s.semcode,
    d.id,
    s.pair,
    1,
    s.disc_id,
    CASE 
        WHEN s.pair = 1 THEN '9:00'
        WHEN s.pair = 2 THEN '10:40'
        WHEN s.pair = 3 THEN '12:40'  
        WHEN s.pair = 4 THEN '14:20'
        WHEN s.pair = 5 THEN '16:20'
        WHEN s.pair = 6 THEN '18:00'
        WHEN s.pair = 7 THEN '19:40'
    END AS timestart,
    CASE 
        WHEN s.pair = 1 THEN '10:30'
        WHEN s.pair = 2 THEN '12:10'  
        WHEN s.pair = 3 THEN '14:10'
        WHEN s.pair = 4 THEN '15:50'
        WHEN s.pair = 5 THEN '17:50'
        WHEN s.pair = 6 THEN '19:30'
        WHEN s.pair = 7 THEN '21:10'
    END AS timeend
FROM 
    sc_rasp7 s
INNER JOIN  
    sc_rasp18_days d ON s.weekday = d.weekday AND (d.week = any(s.weeksarray));

INSERT INTO sc_rasp18_groups (rasp18_id, group_id, subgroup) 
SELECT r18.id, g.group_id, g.subgroup FROM sc_rasp18 r18 
JOIN sc_rasp18_days d ON  r18.day_id = d.id 
JOIN sc_rasp7 r7 ON d.week = ANY(r7.weeksarray) AND d.weekday = r7.weekday AND r18.pair = r7.pair 
JOIN sc_rasp7_groups g ON r7.id = g.rasp7_id
ORDER BY day ASC, d.weekday ASC, r18.pair ASC;

INSERT INTO sc_rasp18_preps (rasp18_id, prep_id) 
SELECT r18.id, p.id FROM sc_rasp18 r18 
JOIN sc_rasp18_days d ON  r18.day_id = d.id 
JOIN sc_rasp7 r7 ON d.week = ANY(r7.weeksarray) AND d.weekday = r7.weekday AND r18.pair = r7.pair 
JOIN sc_rasp7_preps p ON r7.id = p.rasp7_id
ORDER BY day ASC, d.weekday ASC, r18.pair ASC;

INSERT INTO sc_rasp18_rooms (rasp18_id, room) 
SELECT r18.id, rm.room FROM sc_rasp18 r18 
JOIN sc_rasp18_days d ON  r18.day_id = d.id 
JOIN sc_rasp7 r7 on d.week = ANY(r7.weeksarray) and d.weekday = r7.weekday and r18.pair = r7.pair 
JOIN sc_rasp7_rooms rm on r7.id = rm.rasp7_id

ORDER BY day ASC, d.weekday ASC, r18.pair ASC;