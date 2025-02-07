SELECT g.title, r18_gr.subgroup, r18.day_id, d.day, d.week, d.weekday, disc.shorttitle, r18.pair, r18.semcode
FROM sc_group g, sc_rasp18_groups r18_gr
INNER JOIN sc_rasp18 r18 ON r18.id = r18_gr.rasp18_id
INNER JOIN sc_rasp18_days d ON d.id = r18.day_id
INNER JOIN sc_disc disc ON disc.id = r18.disc_id
WHERE group_id = 2 
AND (subgroup = 1 OR subgroup = 0) 
AND d.week = 1
AND d.weekday = 1 
AND r18.semcode = 242501 
AND g.id = r18_gr.group_id;
