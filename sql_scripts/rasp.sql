--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sc_department; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_department (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.sc_department OWNER TO postgres;

--
-- Name: TABLE sc_department; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_department IS 'кафедры';


--
-- Name: sc_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_department_id_seq OWNER TO postgres;

--
-- Name: sc_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_department_id_seq OWNED BY sc_department.id;


--
-- Name: sc_disc; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_disc (
    id integer NOT NULL,
    title text,
    shorttitle text,
    department_id integer,
    varmask text
);


ALTER TABLE public.sc_disc OWNER TO postgres;

--
-- Name: TABLE sc_disc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_disc IS 'кафедры';


--
-- Name: sc_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_group (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.sc_group OWNER TO postgres;

--
-- Name: TABLE sc_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_group IS 'преподавательский состав';


--
-- Name: sc_prep; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_prep (
    id integer NOT NULL,
    fio text,
    chair text,
    degree text,
    photo text
);


ALTER TABLE public.sc_prep OWNER TO postgres;

--
-- Name: sc_rasp18; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18 (
    id integer NOT NULL,
    semcode integer,
    day_id integer,
    pair integer,
    kind integer,
    worktype integer,
    disc_id integer,
    timestart text,
    timeend text
);


ALTER TABLE public.sc_rasp18 OWNER TO postgres;

--
-- Name: TABLE sc_rasp18; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18 IS 'расписание на каждый день (18 недель)';


--
-- Name: sc_rasp18_days; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18_days (
    id integer NOT NULL,
    semcode integer,
    day date,
    weekday integer,
    week integer
);


ALTER TABLE public.sc_rasp18_days OWNER TO postgres;

--
-- Name: TABLE sc_rasp18_days; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18_days IS 'недели и дни недели по датам (18 недель)';


--
-- Name: sc_rasp18_days_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_days_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_days_id_seq OWNED BY sc_rasp18_days.id;


--
-- Name: sc_rasp18_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18_groups (
    id integer NOT NULL,
    rasp18_id integer,
    group_id integer,
    subgroup integer
);


ALTER TABLE public.sc_rasp18_groups OWNER TO postgres;

--
-- Name: TABLE sc_rasp18_groups; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18_groups IS 'группы для расписания (18 недель)';


--
-- Name: sc_rasp18_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_groups_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_groups_id_seq OWNED BY sc_rasp18_groups.id;


--
-- Name: sc_rasp18_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_id_seq OWNED BY sc_rasp18.id;


--
-- Name: sc_rasp18_info; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18_info (
    id integer NOT NULL,
    rasp18_id integer,
    kind integer,
    info text
);


ALTER TABLE public.sc_rasp18_info OWNER TO postgres;

--
-- Name: TABLE sc_rasp18_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18_info IS 'доп. информация к занятиям для расписания (18 недель)';


--
-- Name: sc_rasp18_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_info_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_info_id_seq OWNED BY sc_rasp18_info.id;


--
-- Name: sc_rasp18_move; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18_move (
    id integer NOT NULL,
    rasp18_dest_id integer,
    src_day_id integer,
    src_pair integer,
    reason text,
    comment text
);


ALTER TABLE public.sc_rasp18_move OWNER TO postgres;

--
-- Name: TABLE sc_rasp18_move; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18_move IS 'информация по переносам для расписания (18 недель)';


--
-- Name: sc_rasp18_move_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_move_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_move_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_move_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_move_id_seq OWNED BY sc_rasp18_move.id;


--
-- Name: sc_rasp18_preps; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18_preps (
    id integer NOT NULL,
    rasp18_id integer,
    prep_id integer
);


ALTER TABLE public.sc_rasp18_preps OWNER TO postgres;

--
-- Name: TABLE sc_rasp18_preps; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18_preps IS 'преподаватели для расписания (18 недель)';


--
-- Name: sc_rasp18_preps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_preps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_preps_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_preps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_preps_id_seq OWNED BY sc_rasp18_preps.id;


--
-- Name: sc_rasp18_rooms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp18_rooms (
    id integer NOT NULL,
    rasp18_id integer,
    room text
);


ALTER TABLE public.sc_rasp18_rooms OWNER TO postgres;

--
-- Name: TABLE sc_rasp18_rooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp18_rooms IS 'аудитории для расписания (18 недель)';


--
-- Name: sc_rasp18_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp18_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp18_rooms_id_seq OWNER TO postgres;

--
-- Name: sc_rasp18_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp18_rooms_id_seq OWNED BY sc_rasp18_rooms.id;


--
-- Name: sc_rasp7; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp7 (
    id integer NOT NULL,
    semcode integer,
    version integer,
    disc_id integer,
    weekday integer,
    pair integer,
    weeksarray integer[],
    weekstext text
);


ALTER TABLE public.sc_rasp7 OWNER TO postgres;

--
-- Name: TABLE sc_rasp7; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp7 IS 'расписание на 7 дней (универсальное)';


--
-- Name: sc_rasp7_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp7_groups (
    id integer NOT NULL,
    rasp7_id integer,
    group_id integer,
    subgroup integer
);


ALTER TABLE public.sc_rasp7_groups OWNER TO postgres;

--
-- Name: TABLE sc_rasp7_groups; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp7_groups IS ' группы для расписания на 7 дней';


--
-- Name: sc_rasp7_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp7_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp7_groups_id_seq OWNER TO postgres;

--
-- Name: sc_rasp7_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp7_groups_id_seq OWNED BY sc_rasp7_groups.id;


--
-- Name: sc_rasp7_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp7_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp7_id_seq OWNER TO postgres;

--
-- Name: sc_rasp7_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp7_id_seq OWNED BY sc_rasp7.id;


--
-- Name: sc_rasp7_preps; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp7_preps (
    id integer NOT NULL,
    rasp7_id integer,
    prep_id integer
);


ALTER TABLE public.sc_rasp7_preps OWNER TO postgres;

--
-- Name: TABLE sc_rasp7_preps; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp7_preps IS 'преподаватели для расписания на 7 дней';


--
-- Name: sc_rasp7_preps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp7_preps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp7_preps_id_seq OWNER TO postgres;

--
-- Name: sc_rasp7_preps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp7_preps_id_seq OWNED BY sc_rasp7_preps.id;


--
-- Name: sc_rasp7_rooms; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sc_rasp7_rooms (
    id integer NOT NULL,
    rasp7_id integer,
    room text
);


ALTER TABLE public.sc_rasp7_rooms OWNER TO postgres;

--
-- Name: TABLE sc_rasp7_rooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE sc_rasp7_rooms IS 'аудитории для расписания на 7 дней';


--
-- Name: sc_rasp7_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp7_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp7_rooms_id_seq OWNER TO postgres;

--
-- Name: sc_rasp7_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE sc_rasp7_rooms_id_seq OWNED BY sc_rasp7_rooms.id;


--
-- Name: sc_rasp7_version_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE sc_rasp7_version_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sc_rasp7_version_seq OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE students (
    id integer NOT NULL,
    first_name text,
    middle_name text,
    last_name text,
    email text,
    login text,
    add_date integer,
    subgroup integer,
    locked boolean
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE students_id_seq OWNED BY students.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_department ALTER COLUMN id SET DEFAULT nextval('sc_department_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18 ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18_days ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_days_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18_groups ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18_info ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_info_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18_move ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_move_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18_preps ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_preps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp18_rooms ALTER COLUMN id SET DEFAULT nextval('sc_rasp18_rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp7 ALTER COLUMN id SET DEFAULT nextval('sc_rasp7_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp7_groups ALTER COLUMN id SET DEFAULT nextval('sc_rasp7_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp7_preps ALTER COLUMN id SET DEFAULT nextval('sc_rasp7_preps_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sc_rasp7_rooms ALTER COLUMN id SET DEFAULT nextval('sc_rasp7_rooms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY students ALTER COLUMN id SET DEFAULT nextval('students_id_seq'::regclass);


--
-- Data for Name: sc_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_department (id, title) FROM stdin;
\.


--
-- Name: sc_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_department_id_seq', 1, false);


--
-- Data for Name: sc_disc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_disc (id, title, shorttitle, department_id, varmask) FROM stdin;
\.


--
-- Data for Name: sc_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_group (id, title) FROM stdin;
\.


--
-- Data for Name: sc_prep; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_prep (id, fio, chair, degree, photo) FROM stdin;
\.


--
-- Data for Name: sc_rasp18; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18 (id, semcode, day_id, pair, kind, worktype, disc_id, timestart, timeend) FROM stdin;
\.


--
-- Data for Name: sc_rasp18_days; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18_days (id, semcode, day, weekday, week) FROM stdin;
\.


--
-- Name: sc_rasp18_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_days_id_seq', 1, false);


--
-- Data for Name: sc_rasp18_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18_groups (id, rasp18_id, group_id, subgroup) FROM stdin;
\.


--
-- Name: sc_rasp18_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_groups_id_seq', 1, false);


--
-- Name: sc_rasp18_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_id_seq', 1, false);


--
-- Data for Name: sc_rasp18_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18_info (id, rasp18_id, kind, info) FROM stdin;
\.


--
-- Name: sc_rasp18_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_info_id_seq', 1, false);


--
-- Data for Name: sc_rasp18_move; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18_move (id, rasp18_dest_id, src_day_id, src_pair, reason, comment) FROM stdin;
\.


--
-- Name: sc_rasp18_move_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_move_id_seq', 1, false);


--
-- Data for Name: sc_rasp18_preps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18_preps (id, rasp18_id, prep_id) FROM stdin;
\.


--
-- Name: sc_rasp18_preps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_preps_id_seq', 1, false);


--
-- Data for Name: sc_rasp18_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp18_rooms (id, rasp18_id, room) FROM stdin;
\.


--
-- Name: sc_rasp18_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp18_rooms_id_seq', 1, false);


--
-- Data for Name: sc_rasp7; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp7 (id, semcode, version, disc_id, weekday, pair, weeksarray, weekstext) FROM stdin;
\.


--
-- Data for Name: sc_rasp7_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp7_groups (id, rasp7_id, group_id, subgroup) FROM stdin;
\.


--
-- Name: sc_rasp7_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp7_groups_id_seq', 1, false);


--
-- Name: sc_rasp7_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp7_id_seq', 1, false);


--
-- Data for Name: sc_rasp7_preps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp7_preps (id, rasp7_id, prep_id) FROM stdin;
\.


--
-- Name: sc_rasp7_preps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp7_preps_id_seq', 1, false);


--
-- Data for Name: sc_rasp7_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sc_rasp7_rooms (id, rasp7_id, room) FROM stdin;
\.


--
-- Name: sc_rasp7_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp7_rooms_id_seq', 1, false);


--
-- Name: sc_rasp7_version_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('sc_rasp7_version_seq', 1, false);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY students (id, first_name, middle_name, last_name, email, login, add_date, subgroup, locked) FROM stdin;
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('students_id_seq', 1, false);


--
-- Name: sc_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_department
    ADD CONSTRAINT sc_department_pkey PRIMARY KEY (id);


--
-- Name: sc_disc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_disc
    ADD CONSTRAINT sc_disc_pkey PRIMARY KEY (id);


--
-- Name: sc_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_group
    ADD CONSTRAINT sc_group_pkey PRIMARY KEY (id);


--
-- Name: sc_prep_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_prep
    ADD CONSTRAINT sc_prep_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_days_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18_days
    ADD CONSTRAINT sc_rasp18_days_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18_groups
    ADD CONSTRAINT sc_rasp18_groups_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18_info
    ADD CONSTRAINT sc_rasp18_info_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_move_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18_move
    ADD CONSTRAINT sc_rasp18_move_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18
    ADD CONSTRAINT sc_rasp18_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_preps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18_preps
    ADD CONSTRAINT sc_rasp18_preps_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp18_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp18_rooms
    ADD CONSTRAINT sc_rasp18_rooms_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp7_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp7_groups
    ADD CONSTRAINT sc_rasp7_groups_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp7_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp7
    ADD CONSTRAINT sc_rasp7_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp7_preps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp7_preps
    ADD CONSTRAINT sc_rasp7_preps_pkey PRIMARY KEY (id);


--
-- Name: sc_rasp7_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sc_rasp7_rooms
    ADD CONSTRAINT sc_rasp7_rooms_pkey PRIMARY KEY (id);


--
-- Name: students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

