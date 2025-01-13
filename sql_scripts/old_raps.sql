CREATE TABLE public.sc_rasp (
    id serial,
    disc_id integer,
    prep_id integer,
    weekday integer,
    week integer,
    lesson integer,
    group_id integer,
    subgroup integer
);

ALTER TABLE ONLY public.sc_rasp
    ADD CONSTRAINT sc_rasp4_pkey PRIMARY KEY (id);

CREATE TABLE public.sc_disc (
    id serial,
    title text
);

ALTER TABLE ONLY public.sc_disc
    ADD CONSTRAINT sc_disc_pkey PRIMARY KEY (id);

CREATE TABLE public.sc_group (
    id serial,
    title text
);

ALTER TABLE ONLY public.sc_group
    ADD CONSTRAINT sc_group_pkey PRIMARY KEY (id);

CREATE TABLE public.sc_prep (
    id serial,
    fio text,
    chair text,
    degree text,
    photo text,
    student_id integer,
    archive boolean DEFAULT false
);

ALTER TABLE ONLY public.sc_prep
    ADD CONSTRAINT sc_prep_pkey1 PRIMARY KEY (id);