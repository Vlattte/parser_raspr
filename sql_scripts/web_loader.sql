SELECT r18.semcode, r18m.rasp18_dest_id,r18m.src_day_id, r18m.src_pair, r18.id, r18disc.department_id, room, day_id, disc_id, shorttitle, fio, pair, kind, worktype, timestart, timeend, day, weekday, week, worktype FROM sc_rasp18 r18
            LEFT JOIN (SELECT id, day, weekday, week FROM sc_rasp18_days) r18d ON r18.day_id = r18d.id
            LEFT JOIN (SELECT * FROM sc_rasp18_preps) r18p_id ON r18.id = r18p_id.rasp18_id
            LEFT JOIN (SELECT * FROM sc_rasp18_rooms) r18r ON r18r.rasp18_id = r18.id
            LEFT JOIN (SELECT * FROM sc_prep) r18p ON r18p_id.prep_id = r18p.id
            LEFT JOIN (SELECT * FROM sc_disc) r18disc ON r18.disc_id = r18disc.id
  LEFT JOIN sc_rasp18_move r18m ON r18.id = r18m.rasp18_dest_id or (day_id = r18m.src_day_id and pair = r18m.src_pair)
            WHERE r18.id in 
            (SELECT rasp18_id FROM sc_rasp18_groups WHERE group_id = 6 and (subgroup = 1 or subgroup = 0) ) and weekday = 3 and week = 3 and semcode = 242501
            ORDER BY pair ASC