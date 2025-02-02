SELECT r18_gr.group_id, r18_gr.subgroup, r18.day_id, d.day, d.week, d.weekday
FROM sc_rasp18_groups r18_gr
INNER JOIN sc_rasp18 r18 ON r18.id = r18_gr.rasp18_id
INNER JOIN sc_rasp18_days d ON d.id = r18.day_id
WHERE group_id = 0 AND r18.disc_id = 0