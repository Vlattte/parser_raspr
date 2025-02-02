SELECT r18_gr.group_id, r18_gr.subgroup, r18.day_id
FROM sc_rasp18_groups r18_gr
INNER JOIN sc_rasp18 r18 ON r18.id = r18_gr.rasp18_id
-- INNER JOIN sc_group gr ON r18_gr.group_id = 0
WHERE group_id = 0