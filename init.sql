--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.1

-- Started on 2025-01-23 14:25:47

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16385)
-- Name: sc_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_department (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.sc_department OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE sc_department; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_department IS 'кафедры';


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: sc_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_department_id_seq OWNER TO postgres;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 218
-- Name: sc_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_department_id_seq OWNED BY public.sc_department.id;


--
-- TOC entry 219 (class 1259 OID 16391)
-- Name: sc_disc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_disc (
    id integer NOT NULL,
    title text,
    shorttitle text,
    department_id integer,
    varmask text
);


ALTER TABLE public.sc_disc OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE sc_disc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_disc IS 'кафедры';


--
-- TOC entry 220 (class 1259 OID 16396)
-- Name: sc_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_group (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.sc_group OWNER TO postgres;

--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE sc_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_group IS 'преподавательский состав';


--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: sc_prep; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_prep (
    id integer NOT NULL,
    fio text,
    chair text,
    degree text,
    photo text
);


ALTER TABLE public.sc_prep OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16406)
-- Name: sc_rasp18; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18 (
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
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE sc_rasp18; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18 IS 'расписание на каждый день (18 недель)';


--
-- TOC entry 223 (class 1259 OID 16411)
-- Name: sc_rasp18_days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18_days (
    id integer NOT NULL,
    semcode integer,
    day date,
    weekday integer,
    week integer
);


ALTER TABLE public.sc_rasp18_days OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE sc_rasp18_days; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18_days IS 'недели и дни недели по датам (18 недель)';


--
-- TOC entry 224 (class 1259 OID 16414)
-- Name: sc_rasp18_days_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_days_id_seq OWNER TO postgres;

--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 224
-- Name: sc_rasp18_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_days_id_seq OWNED BY public.sc_rasp18_days.id;


--
-- TOC entry 225 (class 1259 OID 16415)
-- Name: sc_rasp18_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18_groups (
    id integer NOT NULL,
    rasp18_id integer,
    group_id integer,
    subgroup integer
);


ALTER TABLE public.sc_rasp18_groups OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE sc_rasp18_groups; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18_groups IS 'группы для расписания (18 недель)';


--
-- TOC entry 226 (class 1259 OID 16418)
-- Name: sc_rasp18_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_groups_id_seq OWNER TO postgres;

--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 226
-- Name: sc_rasp18_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_groups_id_seq OWNED BY public.sc_rasp18_groups.id;


--
-- TOC entry 227 (class 1259 OID 16419)
-- Name: sc_rasp18_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_id_seq OWNER TO postgres;

--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 227
-- Name: sc_rasp18_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_id_seq OWNED BY public.sc_rasp18.id;


--
-- TOC entry 228 (class 1259 OID 16420)
-- Name: sc_rasp18_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18_info (
    id integer NOT NULL,
    rasp18_id integer,
    kind integer,
    info text
);


ALTER TABLE public.sc_rasp18_info OWNER TO postgres;

--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE sc_rasp18_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18_info IS 'доп. информация к занятиям для расписания (18 недель)';


--
-- TOC entry 229 (class 1259 OID 16425)
-- Name: sc_rasp18_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_info_id_seq OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 229
-- Name: sc_rasp18_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_info_id_seq OWNED BY public.sc_rasp18_info.id;


--
-- TOC entry 230 (class 1259 OID 16426)
-- Name: sc_rasp18_move; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18_move (
    id integer NOT NULL,
    rasp18_dest_id integer,
    src_day_id integer,
    src_pair integer,
    reason text,
    comment text
);


ALTER TABLE public.sc_rasp18_move OWNER TO postgres;

--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE sc_rasp18_move; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18_move IS 'информация по переносам для расписания (18 недель)';


--
-- TOC entry 231 (class 1259 OID 16431)
-- Name: sc_rasp18_move_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_move_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_move_id_seq OWNER TO postgres;

--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 231
-- Name: sc_rasp18_move_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_move_id_seq OWNED BY public.sc_rasp18_move.id;


--
-- TOC entry 232 (class 1259 OID 16432)
-- Name: sc_rasp18_preps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18_preps (
    id integer NOT NULL,
    rasp18_id integer,
    prep_id integer
);


ALTER TABLE public.sc_rasp18_preps OWNER TO postgres;

--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE sc_rasp18_preps; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18_preps IS 'преподаватели для расписания (18 недель)';


--
-- TOC entry 233 (class 1259 OID 16435)
-- Name: sc_rasp18_preps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_preps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_preps_id_seq OWNER TO postgres;

--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 233
-- Name: sc_rasp18_preps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_preps_id_seq OWNED BY public.sc_rasp18_preps.id;


--
-- TOC entry 234 (class 1259 OID 16436)
-- Name: sc_rasp18_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp18_rooms (
    id integer NOT NULL,
    rasp18_id integer,
    room text
);


ALTER TABLE public.sc_rasp18_rooms OWNER TO postgres;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE sc_rasp18_rooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp18_rooms IS 'аудитории для расписания (18 недель)';


--
-- TOC entry 235 (class 1259 OID 16441)
-- Name: sc_rasp18_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp18_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp18_rooms_id_seq OWNER TO postgres;

--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 235
-- Name: sc_rasp18_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp18_rooms_id_seq OWNED BY public.sc_rasp18_rooms.id;


--
-- TOC entry 236 (class 1259 OID 16442)
-- Name: sc_rasp7; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp7 (
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
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE sc_rasp7; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp7 IS 'расписание на 7 дней (универсальное)';


--
-- TOC entry 237 (class 1259 OID 16447)
-- Name: sc_rasp7_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp7_groups (
    id integer NOT NULL,
    rasp7_id integer,
    group_id integer,
    subgroup integer
);


ALTER TABLE public.sc_rasp7_groups OWNER TO postgres;

--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE sc_rasp7_groups; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp7_groups IS ' группы для расписания на 7 дней';


--
-- TOC entry 238 (class 1259 OID 16450)
-- Name: sc_rasp7_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp7_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp7_groups_id_seq OWNER TO postgres;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 238
-- Name: sc_rasp7_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp7_groups_id_seq OWNED BY public.sc_rasp7_groups.id;


--
-- TOC entry 239 (class 1259 OID 16451)
-- Name: sc_rasp7_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp7_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp7_id_seq OWNER TO postgres;

--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 239
-- Name: sc_rasp7_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp7_id_seq OWNED BY public.sc_rasp7.id;


--
-- TOC entry 240 (class 1259 OID 16452)
-- Name: sc_rasp7_preps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp7_preps (
    id integer NOT NULL,
    rasp7_id integer,
    prep_id integer
);


ALTER TABLE public.sc_rasp7_preps OWNER TO postgres;

--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE sc_rasp7_preps; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp7_preps IS 'преподаватели для расписания на 7 дней';


--
-- TOC entry 241 (class 1259 OID 16455)
-- Name: sc_rasp7_preps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp7_preps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp7_preps_id_seq OWNER TO postgres;

--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 241
-- Name: sc_rasp7_preps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp7_preps_id_seq OWNED BY public.sc_rasp7_preps.id;


--
-- TOC entry 242 (class 1259 OID 16456)
-- Name: sc_rasp7_rooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_rasp7_rooms (
    id integer NOT NULL,
    rasp7_id integer,
    room text
);


ALTER TABLE public.sc_rasp7_rooms OWNER TO postgres;

--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE sc_rasp7_rooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sc_rasp7_rooms IS 'аудитории для расписания на 7 дней';


--
-- TOC entry 243 (class 1259 OID 16461)
-- Name: sc_rasp7_rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp7_rooms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp7_rooms_id_seq OWNER TO postgres;

--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 243
-- Name: sc_rasp7_rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_rasp7_rooms_id_seq OWNED BY public.sc_rasp7_rooms.id;


--
-- TOC entry 244 (class 1259 OID 16462)
-- Name: sc_rasp7_version_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_rasp7_version_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_rasp7_version_seq OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16463)
-- Name: sc_worktypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sc_worktypes (
    id integer NOT NULL,
    title text
);


ALTER TABLE public.sc_worktypes OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16468)
-- Name: sc_worktypes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sc_worktypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sc_worktypes_id_seq OWNER TO postgres;

--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 246
-- Name: sc_worktypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sc_worktypes_id_seq OWNED BY public.sc_worktypes.id;


--
-- TOC entry 247 (class 1259 OID 16469)
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
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
-- TOC entry 248 (class 1259 OID 16474)
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_id_seq OWNER TO postgres;

--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 248
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- TOC entry 249 (class 1259 OID 16475)
-- Name: tg_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tg_users (
    tg_id integer NOT NULL,
    source_type text,
    source_name text,
    subgroup integer
);


ALTER TABLE public.tg_users OWNER TO postgres;

--
-- TOC entry 3292 (class 2604 OID 16480)
-- Name: sc_department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_department ALTER COLUMN id SET DEFAULT nextval('public.sc_department_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 16481)
-- Name: sc_rasp18 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18 ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 16482)
-- Name: sc_rasp18_days id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_days ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_days_id_seq'::regclass);


--
-- TOC entry 3295 (class 2604 OID 16483)
-- Name: sc_rasp18_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_groups ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_groups_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 16484)
-- Name: sc_rasp18_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_info ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_info_id_seq'::regclass);


--
-- TOC entry 3297 (class 2604 OID 16485)
-- Name: sc_rasp18_move id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_move ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_move_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 16486)
-- Name: sc_rasp18_preps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_preps ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_preps_id_seq'::regclass);


--
-- TOC entry 3299 (class 2604 OID 16487)
-- Name: sc_rasp18_rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_rooms ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp18_rooms_id_seq'::regclass);


--
-- TOC entry 3300 (class 2604 OID 16488)
-- Name: sc_rasp7 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7 ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp7_id_seq'::regclass);


--
-- TOC entry 3301 (class 2604 OID 16489)
-- Name: sc_rasp7_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7_groups ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp7_groups_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 16490)
-- Name: sc_rasp7_preps id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7_preps ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp7_preps_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 16491)
-- Name: sc_rasp7_rooms id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7_rooms ALTER COLUMN id SET DEFAULT nextval('public.sc_rasp7_rooms_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 16492)
-- Name: sc_worktypes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_worktypes ALTER COLUMN id SET DEFAULT nextval('public.sc_worktypes_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 16493)
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- TOC entry 3487 (class 0 OID 16385)
-- Dependencies: 217
-- Data for Name: sc_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_department (id, title) FROM stdin;
1	ВЕГА
2	ВМ
3	только для ВЕГИ
4	только для ВМ
5	другая
\.


--
-- TOC entry 3489 (class 0 OID 16391)
-- Dependencies: 219
-- Data for Name: sc_disc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_disc (id, title, shorttitle, department_id, varmask) FROM stdin;
20	null	Методы мат. анализа	2	null
21	null	Алгебра и геометрия	2	null
22	null	Спецрасписание\n\n2н - для всех студентов \nВоенная подготовка\nкампус Усачева 7/1	5	null
23	null	БЖД	5	null
24	null	ТВ и МС	2	null
25	null	Опер. системы	1	null
26	null	Числ. методы	1	null
27	null	Проект. трансляторов	1	null
28	null	Анализ и проект. ИС	1	null
29	null	Радиолокац. системы	1	null
30	null	Мат. мет. механики	2	null
31	null	Функц. анализ	2	null
32	null	Спецрасписание\n\n3н - для всех студентов\nВоенная подготовка\nкампус Усачева 7/1	5	null
33	null	САПР	1	null
34	null	Мет. моделир. РЛС	1	null
35	null	Упр. разраб. ПО	1	null
36	null	Теория игр и ИО	1	null
37	null	Спецрасписание	5	null
38	null	Проект. трансл.	1	null
39	null	Системы масс. обсл.	2	null
40	null	Мет. оптимизации	2	null
41	null	Случ. процессы	2	null
42	null	НИР	1	null
43	null	Рус. язык и КР	5	null
44	null	Психол. и пед.	5	null
45	null	Русский язык и КР	5	null
46	null	Высокоур. яз. прогр.	2	null
47	null	Дискр. мат. модели	2	null
48	null	Мет. реш. задач механики	2	null
49	null	Непр. мат. модели	2	null
50	null	Осн. научных иссл.	2	null
51	null	Качество и тестир. ПО	2	null
52	null	Дизайн цифровых продуктов	1	null
53	null	Дизайн-мышление и эрг. ПО	1	null
54	null	Совр. проблемы ПМИ	4	null
55	null	Мат. модели РО	4	null
56	null	Разр. сложных систем ОИУ	1	null
57	null	Мат. модели РО	2	null
58	null	Гибкое упр. проектами	5	null
59	null	Социол. и педаг. выс. шк.	5	null
60	null	Техн. личн. роста	5	null
61	null	Соц. и пед. выс. шк.	5	null
62	null	Гикое упр. проектами	5	null
63	null	Введение в ПД	1	null
64	null	Алг. и геометрия	2	null
65	null	АПИС	1	null
66	null	Сист. анализ ПО	1	null
67	null	РЛС	1	null
68	null	Воен. подготовка	5	null
69	null	Сист. масс. обслуж.	2	null
70	null	Псих. и педагогика	5	null
71	null	ТИ и ИсО	1	null
72	null	Управл. разраб. ПО	1	null
73	null	Общие методы исслед.	1	null
74	null	Высокоур. яз. прогр.	1	null
75	null	Тестирование ПО	1	null
76	null	Мет. реш. задач мех.	2	null
77	null	Технол. практика	3	null
78	null	Технол. практика	4	null
79	null	Гибк. упр. проектами	5	null
80	null	Совр. пробл. ПМИ	4	null
81	null	Дизайн цифр. прод.	1	null
82	null	Разр. ССОИиУ	3	null
83	null	ММ расп. образов	2	null
84	null	Соц. и пед. ВШ	5	null
85	null	ДМ и эргономика	1	null
86	null	НИР	3	null
87	null	НИР	4	null
0	null	История России	5	null
1	null	Мат. анализ	2	null
2	null	Дискр. математика	2	null
3	null	Введ. в разр. ПО	1	null
4	null	Введ. в проф. деят.	1	null
5	null	Правоведение	5	null
6	null	Информатика	5	null
7	null	Мет. мат. анализа	2	null
8	null	Ин. язык	5	null
9	null	Физ-ра	5	null
10	null	Прогр. в ЗРЛ	1	null
11	null	Лин. алг. и ан. геом.	2	null
12	null	Прогр. в ЗРЛ 	1	null
13	null	Матем. анализ	2	null
14	null	Дифф. геометрия	2	null
15	null	Спец. главы ВМ	2	null
16	null	Мет. и ст. прогр.	1	null
17	null	Системы ИИ и БД	5	null
18	null	Базы данных	1	null
19	null	Алгебра и геом.	2	null
\.


--
-- TOC entry 3490 (class 0 OID 16396)
-- Dependencies: 220
-- Data for Name: sc_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_group (id, title) FROM stdin;
0	КМБО-21-24
1	КМБО-22-24
2	КМБО-23-24
3	КМБО-24-24
4	КМБО-02-23
5	КМБО-05-23
6	КМБО-02-22
7	КМБО-05-22
8	КМБО-02-21
9	КМБО-05-21
10	КММО-11-24
11	КММО-01-23
\.


--
-- TOC entry 3491 (class 0 OID 16401)
-- Dependencies: 221
-- Data for Name: sc_prep; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_prep (id, fio, chair, degree, photo) FROM stdin;
35	Кодзасова Д.А.	None	None	None
36	Кочерова А.А.	None	None	None
37	Плахотина Ю.С.	None	None	None
38	Врублевский Ю.О.\nФролова О.А.	None	None	None
39	Одегов Р.А.	None	None	None
40	Пулькин И.С.	None	None	None
41	Воронов Г.Б.	None	None	None
42	Власов Е.Е.	None	None	None
43	Крыжановский Ю.М.	None	None	None
44	Волков А.В.	None	None	None
45	Рыжик Д.А.	None	None	None
46	Манаков В.Ю.	None	None	None
47	Кишкин А.М.	None	None	None
48	Плаченов А.Б.	None	None	None
49	Коновалова И.В.	None	None	None
50	Смирнов В.И.\nДрейфельд Д.Э.	None	None	None
51	Завьялов А.В.	None	None	None
52	Кирсанов А.П.	None	None	None
53	Лобузов А.А.	None	None	None
54	Патрикеева И.А.	None	None	None
55	Харламов С.Г.	None	None	None
56	Иванова Е.В.	None	None	None
57	Шихнабиева Т.Ш.	None	None	None
58	Миронов М.А.	None	None	None
59	Смирнов В.И.	None	None	None
60	Парфенов Д.В.	None	None	None
61	Эркенова Д.И.	None	None	None
62	Булычев Г.Г.	None	None	None
63	Пистун Е.Н.	None	None	None
64	Лебо И.Г.	None	None	None
65	Юссуф А.А.	None	None	None
66	Войтикова М.А.	None	None	None
67	Шпагина Е.М.	None	None	None
68	Барматова С.П.	None	None	None
69	Тарасова Н.В.	None	None	None
70	Шульгина А.С., \nЧерноусов И.Д.	None	None	None
71	Качалов С.К., \nМеретукова Б.Ш.	None	None	None
72	Ануфриев О.С.,\nНовикова А.А.\n	None	None	None
73	Качалов С.К., \nКритский А.С.	None	None	None
74	Куклева А. А.,\nМарченко А.К.\n	None	None	None
75	Дятлова Р.И.,\nНовикова А.Р.\n	None	None	None
76	Дрейфельд И.А.,\nДрейфельд Д.Э.	None	None	None
77	Черноусов И.Д., \nКодзасова Д.А.	None	None	None
78	Одегов Р.А., \nКодзасова Д.А.	None	None	None
79	Врублевский Ю.О.,\nФролова О.А.	None	None	None
80	Кирюшин В.В.	None	None	None
81	Коновалова И.В.,\nОдегов Р.А.	None	None	None
82	Волков А.В., \nСмирнов В.И., \nДрейфельд Д.Э.	None	None	None
0	Верченкова В.В.	None	None	None
1	Старостина А.В.	None	None	None
2	Хазиев Г.А.	None	None	None
3	Черноусов И.Д.	None	None	None
4	Сидоренко Т.В.	None	None	None
5	Рагимова Н.К.	None	None	None
6	Горлова К.О.	None	None	None
7	Хрычев Д.А.	None	None	None
8	Лаврова О.Ю.	None	None	None
9	Быстров Н.А.	None	None	None
10	Дроздов И.Ю.	None	None	None
11	Шульгина А.С.	None	None	None
12	Качалов С.К.	None	None	None
13	Благовещенский И.Г.	None	None	None
14	Сазонов А.И.	None	None	None
15	Смеловский Е.А.	None	None	None
16	Меретукова Б.Ш.	None	None	None
17	Ануфриев О.С.\nНовикова А.А.	None	None	None
18	Борец А.А.	None	None	None
19	Куклева А.А.\nМарченко А.К.	None	None	None
20	Канаев А.В.	None	None	None
21	Сухатерина С.Н.	None	None	None
22	Угрюмова М.В.	None	None	None
23	Критский А.В.	None	None	None
24	Дятлова Р.И.\nНовикова А.Р.	None	None	None
25	Шелепин А.Л.	None	None	None
26	Хачлаев Т.С.	None	None	None
27	Шатина А.В.	None	None	None
28	Тетерин Н.Н.	None	None	None
29	Каппушева И.Ш.	None	None	None
30	Дрейфельд И.А.	None	None	None
31	Дрейфельд Д.Э.	None	None	None
32	Артамкин И.В.	None	None	None
33	Есипов И.В.	None	None	None
34	Воловиков А.Ю.	None	None	None
\.


--
-- TOC entry 3492 (class 0 OID 16406)
-- Dependencies: 222
-- Data for Name: sc_rasp18; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18 (id, semcode, day_id, pair, kind, worktype, disc_id, timestart, timeend) FROM stdin;
76729	242500	6605	3	0	1	19	12:40	14:10
76872	242500	6540	3	0	0	21	12:40	14:10
76873	242500	6547	3	0	0	21	12:40	14:10
76874	242500	6554	3	0	0	21	12:40	14:10
76875	242500	6561	3	0	0	21	12:40	14:10
76876	242500	6568	3	0	0	21	12:40	14:10
76877	242500	6575	3	0	0	21	12:40	14:10
76878	242500	6582	3	0	0	21	12:40	14:10
76879	242500	6589	3	0	0	21	12:40	14:10
76880	242500	6596	3	0	0	21	12:40	14:10
76881	242500	6603	3	0	0	21	12:40	14:10
76882	242500	6610	3	0	0	21	12:40	14:10
76883	242500	6617	3	0	0	21	12:40	14:10
76884	242500	6624	3	0	0	21	12:40	14:10
76885	242500	6631	3	0	0	21	12:40	14:10
76886	242500	6638	3	0	0	21	12:40	14:10
76887	242500	6533	4	0	0	14	14:20	15:50
76888	242500	6540	4	0	0	14	14:20	15:50
76889	242500	6547	4	0	0	14	14:20	15:50
76890	242500	6554	4	0	0	14	14:20	15:50
76891	242500	6561	4	0	0	14	14:20	15:50
76892	242500	6568	4	0	0	14	14:20	15:50
76893	242500	6575	4	0	0	14	14:20	15:50
76894	242500	6582	4	0	0	14	14:20	15:50
76895	242500	6589	4	0	0	14	14:20	15:50
76896	242500	6596	4	0	0	14	14:20	15:50
76897	242500	6603	4	0	0	14	14:20	15:50
76898	242500	6610	4	0	0	14	14:20	15:50
76899	242500	6617	4	0	0	14	14:20	15:50
76900	242500	6624	4	0	0	14	14:20	15:50
76901	242500	6631	4	0	0	14	14:20	15:50
76902	242500	6638	4	0	0	14	14:20	15:50
76903	242500	6540	5	0	0	18	16:20	17:50
76904	242500	6554	5	0	0	18	16:20	17:50
76905	242500	6568	5	0	0	18	16:20	17:50
76906	242500	6582	5	0	0	18	16:20	17:50
76907	242500	6596	5	0	0	18	16:20	17:50
76908	242500	6610	5	0	0	18	16:20	17:50
76909	242500	6624	5	0	0	18	16:20	17:50
76910	242500	6638	5	0	0	18	16:20	17:50
76911	242500	6534	1	0	1	18	09:00	10:30
76912	242500	6548	1	0	1	18	09:00	10:30
76913	242500	6562	1	0	1	18	09:00	10:30
76914	242500	6576	1	0	1	18	09:00	10:30
76915	242500	6590	1	0	1	18	09:00	10:30
76916	242500	6604	1	0	1	18	09:00	10:30
76917	242500	6618	1	0	1	18	09:00	10:30
76918	242500	6632	1	0	1	18	09:00	10:30
76919	242500	6534	2	0	1	2	10:40	12:10
76920	242500	6548	2	0	1	2	10:40	12:10
76921	242500	6562	2	0	1	2	10:40	12:10
76922	242500	6576	2	0	1	2	10:40	12:10
76923	242500	6590	2	0	1	2	10:40	12:10
76924	242500	6604	2	0	1	2	10:40	12:10
76925	242500	6618	2	0	1	2	10:40	12:10
76926	242500	6632	2	0	1	2	10:40	12:10
76927	242500	6541	2	0	1	17	10:40	12:10
76928	242500	6555	2	0	1	17	10:40	12:10
76929	242500	6569	2	0	1	17	10:40	12:10
76930	242500	6583	2	0	1	17	10:40	12:10
76931	242500	6597	2	0	1	17	10:40	12:10
76932	242500	6611	2	0	1	17	10:40	12:10
76933	242500	6625	2	0	1	17	10:40	12:10
76934	242500	6639	2	0	1	17	10:40	12:10
76935	242500	6534	3	0	0	20	12:40	14:10
76936	242500	6541	3	0	0	20	12:40	14:10
76937	242500	6548	3	0	0	20	12:40	14:10
76938	242500	6555	3	0	0	20	12:40	14:10
76939	242500	6562	3	0	0	20	12:40	14:10
76940	242500	6569	3	0	0	20	12:40	14:10
76941	242500	6576	3	0	0	20	12:40	14:10
76942	242500	6583	3	0	0	20	12:40	14:10
76943	242500	6590	3	0	0	20	12:40	14:10
76944	242500	6597	3	0	0	20	12:40	14:10
76945	242500	6604	3	0	0	20	12:40	14:10
76946	242500	6611	3	0	0	20	12:40	14:10
76947	242500	6618	3	0	0	20	12:40	14:10
76948	242500	6625	3	0	0	20	12:40	14:10
76949	242500	6632	3	0	0	20	12:40	14:10
76950	242500	6639	3	0	0	20	12:40	14:10
76951	242500	6534	4	0	0	8	14:20	15:50
76952	242500	6541	4	0	0	8	14:20	15:50
76953	242500	6548	4	0	0	8	14:20	15:50
76954	242500	6555	4	0	0	8	14:20	15:50
76955	242500	6562	4	0	0	8	14:20	15:50
76956	242500	6569	4	0	0	8	14:20	15:50
76957	242500	6576	4	0	0	8	14:20	15:50
76958	242500	6583	4	0	0	8	14:20	15:50
76959	242500	6590	4	0	0	8	14:20	15:50
76960	242500	6597	4	0	0	8	14:20	15:50
76961	242500	6604	4	0	0	8	14:20	15:50
76962	242500	6611	4	0	0	8	14:20	15:50
76963	242500	6618	4	0	0	8	14:20	15:50
76964	242500	6625	4	0	0	8	14:20	15:50
76965	242500	6632	4	0	0	8	14:20	15:50
76966	242500	6639	4	0	0	8	14:20	15:50
76967	242500	6535	1	0	0	16	09:00	10:30
76968	242500	6542	1	0	0	16	09:00	10:30
76969	242500	6549	1	0	0	16	09:00	10:30
76970	242500	6556	1	0	0	16	09:00	10:30
76971	242500	6563	1	0	0	16	09:00	10:30
76972	242500	6570	1	0	0	16	09:00	10:30
76973	242500	6577	1	0	0	16	09:00	10:30
76974	242500	6584	1	0	0	16	09:00	10:30
76975	242500	6591	1	0	0	16	09:00	10:30
76976	242500	6598	1	0	0	16	09:00	10:30
76977	242500	6605	1	0	0	16	09:00	10:30
76978	242500	6612	1	0	0	16	09:00	10:30
76979	242500	6619	1	0	0	16	09:00	10:30
76980	242500	6626	1	0	0	16	09:00	10:30
76981	242500	6633	1	0	0	16	09:00	10:30
76982	242500	6640	1	0	0	16	09:00	10:30
76983	242500	6535	2	0	0	1	10:40	12:10
76984	242500	6549	2	0	0	1	10:40	12:10
76985	242500	6563	2	0	0	1	10:40	12:10
76986	242500	6577	2	0	0	1	10:40	12:10
76987	242500	6591	2	0	0	1	10:40	12:10
76988	242500	6605	2	0	0	1	10:40	12:10
76989	242500	6619	2	0	0	1	10:40	12:10
76990	242500	6633	2	0	0	1	10:40	12:10
76730	242500	6612	3	0	1	19	12:40	14:10
76731	242500	6619	3	0	1	19	12:40	14:10
76732	242500	6626	3	0	1	19	12:40	14:10
76733	242500	6633	3	0	1	19	12:40	14:10
76734	242500	6640	3	0	1	19	12:40	14:10
76735	242500	6535	4	0	0	16	14:20	15:50
76736	242500	6542	4	0	0	16	14:20	15:50
76737	242500	6549	4	0	0	16	14:20	15:50
76738	242500	6556	4	0	0	16	14:20	15:50
76739	242500	6563	4	0	0	16	14:20	15:50
76740	242500	6570	4	0	0	16	14:20	15:50
76741	242500	6577	4	0	0	16	14:20	15:50
76742	242500	6584	4	0	0	16	14:20	15:50
76743	242500	6591	4	0	0	16	14:20	15:50
76744	242500	6598	4	0	0	16	14:20	15:50
76745	242500	6605	4	0	0	16	14:20	15:50
76746	242500	6612	4	0	0	16	14:20	15:50
76747	242500	6619	4	0	0	16	14:20	15:50
76748	242500	6626	4	0	0	16	14:20	15:50
76749	242500	6633	4	0	0	16	14:20	15:50
76750	242500	6640	4	0	0	16	14:20	15:50
76751	242500	6536	2	0	1	16	10:40	12:10
76752	242500	6550	2	0	1	16	10:40	12:10
76753	242500	6564	2	0	1	16	10:40	12:10
76754	242500	6578	2	0	1	16	10:40	12:10
76755	242500	6592	2	0	1	16	10:40	12:10
76756	242500	6606	2	0	1	16	10:40	12:10
76757	242500	6620	2	0	1	16	10:40	12:10
76758	242500	6634	2	0	1	16	10:40	12:10
76759	242500	6531	3	0	1	15	12:40	14:10
76760	242500	6538	3	0	1	15	12:40	14:10
76761	242500	6545	3	0	1	15	12:40	14:10
76762	242500	6552	3	0	1	15	12:40	14:10
76763	242500	6559	3	0	1	15	12:40	14:10
76764	242500	6566	3	0	1	15	12:40	14:10
76765	242500	6573	3	0	1	15	12:40	14:10
76766	242500	6580	3	0	1	15	12:40	14:10
76767	242500	6587	3	0	1	15	12:40	14:10
76768	242500	6594	3	0	1	15	12:40	14:10
76769	242500	6601	3	0	1	15	12:40	14:10
76770	242500	6608	3	0	1	15	12:40	14:10
76771	242500	6615	3	0	1	15	12:40	14:10
76772	242500	6622	3	0	1	15	12:40	14:10
76773	242500	6629	3	0	1	15	12:40	14:10
76774	242500	6636	3	0	1	15	12:40	14:10
76775	242500	6531	4	0	1	14	14:20	15:50
76776	242500	6538	4	0	1	14	14:20	15:50
76777	242500	6545	4	0	1	14	14:20	15:50
76778	242500	6552	4	0	1	14	14:20	15:50
76779	242500	6559	4	0	1	14	14:20	15:50
76780	242500	6566	4	0	1	14	14:20	15:50
76781	242500	6573	4	0	1	14	14:20	15:50
76782	242500	6580	4	0	1	14	14:20	15:50
76783	242500	6587	4	0	1	14	14:20	15:50
76784	242500	6594	4	0	1	14	14:20	15:50
76785	242500	6601	4	0	1	14	14:20	15:50
76786	242500	6608	4	0	1	14	14:20	15:50
76787	242500	6615	4	0	1	14	14:20	15:50
76788	242500	6622	4	0	1	14	14:20	15:50
76789	242500	6629	4	0	1	14	14:20	15:50
76790	242500	6636	4	0	1	14	14:20	15:50
76791	242500	6531	5	0	0	9	16:20	17:50
76792	242500	6538	5	0	0	9	16:20	17:50
76793	242500	6545	5	0	0	9	16:20	17:50
76794	242500	6552	5	0	0	9	16:20	17:50
76795	242500	6559	5	0	0	9	16:20	17:50
76796	242500	6566	5	0	0	9	16:20	17:50
76797	242500	6573	5	0	0	9	16:20	17:50
76798	242500	6580	5	0	0	9	16:20	17:50
76799	242500	6587	5	0	0	9	16:20	17:50
76800	242500	6594	5	0	0	9	16:20	17:50
75191	242500	6531	1	0	0	0	09:00	10:30
75192	242500	6538	1	0	0	0	09:00	10:30
75193	242500	6545	1	0	0	0	09:00	10:30
75194	242500	6552	1	0	0	0	09:00	10:30
75195	242500	6559	1	0	0	0	09:00	10:30
75196	242500	6566	1	0	0	0	09:00	10:30
75197	242500	6573	1	0	0	0	09:00	10:30
75198	242500	6580	1	0	0	0	09:00	10:30
75199	242500	6587	1	0	0	0	09:00	10:30
75200	242500	6594	1	0	0	0	09:00	10:30
75201	242500	6601	1	0	0	0	09:00	10:30
75202	242500	6608	1	0	0	0	09:00	10:30
75203	242500	6615	1	0	0	0	09:00	10:30
75204	242500	6622	1	0	0	0	09:00	10:30
75205	242500	6629	1	0	0	0	09:00	10:30
75206	242500	6636	1	0	0	0	09:00	10:30
75207	242500	6531	2	0	0	1	10:40	12:10
75208	242500	6538	2	0	0	1	10:40	12:10
75209	242500	6545	2	0	0	1	10:40	12:10
75210	242500	6552	2	0	0	1	10:40	12:10
75211	242500	6559	2	0	0	1	10:40	12:10
75212	242500	6566	2	0	0	1	10:40	12:10
75213	242500	6573	2	0	0	1	10:40	12:10
75214	242500	6580	2	0	0	1	10:40	12:10
75215	242500	6587	2	0	0	1	10:40	12:10
75216	242500	6594	2	0	0	1	10:40	12:10
75217	242500	6601	2	0	0	1	10:40	12:10
75218	242500	6608	2	0	0	1	10:40	12:10
75219	242500	6615	2	0	0	1	10:40	12:10
75220	242500	6622	2	0	0	1	10:40	12:10
75221	242500	6629	2	0	0	1	10:40	12:10
75222	242500	6636	2	0	0	1	10:40	12:10
75223	242500	6531	3	0	0	2	12:40	14:10
75224	242500	6538	3	0	0	2	12:40	14:10
75225	242500	6545	3	0	0	2	12:40	14:10
75226	242500	6552	3	0	0	2	12:40	14:10
75227	242500	6559	3	0	0	2	12:40	14:10
75228	242500	6566	3	0	0	2	12:40	14:10
75229	242500	6573	3	0	0	2	12:40	14:10
75230	242500	6580	3	0	0	2	12:40	14:10
75231	242500	6587	3	0	0	2	12:40	14:10
75232	242500	6594	3	0	0	2	12:40	14:10
75233	242500	6601	3	0	0	2	12:40	14:10
75234	242500	6608	3	0	0	2	12:40	14:10
75235	242500	6615	3	0	0	2	12:40	14:10
75236	242500	6622	3	0	0	2	12:40	14:10
75237	242500	6629	3	0	0	2	12:40	14:10
75238	242500	6636	3	0	0	2	12:40	14:10
75239	242500	6531	4	0	0	3	14:20	15:50
75240	242500	6538	4	0	0	3	14:20	15:50
75241	242500	6545	4	0	0	3	14:20	15:50
75242	242500	6552	4	0	0	3	14:20	15:50
75243	242500	6559	4	0	0	3	14:20	15:50
75244	242500	6566	4	0	0	3	14:20	15:50
75245	242500	6573	4	0	0	3	14:20	15:50
75246	242500	6580	4	0	0	3	14:20	15:50
75247	242500	6587	4	0	0	3	14:20	15:50
75248	242500	6594	4	0	0	3	14:20	15:50
75249	242500	6601	4	0	0	3	14:20	15:50
75250	242500	6608	4	0	0	3	14:20	15:50
75251	242500	6615	4	0	0	3	14:20	15:50
75252	242500	6622	4	0	0	3	14:20	15:50
75253	242500	6629	4	0	0	3	14:20	15:50
75254	242500	6636	4	0	0	3	14:20	15:50
75255	242500	6538	5	0	0	4	16:20	17:50
75256	242500	6552	5	0	0	4	16:20	17:50
75257	242500	6566	5	0	0	4	16:20	17:50
75258	242500	6580	5	0	0	4	16:20	17:50
75259	242500	6594	5	0	0	4	16:20	17:50
75260	242500	6608	5	0	0	4	16:20	17:50
75261	242500	6622	5	0	0	4	16:20	17:50
75262	242500	6636	5	0	0	4	16:20	17:50
75263	242500	6539	2	0	0	5	10:40	12:10
75264	242500	6553	2	0	0	5	10:40	12:10
75265	242500	6567	2	0	0	5	10:40	12:10
75266	242500	6581	2	0	0	5	10:40	12:10
75267	242500	6595	2	0	0	5	10:40	12:10
75268	242500	6609	2	0	0	5	10:40	12:10
75269	242500	6623	2	0	0	5	10:40	12:10
75270	242500	6637	2	0	0	5	10:40	12:10
75271	242500	6532	3	0	0	6	12:40	14:10
75272	242500	6539	3	0	0	6	12:40	14:10
75273	242500	6546	3	0	0	6	12:40	14:10
75274	242500	6553	3	0	0	6	12:40	14:10
75275	242500	6560	3	0	0	6	12:40	14:10
75276	242500	6567	3	0	0	6	12:40	14:10
75277	242500	6574	3	0	0	6	12:40	14:10
75278	242500	6581	3	0	0	6	12:40	14:10
75279	242500	6588	3	0	0	6	12:40	14:10
75280	242500	6595	3	0	0	6	12:40	14:10
75281	242500	6602	3	0	0	6	12:40	14:10
75282	242500	6609	3	0	0	6	12:40	14:10
75283	242500	6616	3	0	0	6	12:40	14:10
75284	242500	6623	3	0	0	6	12:40	14:10
75285	242500	6630	3	0	0	6	12:40	14:10
75286	242500	6637	3	0	0	6	12:40	14:10
75287	242500	6532	4	0	0	6	14:20	15:50
75288	242500	6539	4	0	0	6	14:20	15:50
75289	242500	6546	4	0	0	6	14:20	15:50
75290	242500	6553	4	0	0	6	14:20	15:50
75291	242500	6560	4	0	0	6	14:20	15:50
75292	242500	6567	4	0	0	6	14:20	15:50
75293	242500	6574	4	0	0	6	14:20	15:50
75294	242500	6581	4	0	0	6	14:20	15:50
75295	242500	6588	4	0	0	6	14:20	15:50
75296	242500	6595	4	0	0	6	14:20	15:50
75297	242500	6602	4	0	0	6	14:20	15:50
75298	242500	6609	4	0	0	6	14:20	15:50
75299	242500	6616	4	0	0	6	14:20	15:50
75300	242500	6623	4	0	0	6	14:20	15:50
75301	242500	6630	4	0	0	6	14:20	15:50
75302	242500	6637	4	0	0	6	14:20	15:50
75303	242500	6532	5	0	0	7	16:20	17:50
75304	242500	6539	5	0	0	7	16:20	17:50
75305	242500	6546	5	0	0	7	16:20	17:50
75306	242500	6553	5	0	0	7	16:20	17:50
75307	242500	6560	5	0	0	7	16:20	17:50
75308	242500	6567	5	0	0	7	16:20	17:50
75309	242500	6574	5	0	0	7	16:20	17:50
75310	242500	6581	5	0	0	7	16:20	17:50
75311	242500	6588	5	0	0	7	16:20	17:50
75312	242500	6595	5	0	0	7	16:20	17:50
75313	242500	6602	5	0	0	7	16:20	17:50
75314	242500	6609	5	0	0	7	16:20	17:50
75315	242500	6616	5	0	0	7	16:20	17:50
75316	242500	6623	5	0	0	7	16:20	17:50
75317	242500	6630	5	0	0	7	16:20	17:50
75318	242500	6637	5	0	0	7	16:20	17:50
75319	242500	6533	1	0	1	1	09:00	10:30
75320	242500	6540	1	0	1	1	09:00	10:30
75321	242500	6547	1	0	1	1	09:00	10:30
75322	242500	6554	1	0	1	1	09:00	10:30
75323	242500	6561	1	0	1	1	09:00	10:30
75324	242500	6568	1	0	1	1	09:00	10:30
75325	242500	6575	1	0	1	1	09:00	10:30
75326	242500	6582	1	0	1	1	09:00	10:30
75327	242500	6589	1	0	1	1	09:00	10:30
75328	242500	6596	1	0	1	1	09:00	10:30
75329	242500	6603	1	0	1	1	09:00	10:30
75330	242500	6610	1	0	1	1	09:00	10:30
75331	242500	6617	1	0	1	1	09:00	10:30
75332	242500	6624	1	0	1	1	09:00	10:30
75333	242500	6631	1	0	1	1	09:00	10:30
75334	242500	6638	1	0	1	1	09:00	10:30
75335	242500	6533	2	0	1	7	10:40	12:10
75336	242500	6540	2	0	1	7	10:40	12:10
75337	242500	6547	2	0	1	7	10:40	12:10
75338	242500	6554	2	0	1	7	10:40	12:10
75339	242500	6561	2	0	1	7	10:40	12:10
75340	242500	6568	2	0	1	7	10:40	12:10
75341	242500	6575	2	0	1	7	10:40	12:10
75342	242500	6582	2	0	1	7	10:40	12:10
75343	242500	6589	2	0	1	7	10:40	12:10
75344	242500	6596	2	0	1	7	10:40	12:10
75345	242500	6603	2	0	1	7	10:40	12:10
75346	242500	6610	2	0	1	7	10:40	12:10
75347	242500	6617	2	0	1	7	10:40	12:10
75348	242500	6624	2	0	1	7	10:40	12:10
75349	242500	6631	2	0	1	7	10:40	12:10
75350	242500	6638	2	0	1	7	10:40	12:10
75351	242500	6533	3	0	0	8	12:40	14:10
75352	242500	6540	3	0	0	8	12:40	14:10
75353	242500	6547	3	0	0	8	12:40	14:10
75354	242500	6554	3	0	0	8	12:40	14:10
75355	242500	6561	3	0	0	8	12:40	14:10
75356	242500	6568	3	0	0	8	12:40	14:10
75357	242500	6575	3	0	0	8	12:40	14:10
75358	242500	6582	3	0	0	8	12:40	14:10
75359	242500	6589	3	0	0	8	12:40	14:10
75360	242500	6596	3	0	0	8	12:40	14:10
75361	242500	6603	3	0	0	8	12:40	14:10
75362	242500	6610	3	0	0	8	12:40	14:10
75363	242500	6617	3	0	0	8	12:40	14:10
75364	242500	6624	3	0	0	8	12:40	14:10
75365	242500	6631	3	0	0	8	12:40	14:10
75366	242500	6638	3	0	0	8	12:40	14:10
75367	242500	6534	1	0	1	2	09:00	10:30
75368	242500	6541	1	0	1	2	09:00	10:30
75369	242500	6548	1	0	1	2	09:00	10:30
75370	242500	6555	1	0	1	2	09:00	10:30
75371	242500	6562	1	0	1	2	09:00	10:30
75372	242500	6569	1	0	1	2	09:00	10:30
75373	242500	6576	1	0	1	2	09:00	10:30
75374	242500	6583	1	0	1	2	09:00	10:30
75375	242500	6590	1	0	1	2	09:00	10:30
75376	242500	6597	1	0	1	2	09:00	10:30
75377	242500	6604	1	0	1	2	09:00	10:30
75378	242500	6611	1	0	1	2	09:00	10:30
75379	242500	6618	1	0	1	2	09:00	10:30
75380	242500	6625	1	0	1	2	09:00	10:30
75381	242500	6632	1	0	1	2	09:00	10:30
75382	242500	6639	1	0	1	2	09:00	10:30
75383	242500	6534	2	0	1	3	10:40	12:10
75384	242500	6548	2	0	1	3	10:40	12:10
75385	242500	6562	2	0	1	3	10:40	12:10
75386	242500	6576	2	0	1	3	10:40	12:10
75387	242500	6590	2	0	1	3	10:40	12:10
75388	242500	6604	2	0	1	3	10:40	12:10
75389	242500	6618	2	0	1	3	10:40	12:10
75390	242500	6632	2	0	1	3	10:40	12:10
75391	242500	6534	3	0	0	9	12:40	14:10
75392	242500	6541	3	0	0	9	12:40	14:10
75393	242500	6548	3	0	0	9	12:40	14:10
75394	242500	6555	3	0	0	9	12:40	14:10
75395	242500	6562	3	0	0	9	12:40	14:10
75396	242500	6569	3	0	0	9	12:40	14:10
75397	242500	6576	3	0	0	9	12:40	14:10
75398	242500	6583	3	0	0	9	12:40	14:10
75399	242500	6590	3	0	0	9	12:40	14:10
75400	242500	6597	3	0	0	9	12:40	14:10
75401	242500	6604	3	0	0	9	12:40	14:10
75402	242500	6611	3	0	0	9	12:40	14:10
75403	242500	6618	3	0	0	9	12:40	14:10
75404	242500	6625	3	0	0	9	12:40	14:10
75405	242500	6632	3	0	0	9	12:40	14:10
75406	242500	6639	3	0	0	9	12:40	14:10
75407	242500	6534	4	0	0	3	14:20	15:50
75408	242500	6541	4	0	0	3	14:20	15:50
75409	242500	6548	4	0	0	3	14:20	15:50
75410	242500	6555	4	0	0	3	14:20	15:50
75411	242500	6562	4	0	0	3	14:20	15:50
75412	242500	6569	4	0	0	3	14:20	15:50
75413	242500	6576	4	0	0	3	14:20	15:50
75414	242500	6583	4	0	0	3	14:20	15:50
75415	242500	6590	4	0	0	3	14:20	15:50
75416	242500	6597	4	0	0	3	14:20	15:50
75417	242500	6604	4	0	0	3	14:20	15:50
75418	242500	6611	4	0	0	3	14:20	15:50
75419	242500	6618	4	0	0	3	14:20	15:50
75420	242500	6625	4	0	0	3	14:20	15:50
75421	242500	6632	4	0	0	3	14:20	15:50
75422	242500	6639	4	0	0	3	14:20	15:50
75423	242500	6535	1	0	1	10	09:00	10:30
75424	242500	6549	1	0	1	10	09:00	10:30
75425	242500	6563	1	0	1	10	09:00	10:30
75426	242500	6577	1	0	1	10	09:00	10:30
75427	242500	6591	1	0	1	10	09:00	10:30
75428	242500	6605	1	0	1	10	09:00	10:30
75429	242500	6619	1	0	1	10	09:00	10:30
75430	242500	6633	1	0	1	10	09:00	10:30
75431	242500	6542	1	0	1	6	09:00	10:30
75432	242500	6556	1	0	1	6	09:00	10:30
75433	242500	6570	1	0	1	6	09:00	10:30
75434	242500	6584	1	0	1	6	09:00	10:30
75435	242500	6598	1	0	1	6	09:00	10:30
75436	242500	6612	1	0	1	6	09:00	10:30
75437	242500	6626	1	0	1	6	09:00	10:30
75438	242500	6640	1	0	1	6	09:00	10:30
75439	242500	6535	2	0	0	10	10:40	12:10
75440	242500	6549	2	0	0	10	10:40	12:10
75441	242500	6563	2	0	0	10	10:40	12:10
75442	242500	6577	2	0	0	10	10:40	12:10
75443	242500	6591	2	0	0	10	10:40	12:10
75444	242500	6605	2	0	0	10	10:40	12:10
75445	242500	6619	2	0	0	10	10:40	12:10
75446	242500	6633	2	0	0	10	10:40	12:10
75447	242500	6535	3	0	0	11	12:40	14:10
75448	242500	6542	3	0	0	11	12:40	14:10
75449	242500	6549	3	0	0	11	12:40	14:10
75450	242500	6556	3	0	0	11	12:40	14:10
75451	242500	6563	3	0	0	11	12:40	14:10
75452	242500	6570	3	0	0	11	12:40	14:10
75453	242500	6577	3	0	0	11	12:40	14:10
75454	242500	6584	3	0	0	11	12:40	14:10
75455	242500	6591	3	0	0	11	12:40	14:10
75456	242500	6598	3	0	0	11	12:40	14:10
75457	242500	6605	3	0	0	11	12:40	14:10
75458	242500	6612	3	0	0	11	12:40	14:10
75459	242500	6619	3	0	0	11	12:40	14:10
75460	242500	6626	3	0	0	11	12:40	14:10
75461	242500	6633	3	0	0	11	12:40	14:10
75462	242500	6640	3	0	0	11	12:40	14:10
75463	242500	6535	4	0	1	11	14:20	15:50
75464	242500	6542	4	0	1	11	14:20	15:50
75465	242500	6549	4	0	1	11	14:20	15:50
75466	242500	6556	4	0	1	11	14:20	15:50
75467	242500	6563	4	0	1	11	14:20	15:50
75468	242500	6570	4	0	1	11	14:20	15:50
75469	242500	6577	4	0	1	11	14:20	15:50
75470	242500	6584	4	0	1	11	14:20	15:50
75471	242500	6591	4	0	1	11	14:20	15:50
75472	242500	6598	4	0	1	11	14:20	15:50
75473	242500	6605	4	0	1	11	14:20	15:50
75474	242500	6612	4	0	1	11	14:20	15:50
75475	242500	6619	4	0	1	11	14:20	15:50
75476	242500	6626	4	0	1	11	14:20	15:50
75477	242500	6633	4	0	1	11	14:20	15:50
75478	242500	6640	4	0	1	11	14:20	15:50
75479	242500	6535	5	0	1	0	16:20	17:50
75480	242500	6542	5	0	1	0	16:20	17:50
75481	242500	6549	5	0	1	0	16:20	17:50
75482	242500	6556	5	0	1	0	16:20	17:50
75483	242500	6563	5	0	1	0	16:20	17:50
75484	242500	6570	5	0	1	0	16:20	17:50
75485	242500	6577	5	0	1	0	16:20	17:50
75486	242500	6584	5	0	1	0	16:20	17:50
75487	242500	6591	5	0	1	0	16:20	17:50
75488	242500	6598	5	0	1	0	16:20	17:50
75489	242500	6605	5	0	1	0	16:20	17:50
75490	242500	6612	5	0	1	0	16:20	17:50
75491	242500	6619	5	0	1	0	16:20	17:50
75492	242500	6626	5	0	1	0	16:20	17:50
75493	242500	6633	5	0	1	0	16:20	17:50
75494	242500	6640	5	0	1	0	16:20	17:50
75495	242500	6536	1	0	0	10	09:00	10:30
75496	242500	6550	1	0	0	10	09:00	10:30
75497	242500	6564	1	0	0	10	09:00	10:30
75498	242500	6578	1	0	0	10	09:00	10:30
75499	242500	6592	1	0	0	10	09:00	10:30
75500	242500	6606	1	0	0	10	09:00	10:30
75501	242500	6620	1	0	0	10	09:00	10:30
75502	242500	6634	1	0	0	10	09:00	10:30
75503	242500	6536	6	0	1	5	18:00	19:30
75504	242500	6550	6	0	1	5	18:00	19:30
75505	242500	6564	6	0	1	5	18:00	19:30
75506	242500	6578	6	0	1	5	18:00	19:30
75507	242500	6592	6	0	1	5	18:00	19:30
75508	242500	6606	6	0	1	5	18:00	19:30
75509	242500	6620	6	0	1	5	18:00	19:30
75510	242500	6634	6	0	1	5	18:00	19:30
75511	242500	6538	1	0	0	8	09:00	10:30
75512	242500	6552	1	0	0	8	09:00	10:30
75513	242500	6566	1	0	0	8	09:00	10:30
75514	242500	6580	1	0	0	8	09:00	10:30
75515	242500	6594	1	0	0	8	09:00	10:30
75516	242500	6608	1	0	0	8	09:00	10:30
75517	242500	6622	1	0	0	8	09:00	10:30
75518	242500	6636	1	0	0	8	09:00	10:30
75519	242500	6538	2	0	0	8	10:40	12:10
75520	242500	6552	2	0	0	8	10:40	12:10
75521	242500	6566	2	0	0	8	10:40	12:10
75522	242500	6580	2	0	0	8	10:40	12:10
75523	242500	6594	2	0	0	8	10:40	12:10
75524	242500	6608	2	0	0	8	10:40	12:10
75525	242500	6622	2	0	0	8	10:40	12:10
75526	242500	6636	2	0	0	8	10:40	12:10
75527	242500	6531	3	0	0	1	12:40	14:10
75528	242500	6538	3	0	0	1	12:40	14:10
75529	242500	6545	3	0	0	1	12:40	14:10
75530	242500	6552	3	0	0	1	12:40	14:10
75531	242500	6559	3	0	0	1	12:40	14:10
75532	242500	6566	3	0	0	1	12:40	14:10
75533	242500	6573	3	0	0	1	12:40	14:10
75534	242500	6580	3	0	0	1	12:40	14:10
75535	242500	6587	3	0	0	1	12:40	14:10
75536	242500	6594	3	0	0	1	12:40	14:10
75537	242500	6601	3	0	0	1	12:40	14:10
75538	242500	6608	3	0	0	1	12:40	14:10
75539	242500	6615	3	0	0	1	12:40	14:10
75540	242500	6622	3	0	0	1	12:40	14:10
75541	242500	6629	3	0	0	1	12:40	14:10
75542	242500	6636	3	0	0	1	12:40	14:10
75543	242500	6531	4	0	0	0	14:20	15:50
75544	242500	6538	4	0	0	0	14:20	15:50
75545	242500	6545	4	0	0	0	14:20	15:50
75546	242500	6552	4	0	0	0	14:20	15:50
75547	242500	6559	4	0	0	0	14:20	15:50
75548	242500	6566	4	0	0	0	14:20	15:50
75549	242500	6573	4	0	0	0	14:20	15:50
75550	242500	6580	4	0	0	0	14:20	15:50
75551	242500	6587	4	0	0	0	14:20	15:50
75552	242500	6594	4	0	0	0	14:20	15:50
75553	242500	6601	4	0	0	0	14:20	15:50
75554	242500	6608	4	0	0	0	14:20	15:50
75555	242500	6615	4	0	0	0	14:20	15:50
75556	242500	6622	4	0	0	0	14:20	15:50
75557	242500	6629	4	0	0	0	14:20	15:50
75558	242500	6636	4	0	0	0	14:20	15:50
75559	242500	6538	5	0	0	4	16:20	17:50
75560	242500	6552	5	0	0	4	16:20	17:50
75561	242500	6566	5	0	0	4	16:20	17:50
75562	242500	6580	5	0	0	4	16:20	17:50
75563	242500	6594	5	0	0	4	16:20	17:50
75564	242500	6608	5	0	0	4	16:20	17:50
75565	242500	6622	5	0	0	4	16:20	17:50
75566	242500	6636	5	0	0	4	16:20	17:50
75567	242500	6531	6	0	0	3	18:00	19:30
75568	242500	6538	6	0	0	3	18:00	19:30
75569	242500	6545	6	0	0	3	18:00	19:30
75570	242500	6552	6	0	0	3	18:00	19:30
75571	242500	6559	6	0	0	3	18:00	19:30
75572	242500	6566	6	0	0	3	18:00	19:30
75573	242500	6573	6	0	0	3	18:00	19:30
75574	242500	6580	6	0	0	3	18:00	19:30
75575	242500	6587	6	0	0	3	18:00	19:30
75576	242500	6594	6	0	0	3	18:00	19:30
75577	242500	6601	6	0	0	3	18:00	19:30
75578	242500	6608	6	0	0	3	18:00	19:30
75579	242500	6615	6	0	0	3	18:00	19:30
75580	242500	6622	6	0	0	3	18:00	19:30
75581	242500	6629	6	0	0	3	18:00	19:30
75582	242500	6636	6	0	0	3	18:00	19:30
75583	242500	6539	3	0	0	5	12:40	14:10
75584	242500	6553	3	0	0	5	12:40	14:10
75585	242500	6567	3	0	0	5	12:40	14:10
75586	242500	6581	3	0	0	5	12:40	14:10
75587	242500	6595	3	0	0	5	12:40	14:10
75588	242500	6609	3	0	0	5	12:40	14:10
75589	242500	6623	3	0	0	5	12:40	14:10
75590	242500	6637	3	0	0	5	12:40	14:10
75591	242500	6532	4	0	0	11	14:20	15:50
75592	242500	6539	4	0	0	11	14:20	15:50
75593	242500	6546	4	0	0	11	14:20	15:50
75594	242500	6553	4	0	0	11	14:20	15:50
75595	242500	6560	4	0	0	11	14:20	15:50
75596	242500	6567	4	0	0	11	14:20	15:50
75597	242500	6574	4	0	0	11	14:20	15:50
75598	242500	6581	4	0	0	11	14:20	15:50
75599	242500	6588	4	0	0	11	14:20	15:50
75600	242500	6595	4	0	0	11	14:20	15:50
75601	242500	6602	4	0	0	11	14:20	15:50
75602	242500	6609	4	0	0	11	14:20	15:50
75603	242500	6616	4	0	0	11	14:20	15:50
75604	242500	6623	4	0	0	11	14:20	15:50
75605	242500	6630	4	0	0	11	14:20	15:50
75606	242500	6637	4	0	0	11	14:20	15:50
75607	242500	6532	5	0	0	9	16:20	17:50
75608	242500	6539	5	0	0	9	16:20	17:50
75609	242500	6546	5	0	0	9	16:20	17:50
75610	242500	6553	5	0	0	9	16:20	17:50
75611	242500	6560	5	0	0	9	16:20	17:50
75612	242500	6567	5	0	0	9	16:20	17:50
75613	242500	6574	5	0	0	9	16:20	17:50
75614	242500	6581	5	0	0	9	16:20	17:50
75615	242500	6588	5	0	0	9	16:20	17:50
75616	242500	6595	5	0	0	9	16:20	17:50
75617	242500	6602	5	0	0	9	16:20	17:50
75618	242500	6609	5	0	0	9	16:20	17:50
75619	242500	6616	5	0	0	9	16:20	17:50
75620	242500	6623	5	0	0	9	16:20	17:50
75621	242500	6630	5	0	0	9	16:20	17:50
75622	242500	6637	5	0	0	9	16:20	17:50
75623	242500	6532	6	0	0	7	18:00	19:30
75624	242500	6539	6	0	0	7	18:00	19:30
75625	242500	6546	6	0	0	7	18:00	19:30
75626	242500	6553	6	0	0	7	18:00	19:30
75627	242500	6560	6	0	0	7	18:00	19:30
75628	242500	6567	6	0	0	7	18:00	19:30
75629	242500	6574	6	0	0	7	18:00	19:30
75630	242500	6581	6	0	0	7	18:00	19:30
75631	242500	6588	6	0	0	7	18:00	19:30
75632	242500	6595	6	0	0	7	18:00	19:30
75633	242500	6602	6	0	0	7	18:00	19:30
75634	242500	6609	6	0	0	7	18:00	19:30
75635	242500	6616	6	0	0	7	18:00	19:30
75636	242500	6623	6	0	0	7	18:00	19:30
75637	242500	6630	6	0	0	7	18:00	19:30
75638	242500	6637	6	0	0	7	18:00	19:30
75639	242500	6533	1	0	1	1	09:00	10:30
75640	242500	6540	1	0	1	1	09:00	10:30
75641	242500	6547	1	0	1	1	09:00	10:30
75642	242500	6554	1	0	1	1	09:00	10:30
75643	242500	6561	1	0	1	1	09:00	10:30
75644	242500	6568	1	0	1	1	09:00	10:30
75645	242500	6575	1	0	1	1	09:00	10:30
75646	242500	6582	1	0	1	1	09:00	10:30
75647	242500	6589	1	0	1	1	09:00	10:30
75648	242500	6596	1	0	1	1	09:00	10:30
75649	242500	6603	1	0	1	1	09:00	10:30
75650	242500	6610	1	0	1	1	09:00	10:30
75651	242500	6617	1	0	1	1	09:00	10:30
75652	242500	6624	1	0	1	1	09:00	10:30
75653	242500	6631	1	0	1	1	09:00	10:30
75654	242500	6638	1	0	1	1	09:00	10:30
75655	242500	6533	2	0	1	7	10:40	12:10
75656	242500	6540	2	0	1	7	10:40	12:10
75657	242500	6547	2	0	1	7	10:40	12:10
75658	242500	6554	2	0	1	7	10:40	12:10
75659	242500	6561	2	0	1	7	10:40	12:10
75660	242500	6568	2	0	1	7	10:40	12:10
75661	242500	6575	2	0	1	7	10:40	12:10
75662	242500	6582	2	0	1	7	10:40	12:10
75663	242500	6589	2	0	1	7	10:40	12:10
75664	242500	6596	2	0	1	7	10:40	12:10
75665	242500	6603	2	0	1	7	10:40	12:10
75666	242500	6610	2	0	1	7	10:40	12:10
75667	242500	6617	2	0	1	7	10:40	12:10
75668	242500	6624	2	0	1	7	10:40	12:10
75669	242500	6631	2	0	1	7	10:40	12:10
75670	242500	6638	2	0	1	7	10:40	12:10
75671	242500	6533	3	0	0	6	12:40	14:10
75672	242500	6540	3	0	0	6	12:40	14:10
75673	242500	6547	3	0	0	6	12:40	14:10
75674	242500	6554	3	0	0	6	12:40	14:10
75675	242500	6561	3	0	0	6	12:40	14:10
75676	242500	6568	3	0	0	6	12:40	14:10
75677	242500	6575	3	0	0	6	12:40	14:10
75678	242500	6582	3	0	0	6	12:40	14:10
75679	242500	6589	3	0	0	6	12:40	14:10
75680	242500	6596	3	0	0	6	12:40	14:10
75681	242500	6603	3	0	0	6	12:40	14:10
75682	242500	6610	3	0	0	6	12:40	14:10
75683	242500	6617	3	0	0	6	12:40	14:10
75684	242500	6624	3	0	0	6	12:40	14:10
75685	242500	6631	3	0	0	6	12:40	14:10
75686	242500	6638	3	0	0	6	12:40	14:10
75687	242500	6533	4	0	0	6	14:20	15:50
75688	242500	6540	4	0	0	6	14:20	15:50
75689	242500	6547	4	0	0	6	14:20	15:50
75690	242500	6554	4	0	0	6	14:20	15:50
75691	242500	6561	4	0	0	6	14:20	15:50
75692	242500	6568	4	0	0	6	14:20	15:50
75693	242500	6575	4	0	0	6	14:20	15:50
75694	242500	6582	4	0	0	6	14:20	15:50
75695	242500	6589	4	0	0	6	14:20	15:50
75696	242500	6596	4	0	0	6	14:20	15:50
75697	242500	6603	4	0	0	6	14:20	15:50
75698	242500	6610	4	0	0	6	14:20	15:50
75699	242500	6617	4	0	0	6	14:20	15:50
75700	242500	6624	4	0	0	6	14:20	15:50
75701	242500	6631	4	0	0	6	14:20	15:50
75702	242500	6638	4	0	0	6	14:20	15:50
75703	242500	6534	1	0	1	2	09:00	10:30
75704	242500	6541	1	0	1	2	09:00	10:30
75705	242500	6548	1	0	1	2	09:00	10:30
75706	242500	6555	1	0	1	2	09:00	10:30
75707	242500	6562	1	0	1	2	09:00	10:30
75708	242500	6569	1	0	1	2	09:00	10:30
75709	242500	6576	1	0	1	2	09:00	10:30
75710	242500	6583	1	0	1	2	09:00	10:30
75711	242500	6590	1	0	1	2	09:00	10:30
75712	242500	6597	1	0	1	2	09:00	10:30
75713	242500	6604	1	0	1	2	09:00	10:30
75714	242500	6611	1	0	1	2	09:00	10:30
75715	242500	6618	1	0	1	2	09:00	10:30
75716	242500	6625	1	0	1	2	09:00	10:30
75717	242500	6632	1	0	1	2	09:00	10:30
75718	242500	6639	1	0	1	2	09:00	10:30
75719	242500	6534	2	0	1	3	10:40	12:10
75720	242500	6548	2	0	1	3	10:40	12:10
75721	242500	6562	2	0	1	3	10:40	12:10
75722	242500	6576	2	0	1	3	10:40	12:10
75723	242500	6590	2	0	1	3	10:40	12:10
75724	242500	6604	2	0	1	3	10:40	12:10
75725	242500	6618	2	0	1	3	10:40	12:10
75726	242500	6632	2	0	1	3	10:40	12:10
75727	242500	6534	3	0	0	3	12:40	14:10
75728	242500	6541	3	0	0	3	12:40	14:10
75729	242500	6548	3	0	0	3	12:40	14:10
75730	242500	6555	3	0	0	3	12:40	14:10
75731	242500	6562	3	0	0	3	12:40	14:10
75732	242500	6569	3	0	0	3	12:40	14:10
75733	242500	6576	3	0	0	3	12:40	14:10
75734	242500	6583	3	0	0	3	12:40	14:10
75735	242500	6590	3	0	0	3	12:40	14:10
75736	242500	6597	3	0	0	3	12:40	14:10
75737	242500	6604	3	0	0	3	12:40	14:10
75738	242500	6611	3	0	0	3	12:40	14:10
75739	242500	6618	3	0	0	3	12:40	14:10
75740	242500	6625	3	0	0	3	12:40	14:10
75741	242500	6632	3	0	0	3	12:40	14:10
75742	242500	6639	3	0	0	3	12:40	14:10
75743	242500	6535	1	0	1	12	09:00	10:30
75744	242500	6549	1	0	1	12	09:00	10:30
75745	242500	6563	1	0	1	12	09:00	10:30
75746	242500	6577	1	0	1	12	09:00	10:30
75747	242500	6591	1	0	1	12	09:00	10:30
75748	242500	6605	1	0	1	12	09:00	10:30
75749	242500	6619	1	0	1	12	09:00	10:30
75750	242500	6633	1	0	1	12	09:00	10:30
75751	242500	6542	1	0	1	6	09:00	10:30
75752	242500	6556	1	0	1	6	09:00	10:30
75753	242500	6570	1	0	1	6	09:00	10:30
75754	242500	6584	1	0	1	6	09:00	10:30
75755	242500	6598	1	0	1	6	09:00	10:30
75756	242500	6612	1	0	1	6	09:00	10:30
75757	242500	6626	1	0	1	6	09:00	10:30
75758	242500	6640	1	0	1	6	09:00	10:30
75759	242500	6542	1	0	0	10	09:00	10:30
75760	242500	6556	1	0	0	10	09:00	10:30
75761	242500	6570	1	0	0	10	09:00	10:30
75762	242500	6584	1	0	0	10	09:00	10:30
75763	242500	6598	1	0	0	10	09:00	10:30
75764	242500	6612	1	0	0	10	09:00	10:30
75765	242500	6626	1	0	0	10	09:00	10:30
75766	242500	6640	1	0	0	10	09:00	10:30
75767	242500	6535	3	0	0	2	12:40	14:10
75768	242500	6542	3	0	0	2	12:40	14:10
75769	242500	6549	3	0	0	2	12:40	14:10
75770	242500	6556	3	0	0	2	12:40	14:10
75771	242500	6563	3	0	0	2	12:40	14:10
75772	242500	6570	3	0	0	2	12:40	14:10
75773	242500	6577	3	0	0	2	12:40	14:10
75774	242500	6584	3	0	0	2	12:40	14:10
75775	242500	6591	3	0	0	2	12:40	14:10
75776	242500	6598	3	0	0	2	12:40	14:10
75777	242500	6605	3	0	0	2	12:40	14:10
75778	242500	6612	3	0	0	2	12:40	14:10
75779	242500	6619	3	0	0	2	12:40	14:10
75780	242500	6626	3	0	0	2	12:40	14:10
75781	242500	6633	3	0	0	2	12:40	14:10
75782	242500	6640	3	0	0	2	12:40	14:10
75783	242500	6535	4	0	1	11	14:20	15:50
75784	242500	6542	4	0	1	11	14:20	15:50
75785	242500	6549	4	0	1	11	14:20	15:50
75786	242500	6556	4	0	1	11	14:20	15:50
75787	242500	6563	4	0	1	11	14:20	15:50
75788	242500	6570	4	0	1	11	14:20	15:50
75789	242500	6577	4	0	1	11	14:20	15:50
75790	242500	6584	4	0	1	11	14:20	15:50
75791	242500	6591	4	0	1	11	14:20	15:50
75792	242500	6598	4	0	1	11	14:20	15:50
75793	242500	6605	4	0	1	11	14:20	15:50
75794	242500	6612	4	0	1	11	14:20	15:50
75795	242500	6619	4	0	1	11	14:20	15:50
75796	242500	6626	4	0	1	11	14:20	15:50
75797	242500	6633	4	0	1	11	14:20	15:50
75798	242500	6640	4	0	1	11	14:20	15:50
75799	242500	6535	5	0	1	0	16:20	17:50
75800	242500	6542	5	0	1	0	16:20	17:50
75801	242500	6549	5	0	1	0	16:20	17:50
75802	242500	6556	5	0	1	0	16:20	17:50
75803	242500	6563	5	0	1	0	16:20	17:50
75804	242500	6570	5	0	1	0	16:20	17:50
75805	242500	6577	5	0	1	0	16:20	17:50
75806	242500	6584	5	0	1	0	16:20	17:50
75807	242500	6591	5	0	1	0	16:20	17:50
75808	242500	6598	5	0	1	0	16:20	17:50
75809	242500	6605	5	0	1	0	16:20	17:50
75810	242500	6612	5	0	1	0	16:20	17:50
75811	242500	6619	5	0	1	0	16:20	17:50
75812	242500	6626	5	0	1	0	16:20	17:50
75813	242500	6633	5	0	1	0	16:20	17:50
75814	242500	6640	5	0	1	0	16:20	17:50
75815	242500	6536	2	0	0	12	10:40	12:10
75816	242500	6550	2	0	0	12	10:40	12:10
75817	242500	6564	2	0	0	12	10:40	12:10
75818	242500	6578	2	0	0	12	10:40	12:10
75819	242500	6592	2	0	0	12	10:40	12:10
75820	242500	6606	2	0	0	12	10:40	12:10
75821	242500	6620	2	0	0	12	10:40	12:10
75822	242500	6634	2	0	0	12	10:40	12:10
75823	242500	6536	6	0	1	5	18:00	19:30
75824	242500	6550	6	0	1	5	18:00	19:30
75825	242500	6564	6	0	1	5	18:00	19:30
75826	242500	6578	6	0	1	5	18:00	19:30
75827	242500	6592	6	0	1	5	18:00	19:30
75828	242500	6606	6	0	1	5	18:00	19:30
75829	242500	6620	6	0	1	5	18:00	19:30
75830	242500	6634	6	0	1	5	18:00	19:30
75831	242500	6531	2	0	0	5	10:40	12:10
75832	242500	6545	2	0	0	5	10:40	12:10
75833	242500	6559	2	0	0	5	10:40	12:10
75834	242500	6573	2	0	0	5	10:40	12:10
75835	242500	6587	2	0	0	5	10:40	12:10
75836	242500	6601	2	0	0	5	10:40	12:10
75837	242500	6615	2	0	0	5	10:40	12:10
75838	242500	6629	2	0	0	5	10:40	12:10
75839	242500	6531	3	0	0	8	12:40	14:10
75840	242500	6538	3	0	0	8	12:40	14:10
75841	242500	6545	3	0	0	8	12:40	14:10
75842	242500	6552	3	0	0	8	12:40	14:10
75843	242500	6559	3	0	0	8	12:40	14:10
75844	242500	6566	3	0	0	8	12:40	14:10
75845	242500	6573	3	0	0	8	12:40	14:10
75846	242500	6580	3	0	0	8	12:40	14:10
75847	242500	6587	3	0	0	8	12:40	14:10
75848	242500	6594	3	0	0	8	12:40	14:10
75849	242500	6601	3	0	0	8	12:40	14:10
75850	242500	6608	3	0	0	8	12:40	14:10
75851	242500	6615	3	0	0	8	12:40	14:10
75852	242500	6622	3	0	0	8	12:40	14:10
75853	242500	6629	3	0	0	8	12:40	14:10
75854	242500	6636	3	0	0	8	12:40	14:10
75855	242500	6531	4	0	0	2	14:20	15:50
75856	242500	6538	4	0	0	2	14:20	15:50
75857	242500	6545	4	0	0	2	14:20	15:50
75858	242500	6552	4	0	0	2	14:20	15:50
75859	242500	6559	4	0	0	2	14:20	15:50
75860	242500	6566	4	0	0	2	14:20	15:50
75861	242500	6573	4	0	0	2	14:20	15:50
75862	242500	6580	4	0	0	2	14:20	15:50
75863	242500	6587	4	0	0	2	14:20	15:50
75864	242500	6594	4	0	0	2	14:20	15:50
75865	242500	6601	4	0	0	2	14:20	15:50
75866	242500	6608	4	0	0	2	14:20	15:50
75867	242500	6615	4	0	0	2	14:20	15:50
75868	242500	6622	4	0	0	2	14:20	15:50
75869	242500	6629	4	0	0	2	14:20	15:50
75870	242500	6636	4	0	0	2	14:20	15:50
75871	242500	6538	5	0	0	4	16:20	17:50
75872	242500	6552	5	0	0	4	16:20	17:50
75873	242500	6566	5	0	0	4	16:20	17:50
75874	242500	6580	5	0	0	4	16:20	17:50
75875	242500	6594	5	0	0	4	16:20	17:50
75876	242500	6608	5	0	0	4	16:20	17:50
75877	242500	6622	5	0	0	4	16:20	17:50
75878	242500	6636	5	0	0	4	16:20	17:50
75879	242500	6532	1	0	0	3	09:00	10:30
75880	242500	6539	1	0	0	3	09:00	10:30
75881	242500	6546	1	0	0	3	09:00	10:30
75882	242500	6553	1	0	0	3	09:00	10:30
75883	242500	6560	1	0	0	3	09:00	10:30
75884	242500	6567	1	0	0	3	09:00	10:30
75885	242500	6574	1	0	0	3	09:00	10:30
75886	242500	6581	1	0	0	3	09:00	10:30
75887	242500	6588	1	0	0	3	09:00	10:30
75888	242500	6595	1	0	0	3	09:00	10:30
75889	242500	6602	1	0	0	3	09:00	10:30
75890	242500	6609	1	0	0	3	09:00	10:30
75891	242500	6616	1	0	0	3	09:00	10:30
75892	242500	6623	1	0	0	3	09:00	10:30
75893	242500	6630	1	0	0	3	09:00	10:30
75894	242500	6637	1	0	0	3	09:00	10:30
75895	242500	6532	2	0	0	3	10:40	12:10
75896	242500	6539	2	0	0	3	10:40	12:10
75897	242500	6546	2	0	0	3	10:40	12:10
75898	242500	6553	2	0	0	3	10:40	12:10
75899	242500	6560	2	0	0	3	10:40	12:10
75900	242500	6567	2	0	0	3	10:40	12:10
75901	242500	6574	2	0	0	3	10:40	12:10
75902	242500	6581	2	0	0	3	10:40	12:10
75903	242500	6588	2	0	0	3	10:40	12:10
75904	242500	6595	2	0	0	3	10:40	12:10
75905	242500	6602	2	0	0	3	10:40	12:10
75906	242500	6609	2	0	0	3	10:40	12:10
75907	242500	6616	2	0	0	3	10:40	12:10
75908	242500	6623	2	0	0	3	10:40	12:10
75909	242500	6630	2	0	0	3	10:40	12:10
75910	242500	6637	2	0	0	3	10:40	12:10
75911	242500	6532	3	0	0	11	12:40	14:10
75912	242500	6539	3	0	0	11	12:40	14:10
75913	242500	6546	3	0	0	11	12:40	14:10
75914	242500	6553	3	0	0	11	12:40	14:10
75915	242500	6560	3	0	0	11	12:40	14:10
75916	242500	6567	3	0	0	11	12:40	14:10
75917	242500	6574	3	0	0	11	12:40	14:10
75918	242500	6581	3	0	0	11	12:40	14:10
75919	242500	6588	3	0	0	11	12:40	14:10
75920	242500	6595	3	0	0	11	12:40	14:10
75921	242500	6602	3	0	0	11	12:40	14:10
75922	242500	6609	3	0	0	11	12:40	14:10
75923	242500	6616	3	0	0	11	12:40	14:10
75924	242500	6623	3	0	0	11	12:40	14:10
75925	242500	6630	3	0	0	11	12:40	14:10
75926	242500	6637	3	0	0	11	12:40	14:10
75927	242500	6532	4	0	0	7	14:20	15:50
75928	242500	6539	4	0	0	7	14:20	15:50
75929	242500	6546	4	0	0	7	14:20	15:50
75930	242500	6553	4	0	0	7	14:20	15:50
75931	242500	6560	4	0	0	7	14:20	15:50
75932	242500	6567	4	0	0	7	14:20	15:50
75933	242500	6574	4	0	0	7	14:20	15:50
75934	242500	6581	4	0	0	7	14:20	15:50
75935	242500	6588	4	0	0	7	14:20	15:50
75936	242500	6595	4	0	0	7	14:20	15:50
75937	242500	6602	4	0	0	7	14:20	15:50
75938	242500	6609	4	0	0	7	14:20	15:50
75939	242500	6616	4	0	0	7	14:20	15:50
75940	242500	6623	4	0	0	7	14:20	15:50
75941	242500	6630	4	0	0	7	14:20	15:50
75942	242500	6637	4	0	0	7	14:20	15:50
75943	242500	6533	1	0	1	1	09:00	10:30
75944	242500	6540	1	0	1	1	09:00	10:30
75945	242500	6547	1	0	1	1	09:00	10:30
75946	242500	6554	1	0	1	1	09:00	10:30
75947	242500	6561	1	0	1	1	09:00	10:30
75948	242500	6568	1	0	1	1	09:00	10:30
75949	242500	6575	1	0	1	1	09:00	10:30
75950	242500	6582	1	0	1	1	09:00	10:30
75951	242500	6589	1	0	1	1	09:00	10:30
75952	242500	6596	1	0	1	1	09:00	10:30
75953	242500	6603	1	0	1	1	09:00	10:30
75954	242500	6610	1	0	1	1	09:00	10:30
75955	242500	6617	1	0	1	1	09:00	10:30
75956	242500	6624	1	0	1	1	09:00	10:30
75957	242500	6631	1	0	1	1	09:00	10:30
75958	242500	6638	1	0	1	1	09:00	10:30
75959	242500	6533	2	0	1	7	10:40	12:10
75960	242500	6540	2	0	1	7	10:40	12:10
75961	242500	6547	2	0	1	7	10:40	12:10
75962	242500	6554	2	0	1	7	10:40	12:10
75963	242500	6561	2	0	1	7	10:40	12:10
75964	242500	6568	2	0	1	7	10:40	12:10
75965	242500	6575	2	0	1	7	10:40	12:10
75966	242500	6582	2	0	1	7	10:40	12:10
75967	242500	6589	2	0	1	7	10:40	12:10
75968	242500	6596	2	0	1	7	10:40	12:10
75969	242500	6603	2	0	1	7	10:40	12:10
75970	242500	6610	2	0	1	7	10:40	12:10
75971	242500	6617	2	0	1	7	10:40	12:10
75972	242500	6624	2	0	1	7	10:40	12:10
75973	242500	6631	2	0	1	7	10:40	12:10
75974	242500	6638	2	0	1	7	10:40	12:10
75975	242500	6533	3	0	0	6	12:40	14:10
75976	242500	6540	3	0	0	6	12:40	14:10
75977	242500	6547	3	0	0	6	12:40	14:10
75978	242500	6554	3	0	0	6	12:40	14:10
75979	242500	6561	3	0	0	6	12:40	14:10
75980	242500	6568	3	0	0	6	12:40	14:10
75981	242500	6575	3	0	0	6	12:40	14:10
75982	242500	6582	3	0	0	6	12:40	14:10
75983	242500	6589	3	0	0	6	12:40	14:10
75984	242500	6596	3	0	0	6	12:40	14:10
75985	242500	6603	3	0	0	6	12:40	14:10
75986	242500	6610	3	0	0	6	12:40	14:10
75987	242500	6617	3	0	0	6	12:40	14:10
75988	242500	6624	3	0	0	6	12:40	14:10
75989	242500	6631	3	0	0	6	12:40	14:10
75990	242500	6638	3	0	0	6	12:40	14:10
75991	242500	6533	4	0	0	6	14:20	15:50
75992	242500	6540	4	0	0	6	14:20	15:50
75993	242500	6547	4	0	0	6	14:20	15:50
75994	242500	6554	4	0	0	6	14:20	15:50
75995	242500	6561	4	0	0	6	14:20	15:50
75996	242500	6568	4	0	0	6	14:20	15:50
75997	242500	6575	4	0	0	6	14:20	15:50
75998	242500	6582	4	0	0	6	14:20	15:50
75999	242500	6589	4	0	0	6	14:20	15:50
76000	242500	6596	4	0	0	6	14:20	15:50
76001	242500	6603	4	0	0	6	14:20	15:50
76002	242500	6610	4	0	0	6	14:20	15:50
76003	242500	6617	4	0	0	6	14:20	15:50
76004	242500	6624	4	0	0	6	14:20	15:50
76005	242500	6631	4	0	0	6	14:20	15:50
76006	242500	6638	4	0	0	6	14:20	15:50
76007	242500	6533	5	0	0	9	16:20	17:50
76008	242500	6540	5	0	0	9	16:20	17:50
76009	242500	6547	5	0	0	9	16:20	17:50
76010	242500	6554	5	0	0	9	16:20	17:50
76011	242500	6561	5	0	0	9	16:20	17:50
76012	242500	6568	5	0	0	9	16:20	17:50
76013	242500	6575	5	0	0	9	16:20	17:50
76014	242500	6582	5	0	0	9	16:20	17:50
76015	242500	6589	5	0	0	9	16:20	17:50
76016	242500	6596	5	0	0	9	16:20	17:50
76017	242500	6603	5	0	0	9	16:20	17:50
76018	242500	6610	5	0	0	9	16:20	17:50
76019	242500	6617	5	0	0	9	16:20	17:50
76020	242500	6624	5	0	0	9	16:20	17:50
76021	242500	6631	5	0	0	9	16:20	17:50
76022	242500	6638	5	0	0	9	16:20	17:50
76023	242500	6534	1	0	1	2	09:00	10:30
76024	242500	6541	1	0	1	2	09:00	10:30
76025	242500	6548	1	0	1	2	09:00	10:30
76026	242500	6555	1	0	1	2	09:00	10:30
76027	242500	6562	1	0	1	2	09:00	10:30
76028	242500	6569	1	0	1	2	09:00	10:30
76029	242500	6576	1	0	1	2	09:00	10:30
76030	242500	6583	1	0	1	2	09:00	10:30
76031	242500	6590	1	0	1	2	09:00	10:30
76032	242500	6597	1	0	1	2	09:00	10:30
76033	242500	6604	1	0	1	2	09:00	10:30
76034	242500	6611	1	0	1	2	09:00	10:30
76035	242500	6618	1	0	1	2	09:00	10:30
76036	242500	6625	1	0	1	2	09:00	10:30
76037	242500	6632	1	0	1	2	09:00	10:30
76038	242500	6639	1	0	1	2	09:00	10:30
76039	242500	6534	2	0	1	3	10:40	12:10
76040	242500	6548	2	0	1	3	10:40	12:10
76041	242500	6562	2	0	1	3	10:40	12:10
76042	242500	6576	2	0	1	3	10:40	12:10
76043	242500	6590	2	0	1	3	10:40	12:10
76044	242500	6604	2	0	1	3	10:40	12:10
76045	242500	6618	2	0	1	3	10:40	12:10
76046	242500	6632	2	0	1	3	10:40	12:10
76047	242500	6535	1	0	1	12	09:00	10:30
76048	242500	6549	1	0	1	12	09:00	10:30
76049	242500	6563	1	0	1	12	09:00	10:30
76050	242500	6577	1	0	1	12	09:00	10:30
76051	242500	6591	1	0	1	12	09:00	10:30
76052	242500	6605	1	0	1	12	09:00	10:30
76053	242500	6619	1	0	1	12	09:00	10:30
76054	242500	6633	1	0	1	12	09:00	10:30
76055	242500	6542	1	0	1	6	09:00	10:30
76056	242500	6556	1	0	1	6	09:00	10:30
76057	242500	6570	1	0	1	6	09:00	10:30
76058	242500	6584	1	0	1	6	09:00	10:30
76059	242500	6598	1	0	1	6	09:00	10:30
76060	242500	6612	1	0	1	6	09:00	10:30
76061	242500	6626	1	0	1	6	09:00	10:30
76062	242500	6640	1	0	1	6	09:00	10:30
76063	242500	6535	2	0	0	13	10:40	12:10
76064	242500	6542	2	0	0	13	10:40	12:10
76065	242500	6549	2	0	0	13	10:40	12:10
76066	242500	6556	2	0	0	13	10:40	12:10
76067	242500	6563	2	0	0	13	10:40	12:10
76068	242500	6570	2	0	0	13	10:40	12:10
76069	242500	6577	2	0	0	13	10:40	12:10
76070	242500	6584	2	0	0	13	10:40	12:10
76071	242500	6591	2	0	0	13	10:40	12:10
76072	242500	6598	2	0	0	13	10:40	12:10
76073	242500	6605	2	0	0	13	10:40	12:10
76074	242500	6612	2	0	0	13	10:40	12:10
76075	242500	6619	2	0	0	13	10:40	12:10
76076	242500	6626	2	0	0	13	10:40	12:10
76077	242500	6633	2	0	0	13	10:40	12:10
76078	242500	6640	2	0	0	13	10:40	12:10
76079	242500	6535	3	0	0	0	12:40	14:10
76080	242500	6542	3	0	0	0	12:40	14:10
76081	242500	6549	3	0	0	0	12:40	14:10
76082	242500	6556	3	0	0	0	12:40	14:10
76083	242500	6563	3	0	0	0	12:40	14:10
76084	242500	6570	3	0	0	0	12:40	14:10
76085	242500	6577	3	0	0	0	12:40	14:10
76086	242500	6584	3	0	0	0	12:40	14:10
76087	242500	6591	3	0	0	0	12:40	14:10
76088	242500	6598	3	0	0	0	12:40	14:10
76089	242500	6605	3	0	0	0	12:40	14:10
76090	242500	6612	3	0	0	0	12:40	14:10
76091	242500	6619	3	0	0	0	12:40	14:10
76092	242500	6626	3	0	0	0	12:40	14:10
76093	242500	6633	3	0	0	0	12:40	14:10
76094	242500	6640	3	0	0	0	12:40	14:10
76095	242500	6535	4	0	1	11	14:20	15:50
76096	242500	6542	4	0	1	11	14:20	15:50
76097	242500	6549	4	0	1	11	14:20	15:50
76098	242500	6556	4	0	1	11	14:20	15:50
76099	242500	6563	4	0	1	11	14:20	15:50
76100	242500	6570	4	0	1	11	14:20	15:50
76101	242500	6577	4	0	1	11	14:20	15:50
76102	242500	6584	4	0	1	11	14:20	15:50
76103	242500	6591	4	0	1	11	14:20	15:50
76104	242500	6598	4	0	1	11	14:20	15:50
76105	242500	6605	4	0	1	11	14:20	15:50
76106	242500	6612	4	0	1	11	14:20	15:50
76107	242500	6619	4	0	1	11	14:20	15:50
76108	242500	6626	4	0	1	11	14:20	15:50
76109	242500	6633	4	0	1	11	14:20	15:50
76110	242500	6640	4	0	1	11	14:20	15:50
76111	242500	6535	5	0	1	0	16:20	17:50
76112	242500	6542	5	0	1	0	16:20	17:50
76113	242500	6549	5	0	1	0	16:20	17:50
76114	242500	6556	5	0	1	0	16:20	17:50
76115	242500	6563	5	0	1	0	16:20	17:50
76116	242500	6570	5	0	1	0	16:20	17:50
76117	242500	6577	5	0	1	0	16:20	17:50
76118	242500	6584	5	0	1	0	16:20	17:50
76119	242500	6591	5	0	1	0	16:20	17:50
76120	242500	6598	5	0	1	0	16:20	17:50
76121	242500	6605	5	0	1	0	16:20	17:50
76122	242500	6612	5	0	1	0	16:20	17:50
76123	242500	6619	5	0	1	0	16:20	17:50
76124	242500	6626	5	0	1	0	16:20	17:50
76125	242500	6633	5	0	1	0	16:20	17:50
76126	242500	6640	5	0	1	0	16:20	17:50
76127	242500	6543	2	0	0	10	10:40	12:10
76128	242500	6557	2	0	0	10	10:40	12:10
76129	242500	6571	2	0	0	10	10:40	12:10
76130	242500	6585	2	0	0	10	10:40	12:10
76131	242500	6599	2	0	0	10	10:40	12:10
76132	242500	6613	2	0	0	10	10:40	12:10
76133	242500	6627	2	0	0	10	10:40	12:10
76134	242500	6641	2	0	0	10	10:40	12:10
76135	242500	6543	3	0	0	10	12:40	14:10
76136	242500	6557	3	0	0	10	12:40	14:10
76137	242500	6571	3	0	0	10	12:40	14:10
76138	242500	6585	3	0	0	10	12:40	14:10
76139	242500	6599	3	0	0	10	12:40	14:10
76140	242500	6613	3	0	0	10	12:40	14:10
76141	242500	6627	3	0	0	10	12:40	14:10
76142	242500	6641	3	0	0	10	12:40	14:10
76143	242500	6536	6	0	1	5	18:00	19:30
76144	242500	6550	6	0	1	5	18:00	19:30
76145	242500	6564	6	0	1	5	18:00	19:30
76146	242500	6578	6	0	1	5	18:00	19:30
76147	242500	6592	6	0	1	5	18:00	19:30
76148	242500	6606	6	0	1	5	18:00	19:30
76149	242500	6620	6	0	1	5	18:00	19:30
76150	242500	6634	6	0	1	5	18:00	19:30
76151	242500	6538	1	0	0	5	09:00	10:30
76152	242500	6552	1	0	0	5	09:00	10:30
76153	242500	6566	1	0	0	5	09:00	10:30
76154	242500	6580	1	0	0	5	09:00	10:30
76155	242500	6594	1	0	0	5	09:00	10:30
76156	242500	6608	1	0	0	5	09:00	10:30
76157	242500	6622	1	0	0	5	09:00	10:30
76158	242500	6636	1	0	0	5	09:00	10:30
76159	242500	6531	2	0	0	2	10:40	12:10
76160	242500	6538	2	0	0	2	10:40	12:10
76161	242500	6545	2	0	0	2	10:40	12:10
76162	242500	6552	2	0	0	2	10:40	12:10
76163	242500	6559	2	0	0	2	10:40	12:10
76164	242500	6566	2	0	0	2	10:40	12:10
76165	242500	6573	2	0	0	2	10:40	12:10
76166	242500	6580	2	0	0	2	10:40	12:10
76167	242500	6587	2	0	0	2	10:40	12:10
76168	242500	6594	2	0	0	2	10:40	12:10
76169	242500	6601	2	0	0	2	10:40	12:10
76170	242500	6608	2	0	0	2	10:40	12:10
76171	242500	6615	2	0	0	2	10:40	12:10
76172	242500	6622	2	0	0	2	10:40	12:10
76173	242500	6629	2	0	0	2	10:40	12:10
76174	242500	6636	2	0	0	2	10:40	12:10
76175	242500	6531	3	0	0	6	12:40	14:10
76176	242500	6538	3	0	0	6	12:40	14:10
76177	242500	6545	3	0	0	6	12:40	14:10
76178	242500	6552	3	0	0	6	12:40	14:10
76179	242500	6559	3	0	0	6	12:40	14:10
76180	242500	6566	3	0	0	6	12:40	14:10
76181	242500	6573	3	0	0	6	12:40	14:10
76182	242500	6580	3	0	0	6	12:40	14:10
76183	242500	6587	3	0	0	6	12:40	14:10
76184	242500	6594	3	0	0	6	12:40	14:10
76185	242500	6601	3	0	0	6	12:40	14:10
76186	242500	6608	3	0	0	6	12:40	14:10
76187	242500	6615	3	0	0	6	12:40	14:10
76188	242500	6622	3	0	0	6	12:40	14:10
76189	242500	6629	3	0	0	6	12:40	14:10
76190	242500	6636	3	0	0	6	12:40	14:10
76191	242500	6531	4	0	0	6	14:20	15:50
76192	242500	6538	4	0	0	6	14:20	15:50
76193	242500	6545	4	0	0	6	14:20	15:50
76194	242500	6552	4	0	0	6	14:20	15:50
76195	242500	6559	4	0	0	6	14:20	15:50
76196	242500	6566	4	0	0	6	14:20	15:50
76197	242500	6573	4	0	0	6	14:20	15:50
76198	242500	6580	4	0	0	6	14:20	15:50
76199	242500	6587	4	0	0	6	14:20	15:50
76200	242500	6594	4	0	0	6	14:20	15:50
76201	242500	6601	4	0	0	6	14:20	15:50
76202	242500	6608	4	0	0	6	14:20	15:50
76203	242500	6615	4	0	0	6	14:20	15:50
76204	242500	6622	4	0	0	6	14:20	15:50
76205	242500	6629	4	0	0	6	14:20	15:50
76206	242500	6636	4	0	0	6	14:20	15:50
76207	242500	6538	5	0	0	4	16:20	17:50
76208	242500	6552	5	0	0	4	16:20	17:50
76209	242500	6566	5	0	0	4	16:20	17:50
76210	242500	6580	5	0	0	4	16:20	17:50
76211	242500	6594	5	0	0	4	16:20	17:50
76212	242500	6608	5	0	0	4	16:20	17:50
76213	242500	6622	5	0	0	4	16:20	17:50
76214	242500	6636	5	0	0	4	16:20	17:50
76215	242500	6532	1	0	0	9	09:00	10:30
76216	242500	6539	1	0	0	9	09:00	10:30
76217	242500	6546	1	0	0	9	09:00	10:30
76218	242500	6553	1	0	0	9	09:00	10:30
76219	242500	6560	1	0	0	9	09:00	10:30
76220	242500	6567	1	0	0	9	09:00	10:30
76221	242500	6574	1	0	0	9	09:00	10:30
76222	242500	6581	1	0	0	9	09:00	10:30
76223	242500	6588	1	0	0	9	09:00	10:30
76224	242500	6595	1	0	0	9	09:00	10:30
76225	242500	6602	1	0	0	9	09:00	10:30
76226	242500	6609	1	0	0	9	09:00	10:30
76227	242500	6616	1	0	0	9	09:00	10:30
76228	242500	6623	1	0	0	9	09:00	10:30
76229	242500	6630	1	0	0	9	09:00	10:30
76230	242500	6637	1	0	0	9	09:00	10:30
76231	242500	6532	2	0	0	11	10:40	12:10
76232	242500	6539	2	0	0	11	10:40	12:10
76233	242500	6546	2	0	0	11	10:40	12:10
76234	242500	6553	2	0	0	11	10:40	12:10
76235	242500	6560	2	0	0	11	10:40	12:10
76236	242500	6567	2	0	0	11	10:40	12:10
76237	242500	6574	2	0	0	11	10:40	12:10
76238	242500	6581	2	0	0	11	10:40	12:10
76239	242500	6588	2	0	0	11	10:40	12:10
76240	242500	6595	2	0	0	11	10:40	12:10
76241	242500	6602	2	0	0	11	10:40	12:10
76242	242500	6609	2	0	0	11	10:40	12:10
76243	242500	6616	2	0	0	11	10:40	12:10
76244	242500	6623	2	0	0	11	10:40	12:10
76245	242500	6630	2	0	0	11	10:40	12:10
76246	242500	6637	2	0	0	11	10:40	12:10
76247	242500	6532	3	0	0	3	12:40	14:10
76248	242500	6539	3	0	0	3	12:40	14:10
76249	242500	6546	3	0	0	3	12:40	14:10
76250	242500	6553	3	0	0	3	12:40	14:10
76251	242500	6560	3	0	0	3	12:40	14:10
76252	242500	6567	3	0	0	3	12:40	14:10
76253	242500	6574	3	0	0	3	12:40	14:10
76254	242500	6581	3	0	0	3	12:40	14:10
76255	242500	6588	3	0	0	3	12:40	14:10
76256	242500	6595	3	0	0	3	12:40	14:10
76257	242500	6602	3	0	0	3	12:40	14:10
76258	242500	6609	3	0	0	3	12:40	14:10
76259	242500	6616	3	0	0	3	12:40	14:10
76260	242500	6623	3	0	0	3	12:40	14:10
76261	242500	6630	3	0	0	3	12:40	14:10
76262	242500	6637	3	0	0	3	12:40	14:10
76263	242500	6532	4	0	0	3	14:20	15:50
76264	242500	6539	4	0	0	3	14:20	15:50
76265	242500	6546	4	0	0	3	14:20	15:50
76266	242500	6553	4	0	0	3	14:20	15:50
76267	242500	6560	4	0	0	3	14:20	15:50
76268	242500	6567	4	0	0	3	14:20	15:50
76269	242500	6574	4	0	0	3	14:20	15:50
76270	242500	6581	4	0	0	3	14:20	15:50
76271	242500	6588	4	0	0	3	14:20	15:50
76272	242500	6595	4	0	0	3	14:20	15:50
76273	242500	6602	4	0	0	3	14:20	15:50
76274	242500	6609	4	0	0	3	14:20	15:50
76275	242500	6616	4	0	0	3	14:20	15:50
76276	242500	6623	4	0	0	3	14:20	15:50
76277	242500	6630	4	0	0	3	14:20	15:50
76278	242500	6637	4	0	0	3	14:20	15:50
76279	242500	6533	1	0	1	1	09:00	10:30
76280	242500	6540	1	0	1	1	09:00	10:30
76281	242500	6547	1	0	1	1	09:00	10:30
76282	242500	6554	1	0	1	1	09:00	10:30
76283	242500	6561	1	0	1	1	09:00	10:30
76284	242500	6568	1	0	1	1	09:00	10:30
76285	242500	6575	1	0	1	1	09:00	10:30
76286	242500	6582	1	0	1	1	09:00	10:30
76287	242500	6589	1	0	1	1	09:00	10:30
76288	242500	6596	1	0	1	1	09:00	10:30
76289	242500	6603	1	0	1	1	09:00	10:30
76290	242500	6610	1	0	1	1	09:00	10:30
76291	242500	6617	1	0	1	1	09:00	10:30
76292	242500	6624	1	0	1	1	09:00	10:30
76293	242500	6631	1	0	1	1	09:00	10:30
76294	242500	6638	1	0	1	1	09:00	10:30
76295	242500	6533	2	0	1	7	10:40	12:10
76296	242500	6540	2	0	1	7	10:40	12:10
76297	242500	6547	2	0	1	7	10:40	12:10
76298	242500	6554	2	0	1	7	10:40	12:10
76299	242500	6561	2	0	1	7	10:40	12:10
76300	242500	6568	2	0	1	7	10:40	12:10
76301	242500	6575	2	0	1	7	10:40	12:10
76302	242500	6582	2	0	1	7	10:40	12:10
76303	242500	6589	2	0	1	7	10:40	12:10
76304	242500	6596	2	0	1	7	10:40	12:10
76305	242500	6603	2	0	1	7	10:40	12:10
76306	242500	6610	2	0	1	7	10:40	12:10
76307	242500	6617	2	0	1	7	10:40	12:10
76308	242500	6624	2	0	1	7	10:40	12:10
76309	242500	6631	2	0	1	7	10:40	12:10
76310	242500	6638	2	0	1	7	10:40	12:10
76311	242500	6533	4	0	0	1	14:20	15:50
76312	242500	6540	4	0	0	1	14:20	15:50
76313	242500	6547	4	0	0	1	14:20	15:50
76314	242500	6554	4	0	0	1	14:20	15:50
76315	242500	6561	4	0	0	1	14:20	15:50
76316	242500	6568	4	0	0	1	14:20	15:50
76317	242500	6575	4	0	0	1	14:20	15:50
76318	242500	6582	4	0	0	1	14:20	15:50
76319	242500	6589	4	0	0	1	14:20	15:50
76320	242500	6596	4	0	0	1	14:20	15:50
76321	242500	6603	4	0	0	1	14:20	15:50
76322	242500	6610	4	0	0	1	14:20	15:50
76323	242500	6617	4	0	0	1	14:20	15:50
76324	242500	6624	4	0	0	1	14:20	15:50
76325	242500	6631	4	0	0	1	14:20	15:50
76326	242500	6638	4	0	0	1	14:20	15:50
76327	242500	6533	5	0	0	7	16:20	17:50
76328	242500	6540	5	0	0	7	16:20	17:50
76329	242500	6547	5	0	0	7	16:20	17:50
76330	242500	6554	5	0	0	7	16:20	17:50
76331	242500	6561	5	0	0	7	16:20	17:50
76332	242500	6568	5	0	0	7	16:20	17:50
76333	242500	6575	5	0	0	7	16:20	17:50
76334	242500	6582	5	0	0	7	16:20	17:50
76335	242500	6589	5	0	0	7	16:20	17:50
76336	242500	6596	5	0	0	7	16:20	17:50
76337	242500	6603	5	0	0	7	16:20	17:50
76338	242500	6610	5	0	0	7	16:20	17:50
76339	242500	6617	5	0	0	7	16:20	17:50
76340	242500	6624	5	0	0	7	16:20	17:50
76341	242500	6631	5	0	0	7	16:20	17:50
76342	242500	6638	5	0	0	7	16:20	17:50
76343	242500	6534	1	0	1	2	09:00	10:30
76344	242500	6541	1	0	1	2	09:00	10:30
76345	242500	6548	1	0	1	2	09:00	10:30
76346	242500	6555	1	0	1	2	09:00	10:30
76347	242500	6562	1	0	1	2	09:00	10:30
76348	242500	6569	1	0	1	2	09:00	10:30
76349	242500	6576	1	0	1	2	09:00	10:30
76350	242500	6583	1	0	1	2	09:00	10:30
76351	242500	6590	1	0	1	2	09:00	10:30
76352	242500	6597	1	0	1	2	09:00	10:30
76353	242500	6604	1	0	1	2	09:00	10:30
76354	242500	6611	1	0	1	2	09:00	10:30
76355	242500	6618	1	0	1	2	09:00	10:30
76356	242500	6625	1	0	1	2	09:00	10:30
76357	242500	6632	1	0	1	2	09:00	10:30
76358	242500	6639	1	0	1	2	09:00	10:30
76359	242500	6534	2	0	1	3	10:40	12:10
76360	242500	6548	2	0	1	3	10:40	12:10
76361	242500	6562	2	0	1	3	10:40	12:10
76362	242500	6576	2	0	1	3	10:40	12:10
76363	242500	6590	2	0	1	3	10:40	12:10
76364	242500	6604	2	0	1	3	10:40	12:10
76365	242500	6618	2	0	1	3	10:40	12:10
76366	242500	6632	2	0	1	3	10:40	12:10
76367	242500	6535	1	0	1	10	09:00	10:30
76368	242500	6549	1	0	1	10	09:00	10:30
76369	242500	6563	1	0	1	10	09:00	10:30
76370	242500	6577	1	0	1	10	09:00	10:30
76371	242500	6591	1	0	1	10	09:00	10:30
76372	242500	6605	1	0	1	10	09:00	10:30
76373	242500	6619	1	0	1	10	09:00	10:30
76374	242500	6633	1	0	1	10	09:00	10:30
76375	242500	6542	1	0	1	6	09:00	10:30
76376	242500	6556	1	0	1	6	09:00	10:30
76377	242500	6570	1	0	1	6	09:00	10:30
76378	242500	6584	1	0	1	6	09:00	10:30
76379	242500	6598	1	0	1	6	09:00	10:30
76380	242500	6612	1	0	1	6	09:00	10:30
76381	242500	6626	1	0	1	6	09:00	10:30
76382	242500	6640	1	0	1	6	09:00	10:30
76383	242500	6535	2	0	0	0	10:40	12:10
76384	242500	6542	2	0	0	0	10:40	12:10
76385	242500	6549	2	0	0	0	10:40	12:10
76386	242500	6556	2	0	0	0	10:40	12:10
76387	242500	6563	2	0	0	0	10:40	12:10
76388	242500	6570	2	0	0	0	10:40	12:10
76389	242500	6577	2	0	0	0	10:40	12:10
76390	242500	6584	2	0	0	0	10:40	12:10
76391	242500	6591	2	0	0	0	10:40	12:10
76392	242500	6598	2	0	0	0	10:40	12:10
76393	242500	6605	2	0	0	0	10:40	12:10
76394	242500	6612	2	0	0	0	10:40	12:10
76395	242500	6619	2	0	0	0	10:40	12:10
76396	242500	6626	2	0	0	0	10:40	12:10
76397	242500	6633	2	0	0	0	10:40	12:10
76398	242500	6640	2	0	0	0	10:40	12:10
76399	242500	6535	3	0	0	8	12:40	14:10
76400	242500	6542	3	0	0	8	12:40	14:10
76401	242500	6549	3	0	0	8	12:40	14:10
76402	242500	6556	3	0	0	8	12:40	14:10
76403	242500	6563	3	0	0	8	12:40	14:10
76404	242500	6570	3	0	0	8	12:40	14:10
76405	242500	6577	3	0	0	8	12:40	14:10
76406	242500	6584	3	0	0	8	12:40	14:10
76407	242500	6591	3	0	0	8	12:40	14:10
76408	242500	6598	3	0	0	8	12:40	14:10
76409	242500	6605	3	0	0	8	12:40	14:10
76410	242500	6612	3	0	0	8	12:40	14:10
76411	242500	6619	3	0	0	8	12:40	14:10
76412	242500	6626	3	0	0	8	12:40	14:10
76413	242500	6633	3	0	0	8	12:40	14:10
76414	242500	6640	3	0	0	8	12:40	14:10
76415	242500	6535	4	0	1	11	14:20	15:50
76416	242500	6542	4	0	1	11	14:20	15:50
76417	242500	6549	4	0	1	11	14:20	15:50
76418	242500	6556	4	0	1	11	14:20	15:50
76419	242500	6563	4	0	1	11	14:20	15:50
76420	242500	6570	4	0	1	11	14:20	15:50
76421	242500	6577	4	0	1	11	14:20	15:50
76422	242500	6584	4	0	1	11	14:20	15:50
76423	242500	6591	4	0	1	11	14:20	15:50
76424	242500	6598	4	0	1	11	14:20	15:50
76425	242500	6605	4	0	1	11	14:20	15:50
76426	242500	6612	4	0	1	11	14:20	15:50
76427	242500	6619	4	0	1	11	14:20	15:50
76428	242500	6626	4	0	1	11	14:20	15:50
76429	242500	6633	4	0	1	11	14:20	15:50
76430	242500	6640	4	0	1	11	14:20	15:50
76431	242500	6535	5	0	1	0	16:20	17:50
76432	242500	6542	5	0	1	0	16:20	17:50
76433	242500	6549	5	0	1	0	16:20	17:50
76434	242500	6556	5	0	1	0	16:20	17:50
76435	242500	6563	5	0	1	0	16:20	17:50
76436	242500	6570	5	0	1	0	16:20	17:50
76437	242500	6577	5	0	1	0	16:20	17:50
76438	242500	6584	5	0	1	0	16:20	17:50
76439	242500	6591	5	0	1	0	16:20	17:50
76440	242500	6598	5	0	1	0	16:20	17:50
76441	242500	6605	5	0	1	0	16:20	17:50
76442	242500	6612	5	0	1	0	16:20	17:50
76443	242500	6619	5	0	1	0	16:20	17:50
76444	242500	6626	5	0	1	0	16:20	17:50
76445	242500	6633	5	0	1	0	16:20	17:50
76446	242500	6640	5	0	1	0	16:20	17:50
76447	242500	6543	4	0	0	10	14:20	15:50
76448	242500	6557	4	0	0	10	14:20	15:50
76449	242500	6571	4	0	0	10	14:20	15:50
76450	242500	6585	4	0	0	10	14:20	15:50
76451	242500	6599	4	0	0	10	14:20	15:50
76452	242500	6613	4	0	0	10	14:20	15:50
76453	242500	6627	4	0	0	10	14:20	15:50
76454	242500	6641	4	0	0	10	14:20	15:50
76455	242500	6543	5	0	0	10	16:20	17:50
76456	242500	6557	5	0	0	10	16:20	17:50
76457	242500	6571	5	0	0	10	16:20	17:50
76458	242500	6585	5	0	0	10	16:20	17:50
76459	242500	6599	5	0	0	10	16:20	17:50
76460	242500	6613	5	0	0	10	16:20	17:50
76461	242500	6627	5	0	0	10	16:20	17:50
76462	242500	6641	5	0	0	10	16:20	17:50
76463	242500	6536	6	0	1	5	18:00	19:30
76464	242500	6550	6	0	1	5	18:00	19:30
76465	242500	6564	6	0	1	5	18:00	19:30
76466	242500	6578	6	0	1	5	18:00	19:30
76467	242500	6592	6	0	1	5	18:00	19:30
76468	242500	6606	6	0	1	5	18:00	19:30
76469	242500	6620	6	0	1	5	18:00	19:30
76470	242500	6634	6	0	1	5	18:00	19:30
76471	242500	6531	2	0	0	14	10:40	12:10
76472	242500	6538	2	0	0	14	10:40	12:10
76473	242500	6545	2	0	0	14	10:40	12:10
76474	242500	6552	2	0	0	14	10:40	12:10
76475	242500	6559	2	0	0	14	10:40	12:10
76476	242500	6566	2	0	0	14	10:40	12:10
76477	242500	6573	2	0	0	14	10:40	12:10
76478	242500	6580	2	0	0	14	10:40	12:10
76479	242500	6587	2	0	0	14	10:40	12:10
76480	242500	6594	2	0	0	14	10:40	12:10
76481	242500	6601	2	0	0	14	10:40	12:10
76482	242500	6608	2	0	0	14	10:40	12:10
76483	242500	6615	2	0	0	14	10:40	12:10
76484	242500	6622	2	0	0	14	10:40	12:10
76485	242500	6629	2	0	0	14	10:40	12:10
76486	242500	6636	2	0	0	14	10:40	12:10
76487	242500	6531	3	0	1	15	12:40	14:10
76488	242500	6538	3	0	1	15	12:40	14:10
76489	242500	6545	3	0	1	15	12:40	14:10
76490	242500	6552	3	0	1	15	12:40	14:10
76491	242500	6559	3	0	1	15	12:40	14:10
76492	242500	6566	3	0	1	15	12:40	14:10
76493	242500	6573	3	0	1	15	12:40	14:10
76494	242500	6580	3	0	1	15	12:40	14:10
76495	242500	6587	3	0	1	15	12:40	14:10
76496	242500	6594	3	0	1	15	12:40	14:10
76497	242500	6601	3	0	1	15	12:40	14:10
76498	242500	6608	3	0	1	15	12:40	14:10
76499	242500	6615	3	0	1	15	12:40	14:10
76500	242500	6622	3	0	1	15	12:40	14:10
76501	242500	6629	3	0	1	15	12:40	14:10
76502	242500	6636	3	0	1	15	12:40	14:10
76503	242500	6531	4	0	1	14	14:20	15:50
76504	242500	6538	4	0	1	14	14:20	15:50
76505	242500	6545	4	0	1	14	14:20	15:50
76506	242500	6552	4	0	1	14	14:20	15:50
76507	242500	6559	4	0	1	14	14:20	15:50
76508	242500	6566	4	0	1	14	14:20	15:50
76509	242500	6573	4	0	1	14	14:20	15:50
76510	242500	6580	4	0	1	14	14:20	15:50
76511	242500	6587	4	0	1	14	14:20	15:50
76512	242500	6594	4	0	1	14	14:20	15:50
76513	242500	6601	4	0	1	14	14:20	15:50
76514	242500	6608	4	0	1	14	14:20	15:50
76515	242500	6615	4	0	1	14	14:20	15:50
76516	242500	6622	4	0	1	14	14:20	15:50
76517	242500	6629	4	0	1	14	14:20	15:50
76518	242500	6636	4	0	1	14	14:20	15:50
76519	242500	6531	5	0	0	16	16:20	17:50
76520	242500	6538	5	0	0	16	16:20	17:50
76521	242500	6545	5	0	0	16	16:20	17:50
76522	242500	6552	5	0	0	16	16:20	17:50
76523	242500	6559	5	0	0	16	16:20	17:50
76524	242500	6566	5	0	0	16	16:20	17:50
76525	242500	6573	5	0	0	16	16:20	17:50
76526	242500	6580	5	0	0	16	16:20	17:50
76527	242500	6587	5	0	0	16	16:20	17:50
76528	242500	6594	5	0	0	16	16:20	17:50
76529	242500	6601	5	0	0	16	16:20	17:50
76530	242500	6608	5	0	0	16	16:20	17:50
76531	242500	6615	5	0	0	16	16:20	17:50
76532	242500	6622	5	0	0	16	16:20	17:50
76533	242500	6629	5	0	0	16	16:20	17:50
76534	242500	6636	5	0	0	16	16:20	17:50
76535	242500	6532	1	0	1	7	09:00	10:30
76536	242500	6539	1	0	1	7	09:00	10:30
76537	242500	6546	1	0	1	7	09:00	10:30
76538	242500	6553	1	0	1	7	09:00	10:30
76539	242500	6560	1	0	1	7	09:00	10:30
76540	242500	6567	1	0	1	7	09:00	10:30
76541	242500	6574	1	0	1	7	09:00	10:30
76542	242500	6581	1	0	1	7	09:00	10:30
76543	242500	6588	1	0	1	7	09:00	10:30
76544	242500	6595	1	0	1	7	09:00	10:30
76545	242500	6602	1	0	1	7	09:00	10:30
76546	242500	6609	1	0	1	7	09:00	10:30
76547	242500	6616	1	0	1	7	09:00	10:30
76548	242500	6623	1	0	1	7	09:00	10:30
76549	242500	6630	1	0	1	7	09:00	10:30
76550	242500	6637	1	0	1	7	09:00	10:30
76551	242500	6532	2	0	1	1	10:40	12:10
76552	242500	6539	2	0	1	1	10:40	12:10
76553	242500	6546	2	0	1	1	10:40	12:10
76554	242500	6553	2	0	1	1	10:40	12:10
76555	242500	6560	2	0	1	1	10:40	12:10
76556	242500	6567	2	0	1	1	10:40	12:10
76557	242500	6574	2	0	1	1	10:40	12:10
76558	242500	6581	2	0	1	1	10:40	12:10
76559	242500	6588	2	0	1	1	10:40	12:10
76560	242500	6595	2	0	1	1	10:40	12:10
76561	242500	6602	2	0	1	1	10:40	12:10
76562	242500	6609	2	0	1	1	10:40	12:10
76563	242500	6616	2	0	1	1	10:40	12:10
76564	242500	6623	2	0	1	1	10:40	12:10
76565	242500	6630	2	0	1	1	10:40	12:10
76566	242500	6637	2	0	1	1	10:40	12:10
76567	242500	6532	3	0	0	7	12:40	14:10
76568	242500	6539	3	0	0	7	12:40	14:10
76569	242500	6546	3	0	0	7	12:40	14:10
76570	242500	6553	3	0	0	7	12:40	14:10
76571	242500	6560	3	0	0	7	12:40	14:10
76572	242500	6567	3	0	0	7	12:40	14:10
76573	242500	6574	3	0	0	7	12:40	14:10
76574	242500	6581	3	0	0	7	12:40	14:10
76575	242500	6588	3	0	0	7	12:40	14:10
76576	242500	6595	3	0	0	7	12:40	14:10
76577	242500	6602	3	0	0	7	12:40	14:10
76578	242500	6609	3	0	0	7	12:40	14:10
76579	242500	6616	3	0	0	7	12:40	14:10
76580	242500	6623	3	0	0	7	12:40	14:10
76581	242500	6630	3	0	0	7	12:40	14:10
76582	242500	6637	3	0	0	7	12:40	14:10
76583	242500	6532	4	0	0	9	14:20	15:50
76584	242500	6539	4	0	0	9	14:20	15:50
76585	242500	6546	4	0	0	9	14:20	15:50
76586	242500	6553	4	0	0	9	14:20	15:50
76587	242500	6560	4	0	0	9	14:20	15:50
76588	242500	6567	4	0	0	9	14:20	15:50
76589	242500	6574	4	0	0	9	14:20	15:50
76590	242500	6581	4	0	0	9	14:20	15:50
76591	242500	6588	4	0	0	9	14:20	15:50
76592	242500	6595	4	0	0	9	14:20	15:50
76593	242500	6602	4	0	0	9	14:20	15:50
76594	242500	6609	4	0	0	9	14:20	15:50
76595	242500	6616	4	0	0	9	14:20	15:50
76596	242500	6623	4	0	0	9	14:20	15:50
76597	242500	6630	4	0	0	9	14:20	15:50
76598	242500	6637	4	0	0	9	14:20	15:50
76599	242500	6532	5	0	0	17	16:20	17:50
76600	242500	6539	5	0	0	17	16:20	17:50
76601	242500	6546	5	0	0	17	16:20	17:50
76602	242500	6553	5	0	0	17	16:20	17:50
76603	242500	6560	5	0	0	17	16:20	17:50
76604	242500	6567	5	0	0	17	16:20	17:50
76605	242500	6574	5	0	0	17	16:20	17:50
76606	242500	6581	5	0	0	17	16:20	17:50
76607	242500	6588	5	0	0	17	16:20	17:50
76608	242500	6595	5	0	0	17	16:20	17:50
76609	242500	6602	5	0	0	17	16:20	17:50
76610	242500	6609	5	0	0	17	16:20	17:50
76611	242500	6616	5	0	0	17	16:20	17:50
76612	242500	6623	5	0	0	17	16:20	17:50
76613	242500	6630	5	0	0	17	16:20	17:50
76614	242500	6637	5	0	0	17	16:20	17:50
76615	242500	6533	1	0	0	15	09:00	10:30
76616	242500	6540	1	0	0	15	09:00	10:30
76617	242500	6547	1	0	0	15	09:00	10:30
76618	242500	6554	1	0	0	15	09:00	10:30
76619	242500	6561	1	0	0	15	09:00	10:30
76620	242500	6568	1	0	0	15	09:00	10:30
76621	242500	6575	1	0	0	15	09:00	10:30
76622	242500	6582	1	0	0	15	09:00	10:30
76623	242500	6589	1	0	0	15	09:00	10:30
76624	242500	6596	1	0	0	15	09:00	10:30
76625	242500	6603	1	0	0	15	09:00	10:30
76626	242500	6610	1	0	0	15	09:00	10:30
76627	242500	6617	1	0	0	15	09:00	10:30
76628	242500	6624	1	0	0	15	09:00	10:30
76629	242500	6631	1	0	0	15	09:00	10:30
76630	242500	6638	1	0	0	15	09:00	10:30
76631	242500	6533	2	0	0	8	10:40	12:10
76632	242500	6540	2	0	0	8	10:40	12:10
76633	242500	6547	2	0	0	8	10:40	12:10
76634	242500	6554	2	0	0	8	10:40	12:10
76635	242500	6561	2	0	0	8	10:40	12:10
76636	242500	6568	2	0	0	8	10:40	12:10
76637	242500	6575	2	0	0	8	10:40	12:10
76638	242500	6582	2	0	0	8	10:40	12:10
76639	242500	6589	2	0	0	8	10:40	12:10
76640	242500	6596	2	0	0	8	10:40	12:10
76641	242500	6603	2	0	0	8	10:40	12:10
76642	242500	6610	2	0	0	8	10:40	12:10
76643	242500	6617	2	0	0	8	10:40	12:10
76644	242500	6624	2	0	0	8	10:40	12:10
76645	242500	6631	2	0	0	8	10:40	12:10
76646	242500	6638	2	0	0	8	10:40	12:10
76647	242500	6533	3	0	0	2	12:40	14:10
76648	242500	6540	3	0	0	2	12:40	14:10
76649	242500	6547	3	0	0	2	12:40	14:10
76650	242500	6554	3	0	0	2	12:40	14:10
76651	242500	6561	3	0	0	2	12:40	14:10
76652	242500	6568	3	0	0	2	12:40	14:10
76653	242500	6575	3	0	0	2	12:40	14:10
76654	242500	6582	3	0	0	2	12:40	14:10
76655	242500	6589	3	0	0	2	12:40	14:10
76656	242500	6596	3	0	0	2	12:40	14:10
76657	242500	6603	3	0	0	2	12:40	14:10
76658	242500	6610	3	0	0	2	12:40	14:10
76659	242500	6617	3	0	0	2	12:40	14:10
76660	242500	6624	3	0	0	2	12:40	14:10
76661	242500	6631	3	0	0	2	12:40	14:10
76662	242500	6638	3	0	0	2	12:40	14:10
76663	242500	6534	1	0	1	18	09:00	10:30
76664	242500	6548	1	0	1	18	09:00	10:30
76665	242500	6562	1	0	1	18	09:00	10:30
76666	242500	6576	1	0	1	18	09:00	10:30
76667	242500	6590	1	0	1	18	09:00	10:30
76668	242500	6604	1	0	1	18	09:00	10:30
76669	242500	6618	1	0	1	18	09:00	10:30
76670	242500	6632	1	0	1	18	09:00	10:30
76671	242500	6541	1	0	0	18	09:00	10:30
76672	242500	6555	1	0	0	18	09:00	10:30
76673	242500	6569	1	0	0	18	09:00	10:30
76674	242500	6583	1	0	0	18	09:00	10:30
76675	242500	6597	1	0	0	18	09:00	10:30
76676	242500	6611	1	0	0	18	09:00	10:30
76677	242500	6625	1	0	0	18	09:00	10:30
76678	242500	6639	1	0	0	18	09:00	10:30
76679	242500	6534	2	0	1	2	10:40	12:10
76680	242500	6548	2	0	1	2	10:40	12:10
76681	242500	6562	2	0	1	2	10:40	12:10
76682	242500	6576	2	0	1	2	10:40	12:10
76683	242500	6590	2	0	1	2	10:40	12:10
76684	242500	6604	2	0	1	2	10:40	12:10
76685	242500	6618	2	0	1	2	10:40	12:10
76686	242500	6632	2	0	1	2	10:40	12:10
76687	242500	6541	2	0	1	17	10:40	12:10
76688	242500	6555	2	0	1	17	10:40	12:10
76689	242500	6569	2	0	1	17	10:40	12:10
76690	242500	6583	2	0	1	17	10:40	12:10
76691	242500	6597	2	0	1	17	10:40	12:10
76692	242500	6611	2	0	1	17	10:40	12:10
76693	242500	6625	2	0	1	17	10:40	12:10
76694	242500	6639	2	0	1	17	10:40	12:10
76695	242500	6535	1	0	0	1	09:00	10:30
76696	242500	6549	1	0	0	1	09:00	10:30
76697	242500	6563	1	0	0	1	09:00	10:30
76698	242500	6577	1	0	0	1	09:00	10:30
76699	242500	6591	1	0	0	1	09:00	10:30
76700	242500	6605	1	0	0	1	09:00	10:30
76701	242500	6619	1	0	0	1	09:00	10:30
76702	242500	6633	1	0	0	1	09:00	10:30
76703	242500	6535	2	0	0	19	10:40	12:10
76704	242500	6542	2	0	0	19	10:40	12:10
76705	242500	6549	2	0	0	19	10:40	12:10
76706	242500	6556	2	0	0	19	10:40	12:10
76707	242500	6563	2	0	0	19	10:40	12:10
76708	242500	6570	2	0	0	19	10:40	12:10
76709	242500	6577	2	0	0	19	10:40	12:10
76710	242500	6584	2	0	0	19	10:40	12:10
76711	242500	6591	2	0	0	19	10:40	12:10
76712	242500	6598	2	0	0	19	10:40	12:10
76713	242500	6605	2	0	0	19	10:40	12:10
76714	242500	6612	2	0	0	19	10:40	12:10
76715	242500	6619	2	0	0	19	10:40	12:10
76716	242500	6626	2	0	0	19	10:40	12:10
76717	242500	6633	2	0	0	19	10:40	12:10
76718	242500	6640	2	0	0	19	10:40	12:10
76719	242500	6535	3	0	1	19	12:40	14:10
76720	242500	6542	3	0	1	19	12:40	14:10
76721	242500	6549	3	0	1	19	12:40	14:10
76722	242500	6556	3	0	1	19	12:40	14:10
76723	242500	6563	3	0	1	19	12:40	14:10
76724	242500	6570	3	0	1	19	12:40	14:10
76725	242500	6577	3	0	1	19	12:40	14:10
76726	242500	6584	3	0	1	19	12:40	14:10
76727	242500	6591	3	0	1	19	12:40	14:10
76728	242500	6598	3	0	1	19	12:40	14:10
76801	242500	6601	5	0	0	9	16:20	17:50
76802	242500	6608	5	0	0	9	16:20	17:50
76803	242500	6615	5	0	0	9	16:20	17:50
76804	242500	6622	5	0	0	9	16:20	17:50
76805	242500	6629	5	0	0	9	16:20	17:50
76806	242500	6636	5	0	0	9	16:20	17:50
76807	242500	6532	1	0	1	20	09:00	10:30
76808	242500	6539	1	0	1	20	09:00	10:30
76809	242500	6546	1	0	1	20	09:00	10:30
76810	242500	6553	1	0	1	20	09:00	10:30
76811	242500	6560	1	0	1	20	09:00	10:30
76812	242500	6567	1	0	1	20	09:00	10:30
76813	242500	6574	1	0	1	20	09:00	10:30
76814	242500	6581	1	0	1	20	09:00	10:30
76815	242500	6588	1	0	1	20	09:00	10:30
76816	242500	6595	1	0	1	20	09:00	10:30
76817	242500	6602	1	0	1	20	09:00	10:30
76818	242500	6609	1	0	1	20	09:00	10:30
76819	242500	6616	1	0	1	20	09:00	10:30
76820	242500	6623	1	0	1	20	09:00	10:30
76821	242500	6630	1	0	1	20	09:00	10:30
76822	242500	6637	1	0	1	20	09:00	10:30
76823	242500	6532	2	0	1	1	10:40	12:10
76824	242500	6539	2	0	1	1	10:40	12:10
76825	242500	6546	2	0	1	1	10:40	12:10
76826	242500	6553	2	0	1	1	10:40	12:10
76827	242500	6560	2	0	1	1	10:40	12:10
76828	242500	6567	2	0	1	1	10:40	12:10
76829	242500	6574	2	0	1	1	10:40	12:10
76830	242500	6581	2	0	1	1	10:40	12:10
76831	242500	6588	2	0	1	1	10:40	12:10
76832	242500	6595	2	0	1	1	10:40	12:10
76833	242500	6602	2	0	1	1	10:40	12:10
76834	242500	6609	2	0	1	1	10:40	12:10
76835	242500	6616	2	0	1	1	10:40	12:10
76836	242500	6623	2	0	1	1	10:40	12:10
76837	242500	6630	2	0	1	1	10:40	12:10
76838	242500	6637	2	0	1	1	10:40	12:10
76839	242500	6533	1	0	0	17	09:00	10:30
76840	242500	6540	1	0	0	17	09:00	10:30
76841	242500	6547	1	0	0	17	09:00	10:30
76842	242500	6554	1	0	0	17	09:00	10:30
76843	242500	6561	1	0	0	17	09:00	10:30
76844	242500	6568	1	0	0	17	09:00	10:30
76845	242500	6575	1	0	0	17	09:00	10:30
76846	242500	6582	1	0	0	17	09:00	10:30
76847	242500	6589	1	0	0	17	09:00	10:30
76848	242500	6596	1	0	0	17	09:00	10:30
76849	242500	6603	1	0	0	17	09:00	10:30
76850	242500	6610	1	0	0	17	09:00	10:30
76851	242500	6617	1	0	0	17	09:00	10:30
76852	242500	6624	1	0	0	17	09:00	10:30
76853	242500	6631	1	0	0	17	09:00	10:30
76854	242500	6638	1	0	0	17	09:00	10:30
76855	242500	6533	2	0	0	2	10:40	12:10
76856	242500	6540	2	0	0	2	10:40	12:10
76857	242500	6547	2	0	0	2	10:40	12:10
76858	242500	6554	2	0	0	2	10:40	12:10
76859	242500	6561	2	0	0	2	10:40	12:10
76860	242500	6568	2	0	0	2	10:40	12:10
76861	242500	6575	2	0	0	2	10:40	12:10
76862	242500	6582	2	0	0	2	10:40	12:10
76863	242500	6589	2	0	0	2	10:40	12:10
76864	242500	6596	2	0	0	2	10:40	12:10
76865	242500	6603	2	0	0	2	10:40	12:10
76866	242500	6610	2	0	0	2	10:40	12:10
76867	242500	6617	2	0	0	2	10:40	12:10
76868	242500	6624	2	0	0	2	10:40	12:10
76869	242500	6631	2	0	0	2	10:40	12:10
76870	242500	6638	2	0	0	2	10:40	12:10
76871	242500	6533	3	0	0	21	12:40	14:10
76991	242500	6535	3	0	1	19	12:40	14:10
76992	242500	6542	3	0	1	19	12:40	14:10
76993	242500	6549	3	0	1	19	12:40	14:10
76994	242500	6556	3	0	1	19	12:40	14:10
76995	242500	6563	3	0	1	19	12:40	14:10
76996	242500	6570	3	0	1	19	12:40	14:10
76997	242500	6577	3	0	1	19	12:40	14:10
76998	242500	6584	3	0	1	19	12:40	14:10
76999	242500	6591	3	0	1	19	12:40	14:10
77000	242500	6598	3	0	1	19	12:40	14:10
77001	242500	6605	3	0	1	19	12:40	14:10
77002	242500	6612	3	0	1	19	12:40	14:10
77003	242500	6619	3	0	1	19	12:40	14:10
77004	242500	6626	3	0	1	19	12:40	14:10
77005	242500	6633	3	0	1	19	12:40	14:10
77006	242500	6640	3	0	1	19	12:40	14:10
77007	242500	6535	4	0	0	15	14:20	15:50
77008	242500	6542	4	0	0	15	14:20	15:50
77009	242500	6549	4	0	0	15	14:20	15:50
77010	242500	6556	4	0	0	15	14:20	15:50
77011	242500	6563	4	0	0	15	14:20	15:50
77012	242500	6570	4	0	0	15	14:20	15:50
77013	242500	6577	4	0	0	15	14:20	15:50
77014	242500	6584	4	0	0	15	14:20	15:50
77015	242500	6591	4	0	0	15	14:20	15:50
77016	242500	6598	4	0	0	15	14:20	15:50
77017	242500	6605	4	0	0	15	14:20	15:50
77018	242500	6612	4	0	0	15	14:20	15:50
77019	242500	6619	4	0	0	15	14:20	15:50
77020	242500	6626	4	0	0	15	14:20	15:50
77021	242500	6633	4	0	0	15	14:20	15:50
77022	242500	6640	4	0	0	15	14:20	15:50
77023	242500	6535	5	0	0	16	16:20	17:50
77024	242500	6542	5	0	0	16	16:20	17:50
77025	242500	6549	5	0	0	16	16:20	17:50
77026	242500	6556	5	0	0	16	16:20	17:50
77027	242500	6563	5	0	0	16	16:20	17:50
77028	242500	6570	5	0	0	16	16:20	17:50
77029	242500	6577	5	0	0	16	16:20	17:50
77030	242500	6584	5	0	0	16	16:20	17:50
77031	242500	6591	5	0	0	16	16:20	17:50
77032	242500	6598	5	0	0	16	16:20	17:50
77033	242500	6605	5	0	0	16	16:20	17:50
77034	242500	6612	5	0	0	16	16:20	17:50
77035	242500	6619	5	0	0	16	16:20	17:50
77036	242500	6626	5	0	0	16	16:20	17:50
77037	242500	6633	5	0	0	16	16:20	17:50
77038	242500	6640	5	0	0	16	16:20	17:50
77039	242500	6536	2	0	1	16	10:40	12:10
77040	242500	6550	2	0	1	16	10:40	12:10
77041	242500	6564	2	0	1	16	10:40	12:10
77042	242500	6578	2	0	1	16	10:40	12:10
77043	242500	6592	2	0	1	16	10:40	12:10
77044	242500	6606	2	0	1	16	10:40	12:10
77045	242500	6620	2	0	1	16	10:40	12:10
77046	242500	6634	2	0	1	16	10:40	12:10
77047	242500	6538	1	0	0	22	09:00	10:30
77048	242500	6538	2	0	0	22	10:40	12:10
77049	242500	6538	3	0	0	22	12:40	14:10
77050	242500	6538	4	0	0	22	14:20	15:50
77051	242500	6531	6	0	1	23	18:00	19:30
77052	242500	6545	6	0	1	23	18:00	19:30
77053	242500	6559	6	0	1	23	18:00	19:30
77054	242500	6573	6	0	1	23	18:00	19:30
77055	242500	6587	6	0	1	23	18:00	19:30
77056	242500	6601	6	0	1	23	18:00	19:30
77057	242500	6615	6	0	1	23	18:00	19:30
77058	242500	6629	6	0	1	23	18:00	19:30
77059	242500	6532	3	0	0	24	12:40	14:10
77060	242500	6539	3	0	0	24	12:40	14:10
77061	242500	6546	3	0	0	24	12:40	14:10
77062	242500	6553	3	0	0	24	12:40	14:10
77063	242500	6560	3	0	0	24	12:40	14:10
77064	242500	6567	3	0	0	24	12:40	14:10
77065	242500	6574	3	0	0	24	12:40	14:10
77066	242500	6581	3	0	0	24	12:40	14:10
77067	242500	6588	3	0	0	24	12:40	14:10
77068	242500	6595	3	0	0	24	12:40	14:10
77069	242500	6602	3	0	0	24	12:40	14:10
77070	242500	6609	3	0	0	24	12:40	14:10
77071	242500	6616	3	0	0	24	12:40	14:10
77072	242500	6623	3	0	0	24	12:40	14:10
77073	242500	6630	3	0	0	24	12:40	14:10
77074	242500	6637	3	0	0	24	12:40	14:10
77075	242500	6532	4	0	1	24	14:20	15:50
77076	242500	6539	4	0	1	24	14:20	15:50
77077	242500	6546	4	0	1	24	14:20	15:50
77078	242500	6553	4	0	1	24	14:20	15:50
77079	242500	6560	4	0	1	24	14:20	15:50
77080	242500	6567	4	0	1	24	14:20	15:50
77081	242500	6574	4	0	1	24	14:20	15:50
77082	242500	6581	4	0	1	24	14:20	15:50
77083	242500	6588	4	0	1	24	14:20	15:50
77084	242500	6595	4	0	1	24	14:20	15:50
77085	242500	6602	4	0	1	24	14:20	15:50
77086	242500	6609	4	0	1	24	14:20	15:50
77087	242500	6616	4	0	1	24	14:20	15:50
77088	242500	6623	4	0	1	24	14:20	15:50
77089	242500	6630	4	0	1	24	14:20	15:50
77090	242500	6637	4	0	1	24	14:20	15:50
77091	242500	6540	1	0	1	25	09:00	10:30
77092	242500	6554	1	0	1	25	09:00	10:30
77093	242500	6568	1	0	1	25	09:00	10:30
77094	242500	6582	1	0	1	25	09:00	10:30
77095	242500	6596	1	0	1	25	09:00	10:30
77096	242500	6610	1	0	1	25	09:00	10:30
77097	242500	6624	1	0	1	25	09:00	10:30
77098	242500	6638	1	0	1	25	09:00	10:30
77099	242500	6533	2	0	0	26	10:40	12:10
77100	242500	6547	2	0	0	26	10:40	12:10
77101	242500	6561	2	0	0	26	10:40	12:10
77102	242500	6575	2	0	0	26	10:40	12:10
77103	242500	6589	2	0	0	26	10:40	12:10
77104	242500	6603	2	0	0	26	10:40	12:10
77105	242500	6617	2	0	0	26	10:40	12:10
77106	242500	6631	2	0	0	26	10:40	12:10
77107	242500	6540	2	0	0	26	10:40	12:10
77108	242500	6554	2	0	0	26	10:40	12:10
77109	242500	6568	2	0	0	26	10:40	12:10
77110	242500	6582	2	0	0	26	10:40	12:10
77111	242500	6596	2	0	0	26	10:40	12:10
77112	242500	6610	2	0	0	26	10:40	12:10
77113	242500	6624	2	0	0	26	10:40	12:10
77114	242500	6638	2	0	0	26	10:40	12:10
77115	242500	6533	3	0	0	26	12:40	14:10
77116	242500	6547	3	0	0	26	12:40	14:10
77117	242500	6561	3	0	0	26	12:40	14:10
77118	242500	6575	3	0	0	26	12:40	14:10
77119	242500	6589	3	0	0	26	12:40	14:10
77120	242500	6603	3	0	0	26	12:40	14:10
77121	242500	6617	3	0	0	26	12:40	14:10
77122	242500	6631	3	0	0	26	12:40	14:10
77123	242500	6540	3	0	0	26	12:40	14:10
77124	242500	6554	3	0	0	26	12:40	14:10
77125	242500	6568	3	0	0	26	12:40	14:10
77126	242500	6582	3	0	0	26	12:40	14:10
77127	242500	6596	3	0	0	26	12:40	14:10
77128	242500	6610	3	0	0	26	12:40	14:10
77129	242500	6624	3	0	0	26	12:40	14:10
77130	242500	6638	3	0	0	26	12:40	14:10
77131	242500	6533	4	0	0	27	14:20	15:50
77132	242500	6547	4	0	0	27	14:20	15:50
77133	242500	6561	4	0	0	27	14:20	15:50
77134	242500	6575	4	0	0	27	14:20	15:50
77135	242500	6589	4	0	0	27	14:20	15:50
77136	242500	6603	4	0	0	27	14:20	15:50
77137	242500	6617	4	0	0	27	14:20	15:50
77138	242500	6631	4	0	0	27	14:20	15:50
77139	242500	6533	5	0	0	27	16:20	17:50
77140	242500	6547	5	0	0	27	16:20	17:50
77141	242500	6561	5	0	0	27	16:20	17:50
77142	242500	6575	5	0	0	27	16:20	17:50
77143	242500	6589	5	0	0	27	16:20	17:50
77144	242500	6603	5	0	0	27	16:20	17:50
77145	242500	6617	5	0	0	27	16:20	17:50
77146	242500	6631	5	0	0	27	16:20	17:50
77147	242500	6533	6	0	1	25	18:00	19:30
77148	242500	6547	6	0	1	25	18:00	19:30
77149	242500	6561	6	0	1	25	18:00	19:30
77150	242500	6575	6	0	1	25	18:00	19:30
77151	242500	6589	6	0	1	25	18:00	19:30
77152	242500	6603	6	0	1	25	18:00	19:30
77153	242500	6617	6	0	1	25	18:00	19:30
77154	242500	6631	6	0	1	25	18:00	19:30
77155	242500	6534	2	0	1	28	10:40	12:10
77156	242500	6541	2	0	1	28	10:40	12:10
77157	242500	6548	2	0	1	28	10:40	12:10
77158	242500	6555	2	0	1	28	10:40	12:10
77159	242500	6562	2	0	1	28	10:40	12:10
77160	242500	6569	2	0	1	28	10:40	12:10
77161	242500	6576	2	0	1	28	10:40	12:10
77162	242500	6583	2	0	1	28	10:40	12:10
77163	242500	6590	2	0	1	28	10:40	12:10
77164	242500	6597	2	0	1	28	10:40	12:10
77165	242500	6604	2	0	1	28	10:40	12:10
77166	242500	6611	2	0	1	28	10:40	12:10
77167	242500	6618	2	0	1	28	10:40	12:10
77168	242500	6625	2	0	1	28	10:40	12:10
77169	242500	6632	2	0	1	28	10:40	12:10
77170	242500	6639	2	0	1	28	10:40	12:10
77171	242500	6534	3	0	0	29	12:40	14:10
77172	242500	6541	3	0	0	29	12:40	14:10
77173	242500	6548	3	0	0	29	12:40	14:10
77174	242500	6555	3	0	0	29	12:40	14:10
77175	242500	6562	3	0	0	29	12:40	14:10
77176	242500	6569	3	0	0	29	12:40	14:10
77177	242500	6576	3	0	0	29	12:40	14:10
77178	242500	6583	3	0	0	29	12:40	14:10
77179	242500	6590	3	0	0	29	12:40	14:10
77180	242500	6597	3	0	0	29	12:40	14:10
77181	242500	6604	3	0	0	29	12:40	14:10
77182	242500	6611	3	0	0	29	12:40	14:10
77183	242500	6618	3	0	0	29	12:40	14:10
77184	242500	6625	3	0	0	29	12:40	14:10
77185	242500	6632	3	0	0	29	12:40	14:10
77186	242500	6639	3	0	0	29	12:40	14:10
77187	242500	6534	4	0	0	28	14:20	15:50
77188	242500	6548	4	0	0	28	14:20	15:50
77189	242500	6562	4	0	0	28	14:20	15:50
77190	242500	6576	4	0	0	28	14:20	15:50
77191	242500	6590	4	0	0	28	14:20	15:50
77192	242500	6604	4	0	0	28	14:20	15:50
77193	242500	6618	4	0	0	28	14:20	15:50
77194	242500	6632	4	0	0	28	14:20	15:50
77195	242500	6535	1	0	1	30	09:00	10:30
77196	242500	6549	1	0	1	30	09:00	10:30
77197	242500	6563	1	0	1	30	09:00	10:30
77198	242500	6577	1	0	1	30	09:00	10:30
77199	242500	6591	1	0	1	30	09:00	10:30
77200	242500	6605	1	0	1	30	09:00	10:30
77201	242500	6619	1	0	1	30	09:00	10:30
77202	242500	6633	1	0	1	30	09:00	10:30
77203	242500	6535	2	0	1	31	10:40	12:10
77204	242500	6542	2	0	1	31	10:40	12:10
77205	242500	6549	2	0	1	31	10:40	12:10
77206	242500	6556	2	0	1	31	10:40	12:10
77207	242500	6563	2	0	1	31	10:40	12:10
77208	242500	6570	2	0	1	31	10:40	12:10
77209	242500	6577	2	0	1	31	10:40	12:10
77210	242500	6584	2	0	1	31	10:40	12:10
77211	242500	6591	2	0	1	31	10:40	12:10
77212	242500	6598	2	0	1	31	10:40	12:10
77213	242500	6605	2	0	1	31	10:40	12:10
77214	242500	6612	2	0	1	31	10:40	12:10
77215	242500	6619	2	0	1	31	10:40	12:10
77216	242500	6626	2	0	1	31	10:40	12:10
77217	242500	6633	2	0	1	31	10:40	12:10
77218	242500	6640	2	0	1	31	10:40	12:10
77219	242500	6535	3	0	0	25	12:40	14:10
77220	242500	6542	3	0	0	25	12:40	14:10
77221	242500	6549	3	0	0	25	12:40	14:10
77222	242500	6556	3	0	0	25	12:40	14:10
77223	242500	6563	3	0	0	25	12:40	14:10
77224	242500	6570	3	0	0	25	12:40	14:10
77225	242500	6577	3	0	0	25	12:40	14:10
77226	242500	6584	3	0	0	25	12:40	14:10
77227	242500	6591	3	0	0	25	12:40	14:10
77228	242500	6598	3	0	0	25	12:40	14:10
77229	242500	6605	3	0	0	25	12:40	14:10
77230	242500	6612	3	0	0	25	12:40	14:10
77231	242500	6619	3	0	0	25	12:40	14:10
77232	242500	6626	3	0	0	25	12:40	14:10
77233	242500	6633	3	0	0	25	12:40	14:10
77234	242500	6640	3	0	0	25	12:40	14:10
77235	242500	6536	3	0	0	30	12:40	14:10
77236	242500	6543	3	0	0	30	12:40	14:10
77237	242500	6550	3	0	0	30	12:40	14:10
77238	242500	6557	3	0	0	30	12:40	14:10
77239	242500	6564	3	0	0	30	12:40	14:10
77240	242500	6571	3	0	0	30	12:40	14:10
77241	242500	6578	3	0	0	30	12:40	14:10
77242	242500	6585	3	0	0	30	12:40	14:10
77243	242500	6592	3	0	0	30	12:40	14:10
77244	242500	6599	3	0	0	30	12:40	14:10
77245	242500	6606	3	0	0	30	12:40	14:10
77246	242500	6613	3	0	0	30	12:40	14:10
77247	242500	6620	3	0	0	30	12:40	14:10
77248	242500	6627	3	0	0	30	12:40	14:10
77249	242500	6634	3	0	0	30	12:40	14:10
77250	242500	6641	3	0	0	30	12:40	14:10
77251	242500	6536	4	0	0	31	14:20	15:50
77252	242500	6543	4	0	0	31	14:20	15:50
77253	242500	6550	4	0	0	31	14:20	15:50
77254	242500	6557	4	0	0	31	14:20	15:50
77255	242500	6564	4	0	0	31	14:20	15:50
77256	242500	6571	4	0	0	31	14:20	15:50
77257	242500	6578	4	0	0	31	14:20	15:50
77258	242500	6585	4	0	0	31	14:20	15:50
77259	242500	6592	4	0	0	31	14:20	15:50
77260	242500	6599	4	0	0	31	14:20	15:50
77261	242500	6606	4	0	0	31	14:20	15:50
77262	242500	6613	4	0	0	31	14:20	15:50
77263	242500	6620	4	0	0	31	14:20	15:50
77264	242500	6627	4	0	0	31	14:20	15:50
77265	242500	6634	4	0	0	31	14:20	15:50
77266	242500	6641	4	0	0	31	14:20	15:50
77267	242500	6545	1	0	0	32	09:00	10:30
77268	242500	6545	2	0	0	32	10:40	12:10
77269	242500	6545	3	0	0	32	12:40	14:10
77270	242500	6545	4	0	0	32	14:20	15:50
77271	242500	6531	6	0	1	23	18:00	19:30
77272	242500	6545	6	0	1	23	18:00	19:30
77273	242500	6559	6	0	1	23	18:00	19:30
77274	242500	6573	6	0	1	23	18:00	19:30
77275	242500	6587	6	0	1	23	18:00	19:30
77276	242500	6601	6	0	1	23	18:00	19:30
77277	242500	6615	6	0	1	23	18:00	19:30
77278	242500	6629	6	0	1	23	18:00	19:30
77279	242500	6532	4	0	1	24	14:20	15:50
77280	242500	6539	4	0	1	24	14:20	15:50
77281	242500	6546	4	0	1	24	14:20	15:50
77282	242500	6553	4	0	1	24	14:20	15:50
77283	242500	6560	4	0	1	24	14:20	15:50
77284	242500	6567	4	0	1	24	14:20	15:50
77285	242500	6574	4	0	1	24	14:20	15:50
77286	242500	6581	4	0	1	24	14:20	15:50
77287	242500	6588	4	0	1	24	14:20	15:50
77288	242500	6595	4	0	1	24	14:20	15:50
77289	242500	6602	4	0	1	24	14:20	15:50
77290	242500	6609	4	0	1	24	14:20	15:50
77291	242500	6616	4	0	1	24	14:20	15:50
77292	242500	6623	4	0	1	24	14:20	15:50
77293	242500	6630	4	0	1	24	14:20	15:50
77294	242500	6637	4	0	1	24	14:20	15:50
77295	242500	6540	1	0	1	25	09:00	10:30
77296	242500	6554	1	0	1	25	09:00	10:30
77297	242500	6568	1	0	1	25	09:00	10:30
77298	242500	6582	1	0	1	25	09:00	10:30
77299	242500	6596	1	0	1	25	09:00	10:30
77300	242500	6610	1	0	1	25	09:00	10:30
77301	242500	6624	1	0	1	25	09:00	10:30
77302	242500	6638	1	0	1	25	09:00	10:30
77303	242500	6533	2	0	0	26	10:40	12:10
77304	242500	6547	2	0	0	26	10:40	12:10
77305	242500	6561	2	0	0	26	10:40	12:10
77306	242500	6575	2	0	0	26	10:40	12:10
77307	242500	6589	2	0	0	26	10:40	12:10
77308	242500	6603	2	0	0	26	10:40	12:10
77309	242500	6617	2	0	0	26	10:40	12:10
77310	242500	6631	2	0	0	26	10:40	12:10
77311	242500	6540	2	0	0	26	10:40	12:10
77312	242500	6554	2	0	0	26	10:40	12:10
77313	242500	6568	2	0	0	26	10:40	12:10
77314	242500	6582	2	0	0	26	10:40	12:10
77315	242500	6596	2	0	0	26	10:40	12:10
77316	242500	6610	2	0	0	26	10:40	12:10
77317	242500	6624	2	0	0	26	10:40	12:10
77318	242500	6638	2	0	0	26	10:40	12:10
77319	242500	6533	3	0	0	26	12:40	14:10
77320	242500	6547	3	0	0	26	12:40	14:10
77321	242500	6561	3	0	0	26	12:40	14:10
77322	242500	6575	3	0	0	26	12:40	14:10
77323	242500	6589	3	0	0	26	12:40	14:10
77324	242500	6603	3	0	0	26	12:40	14:10
77325	242500	6617	3	0	0	26	12:40	14:10
77326	242500	6631	3	0	0	26	12:40	14:10
77327	242500	6540	3	0	0	26	12:40	14:10
77328	242500	6554	3	0	0	26	12:40	14:10
77329	242500	6568	3	0	0	26	12:40	14:10
77330	242500	6582	3	0	0	26	12:40	14:10
77331	242500	6596	3	0	0	26	12:40	14:10
77332	242500	6610	3	0	0	26	12:40	14:10
77333	242500	6624	3	0	0	26	12:40	14:10
77334	242500	6638	3	0	0	26	12:40	14:10
77335	242500	6533	4	0	0	27	14:20	15:50
77336	242500	6547	4	0	0	27	14:20	15:50
77337	242500	6561	4	0	0	27	14:20	15:50
77338	242500	6575	4	0	0	27	14:20	15:50
77339	242500	6589	4	0	0	27	14:20	15:50
77340	242500	6603	4	0	0	27	14:20	15:50
77341	242500	6617	4	0	0	27	14:20	15:50
77342	242500	6631	4	0	0	27	14:20	15:50
77343	242500	6533	5	0	0	27	16:20	17:50
77344	242500	6547	5	0	0	27	16:20	17:50
77345	242500	6561	5	0	0	27	16:20	17:50
77346	242500	6575	5	0	0	27	16:20	17:50
77347	242500	6589	5	0	0	27	16:20	17:50
77348	242500	6603	5	0	0	27	16:20	17:50
77349	242500	6617	5	0	0	27	16:20	17:50
77350	242500	6631	5	0	0	27	16:20	17:50
77351	242500	6533	6	0	1	25	18:00	19:30
77352	242500	6547	6	0	1	25	18:00	19:30
77353	242500	6561	6	0	1	25	18:00	19:30
77354	242500	6575	6	0	1	25	18:00	19:30
77355	242500	6589	6	0	1	25	18:00	19:30
77356	242500	6603	6	0	1	25	18:00	19:30
77357	242500	6617	6	0	1	25	18:00	19:30
77358	242500	6631	6	0	1	25	18:00	19:30
77359	242500	6534	2	0	1	28	10:40	12:10
77360	242500	6541	2	0	1	28	10:40	12:10
77361	242500	6548	2	0	1	28	10:40	12:10
77362	242500	6555	2	0	1	28	10:40	12:10
77363	242500	6562	2	0	1	28	10:40	12:10
77364	242500	6569	2	0	1	28	10:40	12:10
77365	242500	6576	2	0	1	28	10:40	12:10
77366	242500	6583	2	0	1	28	10:40	12:10
77367	242500	6590	2	0	1	28	10:40	12:10
77368	242500	6597	2	0	1	28	10:40	12:10
77369	242500	6604	2	0	1	28	10:40	12:10
77370	242500	6611	2	0	1	28	10:40	12:10
77371	242500	6618	2	0	1	28	10:40	12:10
77372	242500	6625	2	0	1	28	10:40	12:10
77373	242500	6632	2	0	1	28	10:40	12:10
77374	242500	6639	2	0	1	28	10:40	12:10
77375	242500	6534	3	0	0	29	12:40	14:10
77376	242500	6541	3	0	0	29	12:40	14:10
77377	242500	6548	3	0	0	29	12:40	14:10
77378	242500	6555	3	0	0	29	12:40	14:10
77379	242500	6562	3	0	0	29	12:40	14:10
77380	242500	6569	3	0	0	29	12:40	14:10
77381	242500	6576	3	0	0	29	12:40	14:10
77382	242500	6583	3	0	0	29	12:40	14:10
77383	242500	6590	3	0	0	29	12:40	14:10
77384	242500	6597	3	0	0	29	12:40	14:10
77385	242500	6604	3	0	0	29	12:40	14:10
77386	242500	6611	3	0	0	29	12:40	14:10
77387	242500	6618	3	0	0	29	12:40	14:10
77388	242500	6625	3	0	0	29	12:40	14:10
77389	242500	6632	3	0	0	29	12:40	14:10
77390	242500	6639	3	0	0	29	12:40	14:10
77391	242500	6541	4	0	0	28	14:20	15:50
77392	242500	6555	4	0	0	28	14:20	15:50
77393	242500	6569	4	0	0	28	14:20	15:50
77394	242500	6583	4	0	0	28	14:20	15:50
77395	242500	6597	4	0	0	28	14:20	15:50
77396	242500	6611	4	0	0	28	14:20	15:50
77397	242500	6625	4	0	0	28	14:20	15:50
77398	242500	6639	4	0	0	28	14:20	15:50
77399	242500	6535	1	0	1	30	09:00	10:30
77400	242500	6549	1	0	1	30	09:00	10:30
77401	242500	6563	1	0	1	30	09:00	10:30
77402	242500	6577	1	0	1	30	09:00	10:30
77403	242500	6591	1	0	1	30	09:00	10:30
77404	242500	6605	1	0	1	30	09:00	10:30
77405	242500	6619	1	0	1	30	09:00	10:30
77406	242500	6633	1	0	1	30	09:00	10:30
77407	242500	6535	2	0	1	31	10:40	12:10
77408	242500	6542	2	0	1	31	10:40	12:10
77409	242500	6549	2	0	1	31	10:40	12:10
77410	242500	6556	2	0	1	31	10:40	12:10
77411	242500	6563	2	0	1	31	10:40	12:10
77412	242500	6570	2	0	1	31	10:40	12:10
77413	242500	6577	2	0	1	31	10:40	12:10
77414	242500	6584	2	0	1	31	10:40	12:10
77415	242500	6591	2	0	1	31	10:40	12:10
77416	242500	6598	2	0	1	31	10:40	12:10
77417	242500	6605	2	0	1	31	10:40	12:10
77418	242500	6612	2	0	1	31	10:40	12:10
77419	242500	6619	2	0	1	31	10:40	12:10
77420	242500	6626	2	0	1	31	10:40	12:10
77421	242500	6633	2	0	1	31	10:40	12:10
77422	242500	6640	2	0	1	31	10:40	12:10
77423	242500	6535	3	0	0	24	12:40	14:10
77424	242500	6542	3	0	0	24	12:40	14:10
77425	242500	6549	3	0	0	24	12:40	14:10
77426	242500	6556	3	0	0	24	12:40	14:10
77427	242500	6563	3	0	0	24	12:40	14:10
77428	242500	6570	3	0	0	24	12:40	14:10
77429	242500	6577	3	0	0	24	12:40	14:10
77430	242500	6584	3	0	0	24	12:40	14:10
77431	242500	6591	3	0	0	24	12:40	14:10
77432	242500	6598	3	0	0	24	12:40	14:10
77433	242500	6605	3	0	0	24	12:40	14:10
77434	242500	6612	3	0	0	24	12:40	14:10
77435	242500	6619	3	0	0	24	12:40	14:10
77436	242500	6626	3	0	0	24	12:40	14:10
77437	242500	6633	3	0	0	24	12:40	14:10
77438	242500	6640	3	0	0	24	12:40	14:10
77439	242500	6535	4	0	0	25	14:20	15:50
77440	242500	6542	4	0	0	25	14:20	15:50
77441	242500	6549	4	0	0	25	14:20	15:50
77442	242500	6556	4	0	0	25	14:20	15:50
77443	242500	6563	4	0	0	25	14:20	15:50
77444	242500	6570	4	0	0	25	14:20	15:50
77445	242500	6577	4	0	0	25	14:20	15:50
77446	242500	6584	4	0	0	25	14:20	15:50
77447	242500	6591	4	0	0	25	14:20	15:50
77448	242500	6598	4	0	0	25	14:20	15:50
77449	242500	6605	4	0	0	25	14:20	15:50
77450	242500	6612	4	0	0	25	14:20	15:50
77451	242500	6619	4	0	0	25	14:20	15:50
77452	242500	6626	4	0	0	25	14:20	15:50
77453	242500	6633	4	0	0	25	14:20	15:50
77454	242500	6640	4	0	0	25	14:20	15:50
77455	242500	6536	3	0	0	31	12:40	14:10
77456	242500	6543	3	0	0	31	12:40	14:10
77457	242500	6550	3	0	0	31	12:40	14:10
77458	242500	6557	3	0	0	31	12:40	14:10
77459	242500	6564	3	0	0	31	12:40	14:10
77460	242500	6571	3	0	0	31	12:40	14:10
77461	242500	6578	3	0	0	31	12:40	14:10
77462	242500	6585	3	0	0	31	12:40	14:10
77463	242500	6592	3	0	0	31	12:40	14:10
77464	242500	6599	3	0	0	31	12:40	14:10
77465	242500	6606	3	0	0	31	12:40	14:10
77466	242500	6613	3	0	0	31	12:40	14:10
77467	242500	6620	3	0	0	31	12:40	14:10
77468	242500	6627	3	0	0	31	12:40	14:10
77469	242500	6634	3	0	0	31	12:40	14:10
77470	242500	6641	3	0	0	31	12:40	14:10
77471	242500	6536	4	0	0	30	14:20	15:50
77472	242500	6543	4	0	0	30	14:20	15:50
77473	242500	6550	4	0	0	30	14:20	15:50
77474	242500	6557	4	0	0	30	14:20	15:50
77475	242500	6564	4	0	0	30	14:20	15:50
77476	242500	6571	4	0	0	30	14:20	15:50
77477	242500	6578	4	0	0	30	14:20	15:50
77478	242500	6585	4	0	0	30	14:20	15:50
77479	242500	6592	4	0	0	30	14:20	15:50
77480	242500	6599	4	0	0	30	14:20	15:50
77481	242500	6606	4	0	0	30	14:20	15:50
77482	242500	6613	4	0	0	30	14:20	15:50
77483	242500	6620	4	0	0	30	14:20	15:50
77484	242500	6627	4	0	0	30	14:20	15:50
77485	242500	6634	4	0	0	30	14:20	15:50
77486	242500	6641	4	0	0	30	14:20	15:50
77487	242500	6531	1	0	0	33	09:00	10:30
77488	242500	6538	1	0	0	33	09:00	10:30
77489	242500	6545	1	0	0	33	09:00	10:30
77490	242500	6552	1	0	0	33	09:00	10:30
77491	242500	6559	1	0	0	33	09:00	10:30
77492	242500	6566	1	0	0	33	09:00	10:30
77493	242500	6573	1	0	0	33	09:00	10:30
77494	242500	6580	1	0	0	33	09:00	10:30
77495	242500	6587	1	0	0	33	09:00	10:30
77496	242500	6594	1	0	0	33	09:00	10:30
77497	242500	6601	1	0	0	33	09:00	10:30
77498	242500	6608	1	0	0	33	09:00	10:30
77499	242500	6615	1	0	0	33	09:00	10:30
77500	242500	6622	1	0	0	33	09:00	10:30
77501	242500	6629	1	0	0	33	09:00	10:30
77502	242500	6636	1	0	0	33	09:00	10:30
77503	242500	6531	2	0	0	33	10:40	12:10
77504	242500	6538	2	0	0	33	10:40	12:10
77505	242500	6545	2	0	0	33	10:40	12:10
77506	242500	6552	2	0	0	33	10:40	12:10
77507	242500	6559	2	0	0	33	10:40	12:10
77508	242500	6566	2	0	0	33	10:40	12:10
77509	242500	6573	2	0	0	33	10:40	12:10
77510	242500	6580	2	0	0	33	10:40	12:10
77511	242500	6587	2	0	0	33	10:40	12:10
77512	242500	6594	2	0	0	33	10:40	12:10
77513	242500	6601	2	0	0	33	10:40	12:10
77514	242500	6608	2	0	0	33	10:40	12:10
77515	242500	6615	2	0	0	33	10:40	12:10
77516	242500	6622	2	0	0	33	10:40	12:10
77517	242500	6629	2	0	0	33	10:40	12:10
77518	242500	6636	2	0	0	33	10:40	12:10
77519	242500	6531	3	0	0	34	12:40	14:10
77520	242500	6538	3	0	0	34	12:40	14:10
77521	242500	6545	3	0	0	34	12:40	14:10
77522	242500	6552	3	0	0	34	12:40	14:10
77523	242500	6559	3	0	0	34	12:40	14:10
77524	242500	6566	3	0	0	34	12:40	14:10
77525	242500	6573	3	0	0	34	12:40	14:10
77526	242500	6580	3	0	0	34	12:40	14:10
77527	242500	6587	3	0	0	34	12:40	14:10
77528	242500	6594	3	0	0	34	12:40	14:10
77529	242500	6601	3	0	0	34	12:40	14:10
77530	242500	6608	3	0	0	34	12:40	14:10
77531	242500	6615	3	0	0	34	12:40	14:10
77532	242500	6622	3	0	0	34	12:40	14:10
77533	242500	6629	3	0	0	34	12:40	14:10
77534	242500	6636	3	0	0	34	12:40	14:10
77535	242500	6531	4	0	0	35	14:20	15:50
77536	242500	6545	4	0	0	35	14:20	15:50
77537	242500	6559	4	0	0	35	14:20	15:50
77538	242500	6573	4	0	0	35	14:20	15:50
77539	242500	6587	4	0	0	35	14:20	15:50
77540	242500	6601	4	0	0	35	14:20	15:50
77541	242500	6615	4	0	0	35	14:20	15:50
77542	242500	6629	4	0	0	35	14:20	15:50
77543	242500	6538	4	0	0	35	14:20	15:50
77544	242500	6552	4	0	0	35	14:20	15:50
77545	242500	6566	4	0	0	35	14:20	15:50
77546	242500	6580	4	0	0	35	14:20	15:50
77547	242500	6594	4	0	0	35	14:20	15:50
77548	242500	6608	4	0	0	35	14:20	15:50
77549	242500	6622	4	0	0	35	14:20	15:50
77550	242500	6636	4	0	0	35	14:20	15:50
77551	242500	6531	5	0	0	36	16:20	17:50
77552	242500	6545	5	0	0	36	16:20	17:50
77553	242500	6559	5	0	0	36	16:20	17:50
77554	242500	6573	5	0	0	36	16:20	17:50
77555	242500	6587	5	0	0	36	16:20	17:50
77556	242500	6601	5	0	0	36	16:20	17:50
77557	242500	6615	5	0	0	36	16:20	17:50
77558	242500	6629	5	0	0	36	16:20	17:50
77559	242500	6538	5	0	0	36	16:20	17:50
77560	242500	6552	5	0	0	36	16:20	17:50
77561	242500	6566	5	0	0	36	16:20	17:50
77562	242500	6580	5	0	0	36	16:20	17:50
77563	242500	6594	5	0	0	36	16:20	17:50
77564	242500	6608	5	0	0	36	16:20	17:50
77565	242500	6622	5	0	0	36	16:20	17:50
77566	242500	6636	5	0	0	36	16:20	17:50
77567	242500	6532	1	0	0	37	09:00	10:30
77568	242500	6539	1	0	0	37	09:00	10:30
77569	242500	6546	1	0	0	37	09:00	10:30
77570	242500	6553	1	0	0	37	09:00	10:30
77571	242500	6560	1	0	0	37	09:00	10:30
77572	242500	6567	1	0	0	37	09:00	10:30
77573	242500	6574	1	0	0	37	09:00	10:30
77574	242500	6581	1	0	0	37	09:00	10:30
77575	242500	6588	1	0	0	37	09:00	10:30
77576	242500	6595	1	0	0	37	09:00	10:30
77577	242500	6602	1	0	0	37	09:00	10:30
77578	242500	6609	1	0	0	37	09:00	10:30
77579	242500	6616	1	0	0	37	09:00	10:30
77580	242500	6623	1	0	0	37	09:00	10:30
77581	242500	6630	1	0	0	37	09:00	10:30
77582	242500	6637	1	0	0	37	09:00	10:30
77583	242500	6532	2	0	0	37	10:40	12:10
77584	242500	6539	2	0	0	37	10:40	12:10
77585	242500	6546	2	0	0	37	10:40	12:10
77586	242500	6553	2	0	0	37	10:40	12:10
77587	242500	6560	2	0	0	37	10:40	12:10
77588	242500	6567	2	0	0	37	10:40	12:10
77589	242500	6574	2	0	0	37	10:40	12:10
77590	242500	6581	2	0	0	37	10:40	12:10
77591	242500	6588	2	0	0	37	10:40	12:10
77592	242500	6595	2	0	0	37	10:40	12:10
77593	242500	6602	2	0	0	37	10:40	12:10
77594	242500	6609	2	0	0	37	10:40	12:10
77595	242500	6616	2	0	0	37	10:40	12:10
77596	242500	6623	2	0	0	37	10:40	12:10
77597	242500	6630	2	0	0	37	10:40	12:10
77598	242500	6637	2	0	0	37	10:40	12:10
77599	242500	6532	3	0	0	37	12:40	14:10
77600	242500	6539	3	0	0	37	12:40	14:10
77601	242500	6546	3	0	0	37	12:40	14:10
77602	242500	6553	3	0	0	37	12:40	14:10
77603	242500	6560	3	0	0	37	12:40	14:10
77604	242500	6567	3	0	0	37	12:40	14:10
77605	242500	6574	3	0	0	37	12:40	14:10
77606	242500	6581	3	0	0	37	12:40	14:10
77607	242500	6588	3	0	0	37	12:40	14:10
77608	242500	6595	3	0	0	37	12:40	14:10
77609	242500	6602	3	0	0	37	12:40	14:10
77610	242500	6609	3	0	0	37	12:40	14:10
77611	242500	6616	3	0	0	37	12:40	14:10
77612	242500	6623	3	0	0	37	12:40	14:10
77613	242500	6630	3	0	0	37	12:40	14:10
77614	242500	6637	3	0	0	37	12:40	14:10
77615	242500	6532	4	0	0	37	14:20	15:50
77616	242500	6539	4	0	0	37	14:20	15:50
77617	242500	6546	4	0	0	37	14:20	15:50
77618	242500	6553	4	0	0	37	14:20	15:50
77619	242500	6560	4	0	0	37	14:20	15:50
77620	242500	6567	4	0	0	37	14:20	15:50
77621	242500	6574	4	0	0	37	14:20	15:50
77622	242500	6581	4	0	0	37	14:20	15:50
77623	242500	6588	4	0	0	37	14:20	15:50
77624	242500	6595	4	0	0	37	14:20	15:50
77625	242500	6602	4	0	0	37	14:20	15:50
77626	242500	6609	4	0	0	37	14:20	15:50
77627	242500	6616	4	0	0	37	14:20	15:50
77628	242500	6623	4	0	0	37	14:20	15:50
77629	242500	6630	4	0	0	37	14:20	15:50
77630	242500	6637	4	0	0	37	14:20	15:50
77631	242500	6540	2	0	0	38	10:40	12:10
77632	242500	6554	2	0	0	38	10:40	12:10
77633	242500	6568	2	0	0	38	10:40	12:10
77634	242500	6582	2	0	0	38	10:40	12:10
77635	242500	6596	2	0	0	38	10:40	12:10
77636	242500	6610	2	0	0	38	10:40	12:10
77637	242500	6624	2	0	0	38	10:40	12:10
77638	242500	6638	2	0	0	38	10:40	12:10
77639	242500	6533	3	0	0	38	12:40	14:10
77640	242500	6547	3	0	0	38	12:40	14:10
77641	242500	6561	3	0	0	38	12:40	14:10
77642	242500	6575	3	0	0	38	12:40	14:10
77643	242500	6589	3	0	0	38	12:40	14:10
77644	242500	6603	3	0	0	38	12:40	14:10
77645	242500	6617	3	0	0	38	12:40	14:10
77646	242500	6631	3	0	0	38	12:40	14:10
77647	242500	6540	3	0	0	38	12:40	14:10
77648	242500	6554	3	0	0	38	12:40	14:10
77649	242500	6568	3	0	0	38	12:40	14:10
77650	242500	6582	3	0	0	38	12:40	14:10
77651	242500	6596	3	0	0	38	12:40	14:10
77652	242500	6610	3	0	0	38	12:40	14:10
77653	242500	6624	3	0	0	38	12:40	14:10
77654	242500	6638	3	0	0	38	12:40	14:10
77655	242500	6533	4	0	1	39	14:20	15:50
77656	242500	6540	4	0	1	39	14:20	15:50
77657	242500	6547	4	0	1	39	14:20	15:50
77658	242500	6554	4	0	1	39	14:20	15:50
77659	242500	6561	4	0	1	39	14:20	15:50
77660	242500	6568	4	0	1	39	14:20	15:50
77661	242500	6575	4	0	1	39	14:20	15:50
77662	242500	6582	4	0	1	39	14:20	15:50
77663	242500	6589	4	0	1	39	14:20	15:50
77664	242500	6596	4	0	1	39	14:20	15:50
77665	242500	6603	4	0	1	39	14:20	15:50
77666	242500	6610	4	0	1	39	14:20	15:50
77667	242500	6617	4	0	1	39	14:20	15:50
77668	242500	6624	4	0	1	39	14:20	15:50
77669	242500	6631	4	0	1	39	14:20	15:50
77670	242500	6638	4	0	1	39	14:20	15:50
77671	242500	6533	5	0	0	39	16:20	17:50
77672	242500	6540	5	0	0	39	16:20	17:50
77673	242500	6547	5	0	0	39	16:20	17:50
77674	242500	6554	5	0	0	39	16:20	17:50
77675	242500	6561	5	0	0	39	16:20	17:50
77676	242500	6568	5	0	0	39	16:20	17:50
77677	242500	6575	5	0	0	39	16:20	17:50
77678	242500	6582	5	0	0	39	16:20	17:50
77679	242500	6589	5	0	0	39	16:20	17:50
77680	242500	6596	5	0	0	39	16:20	17:50
77681	242500	6603	5	0	0	39	16:20	17:50
77682	242500	6610	5	0	0	39	16:20	17:50
77683	242500	6617	5	0	0	39	16:20	17:50
77684	242500	6624	5	0	0	39	16:20	17:50
77685	242500	6631	5	0	0	39	16:20	17:50
77686	242500	6638	5	0	0	39	16:20	17:50
77687	242500	6533	6	0	0	35	18:00	19:30
77688	242500	6547	6	0	0	35	18:00	19:30
77689	242500	6561	6	0	0	35	18:00	19:30
77690	242500	6575	6	0	0	35	18:00	19:30
77691	242500	6589	6	0	0	35	18:00	19:30
77692	242500	6603	6	0	0	35	18:00	19:30
77693	242500	6617	6	0	0	35	18:00	19:30
77694	242500	6631	6	0	0	35	18:00	19:30
77695	242500	6541	1	0	0	40	09:00	10:30
77696	242500	6555	1	0	0	40	09:00	10:30
77697	242500	6569	1	0	0	40	09:00	10:30
77698	242500	6583	1	0	0	40	09:00	10:30
77699	242500	6597	1	0	0	40	09:00	10:30
77700	242500	6611	1	0	0	40	09:00	10:30
77701	242500	6625	1	0	0	40	09:00	10:30
77702	242500	6639	1	0	0	40	09:00	10:30
77703	242500	6534	2	0	1	40	10:40	12:10
77704	242500	6548	2	0	1	40	10:40	12:10
77705	242500	6562	2	0	1	40	10:40	12:10
77706	242500	6576	2	0	1	40	10:40	12:10
77707	242500	6590	2	0	1	40	10:40	12:10
77708	242500	6604	2	0	1	40	10:40	12:10
77709	242500	6618	2	0	1	40	10:40	12:10
77710	242500	6632	2	0	1	40	10:40	12:10
77711	242500	6541	2	0	0	40	10:40	12:10
77712	242500	6555	2	0	0	40	10:40	12:10
77713	242500	6569	2	0	0	40	10:40	12:10
77714	242500	6583	2	0	0	40	10:40	12:10
77715	242500	6597	2	0	0	40	10:40	12:10
77716	242500	6611	2	0	0	40	10:40	12:10
77717	242500	6625	2	0	0	40	10:40	12:10
77718	242500	6639	2	0	0	40	10:40	12:10
77719	242500	6534	3	0	1	41	12:40	14:10
77720	242500	6541	3	0	1	41	12:40	14:10
77721	242500	6548	3	0	1	41	12:40	14:10
77722	242500	6555	3	0	1	41	12:40	14:10
77723	242500	6562	3	0	1	41	12:40	14:10
77724	242500	6569	3	0	1	41	12:40	14:10
77725	242500	6576	3	0	1	41	12:40	14:10
77726	242500	6583	3	0	1	41	12:40	14:10
77727	242500	6590	3	0	1	41	12:40	14:10
77728	242500	6597	3	0	1	41	12:40	14:10
77729	242500	6604	3	0	1	41	12:40	14:10
77730	242500	6611	3	0	1	41	12:40	14:10
77731	242500	6618	3	0	1	41	12:40	14:10
77732	242500	6625	3	0	1	41	12:40	14:10
77733	242500	6632	3	0	1	41	12:40	14:10
77734	242500	6639	3	0	1	41	12:40	14:10
77735	242500	6534	4	0	0	41	14:20	15:50
77736	242500	6541	4	0	0	41	14:20	15:50
77737	242500	6548	4	0	0	41	14:20	15:50
77738	242500	6555	4	0	0	41	14:20	15:50
77739	242500	6562	4	0	0	41	14:20	15:50
77740	242500	6569	4	0	0	41	14:20	15:50
77741	242500	6576	4	0	0	41	14:20	15:50
77742	242500	6583	4	0	0	41	14:20	15:50
77743	242500	6590	4	0	0	41	14:20	15:50
77744	242500	6597	4	0	0	41	14:20	15:50
77745	242500	6604	4	0	0	41	14:20	15:50
77746	242500	6611	4	0	0	41	14:20	15:50
77747	242500	6618	4	0	0	41	14:20	15:50
77748	242500	6625	4	0	0	41	14:20	15:50
77749	242500	6632	4	0	0	41	14:20	15:50
77750	242500	6639	4	0	0	41	14:20	15:50
77751	242500	6534	5	0	0	40	16:20	17:50
77752	242500	6548	5	0	0	40	16:20	17:50
77753	242500	6562	5	0	0	40	16:20	17:50
77754	242500	6576	5	0	0	40	16:20	17:50
77755	242500	6590	5	0	0	40	16:20	17:50
77756	242500	6604	5	0	0	40	16:20	17:50
77757	242500	6618	5	0	0	40	16:20	17:50
77758	242500	6632	5	0	0	40	16:20	17:50
77759	242500	6535	1	0	0	42	09:00	10:30
77760	242500	6542	1	0	0	42	09:00	10:30
77761	242500	6549	1	0	0	42	09:00	10:30
77762	242500	6556	1	0	0	42	09:00	10:30
77763	242500	6563	1	0	0	42	09:00	10:30
77764	242500	6570	1	0	0	42	09:00	10:30
77765	242500	6577	1	0	0	42	09:00	10:30
77766	242500	6584	1	0	0	42	09:00	10:30
77767	242500	6591	1	0	0	42	09:00	10:30
77768	242500	6598	1	0	0	42	09:00	10:30
77769	242500	6605	1	0	0	42	09:00	10:30
77770	242500	6612	1	0	0	42	09:00	10:30
77771	242500	6619	1	0	0	42	09:00	10:30
77772	242500	6626	1	0	0	42	09:00	10:30
77773	242500	6633	1	0	0	42	09:00	10:30
77774	242500	6640	1	0	0	42	09:00	10:30
77775	242500	6535	2	0	0	42	10:40	12:10
77776	242500	6542	2	0	0	42	10:40	12:10
77777	242500	6549	2	0	0	42	10:40	12:10
77778	242500	6556	2	0	0	42	10:40	12:10
77779	242500	6563	2	0	0	42	10:40	12:10
77780	242500	6570	2	0	0	42	10:40	12:10
77781	242500	6577	2	0	0	42	10:40	12:10
77782	242500	6584	2	0	0	42	10:40	12:10
77783	242500	6591	2	0	0	42	10:40	12:10
77784	242500	6598	2	0	0	42	10:40	12:10
77785	242500	6605	2	0	0	42	10:40	12:10
77786	242500	6612	2	0	0	42	10:40	12:10
77787	242500	6619	2	0	0	42	10:40	12:10
77788	242500	6626	2	0	0	42	10:40	12:10
77789	242500	6633	2	0	0	42	10:40	12:10
77790	242500	6640	2	0	0	42	10:40	12:10
77791	242500	6535	3	0	0	42	12:40	14:10
77792	242500	6542	3	0	0	42	12:40	14:10
77793	242500	6549	3	0	0	42	12:40	14:10
77794	242500	6556	3	0	0	42	12:40	14:10
77795	242500	6563	3	0	0	42	12:40	14:10
77796	242500	6570	3	0	0	42	12:40	14:10
77797	242500	6577	3	0	0	42	12:40	14:10
77798	242500	6584	3	0	0	42	12:40	14:10
77799	242500	6591	3	0	0	42	12:40	14:10
77800	242500	6598	3	0	0	42	12:40	14:10
77801	242500	6605	3	0	0	42	12:40	14:10
77802	242500	6612	3	0	0	42	12:40	14:10
77803	242500	6619	3	0	0	42	12:40	14:10
77804	242500	6626	3	0	0	42	12:40	14:10
77805	242500	6633	3	0	0	42	12:40	14:10
77806	242500	6640	3	0	0	42	12:40	14:10
77807	242500	6535	4	0	0	42	14:20	15:50
77808	242500	6542	4	0	0	42	14:20	15:50
77809	242500	6549	4	0	0	42	14:20	15:50
77810	242500	6556	4	0	0	42	14:20	15:50
77811	242500	6563	4	0	0	42	14:20	15:50
77812	242500	6570	4	0	0	42	14:20	15:50
77813	242500	6577	4	0	0	42	14:20	15:50
77814	242500	6584	4	0	0	42	14:20	15:50
77815	242500	6591	4	0	0	42	14:20	15:50
77816	242500	6598	4	0	0	42	14:20	15:50
77817	242500	6605	4	0	0	42	14:20	15:50
77818	242500	6612	4	0	0	42	14:20	15:50
77819	242500	6619	4	0	0	42	14:20	15:50
77820	242500	6626	4	0	0	42	14:20	15:50
77821	242500	6633	4	0	0	42	14:20	15:50
77822	242500	6640	4	0	0	42	14:20	15:50
77823	242500	6536	3	0	1	43	12:40	14:10
77824	242500	6550	3	0	1	43	12:40	14:10
77825	242500	6564	3	0	1	43	12:40	14:10
77826	242500	6578	3	0	1	43	12:40	14:10
77827	242500	6592	3	0	1	43	12:40	14:10
77828	242500	6606	3	0	1	43	12:40	14:10
77829	242500	6620	3	0	1	43	12:40	14:10
77830	242500	6634	3	0	1	43	12:40	14:10
77831	242500	6543	3	0	1	44	12:40	14:10
77832	242500	6557	3	0	1	44	12:40	14:10
77833	242500	6571	3	0	1	44	12:40	14:10
77834	242500	6585	3	0	1	44	12:40	14:10
77835	242500	6599	3	0	1	44	12:40	14:10
77836	242500	6613	3	0	1	44	12:40	14:10
77837	242500	6627	3	0	1	44	12:40	14:10
77838	242500	6641	3	0	1	44	12:40	14:10
77839	242500	6536	4	0	0	44	14:20	15:50
77840	242500	6550	4	0	0	44	14:20	15:50
77841	242500	6564	4	0	0	44	14:20	15:50
77842	242500	6578	4	0	0	44	14:20	15:50
77843	242500	6592	4	0	0	44	14:20	15:50
77844	242500	6606	4	0	0	44	14:20	15:50
77845	242500	6620	4	0	0	44	14:20	15:50
77846	242500	6634	4	0	0	44	14:20	15:50
77847	242500	6543	4	0	0	45	14:20	15:50
77848	242500	6557	4	0	0	45	14:20	15:50
77849	242500	6571	4	0	0	45	14:20	15:50
77850	242500	6585	4	0	0	45	14:20	15:50
77851	242500	6599	4	0	0	45	14:20	15:50
77852	242500	6613	4	0	0	45	14:20	15:50
77853	242500	6627	4	0	0	45	14:20	15:50
77854	242500	6641	4	0	0	45	14:20	15:50
77855	242500	6531	1	0	0	33	09:00	10:30
77856	242500	6538	1	0	0	33	09:00	10:30
77857	242500	6545	1	0	0	33	09:00	10:30
77858	242500	6552	1	0	0	33	09:00	10:30
77859	242500	6559	1	0	0	33	09:00	10:30
77860	242500	6566	1	0	0	33	09:00	10:30
77861	242500	6573	1	0	0	33	09:00	10:30
77862	242500	6580	1	0	0	33	09:00	10:30
77863	242500	6587	1	0	0	33	09:00	10:30
77864	242500	6594	1	0	0	33	09:00	10:30
77865	242500	6601	1	0	0	33	09:00	10:30
77866	242500	6608	1	0	0	33	09:00	10:30
77867	242500	6615	1	0	0	33	09:00	10:30
77868	242500	6622	1	0	0	33	09:00	10:30
77869	242500	6629	1	0	0	33	09:00	10:30
77870	242500	6636	1	0	0	33	09:00	10:30
77871	242500	6531	2	0	0	33	10:40	12:10
77872	242500	6538	2	0	0	33	10:40	12:10
77873	242500	6545	2	0	0	33	10:40	12:10
77874	242500	6552	2	0	0	33	10:40	12:10
77875	242500	6559	2	0	0	33	10:40	12:10
77876	242500	6566	2	0	0	33	10:40	12:10
77877	242500	6573	2	0	0	33	10:40	12:10
77878	242500	6580	2	0	0	33	10:40	12:10
77879	242500	6587	2	0	0	33	10:40	12:10
77880	242500	6594	2	0	0	33	10:40	12:10
77881	242500	6601	2	0	0	33	10:40	12:10
77882	242500	6608	2	0	0	33	10:40	12:10
77883	242500	6615	2	0	0	33	10:40	12:10
77884	242500	6622	2	0	0	33	10:40	12:10
77885	242500	6629	2	0	0	33	10:40	12:10
77886	242500	6636	2	0	0	33	10:40	12:10
77887	242500	6531	3	0	0	34	12:40	14:10
77888	242500	6538	3	0	0	34	12:40	14:10
77889	242500	6545	3	0	0	34	12:40	14:10
77890	242500	6552	3	0	0	34	12:40	14:10
77891	242500	6559	3	0	0	34	12:40	14:10
77892	242500	6566	3	0	0	34	12:40	14:10
77893	242500	6573	3	0	0	34	12:40	14:10
77894	242500	6580	3	0	0	34	12:40	14:10
77895	242500	6587	3	0	0	34	12:40	14:10
77896	242500	6594	3	0	0	34	12:40	14:10
77897	242500	6601	3	0	0	34	12:40	14:10
77898	242500	6608	3	0	0	34	12:40	14:10
77899	242500	6615	3	0	0	34	12:40	14:10
77900	242500	6622	3	0	0	34	12:40	14:10
77901	242500	6629	3	0	0	34	12:40	14:10
77902	242500	6636	3	0	0	34	12:40	14:10
77903	242500	6531	4	0	0	35	14:20	15:50
77904	242500	6545	4	0	0	35	14:20	15:50
77905	242500	6559	4	0	0	35	14:20	15:50
77906	242500	6573	4	0	0	35	14:20	15:50
77907	242500	6587	4	0	0	35	14:20	15:50
77908	242500	6601	4	0	0	35	14:20	15:50
77909	242500	6615	4	0	0	35	14:20	15:50
77910	242500	6629	4	0	0	35	14:20	15:50
77911	242500	6538	4	0	0	35	14:20	15:50
77912	242500	6552	4	0	0	35	14:20	15:50
77913	242500	6566	4	0	0	35	14:20	15:50
77914	242500	6580	4	0	0	35	14:20	15:50
77915	242500	6594	4	0	0	35	14:20	15:50
77916	242500	6608	4	0	0	35	14:20	15:50
77917	242500	6622	4	0	0	35	14:20	15:50
77918	242500	6636	4	0	0	35	14:20	15:50
77919	242500	6531	5	0	0	36	16:20	17:50
77920	242500	6545	5	0	0	36	16:20	17:50
77921	242500	6559	5	0	0	36	16:20	17:50
77922	242500	6573	5	0	0	36	16:20	17:50
77923	242500	6587	5	0	0	36	16:20	17:50
77924	242500	6601	5	0	0	36	16:20	17:50
77925	242500	6615	5	0	0	36	16:20	17:50
77926	242500	6629	5	0	0	36	16:20	17:50
77927	242500	6538	5	0	0	36	16:20	17:50
77928	242500	6552	5	0	0	36	16:20	17:50
77929	242500	6566	5	0	0	36	16:20	17:50
77930	242500	6580	5	0	0	36	16:20	17:50
77931	242500	6594	5	0	0	36	16:20	17:50
77932	242500	6608	5	0	0	36	16:20	17:50
77933	242500	6622	5	0	0	36	16:20	17:50
77934	242500	6636	5	0	0	36	16:20	17:50
77935	242500	6532	1	0	0	37	09:00	10:30
77936	242500	6539	1	0	0	37	09:00	10:30
77937	242500	6546	1	0	0	37	09:00	10:30
77938	242500	6553	1	0	0	37	09:00	10:30
77939	242500	6560	1	0	0	37	09:00	10:30
77940	242500	6567	1	0	0	37	09:00	10:30
77941	242500	6574	1	0	0	37	09:00	10:30
77942	242500	6581	1	0	0	37	09:00	10:30
77943	242500	6588	1	0	0	37	09:00	10:30
77944	242500	6595	1	0	0	37	09:00	10:30
77945	242500	6602	1	0	0	37	09:00	10:30
77946	242500	6609	1	0	0	37	09:00	10:30
77947	242500	6616	1	0	0	37	09:00	10:30
77948	242500	6623	1	0	0	37	09:00	10:30
77949	242500	6630	1	0	0	37	09:00	10:30
77950	242500	6637	1	0	0	37	09:00	10:30
77951	242500	6532	2	0	0	37	10:40	12:10
77952	242500	6539	2	0	0	37	10:40	12:10
77953	242500	6546	2	0	0	37	10:40	12:10
77954	242500	6553	2	0	0	37	10:40	12:10
77955	242500	6560	2	0	0	37	10:40	12:10
77956	242500	6567	2	0	0	37	10:40	12:10
77957	242500	6574	2	0	0	37	10:40	12:10
77958	242500	6581	2	0	0	37	10:40	12:10
77959	242500	6588	2	0	0	37	10:40	12:10
77960	242500	6595	2	0	0	37	10:40	12:10
77961	242500	6602	2	0	0	37	10:40	12:10
77962	242500	6609	2	0	0	37	10:40	12:10
77963	242500	6616	2	0	0	37	10:40	12:10
77964	242500	6623	2	0	0	37	10:40	12:10
77965	242500	6630	2	0	0	37	10:40	12:10
77966	242500	6637	2	0	0	37	10:40	12:10
77967	242500	6532	3	0	0	37	12:40	14:10
77968	242500	6539	3	0	0	37	12:40	14:10
77969	242500	6546	3	0	0	37	12:40	14:10
77970	242500	6553	3	0	0	37	12:40	14:10
77971	242500	6560	3	0	0	37	12:40	14:10
77972	242500	6567	3	0	0	37	12:40	14:10
77973	242500	6574	3	0	0	37	12:40	14:10
77974	242500	6581	3	0	0	37	12:40	14:10
77975	242500	6588	3	0	0	37	12:40	14:10
77976	242500	6595	3	0	0	37	12:40	14:10
77977	242500	6602	3	0	0	37	12:40	14:10
77978	242500	6609	3	0	0	37	12:40	14:10
77979	242500	6616	3	0	0	37	12:40	14:10
77980	242500	6623	3	0	0	37	12:40	14:10
77981	242500	6630	3	0	0	37	12:40	14:10
77982	242500	6637	3	0	0	37	12:40	14:10
77983	242500	6532	4	0	0	37	14:20	15:50
77984	242500	6539	4	0	0	37	14:20	15:50
77985	242500	6546	4	0	0	37	14:20	15:50
77986	242500	6553	4	0	0	37	14:20	15:50
77987	242500	6560	4	0	0	37	14:20	15:50
77988	242500	6567	4	0	0	37	14:20	15:50
77989	242500	6574	4	0	0	37	14:20	15:50
77990	242500	6581	4	0	0	37	14:20	15:50
77991	242500	6588	4	0	0	37	14:20	15:50
77992	242500	6595	4	0	0	37	14:20	15:50
77993	242500	6602	4	0	0	37	14:20	15:50
77994	242500	6609	4	0	0	37	14:20	15:50
77995	242500	6616	4	0	0	37	14:20	15:50
77996	242500	6623	4	0	0	37	14:20	15:50
77997	242500	6630	4	0	0	37	14:20	15:50
77998	242500	6637	4	0	0	37	14:20	15:50
77999	242500	6540	2	0	0	38	10:40	12:10
78000	242500	6554	2	0	0	38	10:40	12:10
78001	242500	6568	2	0	0	38	10:40	12:10
78002	242500	6582	2	0	0	38	10:40	12:10
78003	242500	6596	2	0	0	38	10:40	12:10
78004	242500	6610	2	0	0	38	10:40	12:10
78005	242500	6624	2	0	0	38	10:40	12:10
78006	242500	6638	2	0	0	38	10:40	12:10
78007	242500	6533	3	0	0	38	12:40	14:10
78008	242500	6547	3	0	0	38	12:40	14:10
78009	242500	6561	3	0	0	38	12:40	14:10
78010	242500	6575	3	0	0	38	12:40	14:10
78011	242500	6589	3	0	0	38	12:40	14:10
78012	242500	6603	3	0	0	38	12:40	14:10
78013	242500	6617	3	0	0	38	12:40	14:10
78014	242500	6631	3	0	0	38	12:40	14:10
78015	242500	6540	3	0	0	38	12:40	14:10
78016	242500	6554	3	0	0	38	12:40	14:10
78017	242500	6568	3	0	0	38	12:40	14:10
78018	242500	6582	3	0	0	38	12:40	14:10
78019	242500	6596	3	0	0	38	12:40	14:10
78020	242500	6610	3	0	0	38	12:40	14:10
78021	242500	6624	3	0	0	38	12:40	14:10
78022	242500	6638	3	0	0	38	12:40	14:10
78023	242500	6533	4	0	1	39	14:20	15:50
78024	242500	6540	4	0	1	39	14:20	15:50
78025	242500	6547	4	0	1	39	14:20	15:50
78026	242500	6554	4	0	1	39	14:20	15:50
78027	242500	6561	4	0	1	39	14:20	15:50
78028	242500	6568	4	0	1	39	14:20	15:50
78029	242500	6575	4	0	1	39	14:20	15:50
78030	242500	6582	4	0	1	39	14:20	15:50
78031	242500	6589	4	0	1	39	14:20	15:50
78032	242500	6596	4	0	1	39	14:20	15:50
78033	242500	6603	4	0	1	39	14:20	15:50
78034	242500	6610	4	0	1	39	14:20	15:50
78035	242500	6617	4	0	1	39	14:20	15:50
78036	242500	6624	4	0	1	39	14:20	15:50
78037	242500	6631	4	0	1	39	14:20	15:50
78038	242500	6638	4	0	1	39	14:20	15:50
78039	242500	6533	5	0	0	39	16:20	17:50
78040	242500	6540	5	0	0	39	16:20	17:50
78041	242500	6547	5	0	0	39	16:20	17:50
78042	242500	6554	5	0	0	39	16:20	17:50
78043	242500	6561	5	0	0	39	16:20	17:50
78044	242500	6568	5	0	0	39	16:20	17:50
78045	242500	6575	5	0	0	39	16:20	17:50
78046	242500	6582	5	0	0	39	16:20	17:50
78047	242500	6589	5	0	0	39	16:20	17:50
78048	242500	6596	5	0	0	39	16:20	17:50
78049	242500	6603	5	0	0	39	16:20	17:50
78050	242500	6610	5	0	0	39	16:20	17:50
78051	242500	6617	5	0	0	39	16:20	17:50
78052	242500	6624	5	0	0	39	16:20	17:50
78053	242500	6631	5	0	0	39	16:20	17:50
78054	242500	6638	5	0	0	39	16:20	17:50
78055	242500	6533	6	0	0	35	18:00	19:30
78056	242500	6547	6	0	0	35	18:00	19:30
78057	242500	6561	6	0	0	35	18:00	19:30
78058	242500	6575	6	0	0	35	18:00	19:30
78059	242500	6589	6	0	0	35	18:00	19:30
78060	242500	6603	6	0	0	35	18:00	19:30
78061	242500	6617	6	0	0	35	18:00	19:30
78062	242500	6631	6	0	0	35	18:00	19:30
78063	242500	6534	1	0	0	40	09:00	10:30
78064	242500	6541	1	0	0	40	09:00	10:30
78065	242500	6548	1	0	0	40	09:00	10:30
78066	242500	6555	1	0	0	40	09:00	10:30
78067	242500	6562	1	0	0	40	09:00	10:30
78068	242500	6569	1	0	0	40	09:00	10:30
78069	242500	6576	1	0	0	40	09:00	10:30
78070	242500	6583	1	0	0	40	09:00	10:30
78071	242500	6590	1	0	0	40	09:00	10:30
78072	242500	6597	1	0	0	40	09:00	10:30
78073	242500	6604	1	0	0	40	09:00	10:30
78074	242500	6611	1	0	0	40	09:00	10:30
78075	242500	6618	1	0	0	40	09:00	10:30
78076	242500	6625	1	0	0	40	09:00	10:30
78077	242500	6632	1	0	0	40	09:00	10:30
78078	242500	6639	1	0	0	40	09:00	10:30
78079	242500	6534	2	0	1	40	10:40	12:10
78080	242500	6548	2	0	1	40	10:40	12:10
78081	242500	6562	2	0	1	40	10:40	12:10
78082	242500	6576	2	0	1	40	10:40	12:10
78083	242500	6590	2	0	1	40	10:40	12:10
78084	242500	6604	2	0	1	40	10:40	12:10
78085	242500	6618	2	0	1	40	10:40	12:10
78086	242500	6632	2	0	1	40	10:40	12:10
78087	242500	6541	2	0	0	40	10:40	12:10
78088	242500	6555	2	0	0	40	10:40	12:10
78089	242500	6569	2	0	0	40	10:40	12:10
78090	242500	6583	2	0	0	40	10:40	12:10
78091	242500	6597	2	0	0	40	10:40	12:10
78092	242500	6611	2	0	0	40	10:40	12:10
78093	242500	6625	2	0	0	40	10:40	12:10
78094	242500	6639	2	0	0	40	10:40	12:10
78095	242500	6534	3	0	1	41	12:40	14:10
78096	242500	6541	3	0	1	41	12:40	14:10
78097	242500	6548	3	0	1	41	12:40	14:10
78098	242500	6555	3	0	1	41	12:40	14:10
78099	242500	6562	3	0	1	41	12:40	14:10
78100	242500	6569	3	0	1	41	12:40	14:10
78101	242500	6576	3	0	1	41	12:40	14:10
78102	242500	6583	3	0	1	41	12:40	14:10
78103	242500	6590	3	0	1	41	12:40	14:10
78104	242500	6597	3	0	1	41	12:40	14:10
78105	242500	6604	3	0	1	41	12:40	14:10
78106	242500	6611	3	0	1	41	12:40	14:10
78107	242500	6618	3	0	1	41	12:40	14:10
78108	242500	6625	3	0	1	41	12:40	14:10
78109	242500	6632	3	0	1	41	12:40	14:10
78110	242500	6639	3	0	1	41	12:40	14:10
78111	242500	6534	4	0	0	41	14:20	15:50
78112	242500	6541	4	0	0	41	14:20	15:50
78113	242500	6548	4	0	0	41	14:20	15:50
78114	242500	6555	4	0	0	41	14:20	15:50
78115	242500	6562	4	0	0	41	14:20	15:50
78116	242500	6569	4	0	0	41	14:20	15:50
78117	242500	6576	4	0	0	41	14:20	15:50
78118	242500	6583	4	0	0	41	14:20	15:50
78119	242500	6590	4	0	0	41	14:20	15:50
78120	242500	6597	4	0	0	41	14:20	15:50
78121	242500	6604	4	0	0	41	14:20	15:50
78122	242500	6611	4	0	0	41	14:20	15:50
78123	242500	6618	4	0	0	41	14:20	15:50
78124	242500	6625	4	0	0	41	14:20	15:50
78125	242500	6632	4	0	0	41	14:20	15:50
78126	242500	6639	4	0	0	41	14:20	15:50
78127	242500	6535	1	0	0	42	09:00	10:30
78128	242500	6542	1	0	0	42	09:00	10:30
78129	242500	6549	1	0	0	42	09:00	10:30
78130	242500	6556	1	0	0	42	09:00	10:30
78131	242500	6563	1	0	0	42	09:00	10:30
78132	242500	6570	1	0	0	42	09:00	10:30
78133	242500	6577	1	0	0	42	09:00	10:30
78134	242500	6584	1	0	0	42	09:00	10:30
78135	242500	6591	1	0	0	42	09:00	10:30
78136	242500	6598	1	0	0	42	09:00	10:30
78137	242500	6605	1	0	0	42	09:00	10:30
78138	242500	6612	1	0	0	42	09:00	10:30
78139	242500	6619	1	0	0	42	09:00	10:30
78140	242500	6626	1	0	0	42	09:00	10:30
78141	242500	6633	1	0	0	42	09:00	10:30
78142	242500	6640	1	0	0	42	09:00	10:30
78143	242500	6535	2	0	0	42	10:40	12:10
78144	242500	6542	2	0	0	42	10:40	12:10
78145	242500	6549	2	0	0	42	10:40	12:10
78146	242500	6556	2	0	0	42	10:40	12:10
78147	242500	6563	2	0	0	42	10:40	12:10
78148	242500	6570	2	0	0	42	10:40	12:10
78149	242500	6577	2	0	0	42	10:40	12:10
78150	242500	6584	2	0	0	42	10:40	12:10
78151	242500	6591	2	0	0	42	10:40	12:10
78152	242500	6598	2	0	0	42	10:40	12:10
78153	242500	6605	2	0	0	42	10:40	12:10
78154	242500	6612	2	0	0	42	10:40	12:10
78155	242500	6619	2	0	0	42	10:40	12:10
78156	242500	6626	2	0	0	42	10:40	12:10
78157	242500	6633	2	0	0	42	10:40	12:10
78158	242500	6640	2	0	0	42	10:40	12:10
78159	242500	6535	3	0	0	42	12:40	14:10
78160	242500	6542	3	0	0	42	12:40	14:10
78161	242500	6549	3	0	0	42	12:40	14:10
78162	242500	6556	3	0	0	42	12:40	14:10
78163	242500	6563	3	0	0	42	12:40	14:10
78164	242500	6570	3	0	0	42	12:40	14:10
78165	242500	6577	3	0	0	42	12:40	14:10
78166	242500	6584	3	0	0	42	12:40	14:10
78167	242500	6591	3	0	0	42	12:40	14:10
78168	242500	6598	3	0	0	42	12:40	14:10
78169	242500	6605	3	0	0	42	12:40	14:10
78170	242500	6612	3	0	0	42	12:40	14:10
78171	242500	6619	3	0	0	42	12:40	14:10
78172	242500	6626	3	0	0	42	12:40	14:10
78173	242500	6633	3	0	0	42	12:40	14:10
78174	242500	6640	3	0	0	42	12:40	14:10
78175	242500	6535	4	0	0	42	14:20	15:50
78176	242500	6542	4	0	0	42	14:20	15:50
78177	242500	6549	4	0	0	42	14:20	15:50
78178	242500	6556	4	0	0	42	14:20	15:50
78179	242500	6563	4	0	0	42	14:20	15:50
78180	242500	6570	4	0	0	42	14:20	15:50
78181	242500	6577	4	0	0	42	14:20	15:50
78182	242500	6584	4	0	0	42	14:20	15:50
78183	242500	6591	4	0	0	42	14:20	15:50
78184	242500	6598	4	0	0	42	14:20	15:50
78185	242500	6605	4	0	0	42	14:20	15:50
78186	242500	6612	4	0	0	42	14:20	15:50
78187	242500	6619	4	0	0	42	14:20	15:50
78188	242500	6626	4	0	0	42	14:20	15:50
78189	242500	6633	4	0	0	42	14:20	15:50
78190	242500	6640	4	0	0	42	14:20	15:50
78191	242500	6536	3	0	1	43	12:40	14:10
78192	242500	6550	3	0	1	43	12:40	14:10
78193	242500	6564	3	0	1	43	12:40	14:10
78194	242500	6578	3	0	1	43	12:40	14:10
78195	242500	6592	3	0	1	43	12:40	14:10
78196	242500	6606	3	0	1	43	12:40	14:10
78197	242500	6620	3	0	1	43	12:40	14:10
78198	242500	6634	3	0	1	43	12:40	14:10
78199	242500	6543	3	0	1	44	12:40	14:10
78200	242500	6557	3	0	1	44	12:40	14:10
78201	242500	6571	3	0	1	44	12:40	14:10
78202	242500	6585	3	0	1	44	12:40	14:10
78203	242500	6599	3	0	1	44	12:40	14:10
78204	242500	6613	3	0	1	44	12:40	14:10
78205	242500	6627	3	0	1	44	12:40	14:10
78206	242500	6641	3	0	1	44	12:40	14:10
78207	242500	6536	4	0	0	44	14:20	15:50
78208	242500	6550	4	0	0	44	14:20	15:50
78209	242500	6564	4	0	0	44	14:20	15:50
78210	242500	6578	4	0	0	44	14:20	15:50
78211	242500	6592	4	0	0	44	14:20	15:50
78212	242500	6606	4	0	0	44	14:20	15:50
78213	242500	6620	4	0	0	44	14:20	15:50
78214	242500	6634	4	0	0	44	14:20	15:50
78215	242500	6543	4	0	0	45	14:20	15:50
78216	242500	6557	4	0	0	45	14:20	15:50
78217	242500	6571	4	0	0	45	14:20	15:50
78218	242500	6585	4	0	0	45	14:20	15:50
78219	242500	6599	4	0	0	45	14:20	15:50
78220	242500	6613	4	0	0	45	14:20	15:50
78221	242500	6627	4	0	0	45	14:20	15:50
78222	242500	6641	4	0	0	45	14:20	15:50
78223	242500	6538	4	0	0	46	14:20	15:50
78224	242500	6552	4	0	0	46	14:20	15:50
78225	242500	6566	4	0	0	46	14:20	15:50
78226	242500	6580	4	0	0	46	14:20	15:50
78227	242500	6594	4	0	0	46	14:20	15:50
78228	242500	6608	4	0	0	46	14:20	15:50
78229	242500	6622	4	0	0	46	14:20	15:50
78230	242500	6636	4	0	0	46	14:20	15:50
78231	242500	6531	5	0	0	47	16:20	17:50
78232	242500	6538	5	0	0	47	16:20	17:50
78233	242500	6545	5	0	0	47	16:20	17:50
78234	242500	6552	5	0	0	47	16:20	17:50
78235	242500	6559	5	0	0	47	16:20	17:50
78236	242500	6566	5	0	0	47	16:20	17:50
78237	242500	6573	5	0	0	47	16:20	17:50
78238	242500	6580	5	0	0	47	16:20	17:50
78239	242500	6587	5	0	0	47	16:20	17:50
78240	242500	6594	5	0	0	47	16:20	17:50
78241	242500	6601	5	0	0	47	16:20	17:50
78242	242500	6608	5	0	0	47	16:20	17:50
78243	242500	6615	5	0	0	47	16:20	17:50
78244	242500	6622	5	0	0	47	16:20	17:50
78245	242500	6629	5	0	0	47	16:20	17:50
78246	242500	6636	5	0	0	47	16:20	17:50
78247	242500	6531	6	0	0	47	18:00	19:30
78248	242500	6545	6	0	0	47	18:00	19:30
78249	242500	6559	6	0	0	47	18:00	19:30
78250	242500	6573	6	0	0	47	18:00	19:30
78251	242500	6587	6	0	0	47	18:00	19:30
78252	242500	6601	6	0	0	47	18:00	19:30
78253	242500	6615	6	0	0	47	18:00	19:30
78254	242500	6629	6	0	0	47	18:00	19:30
78255	242500	6538	6	0	0	8	18:00	19:30
78256	242500	6552	6	0	0	8	18:00	19:30
78257	242500	6566	6	0	0	8	18:00	19:30
78258	242500	6580	6	0	0	8	18:00	19:30
78259	242500	6594	6	0	0	8	18:00	19:30
78260	242500	6608	6	0	0	8	18:00	19:30
78261	242500	6622	6	0	0	8	18:00	19:30
78262	242500	6636	6	0	0	8	18:00	19:30
78263	242500	6538	7	0	0	8	19:40	21:10
78264	242500	6552	7	0	0	8	19:40	21:10
78265	242500	6566	7	0	0	8	19:40	21:10
78266	242500	6580	7	0	0	8	19:40	21:10
78267	242500	6594	7	0	0	8	19:40	21:10
78268	242500	6608	7	0	0	8	19:40	21:10
78269	242500	6622	7	0	0	8	19:40	21:10
78270	242500	6636	7	0	0	8	19:40	21:10
78271	242500	6532	2	0	0	48	10:40	12:10
78272	242500	6546	2	0	0	48	10:40	12:10
78273	242500	6560	2	0	0	48	10:40	12:10
78274	242500	6574	2	0	0	48	10:40	12:10
78275	242500	6588	2	0	0	48	10:40	12:10
78276	242500	6602	2	0	0	48	10:40	12:10
78277	242500	6616	2	0	0	48	10:40	12:10
78278	242500	6630	2	0	0	48	10:40	12:10
78279	242500	6532	3	0	0	48	12:40	14:10
78280	242500	6546	3	0	0	48	12:40	14:10
78281	242500	6560	3	0	0	48	12:40	14:10
78282	242500	6574	3	0	0	48	12:40	14:10
78283	242500	6588	3	0	0	48	12:40	14:10
78284	242500	6602	3	0	0	48	12:40	14:10
78285	242500	6616	3	0	0	48	12:40	14:10
78286	242500	6630	3	0	0	48	12:40	14:10
78287	242500	6533	3	0	0	49	12:40	14:10
78288	242500	6547	3	0	0	49	12:40	14:10
78289	242500	6561	3	0	0	49	12:40	14:10
78290	242500	6575	3	0	0	49	12:40	14:10
78291	242500	6589	3	0	0	49	12:40	14:10
78292	242500	6603	3	0	0	49	12:40	14:10
78293	242500	6617	3	0	0	49	12:40	14:10
78294	242500	6631	3	0	0	49	12:40	14:10
78295	242500	6533	4	0	0	49	14:20	15:50
78296	242500	6547	4	0	0	49	14:20	15:50
78297	242500	6561	4	0	0	49	14:20	15:50
78298	242500	6575	4	0	0	49	14:20	15:50
78299	242500	6589	4	0	0	49	14:20	15:50
78300	242500	6603	4	0	0	49	14:20	15:50
78301	242500	6617	4	0	0	49	14:20	15:50
78302	242500	6631	4	0	0	49	14:20	15:50
78303	242500	6540	4	0	0	50	14:20	15:50
78304	242500	6554	4	0	0	50	14:20	15:50
78305	242500	6568	4	0	0	50	14:20	15:50
78306	242500	6582	4	0	0	50	14:20	15:50
78307	242500	6596	4	0	0	50	14:20	15:50
78308	242500	6610	4	0	0	50	14:20	15:50
78309	242500	6624	4	0	0	50	14:20	15:50
78310	242500	6638	4	0	0	50	14:20	15:50
78311	242500	6533	5	0	0	51	16:20	17:50
78312	242500	6547	5	0	0	51	16:20	17:50
78313	242500	6561	5	0	0	51	16:20	17:50
78314	242500	6575	5	0	0	51	16:20	17:50
78315	242500	6589	5	0	0	51	16:20	17:50
78316	242500	6603	5	0	0	51	16:20	17:50
78317	242500	6617	5	0	0	51	16:20	17:50
78318	242500	6631	5	0	0	51	16:20	17:50
78319	242500	6540	5	0	0	50	16:20	17:50
78320	242500	6554	5	0	0	50	16:20	17:50
78321	242500	6568	5	0	0	50	16:20	17:50
78322	242500	6582	5	0	0	50	16:20	17:50
78323	242500	6596	5	0	0	50	16:20	17:50
78324	242500	6610	5	0	0	50	16:20	17:50
78325	242500	6624	5	0	0	50	16:20	17:50
78326	242500	6638	5	0	0	50	16:20	17:50
78327	242500	6533	6	0	0	46	18:00	19:30
78328	242500	6547	6	0	0	46	18:00	19:30
78329	242500	6561	6	0	0	46	18:00	19:30
78330	242500	6575	6	0	0	46	18:00	19:30
78331	242500	6589	6	0	0	46	18:00	19:30
78332	242500	6603	6	0	0	46	18:00	19:30
78333	242500	6617	6	0	0	46	18:00	19:30
78334	242500	6631	6	0	0	46	18:00	19:30
78335	242500	6540	6	0	0	51	18:00	19:30
78336	242500	6554	6	0	0	51	18:00	19:30
78337	242500	6568	6	0	0	51	18:00	19:30
78338	242500	6582	6	0	0	51	18:00	19:30
78339	242500	6596	6	0	0	51	18:00	19:30
78340	242500	6610	6	0	0	51	18:00	19:30
78341	242500	6624	6	0	0	51	18:00	19:30
78342	242500	6638	6	0	0	51	18:00	19:30
78343	242500	6533	7	0	0	46	19:40	21:10
78344	242500	6547	7	0	0	46	19:40	21:10
78345	242500	6561	7	0	0	46	19:40	21:10
78346	242500	6575	7	0	0	46	19:40	21:10
78347	242500	6589	7	0	0	46	19:40	21:10
78348	242500	6603	7	0	0	46	19:40	21:10
78349	242500	6617	7	0	0	46	19:40	21:10
78350	242500	6631	7	0	0	46	19:40	21:10
78351	242500	6534	1	0	0	42	09:00	10:30
78352	242500	6541	1	0	0	42	09:00	10:30
78353	242500	6548	1	0	0	42	09:00	10:30
78354	242500	6555	1	0	0	42	09:00	10:30
78355	242500	6562	1	0	0	42	09:00	10:30
78356	242500	6569	1	0	0	42	09:00	10:30
78357	242500	6576	1	0	0	42	09:00	10:30
78358	242500	6583	1	0	0	42	09:00	10:30
78359	242500	6590	1	0	0	42	09:00	10:30
78360	242500	6597	1	0	0	42	09:00	10:30
78361	242500	6604	1	0	0	42	09:00	10:30
78362	242500	6611	1	0	0	42	09:00	10:30
78363	242500	6618	1	0	0	42	09:00	10:30
78364	242500	6625	1	0	0	42	09:00	10:30
78365	242500	6632	1	0	0	42	09:00	10:30
78366	242500	6639	1	0	0	42	09:00	10:30
78367	242500	6534	2	0	0	42	10:40	12:10
78368	242500	6541	2	0	0	42	10:40	12:10
78369	242500	6548	2	0	0	42	10:40	12:10
78370	242500	6555	2	0	0	42	10:40	12:10
78371	242500	6562	2	0	0	42	10:40	12:10
78372	242500	6569	2	0	0	42	10:40	12:10
78373	242500	6576	2	0	0	42	10:40	12:10
78374	242500	6583	2	0	0	42	10:40	12:10
78375	242500	6590	2	0	0	42	10:40	12:10
78376	242500	6597	2	0	0	42	10:40	12:10
78377	242500	6604	2	0	0	42	10:40	12:10
78378	242500	6611	2	0	0	42	10:40	12:10
78379	242500	6618	2	0	0	42	10:40	12:10
78380	242500	6625	2	0	0	42	10:40	12:10
78381	242500	6632	2	0	0	42	10:40	12:10
78382	242500	6639	2	0	0	42	10:40	12:10
78383	242500	6534	3	0	0	42	12:40	14:10
78384	242500	6541	3	0	0	42	12:40	14:10
78385	242500	6548	3	0	0	42	12:40	14:10
78386	242500	6555	3	0	0	42	12:40	14:10
78387	242500	6562	3	0	0	42	12:40	14:10
78388	242500	6569	3	0	0	42	12:40	14:10
78389	242500	6576	3	0	0	42	12:40	14:10
78390	242500	6583	3	0	0	42	12:40	14:10
78391	242500	6590	3	0	0	42	12:40	14:10
78392	242500	6597	3	0	0	42	12:40	14:10
78393	242500	6604	3	0	0	42	12:40	14:10
78394	242500	6611	3	0	0	42	12:40	14:10
78395	242500	6618	3	0	0	42	12:40	14:10
78396	242500	6625	3	0	0	42	12:40	14:10
78397	242500	6632	3	0	0	42	12:40	14:10
78398	242500	6639	3	0	0	42	12:40	14:10
78399	242500	6534	4	0	0	42	14:20	15:50
78400	242500	6541	4	0	0	42	14:20	15:50
78401	242500	6548	4	0	0	42	14:20	15:50
78402	242500	6555	4	0	0	42	14:20	15:50
78403	242500	6562	4	0	0	42	14:20	15:50
78404	242500	6569	4	0	0	42	14:20	15:50
78405	242500	6576	4	0	0	42	14:20	15:50
78406	242500	6583	4	0	0	42	14:20	15:50
78407	242500	6590	4	0	0	42	14:20	15:50
78408	242500	6597	4	0	0	42	14:20	15:50
78409	242500	6604	4	0	0	42	14:20	15:50
78410	242500	6611	4	0	0	42	14:20	15:50
78411	242500	6618	4	0	0	42	14:20	15:50
78412	242500	6625	4	0	0	42	14:20	15:50
78413	242500	6632	4	0	0	42	14:20	15:50
78414	242500	6639	4	0	0	42	14:20	15:50
78415	242500	6535	1	0	0	42	09:00	10:30
78416	242500	6542	1	0	0	42	09:00	10:30
78417	242500	6549	1	0	0	42	09:00	10:30
78418	242500	6556	1	0	0	42	09:00	10:30
78419	242500	6563	1	0	0	42	09:00	10:30
78420	242500	6570	1	0	0	42	09:00	10:30
78421	242500	6577	1	0	0	42	09:00	10:30
78422	242500	6584	1	0	0	42	09:00	10:30
78423	242500	6591	1	0	0	42	09:00	10:30
78424	242500	6598	1	0	0	42	09:00	10:30
78425	242500	6605	1	0	0	42	09:00	10:30
78426	242500	6612	1	0	0	42	09:00	10:30
78427	242500	6619	1	0	0	42	09:00	10:30
78428	242500	6626	1	0	0	42	09:00	10:30
78429	242500	6633	1	0	0	42	09:00	10:30
78430	242500	6640	1	0	0	42	09:00	10:30
78431	242500	6535	2	0	0	42	10:40	12:10
78432	242500	6542	2	0	0	42	10:40	12:10
78433	242500	6549	2	0	0	42	10:40	12:10
78434	242500	6556	2	0	0	42	10:40	12:10
78435	242500	6563	2	0	0	42	10:40	12:10
78436	242500	6570	2	0	0	42	10:40	12:10
78437	242500	6577	2	0	0	42	10:40	12:10
78438	242500	6584	2	0	0	42	10:40	12:10
78439	242500	6591	2	0	0	42	10:40	12:10
78440	242500	6598	2	0	0	42	10:40	12:10
78441	242500	6605	2	0	0	42	10:40	12:10
78442	242500	6612	2	0	0	42	10:40	12:10
78443	242500	6619	2	0	0	42	10:40	12:10
78444	242500	6626	2	0	0	42	10:40	12:10
78445	242500	6633	2	0	0	42	10:40	12:10
78446	242500	6640	2	0	0	42	10:40	12:10
78447	242500	6535	3	0	0	42	12:40	14:10
78448	242500	6542	3	0	0	42	12:40	14:10
78449	242500	6549	3	0	0	42	12:40	14:10
78450	242500	6556	3	0	0	42	12:40	14:10
78451	242500	6563	3	0	0	42	12:40	14:10
78452	242500	6570	3	0	0	42	12:40	14:10
78453	242500	6577	3	0	0	42	12:40	14:10
78454	242500	6584	3	0	0	42	12:40	14:10
78455	242500	6591	3	0	0	42	12:40	14:10
78456	242500	6598	3	0	0	42	12:40	14:10
78457	242500	6605	3	0	0	42	12:40	14:10
78458	242500	6612	3	0	0	42	12:40	14:10
78459	242500	6619	3	0	0	42	12:40	14:10
78460	242500	6626	3	0	0	42	12:40	14:10
78461	242500	6633	3	0	0	42	12:40	14:10
78462	242500	6640	3	0	0	42	12:40	14:10
78463	242500	6535	4	0	0	42	14:20	15:50
78464	242500	6542	4	0	0	42	14:20	15:50
78465	242500	6549	4	0	0	42	14:20	15:50
78466	242500	6556	4	0	0	42	14:20	15:50
78467	242500	6563	4	0	0	42	14:20	15:50
78468	242500	6570	4	0	0	42	14:20	15:50
78469	242500	6577	4	0	0	42	14:20	15:50
78470	242500	6584	4	0	0	42	14:20	15:50
78471	242500	6591	4	0	0	42	14:20	15:50
78472	242500	6598	4	0	0	42	14:20	15:50
78473	242500	6605	4	0	0	42	14:20	15:50
78474	242500	6612	4	0	0	42	14:20	15:50
78475	242500	6619	4	0	0	42	14:20	15:50
78476	242500	6626	4	0	0	42	14:20	15:50
78477	242500	6633	4	0	0	42	14:20	15:50
78478	242500	6640	4	0	0	42	14:20	15:50
78479	242500	6531	1	0	0	42	09:00	10:30
78480	242500	6538	1	0	0	42	09:00	10:30
78481	242500	6545	1	0	0	42	09:00	10:30
78482	242500	6552	1	0	0	42	09:00	10:30
78483	242500	6559	1	0	0	42	09:00	10:30
78484	242500	6566	1	0	0	42	09:00	10:30
78485	242500	6573	1	0	0	42	09:00	10:30
78486	242500	6580	1	0	0	42	09:00	10:30
78487	242500	6587	1	0	0	42	09:00	10:30
78488	242500	6594	1	0	0	42	09:00	10:30
78489	242500	6601	1	0	0	42	09:00	10:30
78490	242500	6608	1	0	0	42	09:00	10:30
78491	242500	6615	1	0	0	42	09:00	10:30
78492	242500	6622	1	0	0	42	09:00	10:30
78493	242500	6629	1	0	0	42	09:00	10:30
78494	242500	6636	1	0	0	42	09:00	10:30
78495	242500	6531	2	0	0	42	10:40	12:10
78496	242500	6538	2	0	0	42	10:40	12:10
78497	242500	6545	2	0	0	42	10:40	12:10
78498	242500	6552	2	0	0	42	10:40	12:10
78499	242500	6559	2	0	0	42	10:40	12:10
78500	242500	6566	2	0	0	42	10:40	12:10
78501	242500	6573	2	0	0	42	10:40	12:10
78502	242500	6580	2	0	0	42	10:40	12:10
78503	242500	6587	2	0	0	42	10:40	12:10
78504	242500	6594	2	0	0	42	10:40	12:10
78505	242500	6601	2	0	0	42	10:40	12:10
78506	242500	6608	2	0	0	42	10:40	12:10
78507	242500	6615	2	0	0	42	10:40	12:10
78508	242500	6622	2	0	0	42	10:40	12:10
78509	242500	6629	2	0	0	42	10:40	12:10
78510	242500	6636	2	0	0	42	10:40	12:10
78511	242500	6531	3	0	0	42	12:40	14:10
78512	242500	6538	3	0	0	42	12:40	14:10
78513	242500	6545	3	0	0	42	12:40	14:10
78514	242500	6552	3	0	0	42	12:40	14:10
78515	242500	6559	3	0	0	42	12:40	14:10
78516	242500	6566	3	0	0	42	12:40	14:10
78517	242500	6573	3	0	0	42	12:40	14:10
78518	242500	6580	3	0	0	42	12:40	14:10
78519	242500	6587	3	0	0	42	12:40	14:10
78520	242500	6594	3	0	0	42	12:40	14:10
78521	242500	6601	3	0	0	42	12:40	14:10
78522	242500	6608	3	0	0	42	12:40	14:10
78523	242500	6615	3	0	0	42	12:40	14:10
78524	242500	6622	3	0	0	42	12:40	14:10
78525	242500	6629	3	0	0	42	12:40	14:10
78526	242500	6636	3	0	0	42	12:40	14:10
78527	242500	6531	5	0	0	52	16:20	17:50
78528	242500	6538	5	0	0	52	16:20	17:50
78529	242500	6545	5	0	0	52	16:20	17:50
78530	242500	6552	5	0	0	52	16:20	17:50
78531	242500	6559	5	0	0	52	16:20	17:50
78532	242500	6566	5	0	0	52	16:20	17:50
78533	242500	6573	5	0	0	52	16:20	17:50
78534	242500	6580	5	0	0	52	16:20	17:50
78535	242500	6587	5	0	0	52	16:20	17:50
78536	242500	6594	5	0	0	52	16:20	17:50
78537	242500	6601	5	0	0	52	16:20	17:50
78538	242500	6608	5	0	0	52	16:20	17:50
78539	242500	6615	5	0	0	52	16:20	17:50
78540	242500	6622	5	0	0	52	16:20	17:50
78541	242500	6629	5	0	0	52	16:20	17:50
78542	242500	6636	5	0	0	52	16:20	17:50
78543	242500	6531	6	0	0	53	18:00	19:30
78544	242500	6538	6	0	0	53	18:00	19:30
78545	242500	6545	6	0	0	53	18:00	19:30
78546	242500	6552	6	0	0	53	18:00	19:30
78547	242500	6559	6	0	0	53	18:00	19:30
78548	242500	6566	6	0	0	53	18:00	19:30
78549	242500	6573	6	0	0	53	18:00	19:30
78550	242500	6580	6	0	0	53	18:00	19:30
78551	242500	6587	6	0	0	53	18:00	19:30
78552	242500	6594	6	0	0	53	18:00	19:30
78553	242500	6601	6	0	0	53	18:00	19:30
78554	242500	6608	6	0	0	53	18:00	19:30
78555	242500	6615	6	0	0	53	18:00	19:30
78556	242500	6622	6	0	0	53	18:00	19:30
78557	242500	6629	6	0	0	53	18:00	19:30
78558	242500	6636	6	0	0	53	18:00	19:30
78559	242500	6532	4	0	0	54	14:20	15:50
78560	242500	6539	4	0	0	54	14:20	15:50
78561	242500	6546	4	0	0	54	14:20	15:50
78562	242500	6553	4	0	0	54	14:20	15:50
78563	242500	6560	4	0	0	54	14:20	15:50
78564	242500	6567	4	0	0	54	14:20	15:50
78565	242500	6574	4	0	0	54	14:20	15:50
78566	242500	6581	4	0	0	54	14:20	15:50
78567	242500	6588	4	0	0	54	14:20	15:50
78568	242500	6595	4	0	0	54	14:20	15:50
78569	242500	6602	4	0	0	54	14:20	15:50
78570	242500	6609	4	0	0	54	14:20	15:50
78571	242500	6616	4	0	0	54	14:20	15:50
78572	242500	6623	4	0	0	54	14:20	15:50
78573	242500	6630	4	0	0	54	14:20	15:50
78574	242500	6637	4	0	0	54	14:20	15:50
78575	242500	6539	6	0	0	55	18:00	19:30
78576	242500	6553	6	0	0	55	18:00	19:30
78577	242500	6567	6	0	0	55	18:00	19:30
78578	242500	6581	6	0	0	55	18:00	19:30
78579	242500	6595	6	0	0	55	18:00	19:30
78580	242500	6609	6	0	0	55	18:00	19:30
78581	242500	6623	6	0	0	55	18:00	19:30
78582	242500	6637	6	0	0	55	18:00	19:30
78583	242500	6533	1	0	0	56	09:00	10:30
78584	242500	6547	1	0	0	56	09:00	10:30
78585	242500	6561	1	0	0	56	09:00	10:30
78586	242500	6575	1	0	0	56	09:00	10:30
78587	242500	6589	1	0	0	56	09:00	10:30
78588	242500	6603	1	0	0	56	09:00	10:30
78589	242500	6617	1	0	0	56	09:00	10:30
78590	242500	6631	1	0	0	56	09:00	10:30
78591	242500	6533	2	0	0	56	10:40	12:10
78592	242500	6547	2	0	0	56	10:40	12:10
78593	242500	6561	2	0	0	56	10:40	12:10
78594	242500	6575	2	0	0	56	10:40	12:10
78595	242500	6589	2	0	0	56	10:40	12:10
78596	242500	6603	2	0	0	56	10:40	12:10
78597	242500	6617	2	0	0	56	10:40	12:10
78598	242500	6631	2	0	0	56	10:40	12:10
78599	242500	6533	3	0	0	42	12:40	14:10
78600	242500	6547	3	0	0	42	12:40	14:10
78601	242500	6561	3	0	0	42	12:40	14:10
78602	242500	6575	3	0	0	42	12:40	14:10
78603	242500	6589	3	0	0	42	12:40	14:10
78604	242500	6603	3	0	0	42	12:40	14:10
78605	242500	6617	3	0	0	42	12:40	14:10
78606	242500	6631	3	0	0	42	12:40	14:10
78607	242500	6533	4	0	0	42	14:20	15:50
78608	242500	6547	4	0	0	42	14:20	15:50
78609	242500	6561	4	0	0	42	14:20	15:50
78610	242500	6575	4	0	0	42	14:20	15:50
78611	242500	6589	4	0	0	42	14:20	15:50
78612	242500	6603	4	0	0	42	14:20	15:50
78613	242500	6617	4	0	0	42	14:20	15:50
78614	242500	6631	4	0	0	42	14:20	15:50
78615	242500	6540	4	0	1	57	14:20	15:50
78616	242500	6554	4	0	1	57	14:20	15:50
78617	242500	6568	4	0	1	57	14:20	15:50
78618	242500	6582	4	0	1	57	14:20	15:50
78619	242500	6596	4	0	1	57	14:20	15:50
78620	242500	6610	4	0	1	57	14:20	15:50
78621	242500	6624	4	0	1	57	14:20	15:50
78622	242500	6638	4	0	1	57	14:20	15:50
78623	242500	6533	5	0	0	42	16:20	17:50
78624	242500	6547	5	0	0	42	16:20	17:50
78625	242500	6561	5	0	0	42	16:20	17:50
78626	242500	6575	5	0	0	42	16:20	17:50
78627	242500	6589	5	0	0	42	16:20	17:50
78628	242500	6603	5	0	0	42	16:20	17:50
78629	242500	6617	5	0	0	42	16:20	17:50
78630	242500	6631	5	0	0	42	16:20	17:50
78631	242500	6533	6	0	0	42	18:00	19:30
78632	242500	6547	6	0	0	42	18:00	19:30
78633	242500	6561	6	0	0	42	18:00	19:30
78634	242500	6575	6	0	0	42	18:00	19:30
78635	242500	6589	6	0	0	42	18:00	19:30
78636	242500	6603	6	0	0	42	18:00	19:30
78637	242500	6617	6	0	0	42	18:00	19:30
78638	242500	6631	6	0	0	42	18:00	19:30
78639	242500	6540	6	0	0	58	18:00	19:30
78640	242500	6554	6	0	0	58	18:00	19:30
78641	242500	6568	6	0	0	58	18:00	19:30
78642	242500	6582	6	0	0	58	18:00	19:30
78643	242500	6596	6	0	0	58	18:00	19:30
78644	242500	6610	6	0	0	58	18:00	19:30
78645	242500	6624	6	0	0	58	18:00	19:30
78646	242500	6638	6	0	0	58	18:00	19:30
78647	242500	6534	1	0	1	59	09:00	10:30
78648	242500	6548	1	0	1	59	09:00	10:30
78649	242500	6562	1	0	1	59	09:00	10:30
78650	242500	6576	1	0	1	59	09:00	10:30
78651	242500	6590	1	0	1	59	09:00	10:30
78652	242500	6604	1	0	1	59	09:00	10:30
78653	242500	6618	1	0	1	59	09:00	10:30
78654	242500	6632	1	0	1	59	09:00	10:30
78655	242500	6541	1	0	1	60	09:00	10:30
78656	242500	6555	1	0	1	60	09:00	10:30
78657	242500	6569	1	0	1	60	09:00	10:30
78658	242500	6583	1	0	1	60	09:00	10:30
78659	242500	6597	1	0	1	60	09:00	10:30
78660	242500	6611	1	0	1	60	09:00	10:30
78661	242500	6625	1	0	1	60	09:00	10:30
78662	242500	6639	1	0	1	60	09:00	10:30
78663	242500	6541	6	0	0	60	18:00	19:30
78664	242500	6569	6	0	0	60	18:00	19:30
78665	242500	6597	6	0	0	60	18:00	19:30
78666	242500	6625	6	0	0	60	18:00	19:30
78667	242500	6541	7	0	0	60	19:40	21:10
78668	242500	6569	7	0	0	60	19:40	21:10
78669	242500	6597	7	0	0	60	19:40	21:10
78670	242500	6625	7	0	0	60	19:40	21:10
78671	242500	6556	6	0	0	61	18:00	19:30
78672	242500	6584	6	0	0	61	18:00	19:30
78673	242500	6612	6	0	0	61	18:00	19:30
78674	242500	6640	6	0	0	61	18:00	19:30
78675	242500	6556	7	0	0	61	19:40	21:10
78676	242500	6584	7	0	0	61	19:40	21:10
78677	242500	6612	7	0	0	61	19:40	21:10
78678	242500	6640	7	0	0	61	19:40	21:10
78679	242500	6536	5	0	1	62	16:20	17:50
78680	242500	6550	5	0	1	62	16:20	17:50
78681	242500	6564	5	0	1	62	16:20	17:50
78682	242500	6578	5	0	1	62	16:20	17:50
78683	242500	6592	5	0	1	62	16:20	17:50
78684	242500	6606	5	0	1	62	16:20	17:50
78685	242500	6620	5	0	1	62	16:20	17:50
78686	242500	6634	5	0	1	62	16:20	17:50
78687	242500	6644	2	0	12	7	10:40	12:10
78688	242500	6644	4	0	12	63	14:20	15:50
78689	242500	6645	3	0	12	8	12:40	14:10
78690	242500	6645	5	0	12	0	16:20	17:50
78691	242500	6646	1	0	12	3	09:00	10:30
78692	242500	6646	3	0	12	9	12:40	14:10
78693	242500	6647	6	0	12	5	18:00	19:30
78694	242500	6648	2	0	12	10	10:40	12:10
78695	242500	6666	1	0	10	6	09:00	10:30
78696	242500	6668	1	0	11	6	09:00	10:30
78697	242500	6671	3	0	10	64	12:40	14:10
78698	242500	6673	1	0	11	64	09:00	10:30
78699	242500	6674	3	0	10	2	12:40	14:10
78700	242500	6676	1	0	11	2	09:00	10:30
78701	242500	6678	1	0	10	13	09:00	10:30
78702	242500	6679	1	0	11	13	09:00	10:30
78703	242500	6644	2	0	12	63	10:40	12:10
78704	242500	6644	4	0	12	9	14:20	15:50
78705	242500	6645	4	0	12	7	14:20	15:50
78706	242500	6645	6	0	12	10	18:00	19:30
78707	242500	6646	2	0	12	3	12:00	13:30
78708	242500	6647	1	0	12	0	09:00	10:30
78709	242500	6647	6	0	12	5	18:00	19:30
78710	242500	6660	1	0	12	8	09:00	10:30
78711	242500	6666	1	0	10	6	09:00	10:30
78712	242500	6668	2	0	11	6	10:40	12:10
78713	242500	6671	3	0	10	64	12:40	14:10
78714	242500	6673	1	0	11	64	09:00	10:30
78715	242500	6674	3	0	10	2	12:40	14:10
78716	242500	6676	1	0	11	2	09:00	10:30
78717	242500	6678	1	0	10	13	09:00	10:30
78718	242500	6679	1	0	11	13	09:00	10:30
78719	242500	6644	5	0	12	63	16:20	17:50
78720	242500	6645	2	0	12	7	10:40	12:10
78721	242500	6645	4	0	12	9	14:20	15:50
78722	242500	6647	3	0	12	0	12:40	14:10
78723	242500	6647	6	0	12	5	18:00	19:30
78724	242500	6648	2	0	12	3	12:00	13:30
78725	242500	6648	5	0	12	10	16:20	17:50
78726	242500	6660	3	0	12	8	12:40	14:10
78727	242500	6666	1	0	10	6	09:00	10:30
78728	242500	6668	3	0	11	6	12:40	14:10
78729	242500	6671	3	0	10	64	12:40	14:10
78730	242500	6673	1	0	11	64	09:00	10:30
78731	242500	6674	3	0	10	2	12:40	14:10
78732	242500	6676	1	0	11	2	09:00	10:30
78733	242500	6678	1	0	10	13	09:00	10:30
78734	242500	6679	1	0	11	13	09:00	10:30
78735	242500	6644	1	0	12	9	09:00	10:30
78736	242500	6644	3	0	12	63	12:40	14:10
78737	242500	6645	2	0	12	7	10:40	12:10
78738	242500	6647	1	0	12	0	09:00	10:30
78739	242500	6647	3	0	12	8	12:40	14:10
78740	242500	6647	6	0	12	5	18:00	19:30
78741	242500	6648	1	0	12	3	09:00	10:30
78742	242500	6648	3	0	12	10	13:20	14:50
78743	242500	6666	1	0	10	6	09:00	10:30
78744	242500	6668	4	0	11	6	14:20	15:50
78745	242500	6671	3	0	10	64	12:40	14:10
78746	242500	6673	1	0	11	64	09:00	10:30
78747	242500	6674	3	0	10	2	12:40	14:10
78748	242500	6676	1	0	11	2	09:00	10:30
78749	242500	6678	1	0	10	13	09:00	10:30
78750	242500	6679	1	0	11	13	09:00	10:30
78751	242500	6644	5	0	12	9	16:20	17:50
78752	242500	6644	2	0	12	18	12:00	13:30
78753	242500	6645	2	0	12	8	10:40	12:10
78754	242500	6646	1	0	12	13	09:00	10:30
78755	242500	6646	4	0	12	16	15:00	16:30
78756	242500	6660	2	0	14	16	10:40	12:10
78757	242500	6661	1	0	10	7	09:00	10:30
78758	242500	6662	3	0	11	7	12:40	14:10
78759	242500	6664	4	0	10	14	14:20	15:50
78760	242500	6666	3	0	11	14	12:40	14:10
78761	242500	6669	1	0	10	64	09:00	10:30
78762	242500	6671	3	0	11	64	12:40	14:10
78763	242500	6674	1	0	12	17	09:00	10:30
78764	242500	6678	2	0	10	2	10:40	12:10
78765	242500	6679	3	0	11	2	12:40	14:10
78766	242500	6680	4	0	10	15	14:20	15:50
78767	242500	6682	3	0	11	15	12:40	14:10
78768	242500	6644	1	0	12	13	09:00	10:30
78769	242500	6644	1	0	12	18	09:00	10:30
78770	242500	6645	4	0	12	16	14:20	15:50
78771	242500	6646	4	0	12	8	14:20	15:50
78772	242500	6660	2	0	14	16	10:40	12:10
78773	242500	6660	5	0	12	9	16:20	17:50
78774	242500	6661	1	0	10	7	09:00	10:30
78775	242500	6662	3	0	11	7	12:40	14:10
78776	242500	6664	4	0	10	14	14:20	15:50
78777	242500	6666	3	0	11	14	12:40	14:10
78778	242500	6669	1	0	10	64	09:00	10:30
78779	242500	6671	3	0	11	64	12:40	14:10
78780	242500	6674	2	0	12	17	10:40	12:10
78781	242500	6678	2	0	10	2	10:40	12:10
78782	242500	6679	3	0	11	2	12:40	14:10
78783	242500	6680	4	0	10	15	14:20	15:50
78784	242500	6682	3	0	11	15	12:40	14:10
78785	242500	6644	4	0	12	27	14:20	15:50
78786	242500	6645	2	0	12	26	11:30	13:00
78787	242500	6645	6	0	12	23	18:00	19:30
78788	242500	6646	2	0	12	65	10:40	12:10
78789	242500	6646	3	0	14	66	12:40	14:10
78790	242500	6661	6	0	10	25	18:00	19:30
78791	242500	6665	2	0	11	25	10:40	12:10
78792	242500	6667	4	0	10	67	14:20	15:50
78793	242500	6668	4	0	11	67	14:20	15:50
78794	242500	6671	3	0	10	31	12:40	14:10
78795	242500	6673	2	0	11	31	10:40	12:10
78796	242500	6675	2	0	10	24	10:40	12:10
78797	242500	6676	1	0	11	24	09:00	10:30
78798	242500	6680	2	0	11	30	10:40	12:10
78799	242500	6682	3	0	11	30	12:40	14:10
78800	242500	6644	5	0	12	27	16:20	17:50
78801	242500	6645	2	0	12	26	11:30	13:00
78802	242500	6645	6	0	12	23	18:00	19:30
78803	242500	6646	4	0	12	65	14:20	15:50
78804	242500	6646	5	0	14	66	16:20	17:50
78805	242500	6661	6	0	10	25	18:00	19:30
78806	242500	6665	4	0	11	25	14:20	15:50
78807	242500	6667	4	0	10	67	14:20	15:50
78808	242500	6668	4	0	11	67	14:20	15:50
78809	242500	6671	3	0	10	31	12:40	14:10
78810	242500	6673	3	0	11	31	12:40	14:10
78811	242500	6675	2	0	10	24	10:40	12:10
78812	242500	6676	1	0	11	24	09:00	10:30
78813	242500	6680	2	0	11	30	10:40	12:10
78814	242500	6681	1	0	11	30	09:00	10:30
78815	242500	6644	1	0	-1	68	09:00	15:50
78816	242500	6645	1	0	12	33	09:00	10:30
78817	242500	6646	1	0	12	69	09:00	10:30
78818	242500	6646	3	0	12	70	12:40	14:10
78819	242500	6647	1	0	12	71	09:00	10:30
78820	242500	6648	4	0	13	42	14:20	15:50
78821	242500	6660	2	0	12	43	10:40	12:10
78822	242500	6660	4	0	15	72	14:20	15:50
78823	242500	6661	4	0	10	72	14:20	15:50
78824	242500	6664	3	0	11	72	12:40	14:10
78825	242500	6667	1	0	10	41	09:00	10:30
78826	242500	6669	1	0	11	41	09:00	10:30
78827	242500	6671	2	0	10	27	10:40	12:10
78828	242500	6672	2	0	11	27	10:40	12:10
78829	242500	6674	2	0	10	34	10:40	12:10
78830	242500	6675	2	0	11	34	10:40	12:10
78831	242500	6678	3	0	10	40	12:40	14:10
78832	242500	6680	2	0	11	40	10:40	12:10
78833	242500	6644	1	0	-1	68	09:00	15:50
78834	242500	6645	1	0	12	33	09:00	10:30
78835	242500	6646	2	0	12	69	10:40	12:10
78836	242500	6646	4	0	12	70	14:20	15:50
78837	242500	6647	2	0	12	71	10:40	12:10
78838	242500	6648	4	0	13	42	15:00	16:30
78839	242500	6660	2	0	12	43	10:40	12:10
78840	242500	6660	5	0	15	72	16:20	17:50
78841	242500	6661	4	0	10	72	14:20	15:50
78842	242500	6664	4	0	11	72	14:20	15:50
78843	242500	6667	1	0	10	41	09:00	10:30
78844	242500	6669	1	0	11	41	09:00	10:30
78845	242500	6671	2	0	10	27	10:40	12:10
78846	242500	6672	3	0	11	27	12:40	14:10
78847	242500	6674	2	0	10	34	10:40	12:10
78848	242500	6675	3	0	11	34	12:40	14:10
78849	242500	6678	3	0	10	40	12:40	14:10
78850	242500	6680	2	0	11	40	10:40	12:10
78851	242500	6660	6	0	10	49	18:00	19:30
78852	242500	6661	6	0	11	49	18:00	19:30
78853	242500	6664	2	0	10	73	10:40	12:10
78854	242500	6666	3	0	11	73	12:40	14:10
78855	242500	6668	6	0	12	47	18:00	19:30
78856	242500	6669	3	0	12	8	12:40	14:10
78857	242500	6671	6	0	10	74	18:00	19:30
78858	242500	6672	6	0	11	74	18:00	19:30
78859	242500	6674	5	0	12	75	16:20	17:50
78860	242500	6679	6	0	10	76	18:00	19:30
78861	242500	6681	6	0	11	76	18:00	19:30
78862	242500	6682	5	0	13	77	16:20	17:50
78863	242500	6682	5	0	13	78	16:20	17:50
78864	242500	6660	1	0	12	79	09:00	10:30
78865	242500	6660	3	0	12	80	12:40	14:10
78866	242500	6661	6	0	10	81	18:00	19:30
78867	242500	6664	6	0	11	81	18:00	19:30
78868	242500	6666	1	0	12	82	09:00	10:30
78869	242500	6667	6	0	14	83	18:00	19:30
78870	242500	6672	6	0	12	84	18:00	19:30
78871	242500	6673	6	0	10	57	18:00	19:30
78872	242500	6675	6	0	11	57	18:00	19:30
78873	242500	6678	6	0	12	60	18:00	19:30
78874	242500	6679	5	0	10	85	16:20	17:50
78875	242500	6680	5	0	11	85	16:20	17:50
78876	242500	6682	3	0	13	86	12:40	14:10
78877	242500	6682	4	0	13	87	14:20	15:50
\.


--
-- TOC entry 3493 (class 0 OID 16411)
-- Dependencies: 223
-- Data for Name: sc_rasp18_days; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18_days (id, semcode, day, weekday, week) FROM stdin;
6531	242500	2024-09-02	1	1
6532	242500	2024-09-03	2	1
6533	242500	2024-09-04	3	1
6534	242500	2024-09-05	4	1
6535	242500	2024-09-06	5	1
6536	242500	2024-09-07	6	1
6537	242500	2024-09-08	0	1
6538	242500	2024-09-09	1	2
6539	242500	2024-09-10	2	2
6540	242500	2024-09-11	3	2
6541	242500	2024-09-12	4	2
6542	242500	2024-09-13	5	2
6543	242500	2024-09-14	6	2
6544	242500	2024-09-15	0	2
6545	242500	2024-09-16	1	3
6546	242500	2024-09-17	2	3
6547	242500	2024-09-18	3	3
6548	242500	2024-09-19	4	3
6549	242500	2024-09-20	5	3
6550	242500	2024-09-21	6	3
6551	242500	2024-09-22	0	3
6552	242500	2024-09-23	1	4
6553	242500	2024-09-24	2	4
6554	242500	2024-09-25	3	4
6555	242500	2024-09-26	4	4
6556	242500	2024-09-27	5	4
6557	242500	2024-09-28	6	4
6558	242500	2024-09-29	0	4
6559	242500	2024-09-30	1	5
6560	242500	2024-10-01	2	5
6561	242500	2024-10-02	3	5
6562	242500	2024-10-03	4	5
6563	242500	2024-10-04	5	5
6564	242500	2024-10-05	6	5
6565	242500	2024-10-06	0	5
6566	242500	2024-10-07	1	6
6567	242500	2024-10-08	2	6
6568	242500	2024-10-09	3	6
6569	242500	2024-10-10	4	6
6570	242500	2024-10-11	5	6
6571	242500	2024-10-12	6	6
6572	242500	2024-10-13	0	6
6573	242500	2024-10-14	1	7
6574	242500	2024-10-15	2	7
6575	242500	2024-10-16	3	7
6576	242500	2024-10-17	4	7
6577	242500	2024-10-18	5	7
6578	242500	2024-10-19	6	7
6579	242500	2024-10-20	0	7
6580	242500	2024-10-21	1	8
6581	242500	2024-10-22	2	8
6582	242500	2024-10-23	3	8
6583	242500	2024-10-24	4	8
6584	242500	2024-10-25	5	8
6585	242500	2024-10-26	6	8
6586	242500	2024-10-27	0	8
6587	242500	2024-10-28	1	9
6588	242500	2024-10-29	2	9
6589	242500	2024-10-30	3	9
6590	242500	2024-10-31	4	9
6591	242500	2024-11-01	5	9
6592	242500	2024-11-02	6	9
6593	242500	2024-11-03	0	9
6594	242500	2024-11-04	1	10
6595	242500	2024-11-05	2	10
6596	242500	2024-11-06	3	10
6597	242500	2024-11-07	4	10
6598	242500	2024-11-08	5	10
6599	242500	2024-11-09	6	10
6600	242500	2024-11-10	0	10
6601	242500	2024-11-11	1	11
6602	242500	2024-11-12	2	11
6603	242500	2024-11-13	3	11
6604	242500	2024-11-14	4	11
6605	242500	2024-11-15	5	11
6606	242500	2024-11-16	6	11
6607	242500	2024-11-17	0	11
6608	242500	2024-11-18	1	12
6609	242500	2024-11-19	2	12
6610	242500	2024-11-20	3	12
6611	242500	2024-11-21	4	12
6612	242500	2024-11-22	5	12
6613	242500	2024-11-23	6	12
6614	242500	2024-11-24	0	12
6615	242500	2024-11-25	1	13
6616	242500	2024-11-26	2	13
6617	242500	2024-11-27	3	13
6618	242500	2024-11-28	4	13
6619	242500	2024-11-29	5	13
6620	242500	2024-11-30	6	13
6621	242500	2024-12-01	0	13
6622	242500	2024-12-02	1	14
6623	242500	2024-12-03	2	14
6624	242500	2024-12-04	3	14
6625	242500	2024-12-05	4	14
6626	242500	2024-12-06	5	14
6627	242500	2024-12-07	6	14
6628	242500	2024-12-08	0	14
6629	242500	2024-12-09	1	15
6630	242500	2024-12-10	2	15
6631	242500	2024-12-11	3	15
6632	242500	2024-12-12	4	15
6633	242500	2024-12-13	5	15
6634	242500	2024-12-14	6	15
6635	242500	2024-12-15	0	15
6636	242500	2024-12-16	1	16
6637	242500	2024-12-17	2	16
6638	242500	2024-12-18	3	16
6639	242500	2024-12-19	4	16
6640	242500	2024-12-20	5	16
6641	242500	2024-12-21	6	16
6642	242500	2024-12-22	0	16
6643	242500	2024-12-23	1	17
6644	242500	2024-12-24	2	17
6645	242500	2024-12-25	3	17
6646	242500	2024-12-26	4	17
6647	242500	2024-12-27	5	17
6648	242500	2024-12-28	6	17
6649	242500	2024-12-29	0	17
6650	242500	2024-12-30	1	18
6651	242500	2024-12-31	2	18
6652	242500	2025-01-01	3	18
6653	242500	2025-01-02	4	18
6654	242500	2025-01-03	5	18
6655	242500	2025-01-04	6	18
6656	242500	2025-01-05	0	18
6657	242500	2025-01-06	1	19
6658	242500	2025-01-07	2	19
6659	242500	2025-01-08	3	19
6660	242500	2025-01-09	4	19
6661	242500	2025-01-10	5	19
6662	242500	2025-01-11	6	19
6663	242500	2025-01-12	0	19
6664	242500	2025-01-13	1	20
6665	242500	2025-01-14	2	20
6666	242500	2025-01-15	3	20
6667	242500	2025-01-16	4	20
6668	242500	2025-01-17	5	20
6669	242500	2025-01-18	6	20
6670	242500	2025-01-19	0	20
6671	242500	2025-01-20	1	21
6672	242500	2025-01-21	2	21
6673	242500	2025-01-22	3	21
6674	242500	2025-01-23	4	21
6675	242500	2025-01-24	5	21
6676	242500	2025-01-25	6	21
6677	242500	2025-01-26	0	21
6678	242500	2025-01-27	1	22
6679	242500	2025-01-28	2	22
6680	242500	2025-01-29	3	22
6681	242500	2025-01-30	4	22
6682	242500	2025-01-31	5	22
6683	242500	2025-02-01	6	22
\.


--
-- TOC entry 3495 (class 0 OID 16415)
-- Dependencies: 225
-- Data for Name: sc_rasp18_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18_groups (id, rasp18_id, group_id, subgroup) FROM stdin;
385235	76729	4	0
385363	76857	5	0
385364	76858	5	0
385365	76859	5	0
385366	76860	5	0
385367	76861	5	0
385368	76862	5	0
385369	76863	5	0
385370	76864	5	0
385371	76865	5	0
385372	76866	5	0
385373	76867	5	0
385374	76868	5	0
385375	76869	5	0
385376	76870	5	0
385377	76871	5	0
385378	76872	5	0
385379	76873	5	0
385380	76874	5	0
385381	76875	5	0
385382	76876	5	0
385383	76877	5	0
385384	76878	5	0
385385	76879	5	0
385386	76880	5	0
385387	76881	5	0
385388	76882	5	0
385389	76883	5	0
385390	76884	5	0
385391	76885	5	0
385392	76886	5	0
385393	76887	5	0
385394	76888	5	0
385395	76889	5	0
385396	76890	5	0
385397	76891	5	0
385398	76892	5	0
385399	76893	5	0
385400	76894	5	0
385401	76895	5	0
385402	76896	5	0
385403	76897	5	0
385404	76898	5	0
385405	76899	5	0
385406	76900	5	0
385407	76901	5	0
385408	76902	5	0
385409	76903	5	0
385410	76904	5	0
385411	76905	5	0
385412	76906	5	0
385413	76907	5	0
385414	76908	5	0
385415	76909	5	0
385416	76910	5	0
385417	76911	5	0
385418	76912	5	0
385419	76913	5	0
385420	76914	5	0
385421	76915	5	0
385422	76916	5	0
385423	76917	5	0
385424	76918	5	0
385425	76919	5	0
385426	76920	5	0
385427	76921	5	0
385428	76922	5	0
385429	76923	5	0
385430	76924	5	0
385431	76925	5	0
385432	76926	5	0
385433	76927	5	0
385434	76928	5	0
385435	76929	5	0
385436	76930	5	0
385437	76931	5	0
385438	76932	5	0
385439	76933	5	0
385440	76934	5	0
385441	76935	5	0
385442	76936	5	0
385443	76937	5	0
385444	76938	5	0
385445	76939	5	0
385446	76940	5	0
385447	76941	5	0
385448	76942	5	0
385449	76943	5	0
385450	76944	5	0
385451	76945	5	0
385452	76946	5	0
385453	76947	5	0
385454	76948	5	0
385455	76949	5	0
385456	76950	5	0
385457	76951	5	0
385458	76952	5	0
385459	76953	5	0
385460	76954	5	0
385461	76955	5	0
385462	76956	5	0
385463	76957	5	0
385464	76958	5	0
385465	76959	5	0
385466	76960	5	0
385467	76961	5	0
385468	76962	5	0
385469	76963	5	0
385470	76964	5	0
385471	76965	5	0
385472	76966	5	0
385473	76967	5	2
385474	76968	5	2
385475	76969	5	2
385476	76970	5	2
385477	76971	5	2
385478	76972	5	2
385479	76973	5	2
385480	76974	5	2
385481	76975	5	2
385482	76976	5	2
385483	76977	5	2
385484	76978	5	2
385485	76979	5	2
385486	76980	5	2
385487	76981	5	2
385488	76982	5	2
385489	76983	5	0
385490	76984	5	0
385491	76985	5	0
385492	76986	5	0
385493	76987	5	0
385494	76988	5	0
385495	76989	5	0
385496	76990	5	0
385497	76991	5	0
385498	76992	5	0
385499	76993	5	0
385500	76994	5	0
385501	76995	5	0
385502	76996	5	0
385503	76997	5	0
385504	76998	5	0
385505	76999	5	0
385506	77000	5	0
385507	77001	5	0
385508	77002	5	0
385509	77003	5	0
385510	77004	5	0
385511	77005	5	0
385512	77006	5	0
385513	77007	5	0
385514	77008	5	0
385515	77009	5	0
385516	77010	5	0
385517	77011	5	0
385518	77012	5	0
385519	77013	5	0
385520	77014	5	0
385521	77015	5	0
385522	77016	5	0
385523	77017	5	0
385524	77018	5	0
385525	77019	5	0
385526	77020	5	0
385527	77021	5	0
385528	77022	5	0
385529	77023	5	1
385530	77024	5	1
385531	77025	5	1
385532	77026	5	1
385533	77027	5	1
385534	77028	5	1
385535	77029	5	1
385536	77030	5	1
385537	77031	5	1
385538	77032	5	1
385539	77033	5	1
385540	77034	5	1
385541	77035	5	1
385542	77036	5	1
385543	77037	5	1
385544	77038	5	1
385545	77039	5	0
385546	77040	5	0
383697	75191	0	0
383698	75192	0	0
383699	75193	0	0
383700	75194	0	0
383701	75195	0	0
383702	75196	0	0
383703	75197	0	0
383704	75198	0	0
383705	75199	0	0
383706	75200	0	0
383707	75201	0	0
383708	75202	0	0
383709	75203	0	0
383710	75204	0	0
383711	75205	0	0
383712	75206	0	0
383713	75207	0	0
383714	75208	0	0
383715	75209	0	0
383716	75210	0	0
383717	75211	0	0
383718	75212	0	0
383719	75213	0	0
383720	75214	0	0
383721	75215	0	0
383722	75216	0	0
383723	75217	0	0
383724	75218	0	0
383725	75219	0	0
383726	75220	0	0
383727	75221	0	0
383728	75222	0	0
383729	75223	0	0
383730	75224	0	0
383731	75225	0	0
383732	75226	0	0
383733	75227	0	0
383734	75228	0	0
383735	75229	0	0
383736	75230	0	0
383737	75231	0	0
383738	75232	0	0
383739	75233	0	0
383740	75234	0	0
383741	75235	0	0
383742	75236	0	0
383743	75237	0	0
383744	75238	0	0
383745	75239	0	1
383746	75240	0	1
383747	75241	0	1
383748	75242	0	1
383749	75243	0	1
383750	75244	0	1
383751	75245	0	1
383752	75246	0	1
383753	75247	0	1
383754	75248	0	1
383755	75249	0	1
383756	75250	0	1
383757	75251	0	1
383758	75252	0	1
383759	75253	0	1
383760	75254	0	1
383761	75255	0	0
383762	75256	0	0
383763	75257	0	0
383764	75258	0	0
383765	75259	0	0
383766	75260	0	0
383767	75261	0	0
383768	75262	0	0
383769	75263	0	0
383770	75264	0	0
383771	75265	0	0
383772	75266	0	0
383773	75267	0	0
383774	75268	0	0
383775	75269	0	0
383776	75270	0	0
383777	75271	0	0
383778	75272	0	0
383779	75273	0	0
383780	75274	0	0
383781	75275	0	0
383782	75276	0	0
383783	75277	0	0
383784	75278	0	0
383785	75279	0	0
383786	75280	0	0
383787	75281	0	0
383788	75282	0	0
383789	75283	0	0
383790	75284	0	0
383791	75285	0	0
383792	75286	0	0
383793	75287	0	0
383794	75288	0	0
383795	75289	0	0
383796	75290	0	0
383797	75291	0	0
383798	75292	0	0
383799	75293	0	0
383800	75294	0	0
383801	75295	0	0
383802	75296	0	0
383803	75297	0	0
383804	75298	0	0
383805	75299	0	0
383806	75300	0	0
383807	75301	0	0
383808	75302	0	0
383809	75303	0	0
383810	75304	0	0
383811	75305	0	0
383812	75306	0	0
383813	75307	0	0
383814	75308	0	0
383815	75309	0	0
383816	75310	0	0
383817	75311	0	0
383818	75312	0	0
383819	75313	0	0
383820	75314	0	0
383821	75315	0	0
383822	75316	0	0
383823	75317	0	0
383824	75318	0	0
383825	75319	0	0
383826	75320	0	0
383827	75321	0	0
383828	75322	0	0
383829	75323	0	0
383830	75324	0	0
383831	75325	0	0
383832	75326	0	0
383833	75327	0	0
383834	75328	0	0
383835	75329	0	0
383836	75330	0	0
383837	75331	0	0
383838	75332	0	0
383839	75333	0	0
383840	75334	0	0
383841	75335	0	0
383842	75336	0	0
383843	75337	0	0
383844	75338	0	0
383845	75339	0	0
383846	75340	0	0
383847	75341	0	0
383848	75342	0	0
383849	75343	0	0
383850	75344	0	0
383851	75345	0	0
383852	75346	0	0
383853	75347	0	0
383854	75348	0	0
383855	75349	0	0
383856	75350	0	0
383857	75351	0	0
383858	75352	0	0
383859	75353	0	0
383860	75354	0	0
383861	75355	0	0
383862	75356	0	0
383863	75357	0	0
383864	75358	0	0
383865	75359	0	0
383866	75360	0	0
383867	75361	0	0
383868	75362	0	0
383869	75363	0	0
383870	75364	0	0
383871	75365	0	0
383872	75366	0	0
383873	75367	0	0
383874	75368	0	0
383875	75369	0	0
383876	75370	0	0
383877	75371	0	0
383878	75372	0	0
383879	75373	0	0
383880	75374	0	0
383881	75375	0	0
383882	75376	0	0
383883	75377	0	0
383884	75378	0	0
383885	75379	0	0
383886	75380	0	0
383887	75381	0	0
383888	75382	0	0
383889	75383	0	0
383890	75384	0	0
383891	75385	0	0
383892	75386	0	0
383893	75387	0	0
383894	75388	0	0
383895	75389	0	0
383896	75390	0	0
383897	75391	0	0
383898	75392	0	0
383899	75393	0	0
383900	75394	0	0
383901	75395	0	0
383902	75396	0	0
383903	75397	0	0
383904	75398	0	0
383905	75399	0	0
383906	75400	0	0
383907	75401	0	0
383908	75402	0	0
383909	75403	0	0
383910	75404	0	0
383911	75405	0	0
383912	75406	0	0
383913	75407	0	2
383914	75408	0	2
383915	75409	0	2
383916	75410	0	2
383917	75411	0	2
383918	75412	0	2
383919	75413	0	2
383920	75414	0	2
383921	75415	0	2
383922	75416	0	2
383923	75417	0	2
383924	75418	0	2
383925	75419	0	2
383926	75420	0	2
383927	75421	0	2
383928	75422	0	2
383929	75423	0	0
383930	75424	0	0
383931	75425	0	0
383932	75426	0	0
383933	75427	0	0
383934	75428	0	0
383935	75429	0	0
383936	75430	0	0
383937	75431	0	0
383938	75432	0	0
383939	75433	0	0
383940	75434	0	0
383941	75435	0	0
383942	75436	0	0
383943	75437	0	0
383944	75438	0	0
383945	75439	0	1
383946	75440	0	1
383947	75441	0	1
383948	75442	0	1
383949	75443	0	1
383950	75444	0	1
383951	75445	0	1
383952	75446	0	1
383953	75447	0	0
383954	75448	0	0
383955	75449	0	0
383956	75450	0	0
383957	75451	0	0
383958	75452	0	0
383959	75453	0	0
383960	75454	0	0
383961	75455	0	0
383962	75456	0	0
383963	75457	0	0
383964	75458	0	0
383965	75459	0	0
383966	75460	0	0
383967	75461	0	0
383968	75462	0	0
383969	75463	0	0
383970	75464	0	0
383971	75465	0	0
383972	75466	0	0
383973	75467	0	0
383974	75468	0	0
383975	75469	0	0
383976	75470	0	0
383977	75471	0	0
383978	75472	0	0
383979	75473	0	0
383980	75474	0	0
383981	75475	0	0
383982	75476	0	0
383983	75477	0	0
383984	75478	0	0
383985	75479	0	0
383986	75480	0	0
383987	75481	0	0
383988	75482	0	0
383989	75483	0	0
383990	75484	0	0
383991	75485	0	0
383992	75486	0	0
383993	75487	0	0
383994	75488	0	0
383995	75489	0	0
383996	75490	0	0
383997	75491	0	0
383998	75492	0	0
383999	75493	0	0
384000	75494	0	0
384001	75495	0	2
384002	75496	0	2
384003	75497	0	2
384004	75498	0	2
384005	75499	0	2
384006	75500	0	2
384007	75501	0	2
384008	75502	0	2
384009	75503	0	0
384010	75504	0	0
384011	75505	0	0
384012	75506	0	0
384013	75507	0	0
384014	75508	0	0
384015	75509	0	0
384016	75510	0	0
384017	75511	1	0
384018	75512	1	0
384019	75513	1	0
384020	75514	1	0
384021	75515	1	0
384022	75516	1	0
384023	75517	1	0
384024	75518	1	0
384025	75519	1	0
384026	75520	1	0
384027	75521	1	0
384028	75522	1	0
384029	75523	1	0
384030	75524	1	0
384031	75525	1	0
384032	75526	1	0
384033	75527	1	0
384034	75528	1	0
384035	75529	1	0
384036	75530	1	0
384037	75531	1	0
384038	75532	1	0
384039	75533	1	0
384040	75534	1	0
384041	75535	1	0
384042	75536	1	0
384043	75537	1	0
384044	75538	1	0
384045	75539	1	0
384046	75540	1	0
384047	75541	1	0
384048	75542	1	0
384049	75543	1	0
384050	75544	1	0
384051	75545	1	0
384052	75546	1	0
384053	75547	1	0
384054	75548	1	0
384055	75549	1	0
384056	75550	1	0
384057	75551	1	0
384058	75552	1	0
384059	75553	1	0
384060	75554	1	0
384061	75555	1	0
384062	75556	1	0
384063	75557	1	0
384064	75558	1	0
384065	75559	1	0
384066	75560	1	0
384067	75561	1	0
384068	75562	1	0
384069	75563	1	0
384070	75564	1	0
384071	75565	1	0
384072	75566	1	0
384073	75567	1	2
384074	75568	1	2
384075	75569	1	2
384076	75570	1	2
384077	75571	1	2
384078	75572	1	2
384079	75573	1	2
384080	75574	1	2
384081	75575	1	2
384082	75576	1	2
384083	75577	1	2
384084	75578	1	2
384085	75579	1	2
384086	75580	1	2
384087	75581	1	2
384088	75582	1	2
384089	75583	1	0
384090	75584	1	0
384091	75585	1	0
384092	75586	1	0
384093	75587	1	0
384094	75588	1	0
384095	75589	1	0
384096	75590	1	0
384097	75591	1	0
384098	75592	1	0
384099	75593	1	0
384100	75594	1	0
384101	75595	1	0
384102	75596	1	0
384103	75597	1	0
384104	75598	1	0
384105	75599	1	0
384106	75600	1	0
384107	75601	1	0
384108	75602	1	0
384109	75603	1	0
384110	75604	1	0
384111	75605	1	0
384112	75606	1	0
384113	75607	1	0
384114	75608	1	0
384115	75609	1	0
384116	75610	1	0
384117	75611	1	0
384118	75612	1	0
384119	75613	1	0
384120	75614	1	0
384121	75615	1	0
384122	75616	1	0
384123	75617	1	0
384124	75618	1	0
384125	75619	1	0
384126	75620	1	0
384127	75621	1	0
384128	75622	1	0
384129	75623	1	0
384130	75624	1	0
384131	75625	1	0
384132	75626	1	0
384133	75627	1	0
384134	75628	1	0
384135	75629	1	0
384136	75630	1	0
384137	75631	1	0
384138	75632	1	0
384139	75633	1	0
384140	75634	1	0
384141	75635	1	0
384142	75636	1	0
384143	75637	1	0
384144	75638	1	0
384145	75639	1	0
384146	75640	1	0
384147	75641	1	0
384148	75642	1	0
384149	75643	1	0
384150	75644	1	0
384151	75645	1	0
384152	75646	1	0
384153	75647	1	0
384154	75648	1	0
384155	75649	1	0
384156	75650	1	0
384157	75651	1	0
384158	75652	1	0
384159	75653	1	0
384160	75654	1	0
384161	75655	1	0
384162	75656	1	0
384163	75657	1	0
384164	75658	1	0
384165	75659	1	0
384166	75660	1	0
384167	75661	1	0
384168	75662	1	0
384169	75663	1	0
384170	75664	1	0
384171	75665	1	0
384172	75666	1	0
384173	75667	1	0
384174	75668	1	0
384175	75669	1	0
384176	75670	1	0
384177	75671	1	0
384178	75672	1	0
384179	75673	1	0
384180	75674	1	0
384181	75675	1	0
384182	75676	1	0
384183	75677	1	0
384184	75678	1	0
384185	75679	1	0
384186	75680	1	0
384187	75681	1	0
384188	75682	1	0
384189	75683	1	0
384190	75684	1	0
384191	75685	1	0
384192	75686	1	0
384193	75687	1	0
384194	75688	1	0
384195	75689	1	0
384196	75690	1	0
384197	75691	1	0
384198	75692	1	0
384199	75693	1	0
384200	75694	1	0
384201	75695	1	0
384202	75696	1	0
384203	75697	1	0
384204	75698	1	0
384205	75699	1	0
384206	75700	1	0
384207	75701	1	0
384208	75702	1	0
384209	75703	1	0
384210	75704	1	0
384211	75705	1	0
384212	75706	1	0
384213	75707	1	0
384214	75708	1	0
384215	75709	1	0
384216	75710	1	0
384217	75711	1	0
384218	75712	1	0
384219	75713	1	0
384220	75714	1	0
384221	75715	1	0
384222	75716	1	0
384223	75717	1	0
384224	75718	1	0
384225	75719	1	0
384226	75720	1	0
384227	75721	1	0
384228	75722	1	0
384229	75723	1	0
384230	75724	1	0
384231	75725	1	0
384232	75726	1	0
384233	75727	1	1
384234	75728	1	1
384235	75729	1	1
384236	75730	1	1
384237	75731	1	1
384238	75732	1	1
384239	75733	1	1
384240	75734	1	1
384241	75735	1	1
384242	75736	1	1
384243	75737	1	1
384244	75738	1	1
384245	75739	1	1
384246	75740	1	1
384247	75741	1	1
384248	75742	1	1
384249	75743	1	0
384250	75744	1	0
384251	75745	1	0
384252	75746	1	0
384253	75747	1	0
384254	75748	1	0
384255	75749	1	0
384256	75750	1	0
384257	75751	1	0
384258	75752	1	0
384259	75753	1	0
384260	75754	1	0
384261	75755	1	0
384262	75756	1	0
384263	75757	1	0
384264	75758	1	0
384265	75759	1	1
384266	75760	1	1
384267	75761	1	1
384268	75762	1	1
384269	75763	1	1
384270	75764	1	1
384271	75765	1	1
384272	75766	1	1
384273	75767	1	0
384274	75768	1	0
384275	75769	1	0
384276	75770	1	0
384277	75771	1	0
384278	75772	1	0
384279	75773	1	0
384280	75774	1	0
384281	75775	1	0
384282	75776	1	0
384283	75777	1	0
384284	75778	1	0
384285	75779	1	0
384286	75780	1	0
384287	75781	1	0
384288	75782	1	0
384289	75783	1	0
384290	75784	1	0
384291	75785	1	0
384292	75786	1	0
384293	75787	1	0
384294	75788	1	0
384295	75789	1	0
384296	75790	1	0
384297	75791	1	0
384298	75792	1	0
384299	75793	1	0
384300	75794	1	0
384301	75795	1	0
384302	75796	1	0
384303	75797	1	0
384304	75798	1	0
384305	75799	1	0
384306	75800	1	0
384307	75801	1	0
384308	75802	1	0
384309	75803	1	0
384310	75804	1	0
384311	75805	1	0
384312	75806	1	0
384313	75807	1	0
384314	75808	1	0
384315	75809	1	0
384316	75810	1	0
384317	75811	1	0
384318	75812	1	0
384319	75813	1	0
384320	75814	1	0
384321	75815	1	2
384322	75816	1	2
384323	75817	1	2
384324	75818	1	2
384325	75819	1	2
384326	75820	1	2
384327	75821	1	2
384328	75822	1	2
384329	75823	1	0
384330	75824	1	0
384331	75825	1	0
384332	75826	1	0
384333	75827	1	0
384334	75828	1	0
384335	75829	1	0
384336	75830	1	0
384337	75831	2	0
384338	75832	2	0
384339	75833	2	0
384340	75834	2	0
384341	75835	2	0
384342	75836	2	0
384343	75837	2	0
384344	75838	2	0
384345	75839	2	0
384346	75840	2	0
384347	75841	2	0
384348	75842	2	0
384349	75843	2	0
384350	75844	2	0
384351	75845	2	0
384352	75846	2	0
384353	75847	2	0
384354	75848	2	0
384355	75849	2	0
384356	75850	2	0
384357	75851	2	0
384358	75852	2	0
384359	75853	2	0
384360	75854	2	0
384361	75855	2	0
384362	75856	2	0
384363	75857	2	0
384364	75858	2	0
384365	75859	2	0
384366	75860	2	0
384367	75861	2	0
384368	75862	2	0
384369	75863	2	0
384370	75864	2	0
384371	75865	2	0
384372	75866	2	0
384373	75867	2	0
384374	75868	2	0
384375	75869	2	0
384376	75870	2	0
384377	75871	2	0
384378	75872	2	0
384379	75873	2	0
384380	75874	2	0
384381	75875	2	0
384382	75876	2	0
384383	75877	2	0
384384	75878	2	0
384385	75879	2	2
384386	75880	2	2
384387	75881	2	2
384388	75882	2	2
384389	75883	2	2
384390	75884	2	2
384391	75885	2	2
384392	75886	2	2
384393	75887	2	2
384394	75888	2	2
384395	75889	2	2
384396	75890	2	2
384397	75891	2	2
384398	75892	2	2
384399	75893	2	2
384400	75894	2	2
384401	75895	2	1
384402	75896	2	1
384403	75897	2	1
384404	75898	2	1
384405	75899	2	1
384406	75900	2	1
384407	75901	2	1
384408	75902	2	1
384409	75903	2	1
384410	75904	2	1
384411	75905	2	1
384412	75906	2	1
384413	75907	2	1
384414	75908	2	1
384415	75909	2	1
384416	75910	2	1
384417	75911	2	0
384418	75912	2	0
384419	75913	2	0
384420	75914	2	0
384421	75915	2	0
384422	75916	2	0
384423	75917	2	0
384424	75918	2	0
384425	75919	2	0
384426	75920	2	0
384427	75921	2	0
384428	75922	2	0
384429	75923	2	0
384430	75924	2	0
384431	75925	2	0
384432	75926	2	0
384433	75927	2	0
384434	75928	2	0
384435	75929	2	0
384436	75930	2	0
384437	75931	2	0
384438	75932	2	0
384439	75933	2	0
384440	75934	2	0
384441	75935	2	0
384442	75936	2	0
384443	75937	2	0
384444	75938	2	0
384445	75939	2	0
384446	75940	2	0
384447	75941	2	0
384448	75942	2	0
384449	75943	2	0
384450	75944	2	0
384451	75945	2	0
384452	75946	2	0
384453	75947	2	0
384454	75948	2	0
384455	75949	2	0
384456	75950	2	0
384457	75951	2	0
384458	75952	2	0
384459	75953	2	0
384460	75954	2	0
384461	75955	2	0
384462	75956	2	0
384463	75957	2	0
384464	75958	2	0
384465	75959	2	0
384466	75960	2	0
384467	75961	2	0
384468	75962	2	0
384469	75963	2	0
384470	75964	2	0
384471	75965	2	0
384472	75966	2	0
384473	75967	2	0
384474	75968	2	0
384475	75969	2	0
384476	75970	2	0
384477	75971	2	0
384478	75972	2	0
384479	75973	2	0
384480	75974	2	0
384481	75975	2	0
384482	75976	2	0
384483	75977	2	0
384484	75978	2	0
384485	75979	2	0
384486	75980	2	0
384487	75981	2	0
384488	75982	2	0
384489	75983	2	0
384490	75984	2	0
384491	75985	2	0
384492	75986	2	0
384493	75987	2	0
384494	75988	2	0
384495	75989	2	0
384496	75990	2	0
384497	75991	2	0
384498	75992	2	0
384499	75993	2	0
384500	75994	2	0
384501	75995	2	0
384502	75996	2	0
384503	75997	2	0
384504	75998	2	0
384505	75999	2	0
384506	76000	2	0
384507	76001	2	0
384508	76002	2	0
384509	76003	2	0
384510	76004	2	0
384511	76005	2	0
384512	76006	2	0
384513	76007	2	0
384514	76008	2	0
384515	76009	2	0
384516	76010	2	0
384517	76011	2	0
384518	76012	2	0
384519	76013	2	0
384520	76014	2	0
384521	76015	2	0
384522	76016	2	0
384523	76017	2	0
384524	76018	2	0
384525	76019	2	0
384526	76020	2	0
384527	76021	2	0
384528	76022	2	0
384529	76023	2	0
384530	76024	2	0
384531	76025	2	0
384532	76026	2	0
384533	76027	2	0
384534	76028	2	0
384535	76029	2	0
384536	76030	2	0
384537	76031	2	0
384538	76032	2	0
384539	76033	2	0
384540	76034	2	0
384541	76035	2	0
384542	76036	2	0
384543	76037	2	0
384544	76038	2	0
384545	76039	2	0
384546	76040	2	0
384547	76041	2	0
384548	76042	2	0
384549	76043	2	0
384550	76044	2	0
384551	76045	2	0
384552	76046	2	0
384553	76047	2	0
384554	76048	2	0
384555	76049	2	0
384556	76050	2	0
384557	76051	2	0
384558	76052	2	0
384559	76053	2	0
384560	76054	2	0
384561	76055	2	0
384562	76056	2	0
384563	76057	2	0
384564	76058	2	0
384565	76059	2	0
384566	76060	2	0
384567	76061	2	0
384568	76062	2	0
384569	76063	2	0
384570	76064	2	0
384571	76065	2	0
384572	76066	2	0
384573	76067	2	0
384574	76068	2	0
384575	76069	2	0
384576	76070	2	0
384577	76071	2	0
384578	76072	2	0
384579	76073	2	0
384580	76074	2	0
384581	76075	2	0
384582	76076	2	0
384583	76077	2	0
384584	76078	2	0
384585	76079	2	0
384586	76080	2	0
384587	76081	2	0
384588	76082	2	0
384589	76083	2	0
384590	76084	2	0
384591	76085	2	0
384592	76086	2	0
384593	76087	2	0
384594	76088	2	0
384595	76089	2	0
384596	76090	2	0
384597	76091	2	0
384598	76092	2	0
384599	76093	2	0
384600	76094	2	0
384601	76095	2	0
384602	76096	2	0
384603	76097	2	0
384604	76098	2	0
384605	76099	2	0
384606	76100	2	0
384607	76101	2	0
384608	76102	2	0
384609	76103	2	0
384610	76104	2	0
384611	76105	2	0
384612	76106	2	0
384613	76107	2	0
384614	76108	2	0
384615	76109	2	0
384616	76110	2	0
384617	76111	2	0
384618	76112	2	0
384619	76113	2	0
384620	76114	2	0
384621	76115	2	0
384622	76116	2	0
384623	76117	2	0
384624	76118	2	0
384625	76119	2	0
384626	76120	2	0
384627	76121	2	0
384628	76122	2	0
384629	76123	2	0
384630	76124	2	0
384631	76125	2	0
384632	76126	2	0
384633	76127	2	1
384634	76128	2	1
384635	76129	2	1
384636	76130	2	1
384637	76131	2	1
384638	76132	2	1
384639	76133	2	1
384640	76134	2	1
384641	76135	2	2
384642	76136	2	2
384643	76137	2	2
384644	76138	2	2
384645	76139	2	2
384646	76140	2	2
384647	76141	2	2
384648	76142	2	2
384649	76143	2	0
384650	76144	2	0
384651	76145	2	0
384652	76146	2	0
384653	76147	2	0
384654	76148	2	0
384655	76149	2	0
384656	76150	2	0
384657	76151	3	0
384658	76152	3	0
384659	76153	3	0
384660	76154	3	0
384661	76155	3	0
384662	76156	3	0
384663	76157	3	0
384664	76158	3	0
384665	76159	3	0
384666	76160	3	0
384667	76161	3	0
384668	76162	3	0
384669	76163	3	0
384670	76164	3	0
384671	76165	3	0
384672	76166	3	0
384673	76167	3	0
384674	76168	3	0
384675	76169	3	0
384676	76170	3	0
384677	76171	3	0
384678	76172	3	0
384679	76173	3	0
384680	76174	3	0
384681	76175	3	0
384682	76176	3	0
384683	76177	3	0
384684	76178	3	0
384685	76179	3	0
384686	76180	3	0
384687	76181	3	0
384688	76182	3	0
384689	76183	3	0
384690	76184	3	0
384691	76185	3	0
384692	76186	3	0
384693	76187	3	0
384694	76188	3	0
384695	76189	3	0
384696	76190	3	0
384697	76191	3	0
384698	76192	3	0
384699	76193	3	0
384700	76194	3	0
384701	76195	3	0
384702	76196	3	0
384703	76197	3	0
384704	76198	3	0
384705	76199	3	0
384706	76200	3	0
384707	76201	3	0
384708	76202	3	0
384709	76203	3	0
384710	76204	3	0
384711	76205	3	0
384712	76206	3	0
384713	76207	3	0
384714	76208	3	0
384715	76209	3	0
384716	76210	3	0
384717	76211	3	0
384718	76212	3	0
384719	76213	3	0
384720	76214	3	0
384721	76215	3	0
384722	76216	3	0
384723	76217	3	0
384724	76218	3	0
384725	76219	3	0
384726	76220	3	0
384727	76221	3	0
384728	76222	3	0
384729	76223	3	0
384730	76224	3	0
384731	76225	3	0
384732	76226	3	0
384733	76227	3	0
384734	76228	3	0
384735	76229	3	0
384736	76230	3	0
384737	76231	3	0
384738	76232	3	0
384739	76233	3	0
384740	76234	3	0
384741	76235	3	0
384742	76236	3	0
384743	76237	3	0
384744	76238	3	0
384745	76239	3	0
384746	76240	3	0
384747	76241	3	0
384748	76242	3	0
384749	76243	3	0
384750	76244	3	0
384751	76245	3	0
384752	76246	3	0
384753	76247	3	2
384754	76248	3	2
384755	76249	3	2
384756	76250	3	2
384757	76251	3	2
384758	76252	3	2
384759	76253	3	2
384760	76254	3	2
384761	76255	3	2
384762	76256	3	2
384763	76257	3	2
384764	76258	3	2
384765	76259	3	2
384766	76260	3	2
384767	76261	3	2
384768	76262	3	2
384769	76263	3	1
384770	76264	3	1
384771	76265	3	1
384772	76266	3	1
384773	76267	3	1
384774	76268	3	1
384775	76269	3	1
384776	76270	3	1
384777	76271	3	1
384778	76272	3	1
384779	76273	3	1
384780	76274	3	1
384781	76275	3	1
384782	76276	3	1
384783	76277	3	1
384784	76278	3	1
384785	76279	3	0
384786	76280	3	0
384787	76281	3	0
384788	76282	3	0
384789	76283	3	0
384790	76284	3	0
384791	76285	3	0
384792	76286	3	0
384793	76287	3	0
384794	76288	3	0
384795	76289	3	0
384796	76290	3	0
384797	76291	3	0
384798	76292	3	0
384799	76293	3	0
384800	76294	3	0
384801	76295	3	0
384802	76296	3	0
384803	76297	3	0
384804	76298	3	0
384805	76299	3	0
384806	76300	3	0
384807	76301	3	0
384808	76302	3	0
384809	76303	3	0
384810	76304	3	0
384811	76305	3	0
384812	76306	3	0
384813	76307	3	0
384814	76308	3	0
384815	76309	3	0
384816	76310	3	0
384817	76311	3	0
384818	76312	3	0
384819	76313	3	0
384820	76314	3	0
384821	76315	3	0
384822	76316	3	0
384823	76317	3	0
384824	76318	3	0
384825	76319	3	0
384826	76320	3	0
384827	76321	3	0
384828	76322	3	0
384829	76323	3	0
384830	76324	3	0
384831	76325	3	0
384832	76326	3	0
384833	76327	3	0
384834	76328	3	0
384835	76329	3	0
384836	76330	3	0
384837	76331	3	0
384838	76332	3	0
384839	76333	3	0
384840	76334	3	0
384841	76335	3	0
384842	76336	3	0
384843	76337	3	0
384844	76338	3	0
384845	76339	3	0
384846	76340	3	0
384847	76341	3	0
384848	76342	3	0
384849	76343	3	0
384850	76344	3	0
384851	76345	3	0
384852	76346	3	0
384853	76347	3	0
384854	76348	3	0
384855	76349	3	0
384856	76350	3	0
384857	76351	3	0
384858	76352	3	0
384859	76353	3	0
384860	76354	3	0
384861	76355	3	0
384862	76356	3	0
384863	76357	3	0
384864	76358	3	0
384865	76359	3	0
384866	76360	3	0
384867	76361	3	0
384868	76362	3	0
384869	76363	3	0
384870	76364	3	0
384871	76365	3	0
384872	76366	3	0
384873	76367	3	0
384874	76368	3	0
384875	76369	3	0
384876	76370	3	0
384877	76371	3	0
384878	76372	3	0
384879	76373	3	0
384880	76374	3	0
384881	76375	3	0
384882	76376	3	0
384883	76377	3	0
384884	76378	3	0
384885	76379	3	0
384886	76380	3	0
384887	76381	3	0
384888	76382	3	0
384889	76383	3	0
384890	76384	3	0
384891	76385	3	0
384892	76386	3	0
384893	76387	3	0
384894	76388	3	0
384895	76389	3	0
384896	76390	3	0
384897	76391	3	0
384898	76392	3	0
384899	76393	3	0
384900	76394	3	0
384901	76395	3	0
384902	76396	3	0
384903	76397	3	0
384904	76398	3	0
384905	76399	3	0
384906	76400	3	0
384907	76401	3	0
384908	76402	3	0
384909	76403	3	0
384910	76404	3	0
384911	76405	3	0
384912	76406	3	0
384913	76407	3	0
384914	76408	3	0
384915	76409	3	0
384916	76410	3	0
384917	76411	3	0
384918	76412	3	0
384919	76413	3	0
384920	76414	3	0
384921	76415	3	0
384922	76416	3	0
384923	76417	3	0
384924	76418	3	0
384925	76419	3	0
384926	76420	3	0
384927	76421	3	0
384928	76422	3	0
384929	76423	3	0
384930	76424	3	0
384931	76425	3	0
384932	76426	3	0
384933	76427	3	0
384934	76428	3	0
384935	76429	3	0
384936	76430	3	0
384937	76431	3	0
384938	76432	3	0
384939	76433	3	0
384940	76434	3	0
384941	76435	3	0
384942	76436	3	0
384943	76437	3	0
384944	76438	3	0
384945	76439	3	0
384946	76440	3	0
384947	76441	3	0
384948	76442	3	0
384949	76443	3	0
384950	76444	3	0
384951	76445	3	0
384952	76446	3	0
384953	76447	3	1
384954	76448	3	1
384955	76449	3	1
384956	76450	3	1
384957	76451	3	1
384958	76452	3	1
384959	76453	3	1
384960	76454	3	1
384961	76455	3	2
384962	76456	3	2
384963	76457	3	2
384964	76458	3	2
384965	76459	3	2
384966	76460	3	2
384967	76461	3	2
384968	76462	3	2
384969	76463	3	0
384970	76464	3	0
384971	76465	3	0
384972	76466	3	0
384973	76467	3	0
384974	76468	3	0
384975	76469	3	0
384976	76470	3	0
384977	76471	4	0
384978	76472	4	0
384979	76473	4	0
384980	76474	4	0
384981	76475	4	0
384982	76476	4	0
384983	76477	4	0
384984	76478	4	0
384985	76479	4	0
384986	76480	4	0
384987	76481	4	0
384988	76482	4	0
384989	76483	4	0
384990	76484	4	0
384991	76485	4	0
384992	76486	4	0
384993	76487	4	0
384994	76488	4	0
384995	76489	4	0
384996	76490	4	0
384997	76491	4	0
384998	76492	4	0
384999	76493	4	0
385000	76494	4	0
385001	76495	4	0
385002	76496	4	0
385003	76497	4	0
385004	76498	4	0
385005	76499	4	0
385006	76500	4	0
385007	76501	4	0
385008	76502	4	0
385009	76503	4	0
385010	76504	4	0
385011	76505	4	0
385012	76506	4	0
385013	76507	4	0
385014	76508	4	0
385015	76509	4	0
385016	76510	4	0
385017	76511	4	0
385018	76512	4	0
385019	76513	4	0
385020	76514	4	0
385021	76515	4	0
385022	76516	4	0
385023	76517	4	0
385024	76518	4	0
385025	76519	4	1
385026	76520	4	1
385027	76521	4	1
385028	76522	4	1
385029	76523	4	1
385030	76524	4	1
385031	76525	4	1
385032	76526	4	1
385033	76527	4	1
385034	76528	4	1
385035	76529	4	1
385036	76530	4	1
385037	76531	4	1
385038	76532	4	1
385039	76533	4	1
385040	76534	4	1
385041	76535	4	0
385042	76536	4	0
385043	76537	4	0
385044	76538	4	0
385045	76539	4	0
385046	76540	4	0
385047	76541	4	0
385048	76542	4	0
385049	76543	4	0
385050	76544	4	0
385051	76545	4	0
385052	76546	4	0
385053	76547	4	0
385054	76548	4	0
385055	76549	4	0
385056	76550	4	0
385057	76551	4	0
385058	76552	4	0
385059	76553	4	0
385060	76554	4	0
385061	76555	4	0
385062	76556	4	0
385063	76557	4	0
385064	76558	4	0
385065	76559	4	0
385066	76560	4	0
385067	76561	4	0
385068	76562	4	0
385069	76563	4	0
385070	76564	4	0
385071	76565	4	0
385072	76566	4	0
385073	76567	4	0
385074	76568	4	0
385075	76569	4	0
385076	76570	4	0
385077	76571	4	0
385078	76572	4	0
385079	76573	4	0
385080	76574	4	0
385081	76575	4	0
385082	76576	4	0
385083	76577	4	0
385084	76578	4	0
385085	76579	4	0
385086	76580	4	0
385087	76581	4	0
385088	76582	4	0
385089	76583	4	0
385090	76584	4	0
385091	76585	4	0
385092	76586	4	0
385093	76587	4	0
385094	76588	4	0
385095	76589	4	0
385096	76590	4	0
385097	76591	4	0
385098	76592	4	0
385099	76593	4	0
385100	76594	4	0
385101	76595	4	0
385102	76596	4	0
385103	76597	4	0
385104	76598	4	0
385105	76599	4	0
385106	76600	4	0
385107	76601	4	0
385108	76602	4	0
385109	76603	4	0
385110	76604	4	0
385111	76605	4	0
385112	76606	4	0
385113	76607	4	0
385114	76608	4	0
385115	76609	4	0
385116	76610	4	0
385117	76611	4	0
385118	76612	4	0
385119	76613	4	0
385120	76614	4	0
385121	76615	4	0
385122	76616	4	0
385123	76617	4	0
385124	76618	4	0
385125	76619	4	0
385126	76620	4	0
385127	76621	4	0
385128	76622	4	0
385129	76623	4	0
385130	76624	4	0
385131	76625	4	0
385132	76626	4	0
385133	76627	4	0
385134	76628	4	0
385135	76629	4	0
385136	76630	4	0
385137	76631	4	0
385138	76632	4	0
385139	76633	4	0
385140	76634	4	0
385141	76635	4	0
385142	76636	4	0
385143	76637	4	0
385144	76638	4	0
385145	76639	4	0
385146	76640	4	0
385147	76641	4	0
385148	76642	4	0
385149	76643	4	0
385150	76644	4	0
385151	76645	4	0
385152	76646	4	0
385153	76647	4	0
385154	76648	4	0
385155	76649	4	0
385156	76650	4	0
385157	76651	4	0
385158	76652	4	0
385159	76653	4	0
385160	76654	4	0
385161	76655	4	0
385162	76656	4	0
385163	76657	4	0
385164	76658	4	0
385165	76659	4	0
385166	76660	4	0
385167	76661	4	0
385168	76662	4	0
385169	76663	4	0
385170	76664	4	0
385171	76665	4	0
385172	76666	4	0
385173	76667	4	0
385174	76668	4	0
385175	76669	4	0
385176	76670	4	0
385177	76671	4	0
385178	76672	4	0
385179	76673	4	0
385180	76674	4	0
385181	76675	4	0
385182	76676	4	0
385183	76677	4	0
385184	76678	4	0
385185	76679	4	0
385186	76680	4	0
385187	76681	4	0
385188	76682	4	0
385189	76683	4	0
385190	76684	4	0
385191	76685	4	0
385192	76686	4	0
385193	76687	4	0
385194	76688	4	0
385195	76689	4	0
385196	76690	4	0
385197	76691	4	0
385198	76692	4	0
385199	76693	4	0
385200	76694	4	0
385201	76695	4	0
385202	76696	4	0
385203	76697	4	0
385204	76698	4	0
385205	76699	4	0
385206	76700	4	0
385207	76701	4	0
385208	76702	4	0
385209	76703	4	0
385210	76704	4	0
385211	76705	4	0
385212	76706	4	0
385213	76707	4	0
385214	76708	4	0
385215	76709	4	0
385216	76710	4	0
385217	76711	4	0
385218	76712	4	0
385219	76713	4	0
385220	76714	4	0
385221	76715	4	0
385222	76716	4	0
385223	76717	4	0
385224	76718	4	0
385225	76719	4	0
385226	76720	4	0
385227	76721	4	0
385228	76722	4	0
385229	76723	4	0
385230	76724	4	0
385231	76725	4	0
385232	76726	4	0
385233	76727	4	0
385234	76728	4	0
385236	76730	4	0
385237	76731	4	0
385238	76732	4	0
385239	76733	4	0
385240	76734	4	0
385241	76735	4	2
385242	76736	4	2
385243	76737	4	2
385244	76738	4	2
385245	76739	4	2
385246	76740	4	2
385247	76741	4	2
385248	76742	4	2
385249	76743	4	2
385250	76744	4	2
385251	76745	4	2
385252	76746	4	2
385253	76747	4	2
385254	76748	4	2
385255	76749	4	2
385256	76750	4	2
385257	76751	4	0
385258	76752	4	0
385259	76753	4	0
385260	76754	4	0
385261	76755	4	0
385262	76756	4	0
385263	76757	4	0
385264	76758	4	0
385265	76759	5	0
385266	76760	5	0
385267	76761	5	0
385268	76762	5	0
385269	76763	5	0
385270	76764	5	0
385271	76765	5	0
385272	76766	5	0
385273	76767	5	0
385274	76768	5	0
385275	76769	5	0
385276	76770	5	0
385277	76771	5	0
385278	76772	5	0
385279	76773	5	0
385280	76774	5	0
385281	76775	5	0
385282	76776	5	0
385283	76777	5	0
385284	76778	5	0
385285	76779	5	0
385286	76780	5	0
385287	76781	5	0
385288	76782	5	0
385289	76783	5	0
385290	76784	5	0
385291	76785	5	0
385292	76786	5	0
385293	76787	5	0
385294	76788	5	0
385295	76789	5	0
385296	76790	5	0
385297	76791	5	0
385298	76792	5	0
385299	76793	5	0
385300	76794	5	0
385301	76795	5	0
385302	76796	5	0
385303	76797	5	0
385304	76798	5	0
385305	76799	5	0
385306	76800	5	0
385307	76801	5	0
385308	76802	5	0
385309	76803	5	0
385310	76804	5	0
385311	76805	5	0
385312	76806	5	0
385313	76807	5	0
385314	76808	5	0
385315	76809	5	0
385316	76810	5	0
385317	76811	5	0
385318	76812	5	0
385319	76813	5	0
385320	76814	5	0
385321	76815	5	0
385322	76816	5	0
385323	76817	5	0
385324	76818	5	0
385325	76819	5	0
385326	76820	5	0
385327	76821	5	0
385328	76822	5	0
385329	76823	5	0
385330	76824	5	0
385331	76825	5	0
385332	76826	5	0
385333	76827	5	0
385334	76828	5	0
385335	76829	5	0
385336	76830	5	0
385337	76831	5	0
385338	76832	5	0
385339	76833	5	0
385340	76834	5	0
385341	76835	5	0
385342	76836	5	0
385343	76837	5	0
385344	76838	5	0
385345	76839	5	0
385346	76840	5	0
385347	76841	5	0
385348	76842	5	0
385349	76843	5	0
385350	76844	5	0
385351	76845	5	0
385352	76846	5	0
385353	76847	5	0
385354	76848	5	0
385355	76849	5	0
385356	76850	5	0
385357	76851	5	0
385358	76852	5	0
385359	76853	5	0
385360	76854	5	0
385361	76855	5	0
385362	76856	5	0
385547	77041	5	0
385548	77042	5	0
385549	77043	5	0
385550	77044	5	0
385551	77045	5	0
385552	77046	5	0
385553	77047	6	0
385554	77048	6	0
385555	77049	6	0
385556	77050	6	0
385557	77051	6	0
385558	77052	6	0
385559	77053	6	0
385560	77054	6	0
385561	77055	6	0
385562	77056	6	0
385563	77057	6	0
385564	77058	6	0
385565	77059	6	0
385566	77060	6	0
385567	77061	6	0
385568	77062	6	0
385569	77063	6	0
385570	77064	6	0
385571	77065	6	0
385572	77066	6	0
385573	77067	6	0
385574	77068	6	0
385575	77069	6	0
385576	77070	6	0
385577	77071	6	0
385578	77072	6	0
385579	77073	6	0
385580	77074	6	0
385581	77075	6	0
385582	77076	6	0
385583	77077	6	0
385584	77078	6	0
385585	77079	6	0
385586	77080	6	0
385587	77081	6	0
385588	77082	6	0
385589	77083	6	0
385590	77084	6	0
385591	77085	6	0
385592	77086	6	0
385593	77087	6	0
385594	77088	6	0
385595	77089	6	0
385596	77090	6	0
385597	77091	6	0
385598	77092	6	0
385599	77093	6	0
385600	77094	6	0
385601	77095	6	0
385602	77096	6	0
385603	77097	6	0
385604	77098	6	0
385605	77099	6	0
385606	77100	6	0
385607	77101	6	0
385608	77102	6	0
385609	77103	6	0
385610	77104	6	0
385611	77105	6	0
385612	77106	6	0
385613	77107	6	0
385614	77108	6	0
385615	77109	6	0
385616	77110	6	0
385617	77111	6	0
385618	77112	6	0
385619	77113	6	0
385620	77114	6	0
385621	77115	6	0
385622	77116	6	0
385623	77117	6	0
385624	77118	6	0
385625	77119	6	0
385626	77120	6	0
385627	77121	6	0
385628	77122	6	0
385629	77123	6	0
385630	77124	6	0
385631	77125	6	0
385632	77126	6	0
385633	77127	6	0
385634	77128	6	0
385635	77129	6	0
385636	77130	6	0
385637	77131	6	0
385638	77132	6	0
385639	77133	6	0
385640	77134	6	0
385641	77135	6	0
385642	77136	6	0
385643	77137	6	0
385644	77138	6	0
385645	77139	6	0
385646	77140	6	0
385647	77141	6	0
385648	77142	6	0
385649	77143	6	0
385650	77144	6	0
385651	77145	6	0
385652	77146	6	0
385653	77147	6	0
385654	77148	6	0
385655	77149	6	0
385656	77150	6	0
385657	77151	6	0
385658	77152	6	0
385659	77153	6	0
385660	77154	6	0
385661	77155	6	0
385662	77156	6	0
385663	77157	6	0
385664	77158	6	0
385665	77159	6	0
385666	77160	6	0
385667	77161	6	0
385668	77162	6	0
385669	77163	6	0
385670	77164	6	0
385671	77165	6	0
385672	77166	6	0
385673	77167	6	0
385674	77168	6	0
385675	77169	6	0
385676	77170	6	0
385677	77171	6	0
385678	77172	6	0
385679	77173	6	0
385680	77174	6	0
385681	77175	6	0
385682	77176	6	0
385683	77177	6	0
385684	77178	6	0
385685	77179	6	0
385686	77180	6	0
385687	77181	6	0
385688	77182	6	0
385689	77183	6	0
385690	77184	6	0
385691	77185	6	0
385692	77186	6	0
385693	77187	6	0
385694	77188	6	0
385695	77189	6	0
385696	77190	6	0
385697	77191	6	0
385698	77192	6	0
385699	77193	6	0
385700	77194	6	0
385701	77195	6	0
385702	77196	6	0
385703	77197	6	0
385704	77198	6	0
385705	77199	6	0
385706	77200	6	0
385707	77201	6	0
385708	77202	6	0
385709	77203	6	0
385710	77204	6	0
385711	77205	6	0
385712	77206	6	0
385713	77207	6	0
385714	77208	6	0
385715	77209	6	0
385716	77210	6	0
385717	77211	6	0
385718	77212	6	0
385719	77213	6	0
385720	77214	6	0
385721	77215	6	0
385722	77216	6	0
385723	77217	6	0
385724	77218	6	0
385725	77219	6	0
385726	77220	6	0
385727	77221	6	0
385728	77222	6	0
385729	77223	6	0
385730	77224	6	0
385731	77225	6	0
385732	77226	6	0
385733	77227	6	0
385734	77228	6	0
385735	77229	6	0
385736	77230	6	0
385737	77231	6	0
385738	77232	6	0
385739	77233	6	0
385740	77234	6	0
385741	77235	6	0
385742	77236	6	0
385743	77237	6	0
385744	77238	6	0
385745	77239	6	0
385746	77240	6	0
385747	77241	6	0
385748	77242	6	0
385749	77243	6	0
385750	77244	6	0
385751	77245	6	0
385752	77246	6	0
385753	77247	6	0
385754	77248	6	0
385755	77249	6	0
385756	77250	6	0
385757	77251	6	0
385758	77252	6	0
385759	77253	6	0
385760	77254	6	0
385761	77255	6	0
385762	77256	6	0
385763	77257	6	0
385764	77258	6	0
385765	77259	6	0
385766	77260	6	0
385767	77261	6	0
385768	77262	6	0
385769	77263	6	0
385770	77264	6	0
385771	77265	6	0
385772	77266	6	0
385773	77267	7	0
385774	77268	7	0
385775	77269	7	0
385776	77270	7	0
385777	77271	7	0
385778	77272	7	0
385779	77273	7	0
385780	77274	7	0
385781	77275	7	0
385782	77276	7	0
385783	77277	7	0
385784	77278	7	0
385785	77279	7	0
385786	77280	7	0
385787	77281	7	0
385788	77282	7	0
385789	77283	7	0
385790	77284	7	0
385791	77285	7	0
385792	77286	7	0
385793	77287	7	0
385794	77288	7	0
385795	77289	7	0
385796	77290	7	0
385797	77291	7	0
385798	77292	7	0
385799	77293	7	0
385800	77294	7	0
385801	77295	7	0
385802	77296	7	0
385803	77297	7	0
385804	77298	7	0
385805	77299	7	0
385806	77300	7	0
385807	77301	7	0
385808	77302	7	0
385809	77303	7	0
385810	77304	7	0
385811	77305	7	0
385812	77306	7	0
385813	77307	7	0
385814	77308	7	0
385815	77309	7	0
385816	77310	7	0
385817	77311	7	0
385818	77312	7	0
385819	77313	7	0
385820	77314	7	0
385821	77315	7	0
385822	77316	7	0
385823	77317	7	0
385824	77318	7	0
385825	77319	7	0
385826	77320	7	0
385827	77321	7	0
385828	77322	7	0
385829	77323	7	0
385830	77324	7	0
385831	77325	7	0
385832	77326	7	0
385833	77327	7	0
385834	77328	7	0
385835	77329	7	0
385836	77330	7	0
385837	77331	7	0
385838	77332	7	0
385839	77333	7	0
385840	77334	7	0
385841	77335	7	0
385842	77336	7	0
385843	77337	7	0
385844	77338	7	0
385845	77339	7	0
385846	77340	7	0
385847	77341	7	0
385848	77342	7	0
385849	77343	7	0
385850	77344	7	0
385851	77345	7	0
385852	77346	7	0
385853	77347	7	0
385854	77348	7	0
385855	77349	7	0
385856	77350	7	0
385857	77351	7	0
385858	77352	7	0
385859	77353	7	0
385860	77354	7	0
385861	77355	7	0
385862	77356	7	0
385863	77357	7	0
385864	77358	7	0
385865	77359	7	0
385866	77360	7	0
385867	77361	7	0
385868	77362	7	0
385869	77363	7	0
385870	77364	7	0
385871	77365	7	0
385872	77366	7	0
385873	77367	7	0
385874	77368	7	0
385875	77369	7	0
385876	77370	7	0
385877	77371	7	0
385878	77372	7	0
385879	77373	7	0
385880	77374	7	0
385881	77375	7	0
385882	77376	7	0
385883	77377	7	0
385884	77378	7	0
385885	77379	7	0
385886	77380	7	0
385887	77381	7	0
385888	77382	7	0
385889	77383	7	0
385890	77384	7	0
385891	77385	7	0
385892	77386	7	0
385893	77387	7	0
385894	77388	7	0
385895	77389	7	0
385896	77390	7	0
385897	77391	7	0
385898	77392	7	0
385899	77393	7	0
385900	77394	7	0
385901	77395	7	0
385902	77396	7	0
385903	77397	7	0
385904	77398	7	0
385905	77399	7	0
385906	77400	7	0
385907	77401	7	0
385908	77402	7	0
385909	77403	7	0
385910	77404	7	0
385911	77405	7	0
385912	77406	7	0
385913	77407	7	0
385914	77408	7	0
385915	77409	7	0
385916	77410	7	0
385917	77411	7	0
385918	77412	7	0
385919	77413	7	0
385920	77414	7	0
385921	77415	7	0
385922	77416	7	0
385923	77417	7	0
385924	77418	7	0
385925	77419	7	0
385926	77420	7	0
385927	77421	7	0
385928	77422	7	0
385929	77423	7	0
385930	77424	7	0
385931	77425	7	0
385932	77426	7	0
385933	77427	7	0
385934	77428	7	0
385935	77429	7	0
385936	77430	7	0
385937	77431	7	0
385938	77432	7	0
385939	77433	7	0
385940	77434	7	0
385941	77435	7	0
385942	77436	7	0
385943	77437	7	0
385944	77438	7	0
385945	77439	7	0
385946	77440	7	0
385947	77441	7	0
385948	77442	7	0
385949	77443	7	0
385950	77444	7	0
385951	77445	7	0
385952	77446	7	0
385953	77447	7	0
385954	77448	7	0
385955	77449	7	0
385956	77450	7	0
385957	77451	7	0
385958	77452	7	0
385959	77453	7	0
385960	77454	7	0
385961	77455	7	0
385962	77456	7	0
385963	77457	7	0
385964	77458	7	0
385965	77459	7	0
385966	77460	7	0
385967	77461	7	0
385968	77462	7	0
385969	77463	7	0
385970	77464	7	0
385971	77465	7	0
385972	77466	7	0
385973	77467	7	0
385974	77468	7	0
385975	77469	7	0
385976	77470	7	0
385977	77471	7	0
385978	77472	7	0
385979	77473	7	0
385980	77474	7	0
385981	77475	7	0
385982	77476	7	0
385983	77477	7	0
385984	77478	7	0
385985	77479	7	0
385986	77480	7	0
385987	77481	7	0
385988	77482	7	0
385989	77483	7	0
385990	77484	7	0
385991	77485	7	0
385992	77486	7	0
385993	77487	8	0
385994	77488	8	0
385995	77489	8	0
385996	77490	8	0
385997	77491	8	0
385998	77492	8	0
385999	77493	8	0
386000	77494	8	0
386001	77495	8	0
386002	77496	8	0
386003	77497	8	0
386004	77498	8	0
386005	77499	8	0
386006	77500	8	0
386007	77501	8	0
386008	77502	8	0
386009	77503	8	0
386010	77504	8	0
386011	77505	8	0
386012	77506	8	0
386013	77507	8	0
386014	77508	8	0
386015	77509	8	0
386016	77510	8	0
386017	77511	8	0
386018	77512	8	0
386019	77513	8	0
386020	77514	8	0
386021	77515	8	0
386022	77516	8	0
386023	77517	8	0
386024	77518	8	0
386025	77519	8	0
386026	77520	8	0
386027	77521	8	0
386028	77522	8	0
386029	77523	8	0
386030	77524	8	0
386031	77525	8	0
386032	77526	8	0
386033	77527	8	0
386034	77528	8	0
386035	77529	8	0
386036	77530	8	0
386037	77531	8	0
386038	77532	8	0
386039	77533	8	0
386040	77534	8	0
386041	77535	8	0
386042	77536	8	0
386043	77537	8	0
386044	77538	8	0
386045	77539	8	0
386046	77540	8	0
386047	77541	8	0
386048	77542	8	0
386049	77543	8	0
386050	77544	8	0
386051	77545	8	0
386052	77546	8	0
386053	77547	8	0
386054	77548	8	0
386055	77549	8	0
386056	77550	8	0
386057	77551	8	0
386058	77552	8	0
386059	77553	8	0
386060	77554	8	0
386061	77555	8	0
386062	77556	8	0
386063	77557	8	0
386064	77558	8	0
386065	77559	8	0
386066	77560	8	0
386067	77561	8	0
386068	77562	8	0
386069	77563	8	0
386070	77564	8	0
386071	77565	8	0
386072	77566	8	0
386073	77567	8	0
386074	77568	8	0
386075	77569	8	0
386076	77570	8	0
386077	77571	8	0
386078	77572	8	0
386079	77573	8	0
386080	77574	8	0
386081	77575	8	0
386082	77576	8	0
386083	77577	8	0
386084	77578	8	0
386085	77579	8	0
386086	77580	8	0
386087	77581	8	0
386088	77582	8	0
386089	77583	8	0
386090	77584	8	0
386091	77585	8	0
386092	77586	8	0
386093	77587	8	0
386094	77588	8	0
386095	77589	8	0
386096	77590	8	0
386097	77591	8	0
386098	77592	8	0
386099	77593	8	0
386100	77594	8	0
386101	77595	8	0
386102	77596	8	0
386103	77597	8	0
386104	77598	8	0
386105	77599	8	0
386106	77600	8	0
386107	77601	8	0
386108	77602	8	0
386109	77603	8	0
386110	77604	8	0
386111	77605	8	0
386112	77606	8	0
386113	77607	8	0
386114	77608	8	0
386115	77609	8	0
386116	77610	8	0
386117	77611	8	0
386118	77612	8	0
386119	77613	8	0
386120	77614	8	0
386121	77615	8	0
386122	77616	8	0
386123	77617	8	0
386124	77618	8	0
386125	77619	8	0
386126	77620	8	0
386127	77621	8	0
386128	77622	8	0
386129	77623	8	0
386130	77624	8	0
386131	77625	8	0
386132	77626	8	0
386133	77627	8	0
386134	77628	8	0
386135	77629	8	0
386136	77630	8	0
386137	77631	8	0
386138	77632	8	0
386139	77633	8	0
386140	77634	8	0
386141	77635	8	0
386142	77636	8	0
386143	77637	8	0
386144	77638	8	0
386145	77639	8	0
386146	77640	8	0
386147	77641	8	0
386148	77642	8	0
386149	77643	8	0
386150	77644	8	0
386151	77645	8	0
386152	77646	8	0
386153	77647	8	0
386154	77648	8	0
386155	77649	8	0
386156	77650	8	0
386157	77651	8	0
386158	77652	8	0
386159	77653	8	0
386160	77654	8	0
386161	77655	8	0
386162	77656	8	0
386163	77657	8	0
386164	77658	8	0
386165	77659	8	0
386166	77660	8	0
386167	77661	8	0
386168	77662	8	0
386169	77663	8	0
386170	77664	8	0
386171	77665	8	0
386172	77666	8	0
386173	77667	8	0
386174	77668	8	0
386175	77669	8	0
386176	77670	8	0
386177	77671	8	0
386178	77672	8	0
386179	77673	8	0
386180	77674	8	0
386181	77675	8	0
386182	77676	8	0
386183	77677	8	0
386184	77678	8	0
386185	77679	8	0
386186	77680	8	0
386187	77681	8	0
386188	77682	8	0
386189	77683	8	0
386190	77684	8	0
386191	77685	8	0
386192	77686	8	0
386193	77687	8	0
386194	77688	8	0
386195	77689	8	0
386196	77690	8	0
386197	77691	8	0
386198	77692	8	0
386199	77693	8	0
386200	77694	8	0
386201	77695	8	0
386202	77696	8	0
386203	77697	8	0
386204	77698	8	0
386205	77699	8	0
386206	77700	8	0
386207	77701	8	0
386208	77702	8	0
386209	77703	8	0
386210	77704	8	0
386211	77705	8	0
386212	77706	8	0
386213	77707	8	0
386214	77708	8	0
386215	77709	8	0
386216	77710	8	0
386217	77711	8	0
386218	77712	8	0
386219	77713	8	0
386220	77714	8	0
386221	77715	8	0
386222	77716	8	0
386223	77717	8	0
386224	77718	8	0
386225	77719	8	0
386226	77720	8	0
386227	77721	8	0
386228	77722	8	0
386229	77723	8	0
386230	77724	8	0
386231	77725	8	0
386232	77726	8	0
386233	77727	8	0
386234	77728	8	0
386235	77729	8	0
386236	77730	8	0
386237	77731	8	0
386238	77732	8	0
386239	77733	8	0
386240	77734	8	0
386241	77735	8	0
386242	77736	8	0
386243	77737	8	0
386244	77738	8	0
386245	77739	8	0
386246	77740	8	0
386247	77741	8	0
386248	77742	8	0
386249	77743	8	0
386250	77744	8	0
386251	77745	8	0
386252	77746	8	0
386253	77747	8	0
386254	77748	8	0
386255	77749	8	0
386256	77750	8	0
386257	77751	8	0
386258	77752	8	0
386259	77753	8	0
386260	77754	8	0
386261	77755	8	0
386262	77756	8	0
386263	77757	8	0
386264	77758	8	0
386265	77759	8	0
386266	77760	8	0
386267	77761	8	0
386268	77762	8	0
386269	77763	8	0
386270	77764	8	0
386271	77765	8	0
386272	77766	8	0
386273	77767	8	0
386274	77768	8	0
386275	77769	8	0
386276	77770	8	0
386277	77771	8	0
386278	77772	8	0
386279	77773	8	0
386280	77774	8	0
386281	77775	8	0
386282	77776	8	0
386283	77777	8	0
386284	77778	8	0
386285	77779	8	0
386286	77780	8	0
386287	77781	8	0
386288	77782	8	0
386289	77783	8	0
386290	77784	8	0
386291	77785	8	0
386292	77786	8	0
386293	77787	8	0
386294	77788	8	0
386295	77789	8	0
386296	77790	8	0
386297	77791	8	0
386298	77792	8	0
386299	77793	8	0
386300	77794	8	0
386301	77795	8	0
386302	77796	8	0
386303	77797	8	0
386304	77798	8	0
386305	77799	8	0
386306	77800	8	0
386307	77801	8	0
386308	77802	8	0
386309	77803	8	0
386310	77804	8	0
386311	77805	8	0
386312	77806	8	0
386313	77807	8	0
386314	77808	8	0
386315	77809	8	0
386316	77810	8	0
386317	77811	8	0
386318	77812	8	0
386319	77813	8	0
386320	77814	8	0
386321	77815	8	0
386322	77816	8	0
386323	77817	8	0
386324	77818	8	0
386325	77819	8	0
386326	77820	8	0
386327	77821	8	0
386328	77822	8	0
386329	77823	8	0
386330	77824	8	0
386331	77825	8	0
386332	77826	8	0
386333	77827	8	0
386334	77828	8	0
386335	77829	8	0
386336	77830	8	0
386337	77831	8	0
386338	77832	8	0
386339	77833	8	0
386340	77834	8	0
386341	77835	8	0
386342	77836	8	0
386343	77837	8	0
386344	77838	8	0
386345	77839	8	0
386346	77840	8	0
386347	77841	8	0
386348	77842	8	0
386349	77843	8	0
386350	77844	8	0
386351	77845	8	0
386352	77846	8	0
386353	77847	8	0
386354	77848	8	0
386355	77849	8	0
386356	77850	8	0
386357	77851	8	0
386358	77852	8	0
386359	77853	8	0
386360	77854	8	0
386361	77855	9	0
386362	77856	9	0
386363	77857	9	0
386364	77858	9	0
386365	77859	9	0
386366	77860	9	0
386367	77861	9	0
386368	77862	9	0
386369	77863	9	0
386370	77864	9	0
386371	77865	9	0
386372	77866	9	0
386373	77867	9	0
386374	77868	9	0
386375	77869	9	0
386376	77870	9	0
386377	77871	9	0
386378	77872	9	0
386379	77873	9	0
386380	77874	9	0
386381	77875	9	0
386382	77876	9	0
386383	77877	9	0
386384	77878	9	0
386385	77879	9	0
386386	77880	9	0
386387	77881	9	0
386388	77882	9	0
386389	77883	9	0
386390	77884	9	0
386391	77885	9	0
386392	77886	9	0
386393	77887	9	0
386394	77888	9	0
386395	77889	9	0
386396	77890	9	0
386397	77891	9	0
386398	77892	9	0
386399	77893	9	0
386400	77894	9	0
386401	77895	9	0
386402	77896	9	0
386403	77897	9	0
386404	77898	9	0
386405	77899	9	0
386406	77900	9	0
386407	77901	9	0
386408	77902	9	0
386409	77903	9	0
386410	77904	9	0
386411	77905	9	0
386412	77906	9	0
386413	77907	9	0
386414	77908	9	0
386415	77909	9	0
386416	77910	9	0
386417	77911	9	0
386418	77912	9	0
386419	77913	9	0
386420	77914	9	0
386421	77915	9	0
386422	77916	9	0
386423	77917	9	0
386424	77918	9	0
386425	77919	9	0
386426	77920	9	0
386427	77921	9	0
386428	77922	9	0
386429	77923	9	0
386430	77924	9	0
386431	77925	9	0
386432	77926	9	0
386433	77927	9	0
386434	77928	9	0
386435	77929	9	0
386436	77930	9	0
386437	77931	9	0
386438	77932	9	0
386439	77933	9	0
386440	77934	9	0
386441	77935	9	0
386442	77936	9	0
386443	77937	9	0
386444	77938	9	0
386445	77939	9	0
386446	77940	9	0
386447	77941	9	0
386448	77942	9	0
386449	77943	9	0
386450	77944	9	0
386451	77945	9	0
386452	77946	9	0
386453	77947	9	0
386454	77948	9	0
386455	77949	9	0
386456	77950	9	0
386457	77951	9	0
386458	77952	9	0
386459	77953	9	0
386460	77954	9	0
386461	77955	9	0
386462	77956	9	0
386463	77957	9	0
386464	77958	9	0
386465	77959	9	0
386466	77960	9	0
386467	77961	9	0
386468	77962	9	0
386469	77963	9	0
386470	77964	9	0
386471	77965	9	0
386472	77966	9	0
386473	77967	9	0
386474	77968	9	0
386475	77969	9	0
386476	77970	9	0
386477	77971	9	0
386478	77972	9	0
386479	77973	9	0
386480	77974	9	0
386481	77975	9	0
386482	77976	9	0
386483	77977	9	0
386484	77978	9	0
386485	77979	9	0
386486	77980	9	0
386487	77981	9	0
386488	77982	9	0
386489	77983	9	0
386490	77984	9	0
386491	77985	9	0
386492	77986	9	0
386493	77987	9	0
386494	77988	9	0
386495	77989	9	0
386496	77990	9	0
386497	77991	9	0
386498	77992	9	0
386499	77993	9	0
386500	77994	9	0
386501	77995	9	0
386502	77996	9	0
386503	77997	9	0
386504	77998	9	0
386505	77999	9	0
386506	78000	9	0
386507	78001	9	0
386508	78002	9	0
386509	78003	9	0
386510	78004	9	0
386511	78005	9	0
386512	78006	9	0
386513	78007	9	0
386514	78008	9	0
386515	78009	9	0
386516	78010	9	0
386517	78011	9	0
386518	78012	9	0
386519	78013	9	0
386520	78014	9	0
386521	78015	9	0
386522	78016	9	0
386523	78017	9	0
386524	78018	9	0
386525	78019	9	0
386526	78020	9	0
386527	78021	9	0
386528	78022	9	0
386529	78023	9	0
386530	78024	9	0
386531	78025	9	0
386532	78026	9	0
386533	78027	9	0
386534	78028	9	0
386535	78029	9	0
386536	78030	9	0
386537	78031	9	0
386538	78032	9	0
386539	78033	9	0
386540	78034	9	0
386541	78035	9	0
386542	78036	9	0
386543	78037	9	0
386544	78038	9	0
386545	78039	9	0
386546	78040	9	0
386547	78041	9	0
386548	78042	9	0
386549	78043	9	0
386550	78044	9	0
386551	78045	9	0
386552	78046	9	0
386553	78047	9	0
386554	78048	9	0
386555	78049	9	0
386556	78050	9	0
386557	78051	9	0
386558	78052	9	0
386559	78053	9	0
386560	78054	9	0
386561	78055	9	0
386562	78056	9	0
386563	78057	9	0
386564	78058	9	0
386565	78059	9	0
386566	78060	9	0
386567	78061	9	0
386568	78062	9	0
386569	78063	9	0
386570	78064	9	0
386571	78065	9	0
386572	78066	9	0
386573	78067	9	0
386574	78068	9	0
386575	78069	9	0
386576	78070	9	0
386577	78071	9	0
386578	78072	9	0
386579	78073	9	0
386580	78074	9	0
386581	78075	9	0
386582	78076	9	0
386583	78077	9	0
386584	78078	9	0
386585	78079	9	0
386586	78080	9	0
386587	78081	9	0
386588	78082	9	0
386589	78083	9	0
386590	78084	9	0
386591	78085	9	0
386592	78086	9	0
386593	78087	9	0
386594	78088	9	0
386595	78089	9	0
386596	78090	9	0
386597	78091	9	0
386598	78092	9	0
386599	78093	9	0
386600	78094	9	0
386601	78095	9	0
386602	78096	9	0
386603	78097	9	0
386604	78098	9	0
386605	78099	9	0
386606	78100	9	0
386607	78101	9	0
386608	78102	9	0
386609	78103	9	0
386610	78104	9	0
386611	78105	9	0
386612	78106	9	0
386613	78107	9	0
386614	78108	9	0
386615	78109	9	0
386616	78110	9	0
386617	78111	9	0
386618	78112	9	0
386619	78113	9	0
386620	78114	9	0
386621	78115	9	0
386622	78116	9	0
386623	78117	9	0
386624	78118	9	0
386625	78119	9	0
386626	78120	9	0
386627	78121	9	0
386628	78122	9	0
386629	78123	9	0
386630	78124	9	0
386631	78125	9	0
386632	78126	9	0
386633	78127	9	0
386634	78128	9	0
386635	78129	9	0
386636	78130	9	0
386637	78131	9	0
386638	78132	9	0
386639	78133	9	0
386640	78134	9	0
386641	78135	9	0
386642	78136	9	0
386643	78137	9	0
386644	78138	9	0
386645	78139	9	0
386646	78140	9	0
386647	78141	9	0
386648	78142	9	0
386649	78143	9	0
386650	78144	9	0
386651	78145	9	0
386652	78146	9	0
386653	78147	9	0
386654	78148	9	0
386655	78149	9	0
386656	78150	9	0
386657	78151	9	0
386658	78152	9	0
386659	78153	9	0
386660	78154	9	0
386661	78155	9	0
386662	78156	9	0
386663	78157	9	0
386664	78158	9	0
386665	78159	9	0
386666	78160	9	0
386667	78161	9	0
386668	78162	9	0
386669	78163	9	0
386670	78164	9	0
386671	78165	9	0
386672	78166	9	0
386673	78167	9	0
386674	78168	9	0
386675	78169	9	0
386676	78170	9	0
386677	78171	9	0
386678	78172	9	0
386679	78173	9	0
386680	78174	9	0
386681	78175	9	0
386682	78176	9	0
386683	78177	9	0
386684	78178	9	0
386685	78179	9	0
386686	78180	9	0
386687	78181	9	0
386688	78182	9	0
386689	78183	9	0
386690	78184	9	0
386691	78185	9	0
386692	78186	9	0
386693	78187	9	0
386694	78188	9	0
386695	78189	9	0
386696	78190	9	0
386697	78191	9	0
386698	78192	9	0
386699	78193	9	0
386700	78194	9	0
386701	78195	9	0
386702	78196	9	0
386703	78197	9	0
386704	78198	9	0
386705	78199	9	0
386706	78200	9	0
386707	78201	9	0
386708	78202	9	0
386709	78203	9	0
386710	78204	9	0
386711	78205	9	0
386712	78206	9	0
386713	78207	9	0
386714	78208	9	0
386715	78209	9	0
386716	78210	9	0
386717	78211	9	0
386718	78212	9	0
386719	78213	9	0
386720	78214	9	0
386721	78215	9	0
386722	78216	9	0
386723	78217	9	0
386724	78218	9	0
386725	78219	9	0
386726	78220	9	0
386727	78221	9	0
386728	78222	9	0
386729	78223	10	0
386730	78224	10	0
386731	78225	10	0
386732	78226	10	0
386733	78227	10	0
386734	78228	10	0
386735	78229	10	0
386736	78230	10	0
386737	78231	10	0
386738	78232	10	0
386739	78233	10	0
386740	78234	10	0
386741	78235	10	0
386742	78236	10	0
386743	78237	10	0
386744	78238	10	0
386745	78239	10	0
386746	78240	10	0
386747	78241	10	0
386748	78242	10	0
386749	78243	10	0
386750	78244	10	0
386751	78245	10	0
386752	78246	10	0
386753	78247	10	0
386754	78248	10	0
386755	78249	10	0
386756	78250	10	0
386757	78251	10	0
386758	78252	10	0
386759	78253	10	0
386760	78254	10	0
386761	78255	10	0
386762	78256	10	0
386763	78257	10	0
386764	78258	10	0
386765	78259	10	0
386766	78260	10	0
386767	78261	10	0
386768	78262	10	0
386769	78263	10	0
386770	78264	10	0
386771	78265	10	0
386772	78266	10	0
386773	78267	10	0
386774	78268	10	0
386775	78269	10	0
386776	78270	10	0
386777	78271	10	0
386778	78272	10	0
386779	78273	10	0
386780	78274	10	0
386781	78275	10	0
386782	78276	10	0
386783	78277	10	0
386784	78278	10	0
386785	78279	10	0
386786	78280	10	0
386787	78281	10	0
386788	78282	10	0
386789	78283	10	0
386790	78284	10	0
386791	78285	10	0
386792	78286	10	0
386793	78287	10	0
386794	78288	10	0
386795	78289	10	0
386796	78290	10	0
386797	78291	10	0
386798	78292	10	0
386799	78293	10	0
386800	78294	10	0
386801	78295	10	0
386802	78296	10	0
386803	78297	10	0
386804	78298	10	0
386805	78299	10	0
386806	78300	10	0
386807	78301	10	0
386808	78302	10	0
386809	78303	10	0
386810	78304	10	0
386811	78305	10	0
386812	78306	10	0
386813	78307	10	0
386814	78308	10	0
386815	78309	10	0
386816	78310	10	0
386817	78311	10	0
386818	78312	10	0
386819	78313	10	0
386820	78314	10	0
386821	78315	10	0
386822	78316	10	0
386823	78317	10	0
386824	78318	10	0
386825	78319	10	0
386826	78320	10	0
386827	78321	10	0
386828	78322	10	0
386829	78323	10	0
386830	78324	10	0
386831	78325	10	0
386832	78326	10	0
386833	78327	10	0
386834	78328	10	0
386835	78329	10	0
386836	78330	10	0
386837	78331	10	0
386838	78332	10	0
386839	78333	10	0
386840	78334	10	0
386841	78335	10	0
386842	78336	10	0
386843	78337	10	0
386844	78338	10	0
386845	78339	10	0
386846	78340	10	0
386847	78341	10	0
386848	78342	10	0
386849	78343	10	0
386850	78344	10	0
386851	78345	10	0
386852	78346	10	0
386853	78347	10	0
386854	78348	10	0
386855	78349	10	0
386856	78350	10	0
386857	78351	10	0
386858	78352	10	0
386859	78353	10	0
386860	78354	10	0
386861	78355	10	0
386862	78356	10	0
386863	78357	10	0
386864	78358	10	0
386865	78359	10	0
386866	78360	10	0
386867	78361	10	0
386868	78362	10	0
386869	78363	10	0
386870	78364	10	0
386871	78365	10	0
386872	78366	10	0
386873	78367	10	0
386874	78368	10	0
386875	78369	10	0
386876	78370	10	0
386877	78371	10	0
386878	78372	10	0
386879	78373	10	0
386880	78374	10	0
386881	78375	10	0
386882	78376	10	0
386883	78377	10	0
386884	78378	10	0
386885	78379	10	0
386886	78380	10	0
386887	78381	10	0
386888	78382	10	0
386889	78383	10	0
386890	78384	10	0
386891	78385	10	0
386892	78386	10	0
386893	78387	10	0
386894	78388	10	0
386895	78389	10	0
386896	78390	10	0
386897	78391	10	0
386898	78392	10	0
386899	78393	10	0
386900	78394	10	0
386901	78395	10	0
386902	78396	10	0
386903	78397	10	0
386904	78398	10	0
386905	78399	10	0
386906	78400	10	0
386907	78401	10	0
386908	78402	10	0
386909	78403	10	0
386910	78404	10	0
386911	78405	10	0
386912	78406	10	0
386913	78407	10	0
386914	78408	10	0
386915	78409	10	0
386916	78410	10	0
386917	78411	10	0
386918	78412	10	0
386919	78413	10	0
386920	78414	10	0
386921	78415	10	0
386922	78416	10	0
386923	78417	10	0
386924	78418	10	0
386925	78419	10	0
386926	78420	10	0
386927	78421	10	0
386928	78422	10	0
386929	78423	10	0
386930	78424	10	0
386931	78425	10	0
386932	78426	10	0
386933	78427	10	0
386934	78428	10	0
386935	78429	10	0
386936	78430	10	0
386937	78431	10	0
386938	78432	10	0
386939	78433	10	0
386940	78434	10	0
386941	78435	10	0
386942	78436	10	0
386943	78437	10	0
386944	78438	10	0
386945	78439	10	0
386946	78440	10	0
386947	78441	10	0
386948	78442	10	0
386949	78443	10	0
386950	78444	10	0
386951	78445	10	0
386952	78446	10	0
386953	78447	10	0
386954	78448	10	0
386955	78449	10	0
386956	78450	10	0
386957	78451	10	0
386958	78452	10	0
386959	78453	10	0
386960	78454	10	0
386961	78455	10	0
386962	78456	10	0
386963	78457	10	0
386964	78458	10	0
386965	78459	10	0
386966	78460	10	0
386967	78461	10	0
386968	78462	10	0
386969	78463	10	0
386970	78464	10	0
386971	78465	10	0
386972	78466	10	0
386973	78467	10	0
386974	78468	10	0
386975	78469	10	0
386976	78470	10	0
386977	78471	10	0
386978	78472	10	0
386979	78473	10	0
386980	78474	10	0
386981	78475	10	0
386982	78476	10	0
386983	78477	10	0
386984	78478	10	0
386985	78479	11	0
386986	78480	11	0
386987	78481	11	0
386988	78482	11	0
386989	78483	11	0
386990	78484	11	0
386991	78485	11	0
386992	78486	11	0
386993	78487	11	0
386994	78488	11	0
386995	78489	11	0
386996	78490	11	0
386997	78491	11	0
386998	78492	11	0
386999	78493	11	0
387000	78494	11	0
387001	78495	11	0
387002	78496	11	0
387003	78497	11	0
387004	78498	11	0
387005	78499	11	0
387006	78500	11	0
387007	78501	11	0
387008	78502	11	0
387009	78503	11	0
387010	78504	11	0
387011	78505	11	0
387012	78506	11	0
387013	78507	11	0
387014	78508	11	0
387015	78509	11	0
387016	78510	11	0
387017	78511	11	0
387018	78512	11	0
387019	78513	11	0
387020	78514	11	0
387021	78515	11	0
387022	78516	11	0
387023	78517	11	0
387024	78518	11	0
387025	78519	11	0
387026	78520	11	0
387027	78521	11	0
387028	78522	11	0
387029	78523	11	0
387030	78524	11	0
387031	78525	11	0
387032	78526	11	0
387033	78527	11	0
387034	78528	11	0
387035	78529	11	0
387036	78530	11	0
387037	78531	11	0
387038	78532	11	0
387039	78533	11	0
387040	78534	11	0
387041	78535	11	0
387042	78536	11	0
387043	78537	11	0
387044	78538	11	0
387045	78539	11	0
387046	78540	11	0
387047	78541	11	0
387048	78542	11	0
387049	78543	11	0
387050	78544	11	0
387051	78545	11	0
387052	78546	11	0
387053	78547	11	0
387054	78548	11	0
387055	78549	11	0
387056	78550	11	0
387057	78551	11	0
387058	78552	11	0
387059	78553	11	0
387060	78554	11	0
387061	78555	11	0
387062	78556	11	0
387063	78557	11	0
387064	78558	11	0
387065	78559	11	0
387066	78560	11	0
387067	78561	11	0
387068	78562	11	0
387069	78563	11	0
387070	78564	11	0
387071	78565	11	0
387072	78566	11	0
387073	78567	11	0
387074	78568	11	0
387075	78569	11	0
387076	78570	11	0
387077	78571	11	0
387078	78572	11	0
387079	78573	11	0
387080	78574	11	0
387081	78575	11	0
387082	78576	11	0
387083	78577	11	0
387084	78578	11	0
387085	78579	11	0
387086	78580	11	0
387087	78581	11	0
387088	78582	11	0
387089	78583	11	0
387090	78584	11	0
387091	78585	11	0
387092	78586	11	0
387093	78587	11	0
387094	78588	11	0
387095	78589	11	0
387096	78590	11	0
387097	78591	11	0
387098	78592	11	0
387099	78593	11	0
387100	78594	11	0
387101	78595	11	0
387102	78596	11	0
387103	78597	11	0
387104	78598	11	0
387105	78599	11	0
387106	78600	11	0
387107	78601	11	0
387108	78602	11	0
387109	78603	11	0
387110	78604	11	0
387111	78605	11	0
387112	78606	11	0
387113	78607	11	0
387114	78608	11	0
387115	78609	11	0
387116	78610	11	0
387117	78611	11	0
387118	78612	11	0
387119	78613	11	0
387120	78614	11	0
387121	78615	11	0
387122	78616	11	0
387123	78617	11	0
387124	78618	11	0
387125	78619	11	0
387126	78620	11	0
387127	78621	11	0
387128	78622	11	0
387129	78623	11	0
387130	78624	11	0
387131	78625	11	0
387132	78626	11	0
387133	78627	11	0
387134	78628	11	0
387135	78629	11	0
387136	78630	11	0
387137	78631	11	0
387138	78632	11	0
387139	78633	11	0
387140	78634	11	0
387141	78635	11	0
387142	78636	11	0
387143	78637	11	0
387144	78638	11	0
387145	78639	11	0
387146	78640	11	0
387147	78641	11	0
387148	78642	11	0
387149	78643	11	0
387150	78644	11	0
387151	78645	11	0
387152	78646	11	0
387153	78647	11	0
387154	78648	11	0
387155	78649	11	0
387156	78650	11	0
387157	78651	11	0
387158	78652	11	0
387159	78653	11	0
387160	78654	11	0
387161	78655	11	0
387162	78656	11	0
387163	78657	11	0
387164	78658	11	0
387165	78659	11	0
387166	78660	11	0
387167	78661	11	0
387168	78662	11	0
387169	78663	11	0
387170	78664	11	0
387171	78665	11	0
387172	78666	11	0
387173	78667	11	0
387174	78668	11	0
387175	78669	11	0
387176	78670	11	0
387177	78671	11	0
387178	78672	11	0
387179	78673	11	0
387180	78674	11	0
387181	78675	11	0
387182	78676	11	0
387183	78677	11	0
387184	78678	11	0
387185	78679	11	0
387186	78680	11	0
387187	78681	11	0
387188	78682	11	0
387189	78683	11	0
387190	78684	11	0
387191	78685	11	0
387192	78686	11	0
387193	78687	0	0
387194	78688	0	0
387195	78689	0	0
387196	78690	0	0
387197	78691	0	0
387198	78692	0	0
387199	78693	0	0
387200	78694	0	0
387201	78695	0	0
387202	78696	0	0
387203	78697	0	0
387204	78698	0	0
387205	78699	0	0
387206	78700	0	0
387207	78701	0	0
387208	78702	0	0
387209	78703	1	0
387210	78704	1	0
387211	78705	1	0
387212	78706	1	0
387213	78707	1	0
387214	78708	1	0
387215	78709	1	0
387216	78710	1	0
387217	78711	1	0
387218	78712	1	0
387219	78713	1	0
387220	78714	1	0
387221	78715	1	0
387222	78716	1	0
387223	78717	1	0
387224	78718	1	0
387225	78719	2	0
387226	78720	2	0
387227	78721	2	0
387228	78722	2	0
387229	78723	2	0
387230	78724	2	0
387231	78725	2	0
387232	78726	2	0
387233	78727	2	0
387234	78728	2	0
387235	78729	2	0
387236	78730	2	0
387237	78731	2	0
387238	78732	2	0
387239	78733	2	0
387240	78734	2	0
387241	78735	3	0
387242	78736	3	0
387243	78737	3	0
387244	78738	3	0
387245	78739	3	0
387246	78740	3	0
387247	78741	3	0
387248	78742	3	0
387249	78743	3	0
387250	78744	3	0
387251	78745	3	0
387252	78746	3	0
387253	78747	3	0
387254	78748	3	0
387255	78749	3	0
387256	78750	3	0
387257	78751	4	0
387258	78752	4	0
387259	78753	4	0
387260	78754	4	0
387261	78755	4	0
387262	78756	4	0
387263	78757	4	0
387264	78758	4	0
387265	78759	4	0
387266	78760	4	0
387267	78761	4	0
387268	78762	4	0
387269	78763	4	0
387270	78764	4	0
387271	78765	4	0
387272	78766	4	0
387273	78767	4	0
387274	78768	5	0
387275	78769	5	0
387276	78770	5	0
387277	78771	5	0
387278	78772	5	0
387279	78773	5	0
387280	78774	5	0
387281	78775	5	0
387282	78776	5	0
387283	78777	5	0
387284	78778	5	0
387285	78779	5	0
387286	78780	5	0
387287	78781	5	0
387288	78782	5	0
387289	78783	5	0
387290	78784	5	0
387291	78785	6	0
387292	78786	6	0
387293	78787	6	0
387294	78788	6	0
387295	78789	6	0
387296	78790	6	0
387297	78791	6	0
387298	78792	6	0
387299	78793	6	0
387300	78794	6	0
387301	78795	6	0
387302	78796	6	0
387303	78797	6	0
387304	78798	6	0
387305	78799	6	0
387306	78800	7	0
387307	78801	7	0
387308	78802	7	0
387309	78803	7	0
387310	78804	7	0
387311	78805	7	0
387312	78806	7	0
387313	78807	7	0
387314	78808	7	0
387315	78809	7	0
387316	78810	7	0
387317	78811	7	0
387318	78812	7	0
387319	78813	7	0
387320	78814	7	0
387321	78815	8	0
387322	78816	8	0
387323	78817	8	0
387324	78818	8	0
387325	78819	8	0
387326	78820	8	0
387327	78821	8	0
387328	78822	8	0
387329	78823	8	0
387330	78824	8	0
387331	78825	8	0
387332	78826	8	0
387333	78827	8	0
387334	78828	8	0
387335	78829	8	0
387336	78830	8	0
387337	78831	8	0
387338	78832	8	0
387339	78833	9	0
387340	78834	9	0
387341	78835	9	0
387342	78836	9	0
387343	78837	9	0
387344	78838	9	0
387345	78839	9	0
387346	78840	9	0
387347	78841	9	0
387348	78842	9	0
387349	78843	9	0
387350	78844	9	0
387351	78845	9	0
387352	78846	9	0
387353	78847	9	0
387354	78848	9	0
387355	78849	9	0
387356	78850	9	0
387357	78851	10	0
387358	78852	10	0
387359	78853	10	0
387360	78854	10	0
387361	78855	10	0
387362	78856	10	0
387363	78857	10	0
387364	78858	10	0
387365	78859	10	0
387366	78860	10	0
387367	78861	10	0
387368	78862	10	0
387369	78863	10	0
387370	78864	11	0
387371	78865	11	0
387372	78866	11	0
387373	78867	11	0
387374	78868	11	0
387375	78869	11	0
387376	78870	11	0
387377	78871	11	0
387378	78872	11	0
387379	78873	11	0
387380	78874	11	0
387381	78875	11	0
387382	78876	11	0
387383	78877	11	0
\.


--
-- TOC entry 3498 (class 0 OID 16420)
-- Dependencies: 228
-- Data for Name: sc_rasp18_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18_info (id, rasp18_id, kind, info) FROM stdin;
\.


--
-- TOC entry 3500 (class 0 OID 16426)
-- Dependencies: 230
-- Data for Name: sc_rasp18_move; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18_move (id, rasp18_dest_id, src_day_id, src_pair, reason, comment) FROM stdin;
\.


--
-- TOC entry 3502 (class 0 OID 16432)
-- Dependencies: 232
-- Data for Name: sc_rasp18_preps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18_preps (id, rasp18_id, prep_id) FROM stdin;
270590	76729	34
270591	76730	34
270592	76731	34
270593	76732	34
270594	76733	34
270595	76734	34
270596	76735	35
270597	76736	35
270598	76737	35
270599	76738	35
270600	76739	35
270601	76740	35
270602	76741	35
270603	76742	35
270604	76743	35
270605	76744	35
270606	76745	35
270607	76746	35
270608	76747	35
270609	76748	35
270610	76749	35
270611	76750	35
270612	76751	36
270613	76752	36
270614	76753	36
270615	76754	36
270616	76755	36
270617	76756	36
270618	76757	36
270619	76758	36
270620	76759	26
270621	76760	26
270622	76761	26
270623	76762	26
270624	76763	26
270625	76764	26
269132	75191	0
269133	75192	0
269134	75193	0
269135	75194	0
269136	75195	0
269137	75196	0
269138	75197	0
269139	75198	0
269140	75199	0
269141	75200	0
269142	75201	0
269143	75202	0
269144	75203	0
269145	75204	0
269146	75205	0
269147	75206	0
269148	75207	1
269149	75208	1
269150	75209	1
269151	75210	1
269152	75211	1
269153	75212	1
269154	75213	1
269155	75214	1
269156	75215	1
269157	75216	1
269158	75217	1
269159	75218	1
269160	75219	1
269161	75220	1
269162	75221	1
269163	75222	1
269164	75223	2
269165	75224	2
269166	75225	2
269167	75226	2
269168	75227	2
269169	75228	2
269170	75229	2
269171	75230	2
269172	75231	2
269173	75232	2
269174	75233	2
269175	75234	2
269176	75235	2
269177	75236	2
269178	75237	2
269179	75238	2
269180	75239	3
269181	75240	3
269182	75241	3
269183	75242	3
269184	75243	3
269185	75244	3
269186	75245	3
269187	75246	3
269188	75247	3
269189	75248	3
269190	75249	3
269191	75250	3
269192	75251	3
269193	75252	3
269194	75253	3
269195	75254	3
269196	75255	4
269197	75256	4
269198	75257	4
269199	75258	4
269200	75259	4
269201	75260	4
269202	75261	4
269203	75262	4
269204	75263	5
269205	75264	5
269206	75265	5
269207	75266	5
269208	75267	5
269209	75268	5
269210	75269	5
269211	75270	5
269212	75271	6
269213	75272	6
269214	75273	6
269215	75274	6
269216	75275	6
269217	75276	6
269218	75277	6
269219	75278	6
269220	75279	6
269221	75280	6
269222	75281	6
269223	75282	6
269224	75283	6
269225	75284	6
269226	75285	6
269227	75286	6
269228	75287	6
269229	75288	6
269230	75289	6
269231	75290	6
269232	75291	6
269233	75292	6
269234	75293	6
269235	75294	6
269236	75295	6
269237	75296	6
269238	75297	6
269239	75298	6
269240	75299	6
269241	75300	6
269242	75301	6
269243	75302	6
269244	75303	7
269245	75304	7
269246	75305	7
269247	75306	7
269248	75307	7
269249	75308	7
269250	75309	7
269251	75310	7
269252	75311	7
269253	75312	7
269254	75313	7
269255	75314	7
269256	75315	7
269257	75316	7
269258	75317	7
269259	75318	7
269260	75319	8
269261	75320	8
269262	75321	8
269263	75322	8
269264	75323	8
269265	75324	8
269266	75325	8
269267	75326	8
269268	75327	8
269269	75328	8
269270	75329	8
269271	75330	8
269272	75331	8
269273	75332	8
269274	75333	8
269275	75334	8
269276	75335	7
269277	75336	7
269278	75337	7
269279	75338	7
269280	75339	7
269281	75340	7
269282	75341	7
269283	75342	7
269284	75343	7
269285	75344	7
269286	75345	7
269287	75346	7
269288	75347	7
269289	75348	7
269290	75349	7
269291	75350	7
269292	75351	9
269293	75352	9
269294	75353	9
269295	75354	9
269296	75355	9
269297	75356	9
269298	75357	9
269299	75358	9
269300	75359	9
269301	75360	9
269302	75361	9
269303	75362	9
269304	75363	9
269305	75364	9
269306	75365	9
269307	75366	9
269308	75367	10
269309	75368	10
269310	75369	10
269311	75370	10
269312	75371	10
269313	75372	10
269314	75373	10
269315	75374	10
269316	75375	10
269317	75376	10
269318	75377	10
269319	75378	10
269320	75379	10
269321	75380	10
269322	75381	10
269323	75382	10
269324	75383	11
269325	75384	11
269326	75385	11
269327	75386	11
269328	75387	11
269329	75388	11
269330	75389	11
269331	75390	11
269332	75407	11
269333	75408	11
269334	75409	11
269335	75410	11
269336	75411	11
269337	75412	11
269338	75413	11
269339	75414	11
269340	75415	11
269341	75416	11
269342	75417	11
269343	75418	11
269344	75419	11
269345	75420	11
269346	75421	11
269347	75422	11
269348	75423	12
269349	75424	12
269350	75425	12
269351	75426	12
269352	75427	12
269353	75428	12
269354	75429	12
269355	75430	12
269356	75431	13
269357	75432	13
269358	75433	13
269359	75434	13
269360	75435	13
269361	75436	13
269362	75437	13
269363	75438	13
269364	75439	12
269365	75440	12
269366	75441	12
269367	75442	12
269368	75443	12
269369	75444	12
269370	75445	12
269371	75446	12
269372	75447	14
269373	75448	14
269374	75449	14
269375	75450	14
269376	75451	14
269377	75452	14
269378	75453	14
269379	75454	14
269380	75455	14
269381	75456	14
269382	75457	14
269383	75458	14
269384	75459	14
269385	75460	14
269386	75461	14
269387	75462	14
269388	75463	14
269389	75464	14
269390	75465	14
269391	75466	14
269392	75467	14
269393	75468	14
269394	75469	14
269395	75470	14
269396	75471	14
269397	75472	14
269398	75473	14
269399	75474	14
269400	75475	14
269401	75476	14
269402	75477	14
269403	75478	14
269404	75479	15
269405	75480	15
269406	75481	15
269407	75482	15
269408	75483	15
269409	75484	15
269410	75485	15
269411	75486	15
269412	75487	15
269413	75488	15
269414	75489	15
269415	75490	15
269416	75491	15
269417	75492	15
269418	75493	15
269419	75494	15
269420	75495	16
269421	75496	16
269422	75497	16
269423	75498	16
269424	75499	16
269425	75500	16
269426	75501	16
269427	75502	16
269428	75503	5
269429	75504	5
269430	75505	5
269431	75506	5
269432	75507	5
269433	75508	5
269434	75509	5
269435	75510	5
269436	75511	17
269437	75512	17
269438	75513	17
269439	75514	17
269440	75515	17
269441	75516	17
269442	75517	17
269443	75518	17
269444	75519	17
269445	75520	17
269446	75521	17
269447	75522	17
269448	75523	17
269449	75524	17
269450	75525	17
269451	75526	17
269452	75527	1
269453	75528	1
269454	75529	1
269455	75530	1
269456	75531	1
269457	75532	1
269458	75533	1
269459	75534	1
269460	75535	1
269461	75536	1
269462	75537	1
269463	75538	1
269464	75539	1
269465	75540	1
269466	75541	1
269467	75542	1
269468	75543	15
269469	75544	15
269470	75545	15
269471	75546	15
269472	75547	15
269473	75548	15
269474	75549	15
269475	75550	15
269476	75551	15
269477	75552	15
269478	75553	15
269479	75554	15
269480	75555	15
269481	75556	15
269482	75557	15
269483	75558	15
269484	75559	4
269485	75560	4
269486	75561	4
269487	75562	4
269488	75563	4
269489	75564	4
269490	75565	4
269491	75566	4
269492	75567	4
269493	75568	4
269494	75569	4
269495	75570	4
269496	75571	4
269497	75572	4
269498	75573	4
269499	75574	4
269500	75575	4
269501	75576	4
269502	75577	4
269503	75578	4
269504	75579	4
269505	75580	4
269506	75581	4
269507	75582	4
269508	75583	5
269509	75584	5
269510	75585	5
269511	75586	5
269512	75587	5
269513	75588	5
269514	75589	5
269515	75590	5
269516	75591	18
269517	75592	18
269518	75593	18
269519	75594	18
269520	75595	18
269521	75596	18
269522	75597	18
269523	75598	18
269524	75599	18
269525	75600	18
269526	75601	18
269527	75602	18
269528	75603	18
269529	75604	18
269530	75605	18
269531	75606	18
269532	75623	7
269533	75624	7
269534	75625	7
269535	75626	7
269536	75627	7
269537	75628	7
269538	75629	7
269539	75630	7
269540	75631	7
269541	75632	7
269542	75633	7
269543	75634	7
269544	75635	7
269545	75636	7
269546	75637	7
269547	75638	7
269548	75639	8
269549	75640	8
269550	75641	8
269551	75642	8
269552	75643	8
269553	75644	8
269554	75645	8
269555	75646	8
269556	75647	8
269557	75648	8
269558	75649	8
269559	75650	8
269560	75651	8
269561	75652	8
269562	75653	8
269563	75654	8
269564	75655	7
269565	75656	7
269566	75657	7
269567	75658	7
269568	75659	7
269569	75660	7
269570	75661	7
269571	75662	7
269572	75663	7
269573	75664	7
269574	75665	7
269575	75666	7
269576	75667	7
269577	75668	7
269578	75669	7
269579	75670	7
269580	75671	6
269581	75672	6
269582	75673	6
269583	75674	6
269584	75675	6
269585	75676	6
269586	75677	6
269587	75678	6
269588	75679	6
269589	75680	6
269590	75681	6
269591	75682	6
269592	75683	6
269593	75684	6
269594	75685	6
269595	75686	6
269596	75687	6
269597	75688	6
269598	75689	6
269599	75690	6
269600	75691	6
269601	75692	6
269602	75693	6
269603	75694	6
269604	75695	6
269605	75696	6
269606	75697	6
269607	75698	6
269608	75699	6
269609	75700	6
269610	75701	6
269611	75702	6
269612	75703	10
269613	75704	10
269614	75705	10
269615	75706	10
269616	75707	10
269617	75708	10
269618	75709	10
269619	75710	10
269620	75711	10
269621	75712	10
269622	75713	10
269623	75714	10
269624	75715	10
269625	75716	10
269626	75717	10
269627	75718	10
269628	75719	11
269629	75720	11
269630	75721	11
269631	75722	11
269632	75723	11
269633	75724	11
269634	75725	11
269635	75726	11
269636	75727	11
269637	75728	11
269638	75729	11
269639	75730	11
269640	75731	11
269641	75732	11
269642	75733	11
269643	75734	11
269644	75735	11
269645	75736	11
269646	75737	11
269647	75738	11
269648	75739	11
269649	75740	11
269650	75741	11
269651	75742	11
269652	75743	12
269653	75744	12
269654	75745	12
269655	75746	12
269656	75747	12
269657	75748	12
269658	75749	12
269659	75750	12
269660	75751	13
269661	75752	13
269662	75753	13
269663	75754	13
269664	75755	13
269665	75756	13
269666	75757	13
269667	75758	13
269668	75759	12
269669	75760	12
269670	75761	12
269671	75762	12
269672	75763	12
269673	75764	12
269674	75765	12
269675	75766	12
269676	75767	2
269677	75768	2
269678	75769	2
269679	75770	2
269680	75771	2
269681	75772	2
269682	75773	2
269683	75774	2
269684	75775	2
269685	75776	2
269686	75777	2
269687	75778	2
269688	75779	2
269689	75780	2
269690	75781	2
269691	75782	2
269692	75783	14
269693	75784	14
269694	75785	14
269695	75786	14
269696	75787	14
269697	75788	14
269698	75789	14
269699	75790	14
269700	75791	14
269701	75792	14
269702	75793	14
269703	75794	14
269704	75795	14
269705	75796	14
269706	75797	14
269707	75798	14
269708	75799	15
269709	75800	15
269710	75801	15
269711	75802	15
269712	75803	15
269713	75804	15
269714	75805	15
269715	75806	15
269716	75807	15
269717	75808	15
269718	75809	15
269719	75810	15
269720	75811	15
269721	75812	15
269722	75813	15
269723	75814	15
269724	75815	16
269725	75816	16
269726	75817	16
269727	75818	16
269728	75819	16
269729	75820	16
269730	75821	16
269731	75822	16
269732	75823	5
269733	75824	5
269734	75825	5
269735	75826	5
269736	75827	5
269737	75828	5
269738	75829	5
269739	75830	5
269740	75831	5
269741	75832	5
269742	75833	5
269743	75834	5
269744	75835	5
269745	75836	5
269746	75837	5
269747	75838	5
269748	75839	19
269749	75840	19
269750	75841	19
269751	75842	19
269752	75843	19
269753	75844	19
269754	75845	19
269755	75846	19
269756	75847	19
269757	75848	19
269758	75849	19
269759	75850	19
269760	75851	19
269761	75852	19
269762	75853	19
269763	75854	19
269764	75855	20
269765	75856	20
269766	75857	20
269767	75858	20
269768	75859	20
269769	75860	20
269770	75861	20
269771	75862	20
269772	75863	20
269773	75864	20
269774	75865	20
269775	75866	20
269776	75867	20
269777	75868	20
269778	75869	20
269779	75870	20
269780	75871	4
269781	75872	4
269782	75873	4
269783	75874	4
269784	75875	4
269785	75876	4
269786	75877	4
269787	75878	4
269788	75879	10
269789	75880	10
269790	75881	10
269791	75882	10
269792	75883	10
269793	75884	10
269794	75885	10
269795	75886	10
269796	75887	10
269797	75888	10
269798	75889	10
269799	75890	10
269800	75891	10
269801	75892	10
269802	75893	10
269803	75894	10
269804	75895	10
269805	75896	10
269806	75897	10
269807	75898	10
269808	75899	10
269809	75900	10
269810	75901	10
269811	75902	10
269812	75903	10
269813	75904	10
269814	75905	10
269815	75906	10
269816	75907	10
269817	75908	10
269818	75909	10
269819	75910	10
269820	75911	18
269821	75912	18
269822	75913	18
269823	75914	18
269824	75915	18
269825	75916	18
269826	75917	18
269827	75918	18
269828	75919	18
269829	75920	18
269830	75921	18
269831	75922	18
269832	75923	18
269833	75924	18
269834	75925	18
269835	75926	18
269836	75927	7
269837	75928	7
269838	75929	7
269839	75930	7
269840	75931	7
269841	75932	7
269842	75933	7
269843	75934	7
269844	75935	7
269845	75936	7
269846	75937	7
269847	75938	7
269848	75939	7
269849	75940	7
269850	75941	7
269851	75942	7
269852	75943	8
269853	75944	8
269854	75945	8
269855	75946	8
269856	75947	8
269857	75948	8
269858	75949	8
269859	75950	8
269860	75951	8
269861	75952	8
269862	75953	8
269863	75954	8
269864	75955	8
269865	75956	8
269866	75957	8
269867	75958	8
269868	75959	7
269869	75960	7
269870	75961	7
269871	75962	7
269872	75963	7
269873	75964	7
269874	75965	7
269875	75966	7
269876	75967	7
269877	75968	7
269878	75969	7
269879	75970	7
269880	75971	7
269881	75972	7
269882	75973	7
269883	75974	7
269884	75975	21
269885	75976	21
269886	75977	21
269887	75978	21
269888	75979	21
269889	75980	21
269890	75981	21
269891	75982	21
269892	75983	21
269893	75984	21
269894	75985	21
269895	75986	21
269896	75987	21
269897	75988	21
269898	75989	21
269899	75990	21
269900	75991	21
269901	75992	21
269902	75993	21
269903	75994	21
269904	75995	21
269905	75996	21
269906	75997	21
269907	75998	21
269908	75999	21
269909	76000	21
269910	76001	21
269911	76002	21
269912	76003	21
269913	76004	21
269914	76005	21
269915	76006	21
269916	76023	10
269917	76024	10
269918	76025	10
269919	76026	10
269920	76027	10
269921	76028	10
269922	76029	10
269923	76030	10
269924	76031	10
269925	76032	10
269926	76033	10
269927	76034	10
269928	76035	10
269929	76036	10
269930	76037	10
269931	76038	10
269932	76039	11
269933	76040	11
269934	76041	11
269935	76042	11
269936	76043	11
269937	76044	11
269938	76045	11
269939	76046	11
269940	76047	12
269941	76048	12
269942	76049	12
269943	76050	12
269944	76051	12
269945	76052	12
269946	76053	12
269947	76054	12
269948	76055	13
269949	76056	13
269950	76057	13
269951	76058	13
269952	76059	13
269953	76060	13
269954	76061	13
269955	76062	13
269956	76063	1
269957	76064	1
269958	76065	1
269959	76066	1
269960	76067	1
269961	76068	1
269962	76069	1
269963	76070	1
269964	76071	1
269965	76072	1
269966	76073	1
269967	76074	1
269968	76075	1
269969	76076	1
269970	76077	1
269971	76078	1
269972	76079	22
269973	76080	22
269974	76081	22
269975	76082	22
269976	76083	22
269977	76084	22
269978	76085	22
269979	76086	22
269980	76087	22
269981	76088	22
269982	76089	22
269983	76090	22
269984	76091	22
269985	76092	22
269986	76093	22
269987	76094	22
269988	76095	14
269989	76096	14
269990	76097	14
269991	76098	14
269992	76099	14
269993	76100	14
269994	76101	14
269995	76102	14
269996	76103	14
269997	76104	14
269998	76105	14
269999	76106	14
270000	76107	14
270001	76108	14
270002	76109	14
270003	76110	14
270004	76111	15
270005	76112	15
270006	76113	15
270007	76114	15
270008	76115	15
270009	76116	15
270010	76117	15
270011	76118	15
270012	76119	15
270013	76120	15
270014	76121	15
270015	76122	15
270016	76123	15
270017	76124	15
270018	76125	15
270019	76126	15
270020	76127	23
270021	76128	23
270022	76129	23
270023	76130	23
270024	76131	23
270025	76132	23
270026	76133	23
270027	76134	23
270028	76135	23
270029	76136	23
270030	76137	23
270031	76138	23
270032	76139	23
270033	76140	23
270034	76141	23
270035	76142	23
270036	76143	5
270037	76144	5
270038	76145	5
270039	76146	5
270040	76147	5
270041	76148	5
270042	76149	5
270043	76150	5
270044	76151	5
270045	76152	5
270046	76153	5
270047	76154	5
270048	76155	5
270049	76156	5
270050	76157	5
270051	76158	5
270052	76159	2
270053	76160	2
270054	76161	2
270055	76162	2
270056	76163	2
270057	76164	2
270058	76165	2
270059	76166	2
270060	76167	2
270061	76168	2
270062	76169	2
270063	76170	2
270064	76171	2
270065	76172	2
270066	76173	2
270067	76174	2
270068	76175	21
270069	76176	21
270070	76177	21
270071	76178	21
270072	76179	21
270073	76180	21
270074	76181	21
270075	76182	21
270076	76183	21
270077	76184	21
270078	76185	21
270079	76186	21
270080	76187	21
270081	76188	21
270082	76189	21
270083	76190	21
270084	76191	21
270085	76192	21
270086	76193	21
270087	76194	21
270088	76195	21
270089	76196	21
270090	76197	21
270091	76198	21
270092	76199	21
270093	76200	21
270094	76201	21
270095	76202	21
270096	76203	21
270097	76204	21
270098	76205	21
270099	76206	21
270100	76207	4
270101	76208	4
270102	76209	4
270103	76210	4
270104	76211	4
270105	76212	4
270106	76213	4
270107	76214	4
270108	76231	18
270109	76232	18
270110	76233	18
270111	76234	18
270112	76235	18
270113	76236	18
270114	76237	18
270115	76238	18
270116	76239	18
270117	76240	18
270118	76241	18
270119	76242	18
270120	76243	18
270121	76244	18
270122	76245	18
270123	76246	18
270124	76247	10
270125	76248	10
270126	76249	10
270127	76250	10
270128	76251	10
270129	76252	10
270130	76253	10
270131	76254	10
270132	76255	10
270133	76256	10
270134	76257	10
270135	76258	10
270136	76259	10
270137	76260	10
270138	76261	10
270139	76262	10
270140	76263	10
270141	76264	10
270142	76265	10
270143	76266	10
270144	76267	10
270145	76268	10
270146	76269	10
270147	76270	10
270148	76271	10
270149	76272	10
270150	76273	10
270151	76274	10
270152	76275	10
270153	76276	10
270154	76277	10
270155	76278	10
270156	76279	8
270157	76280	8
270158	76281	8
270159	76282	8
270160	76283	8
270161	76284	8
270162	76285	8
270163	76286	8
270164	76287	8
270165	76288	8
270166	76289	8
270167	76290	8
270168	76291	8
270169	76292	8
270170	76293	8
270171	76294	8
270172	76295	7
270173	76296	7
270174	76297	7
270175	76298	7
270176	76299	7
270177	76300	7
270178	76301	7
270179	76302	7
270180	76303	7
270181	76304	7
270182	76305	7
270183	76306	7
270184	76307	7
270185	76308	7
270186	76309	7
270187	76310	7
270188	76311	8
270189	76312	8
270190	76313	8
270191	76314	8
270192	76315	8
270193	76316	8
270194	76317	8
270195	76318	8
270196	76319	8
270197	76320	8
270198	76321	8
270199	76322	8
270200	76323	8
270201	76324	8
270202	76325	8
270203	76326	8
270204	76327	1
270205	76328	1
270206	76329	1
270207	76330	1
270208	76331	1
270209	76332	1
270210	76333	1
270211	76334	1
270212	76335	1
270213	76336	1
270214	76337	1
270215	76338	1
270216	76339	1
270217	76340	1
270218	76341	1
270219	76342	1
270220	76343	10
270221	76344	10
270222	76345	10
270223	76346	10
270224	76347	10
270225	76348	10
270226	76349	10
270227	76350	10
270228	76351	10
270229	76352	10
270230	76353	10
270231	76354	10
270232	76355	10
270233	76356	10
270234	76357	10
270235	76358	10
270236	76359	11
270237	76360	11
270238	76361	11
270239	76362	11
270240	76363	11
270241	76364	11
270242	76365	11
270243	76366	11
270244	76367	12
270245	76368	12
270246	76369	12
270247	76370	12
270248	76371	12
270249	76372	12
270250	76373	12
270251	76374	12
270252	76375	13
270253	76376	13
270254	76377	13
270255	76378	13
270256	76379	13
270257	76380	13
270258	76381	13
270259	76382	13
270260	76383	22
270261	76384	22
270262	76385	22
270263	76386	22
270264	76387	22
270265	76388	22
270266	76389	22
270267	76390	22
270268	76391	22
270269	76392	22
270270	76393	22
270271	76394	22
270272	76395	22
270273	76396	22
270274	76397	22
270275	76398	22
270276	76399	24
270277	76400	24
270278	76401	24
270279	76402	24
270280	76403	24
270281	76404	24
270282	76405	24
270283	76406	24
270284	76407	24
270285	76408	24
270286	76409	24
270287	76410	24
270288	76411	24
270289	76412	24
270290	76413	24
270291	76414	24
270292	76415	14
270293	76416	14
270294	76417	14
270295	76418	14
270296	76419	14
270297	76420	14
270298	76421	14
270299	76422	14
270300	76423	14
270301	76424	14
270302	76425	14
270303	76426	14
270304	76427	14
270305	76428	14
270306	76429	14
270307	76430	14
270308	76431	15
270309	76432	15
270310	76433	15
270311	76434	15
270312	76435	15
270313	76436	15
270314	76437	15
270315	76438	15
270316	76439	15
270317	76440	15
270318	76441	15
270319	76442	15
270320	76443	15
270321	76444	15
270322	76445	15
270323	76446	15
270324	76447	23
270325	76448	23
270326	76449	23
270327	76450	23
270328	76451	23
270329	76452	23
270330	76453	23
270331	76454	23
270332	76455	23
270333	76456	23
270334	76457	23
270335	76458	23
270336	76459	23
270337	76460	23
270338	76461	23
270339	76462	23
270340	76463	5
270341	76464	5
270342	76465	5
270343	76466	5
270344	76467	5
270345	76468	5
270346	76469	5
270347	76470	5
270348	76471	25
270349	76472	25
270350	76473	25
270351	76474	25
270352	76475	25
270353	76476	25
270354	76477	25
270355	76478	25
270356	76479	25
270357	76480	25
270358	76481	25
270359	76482	25
270360	76483	25
270361	76484	25
270362	76485	25
270363	76486	25
270364	76487	26
270365	76488	26
270366	76489	26
270367	76490	26
270368	76491	26
270369	76492	26
270370	76493	26
270371	76494	26
270372	76495	26
270373	76496	26
270374	76497	26
270375	76498	26
270376	76499	26
270377	76500	26
270378	76501	26
270379	76502	26
270380	76503	25
270381	76504	25
270382	76505	25
270383	76506	25
270384	76507	25
270385	76508	25
270386	76509	25
270387	76510	25
270388	76511	25
270389	76512	25
270390	76513	25
270391	76514	25
270392	76515	25
270393	76516	25
270394	76517	25
270395	76518	25
270396	76519	3
270397	76520	3
270398	76521	3
270399	76522	3
270400	76523	3
270401	76524	3
270402	76525	3
270403	76526	3
270404	76527	3
270405	76528	3
270406	76529	3
270407	76530	3
270408	76531	3
270409	76532	3
270410	76533	3
270411	76534	3
270412	76535	27
270413	76536	27
270414	76537	27
270415	76538	27
270416	76539	27
270417	76540	27
270418	76541	27
270419	76542	27
270420	76543	27
270421	76544	27
270422	76545	27
270423	76546	27
270424	76547	27
270425	76548	27
270426	76549	27
270427	76550	27
270428	76551	25
270429	76552	25
270430	76553	25
270431	76554	25
270432	76555	25
270433	76556	25
270434	76557	25
270435	76558	25
270436	76559	25
270437	76560	25
270438	76561	25
270439	76562	25
270440	76563	25
270441	76564	25
270442	76565	25
270443	76566	25
270444	76567	27
270445	76568	27
270446	76569	27
270447	76570	27
270448	76571	27
270449	76572	27
270450	76573	27
270451	76574	27
270452	76575	27
270453	76576	27
270454	76577	27
270455	76578	27
270456	76579	27
270457	76580	27
270458	76581	27
270459	76582	27
270460	76599	28
270461	76600	28
270462	76601	28
270463	76602	28
270464	76603	28
270465	76604	28
270466	76605	28
270467	76606	28
270468	76607	28
270469	76608	28
270470	76609	28
270471	76610	28
270472	76611	28
270473	76612	28
270474	76613	28
270475	76614	28
270476	76615	26
270477	76616	26
270478	76617	26
270479	76618	26
270480	76619	26
270481	76620	26
270482	76621	26
270483	76622	26
270484	76623	26
270485	76624	26
270486	76625	26
270487	76626	26
270488	76627	26
270489	76628	26
270490	76629	26
270491	76630	26
270492	76631	29
270493	76632	29
270494	76633	29
270495	76634	29
270496	76635	29
270497	76636	29
270498	76637	29
270499	76638	29
270500	76639	29
270501	76640	29
270502	76641	29
270503	76642	29
270504	76643	29
270505	76644	29
270506	76645	29
270507	76646	29
270508	76647	10
270509	76648	10
270510	76649	10
270511	76650	10
270512	76651	10
270513	76652	10
270514	76653	10
270515	76654	10
270516	76655	10
270517	76656	10
270518	76657	10
270519	76658	10
270520	76659	10
270521	76660	10
270522	76661	10
270523	76662	10
270524	76663	30
270525	76664	30
270526	76665	30
270527	76666	30
270528	76667	30
270529	76668	30
270530	76669	30
270531	76670	30
270532	76671	31
270533	76672	31
270534	76673	31
270535	76674	31
270536	76675	31
270537	76676	31
270538	76677	31
270539	76678	31
270540	76679	32
270541	76680	32
270542	76681	32
270543	76682	32
270544	76683	32
270545	76684	32
270546	76685	32
270547	76686	32
270548	76687	33
270549	76688	33
270550	76689	33
270551	76690	33
270552	76691	33
270553	76692	33
270554	76693	33
270555	76694	33
270556	76695	25
270557	76696	25
270558	76697	25
270559	76698	25
270560	76699	25
270561	76700	25
270562	76701	25
270563	76702	25
270564	76703	34
270565	76704	34
270566	76705	34
270567	76706	34
270568	76707	34
270569	76708	34
270570	76709	34
270571	76710	34
270572	76711	34
270573	76712	34
270574	76713	34
270575	76714	34
270576	76715	34
270577	76716	34
270578	76717	34
270579	76718	34
270580	76719	34
270581	76720	34
270582	76721	34
270583	76722	34
270584	76723	34
270585	76724	34
270586	76725	34
270587	76726	34
270588	76727	34
270589	76728	34
270626	76765	26
270627	76766	26
270628	76767	26
270629	76768	26
270630	76769	26
270631	76770	26
270632	76771	26
270633	76772	26
270634	76773	26
270635	76774	26
270636	76775	25
270637	76776	25
270638	76777	25
270639	76778	25
270640	76779	25
270641	76780	25
270642	76781	25
270643	76782	25
270644	76783	25
270645	76784	25
270646	76785	25
270647	76786	25
270648	76787	25
270649	76788	25
270650	76789	25
270651	76790	25
270652	76807	27
270653	76808	27
270654	76809	27
270655	76810	27
270656	76811	27
270657	76812	27
270658	76813	27
270659	76814	27
270660	76815	27
270661	76816	27
270662	76817	27
270663	76818	27
270664	76819	27
270665	76820	27
270666	76821	27
270667	76822	27
270668	76823	25
270669	76824	25
270670	76825	25
270671	76826	25
270672	76827	25
270673	76828	25
270674	76829	25
270675	76830	25
270676	76831	25
270677	76832	25
270678	76833	25
270679	76834	25
270680	76835	25
270681	76836	25
270682	76837	25
270683	76838	25
270684	76839	28
270685	76840	28
270686	76841	28
270687	76842	28
270688	76843	28
270689	76844	28
270690	76845	28
270691	76846	28
270692	76847	28
270693	76848	28
270694	76849	28
270695	76850	28
270696	76851	28
270697	76852	28
270698	76853	28
270699	76854	28
270700	76855	10
270701	76856	10
270702	76857	10
270703	76858	10
270704	76859	10
270705	76860	10
270706	76861	10
270707	76862	10
270708	76863	10
270709	76864	10
270710	76865	10
270711	76866	10
270712	76867	10
270713	76868	10
270714	76869	10
270715	76870	10
270716	76871	34
270717	76872	34
270718	76873	34
270719	76874	34
270720	76875	34
270721	76876	34
270722	76877	34
270723	76878	34
270724	76879	34
270725	76880	34
270726	76881	34
270727	76882	34
270728	76883	34
270729	76884	34
270730	76885	34
270731	76886	34
270732	76887	34
270733	76888	34
270734	76889	34
270735	76890	34
270736	76891	34
270737	76892	34
270738	76893	34
270739	76894	34
270740	76895	34
270741	76896	34
270742	76897	34
270743	76898	34
270744	76899	34
270745	76900	34
270746	76901	34
270747	76902	34
270748	76903	30
270749	76904	30
270750	76905	30
270751	76906	30
270752	76907	30
270753	76908	30
270754	76909	30
270755	76910	30
270756	76911	30
270757	76912	30
270758	76913	30
270759	76914	30
270760	76915	30
270761	76916	30
270762	76917	30
270763	76918	30
270764	76919	32
270765	76920	32
270766	76921	32
270767	76922	32
270768	76923	32
270769	76924	32
270770	76925	32
270771	76926	32
270772	76927	33
270773	76928	33
270774	76929	33
270775	76930	33
270776	76931	33
270777	76932	33
270778	76933	33
270779	76934	33
270780	76935	37
270781	76936	37
270782	76937	37
270783	76938	37
270784	76939	37
270785	76940	37
270786	76941	37
270787	76942	37
270788	76943	37
270789	76944	37
270790	76945	37
270791	76946	37
270792	76947	37
270793	76948	37
270794	76949	37
270795	76950	37
270796	76951	38
270797	76952	38
270798	76953	38
270799	76954	38
270800	76955	38
270801	76956	38
270802	76957	38
270803	76958	38
270804	76959	38
270805	76960	38
270806	76961	38
270807	76962	38
270808	76963	38
270809	76964	38
270810	76965	38
270811	76966	38
270812	76967	39
270813	76968	39
270814	76969	39
270815	76970	39
270816	76971	39
270817	76972	39
270818	76973	39
270819	76974	39
270820	76975	39
270821	76976	39
270822	76977	39
270823	76978	39
270824	76979	39
270825	76980	39
270826	76981	39
270827	76982	39
270828	76983	25
270829	76984	25
270830	76985	25
270831	76986	25
270832	76987	25
270833	76988	25
270834	76989	25
270835	76990	25
270836	76991	34
270837	76992	34
270838	76993	34
270839	76994	34
270840	76995	34
270841	76996	34
270842	76997	34
270843	76998	34
270844	76999	34
270845	77000	34
270846	77001	34
270847	77002	34
270848	77003	34
270849	77004	34
270850	77005	34
270851	77006	34
270852	77007	26
270853	77008	26
270854	77009	26
270855	77010	26
270856	77011	26
270857	77012	26
270858	77013	26
270859	77014	26
270860	77015	26
270861	77016	26
270862	77017	26
270863	77018	26
270864	77019	26
270865	77020	26
270866	77021	26
270867	77022	26
270868	77023	35
270869	77024	35
270870	77025	35
270871	77026	35
270872	77027	35
270873	77028	35
270874	77029	35
270875	77030	35
270876	77031	35
270877	77032	35
270878	77033	35
270879	77034	35
270880	77035	35
270881	77036	35
270882	77037	35
270883	77038	35
270884	77039	36
270885	77040	36
270886	77041	36
270887	77042	36
270888	77043	36
270889	77044	36
270890	77045	36
270891	77046	36
270892	77059	40
270893	77060	40
270894	77061	40
270895	77062	40
270896	77063	40
270897	77064	40
270898	77065	40
270899	77066	40
270900	77067	40
270901	77068	40
270902	77069	40
270903	77070	40
270904	77071	40
270905	77072	40
270906	77073	40
270907	77074	40
270908	77075	41
270909	77076	41
270910	77077	41
270911	77078	41
270912	77079	41
270913	77080	41
270914	77081	41
270915	77082	41
270916	77083	41
270917	77084	41
270918	77085	41
270919	77086	41
270920	77087	41
270921	77088	41
270922	77089	41
270923	77090	41
270924	77091	42
270925	77092	42
270926	77093	42
270927	77094	42
270928	77095	42
270929	77096	42
270930	77097	42
270931	77098	42
270932	77099	43
270933	77100	43
270934	77101	43
270935	77102	43
270936	77103	43
270937	77104	43
270938	77105	43
270939	77106	43
270940	77107	43
270941	77108	43
270942	77109	43
270943	77110	43
270944	77111	43
270945	77112	43
270946	77113	43
270947	77114	43
270948	77115	43
270949	77116	43
270950	77117	43
270951	77118	43
270952	77119	43
270953	77120	43
270954	77121	43
270955	77122	43
270956	77123	43
270957	77124	43
270958	77125	43
270959	77126	43
270960	77127	43
270961	77128	43
270962	77129	43
270963	77130	43
270964	77131	44
270965	77132	44
270966	77133	44
270967	77134	44
270968	77135	44
270969	77136	44
270970	77137	44
270971	77138	44
270972	77139	44
270973	77140	44
270974	77141	44
270975	77142	44
270976	77143	44
270977	77144	44
270978	77145	44
270979	77146	44
270980	77147	42
270981	77148	42
270982	77149	42
270983	77150	42
270984	77151	42
270985	77152	42
270986	77153	42
270987	77154	42
270988	77155	45
270989	77156	45
270990	77157	45
270991	77158	45
270992	77159	45
270993	77160	45
270994	77161	45
270995	77162	45
270996	77163	45
270997	77164	45
270998	77165	45
270999	77166	45
271000	77167	45
271001	77168	45
271002	77169	45
271003	77170	45
271004	77171	46
271005	77172	46
271006	77173	46
271007	77174	46
271008	77175	46
271009	77176	46
271010	77177	46
271011	77178	46
271012	77179	46
271013	77180	46
271014	77181	46
271015	77182	46
271016	77183	46
271017	77184	46
271018	77185	46
271019	77186	46
271020	77187	45
271021	77188	45
271022	77189	45
271023	77190	45
271024	77191	45
271025	77192	45
271026	77193	45
271027	77194	45
271028	77195	47
271029	77196	47
271030	77197	47
271031	77198	47
271032	77199	47
271033	77200	47
271034	77201	47
271035	77202	47
271036	77203	48
271037	77204	48
271038	77205	48
271039	77206	48
271040	77207	48
271041	77208	48
271042	77209	48
271043	77210	48
271044	77211	48
271045	77212	48
271046	77213	48
271047	77214	48
271048	77215	48
271049	77216	48
271050	77217	48
271051	77218	48
271052	77219	12
271053	77220	12
271054	77221	12
271055	77222	12
271056	77223	12
271057	77224	12
271058	77225	12
271059	77226	12
271060	77227	12
271061	77228	12
271062	77229	12
271063	77230	12
271064	77231	12
271065	77232	12
271066	77233	12
271067	77234	12
271068	77235	47
271069	77236	47
271070	77237	47
271071	77238	47
271072	77239	47
271073	77240	47
271074	77241	47
271075	77242	47
271076	77243	47
271077	77244	47
271078	77245	47
271079	77246	47
271080	77247	47
271081	77248	47
271082	77249	47
271083	77250	47
271084	77251	48
271085	77252	48
271086	77253	48
271087	77254	48
271088	77255	48
271089	77256	48
271090	77257	48
271091	77258	48
271092	77259	48
271093	77260	48
271094	77261	48
271095	77262	48
271096	77263	48
271097	77264	48
271098	77265	48
271099	77266	48
271100	77279	41
271101	77280	41
271102	77281	41
271103	77282	41
271104	77283	41
271105	77284	41
271106	77285	41
271107	77286	41
271108	77287	41
271109	77288	41
271110	77289	41
271111	77290	41
271112	77291	41
271113	77292	41
271114	77293	41
271115	77294	41
271116	77295	42
271117	77296	42
271118	77297	42
271119	77298	42
271120	77299	42
271121	77300	42
271122	77301	42
271123	77302	42
271124	77303	43
271125	77304	43
271126	77305	43
271127	77306	43
271128	77307	43
271129	77308	43
271130	77309	43
271131	77310	43
271132	77311	43
271133	77312	43
271134	77313	43
271135	77314	43
271136	77315	43
271137	77316	43
271138	77317	43
271139	77318	43
271140	77319	43
271141	77320	43
271142	77321	43
271143	77322	43
271144	77323	43
271145	77324	43
271146	77325	43
271147	77326	43
271148	77327	43
271149	77328	43
271150	77329	43
271151	77330	43
271152	77331	43
271153	77332	43
271154	77333	43
271155	77334	43
271156	77335	44
271157	77336	44
271158	77337	44
271159	77338	44
271160	77339	44
271161	77340	44
271162	77341	44
271163	77342	44
271164	77343	44
271165	77344	44
271166	77345	44
271167	77346	44
271168	77347	44
271169	77348	44
271170	77349	44
271171	77350	44
271172	77351	42
271173	77352	42
271174	77353	42
271175	77354	42
271176	77355	42
271177	77356	42
271178	77357	42
271179	77358	42
271180	77359	45
271181	77360	45
271182	77361	45
271183	77362	45
271184	77363	45
271185	77364	45
271186	77365	45
271187	77366	45
271188	77367	45
271189	77368	45
271190	77369	45
271191	77370	45
271192	77371	45
271193	77372	45
271194	77373	45
271195	77374	45
271196	77375	46
271197	77376	46
271198	77377	46
271199	77378	46
271200	77379	46
271201	77380	46
271202	77381	46
271203	77382	46
271204	77383	46
271205	77384	46
271206	77385	46
271207	77386	46
271208	77387	46
271209	77388	46
271210	77389	46
271211	77390	46
271212	77391	45
271213	77392	45
271214	77393	45
271215	77394	45
271216	77395	45
271217	77396	45
271218	77397	45
271219	77398	45
271220	77399	47
271221	77400	47
271222	77401	47
271223	77402	47
271224	77403	47
271225	77404	47
271226	77405	47
271227	77406	47
271228	77407	48
271229	77408	48
271230	77409	48
271231	77410	48
271232	77411	48
271233	77412	48
271234	77413	48
271235	77414	48
271236	77415	48
271237	77416	48
271238	77417	48
271239	77418	48
271240	77419	48
271241	77420	48
271242	77421	48
271243	77422	48
271244	77423	41
271245	77424	41
271246	77425	41
271247	77426	41
271248	77427	41
271249	77428	41
271250	77429	41
271251	77430	41
271252	77431	41
271253	77432	41
271254	77433	41
271255	77434	41
271256	77435	41
271257	77436	41
271258	77437	41
271259	77438	41
271260	77439	12
271261	77440	12
271262	77441	12
271263	77442	12
271264	77443	12
271265	77444	12
271266	77445	12
271267	77446	12
271268	77447	12
271269	77448	12
271270	77449	12
271271	77450	12
271272	77451	12
271273	77452	12
271274	77453	12
271275	77454	12
271276	77455	48
271277	77456	48
271278	77457	48
271279	77458	48
271280	77459	48
271281	77460	48
271282	77461	48
271283	77462	48
271284	77463	48
271285	77464	48
271286	77465	48
271287	77466	48
271288	77467	48
271289	77468	48
271290	77469	48
271291	77470	48
271292	77471	47
271293	77472	47
271294	77473	47
271295	77474	47
271296	77475	47
271297	77476	47
271298	77477	47
271299	77478	47
271300	77479	47
271301	77480	47
271302	77481	47
271303	77482	47
271304	77483	47
271305	77484	47
271306	77485	47
271307	77486	47
271308	77487	49
271309	77488	49
271310	77489	49
271311	77490	49
271312	77491	49
271313	77492	49
271314	77493	49
271315	77494	49
271316	77495	49
271317	77496	49
271318	77497	49
271319	77498	49
271320	77499	49
271321	77500	49
271322	77501	49
271323	77502	49
271324	77503	49
271325	77504	49
271326	77505	49
271327	77506	49
271328	77507	49
271329	77508	49
271330	77509	49
271331	77510	49
271332	77511	49
271333	77512	49
271334	77513	49
271335	77514	49
271336	77515	49
271337	77516	49
271338	77517	49
271339	77518	49
271340	77519	50
271341	77520	50
271342	77521	50
271343	77522	50
271344	77523	50
271345	77524	50
271346	77525	50
271347	77526	50
271348	77527	50
271349	77528	50
271350	77529	50
271351	77530	50
271352	77531	50
271353	77532	50
271354	77533	50
271355	77534	50
271356	77535	51
271357	77536	51
271358	77537	51
271359	77538	51
271360	77539	51
271361	77540	51
271362	77541	51
271363	77542	51
271364	77551	52
271365	77552	52
271366	77553	52
271367	77554	52
271368	77555	52
271369	77556	52
271370	77557	52
271371	77558	52
271372	77631	44
271373	77632	44
271374	77633	44
271375	77634	44
271376	77635	44
271377	77636	44
271378	77637	44
271379	77638	44
271380	77639	44
271381	77640	44
271382	77641	44
271383	77642	44
271384	77643	44
271385	77644	44
271386	77645	44
271387	77646	44
271388	77647	44
271389	77648	44
271390	77649	44
271391	77650	44
271392	77651	44
271393	77652	44
271394	77653	44
271395	77654	44
271396	77655	53
271397	77656	53
271398	77657	53
271399	77658	53
271400	77659	53
271401	77660	53
271402	77661	53
271403	77662	53
271404	77663	53
271405	77664	53
271406	77665	53
271407	77666	53
271408	77667	53
271409	77668	53
271410	77669	53
271411	77670	53
271412	77671	53
271413	77672	53
271414	77673	53
271415	77674	53
271416	77675	53
271417	77676	53
271418	77677	53
271419	77678	53
271420	77679	53
271421	77680	53
271422	77681	53
271423	77682	53
271424	77683	53
271425	77684	53
271426	77685	53
271427	77686	53
271428	77687	54
271429	77688	54
271430	77689	54
271431	77690	54
271432	77691	54
271433	77692	54
271434	77693	54
271435	77694	54
271436	77695	55
271437	77696	55
271438	77697	55
271439	77698	55
271440	77699	55
271441	77700	55
271442	77701	55
271443	77702	55
271444	77703	27
271445	77704	27
271446	77705	27
271447	77706	27
271448	77707	27
271449	77708	27
271450	77709	27
271451	77710	27
271452	77711	55
271453	77712	55
271454	77713	55
271455	77714	55
271456	77715	55
271457	77716	55
271458	77717	55
271459	77718	55
271460	77719	53
271461	77720	53
271462	77721	53
271463	77722	53
271464	77723	53
271465	77724	53
271466	77725	53
271467	77726	53
271468	77727	53
271469	77728	53
271470	77729	53
271471	77730	53
271472	77731	53
271473	77732	53
271474	77733	53
271475	77734	53
271476	77735	53
271477	77736	53
271478	77737	53
271479	77738	53
271480	77739	53
271481	77740	53
271482	77741	53
271483	77742	53
271484	77743	53
271485	77744	53
271486	77745	53
271487	77746	53
271488	77747	53
271489	77748	53
271490	77749	53
271491	77750	53
271492	77751	55
271493	77752	55
271494	77753	55
271495	77754	55
271496	77755	55
271497	77756	55
271498	77757	55
271499	77758	55
271500	77823	56
271501	77824	56
271502	77825	56
271503	77826	56
271504	77827	56
271505	77828	56
271506	77829	56
271507	77830	56
271508	77831	57
271509	77832	57
271510	77833	57
271511	77834	57
271512	77835	57
271513	77836	57
271514	77837	57
271515	77838	57
271516	77839	57
271517	77840	57
271518	77841	57
271519	77842	57
271520	77843	57
271521	77844	57
271522	77845	57
271523	77846	57
271524	77847	58
271525	77848	58
271526	77849	58
271527	77850	58
271528	77851	58
271529	77852	58
271530	77853	58
271531	77854	58
271532	77855	49
271533	77856	49
271534	77857	49
271535	77858	49
271536	77859	49
271537	77860	49
271538	77861	49
271539	77862	49
271540	77863	49
271541	77864	49
271542	77865	49
271543	77866	49
271544	77867	49
271545	77868	49
271546	77869	49
271547	77870	49
271548	77871	49
271549	77872	49
271550	77873	49
271551	77874	49
271552	77875	49
271553	77876	49
271554	77877	49
271555	77878	49
271556	77879	49
271557	77880	49
271558	77881	49
271559	77882	49
271560	77883	49
271561	77884	49
271562	77885	49
271563	77886	49
271564	77887	50
271565	77888	50
271566	77889	50
271567	77890	50
271568	77891	50
271569	77892	50
271570	77893	50
271571	77894	50
271572	77895	50
271573	77896	50
271574	77897	50
271575	77898	50
271576	77899	50
271577	77900	50
271578	77901	50
271579	77902	50
271580	77903	51
271581	77904	51
271582	77905	51
271583	77906	51
271584	77907	51
271585	77908	51
271586	77909	51
271587	77910	51
271588	77919	52
271589	77920	52
271590	77921	52
271591	77922	52
271592	77923	52
271593	77924	52
271594	77925	52
271595	77926	52
271596	77999	44
271597	78000	44
271598	78001	44
271599	78002	44
271600	78003	44
271601	78004	44
271602	78005	44
271603	78006	44
271604	78007	44
271605	78008	44
271606	78009	44
271607	78010	44
271608	78011	44
271609	78012	44
271610	78013	44
271611	78014	44
271612	78015	44
271613	78016	44
271614	78017	44
271615	78018	44
271616	78019	44
271617	78020	44
271618	78021	44
271619	78022	44
271620	78023	53
271621	78024	53
271622	78025	53
271623	78026	53
271624	78027	53
271625	78028	53
271626	78029	53
271627	78030	53
271628	78031	53
271629	78032	53
271630	78033	53
271631	78034	53
271632	78035	53
271633	78036	53
271634	78037	53
271635	78038	53
271636	78039	53
271637	78040	53
271638	78041	53
271639	78042	53
271640	78043	53
271641	78044	53
271642	78045	53
271643	78046	53
271644	78047	53
271645	78048	53
271646	78049	53
271647	78050	53
271648	78051	53
271649	78052	53
271650	78053	53
271651	78054	53
271652	78055	54
271653	78056	54
271654	78057	54
271655	78058	54
271656	78059	54
271657	78060	54
271658	78061	54
271659	78062	54
271660	78063	27
271661	78064	27
271662	78065	27
271663	78066	27
271664	78067	27
271665	78068	27
271666	78069	27
271667	78070	27
271668	78071	27
271669	78072	27
271670	78073	27
271671	78074	27
271672	78075	27
271673	78076	27
271674	78077	27
271675	78078	27
271676	78079	27
271677	78080	27
271678	78081	27
271679	78082	27
271680	78083	27
271681	78084	27
271682	78085	27
271683	78086	27
271684	78087	27
271685	78088	27
271686	78089	27
271687	78090	27
271688	78091	27
271689	78092	27
271690	78093	27
271691	78094	27
271692	78095	53
271693	78096	53
271694	78097	53
271695	78098	53
271696	78099	53
271697	78100	53
271698	78101	53
271699	78102	53
271700	78103	53
271701	78104	53
271702	78105	53
271703	78106	53
271704	78107	53
271705	78108	53
271706	78109	53
271707	78110	53
271708	78111	53
271709	78112	53
271710	78113	53
271711	78114	53
271712	78115	53
271713	78116	53
271714	78117	53
271715	78118	53
271716	78119	53
271717	78120	53
271718	78121	53
271719	78122	53
271720	78123	53
271721	78124	53
271722	78125	53
271723	78126	53
271724	78191	56
271725	78192	56
271726	78193	56
271727	78194	56
271728	78195	56
271729	78196	56
271730	78197	56
271731	78198	56
271732	78199	57
271733	78200	57
271734	78201	57
271735	78202	57
271736	78203	57
271737	78204	57
271738	78205	57
271739	78206	57
271740	78207	57
271741	78208	57
271742	78209	57
271743	78210	57
271744	78211	57
271745	78212	57
271746	78213	57
271747	78214	57
271748	78215	58
271749	78216	58
271750	78217	58
271751	78218	58
271752	78219	58
271753	78220	58
271754	78221	58
271755	78222	58
271756	78223	59
271757	78224	59
271758	78225	59
271759	78226	59
271760	78227	59
271761	78228	59
271762	78229	59
271763	78230	59
271764	78231	60
271765	78232	60
271766	78233	60
271767	78234	60
271768	78235	60
271769	78236	60
271770	78237	60
271771	78238	60
271772	78239	60
271773	78240	60
271774	78241	60
271775	78242	60
271776	78243	60
271777	78244	60
271778	78245	60
271779	78246	60
271780	78247	60
271781	78248	60
271782	78249	60
271783	78250	60
271784	78251	60
271785	78252	60
271786	78253	60
271787	78254	60
271788	78255	61
271789	78256	61
271790	78257	61
271791	78258	61
271792	78259	61
271793	78260	61
271794	78261	61
271795	78262	61
271796	78263	61
271797	78264	61
271798	78265	61
271799	78266	61
271800	78267	61
271801	78268	61
271802	78269	61
271803	78270	61
271804	78271	62
271805	78272	62
271806	78273	62
271807	78274	62
271808	78275	62
271809	78276	62
271810	78277	62
271811	78278	62
271812	78279	62
271813	78280	62
271814	78281	62
271815	78282	62
271816	78283	62
271817	78284	62
271818	78285	62
271819	78286	62
271820	78287	40
271821	78288	40
271822	78289	40
271823	78290	40
271824	78291	40
271825	78292	40
271826	78293	40
271827	78294	40
271828	78295	40
271829	78296	40
271830	78297	40
271831	78298	40
271832	78299	40
271833	78300	40
271834	78301	40
271835	78302	40
271836	78303	43
271837	78304	43
271838	78305	43
271839	78306	43
271840	78307	43
271841	78308	43
271842	78309	43
271843	78310	43
271844	78311	42
271845	78312	42
271846	78313	42
271847	78314	42
271848	78315	42
271849	78316	42
271850	78317	42
271851	78318	42
271852	78319	43
271853	78320	43
271854	78321	43
271855	78322	43
271856	78323	43
271857	78324	43
271858	78325	43
271859	78326	43
271860	78327	63
271861	78328	63
271862	78329	63
271863	78330	63
271864	78331	63
271865	78332	63
271866	78333	63
271867	78334	63
271868	78335	42
271869	78336	42
271870	78337	42
271871	78338	42
271872	78339	42
271873	78340	42
271874	78341	42
271875	78342	42
271876	78343	63
271877	78344	63
271878	78345	63
271879	78346	63
271880	78347	63
271881	78348	63
271882	78349	63
271883	78350	63
271884	78527	51
271885	78528	51
271886	78529	51
271887	78530	51
271888	78531	51
271889	78532	51
271890	78533	51
271891	78534	51
271892	78535	51
271893	78536	51
271894	78537	51
271895	78538	51
271896	78539	51
271897	78540	51
271898	78541	51
271899	78542	51
271900	78543	51
271901	78544	51
271902	78545	51
271903	78546	51
271904	78547	51
271905	78548	51
271906	78549	51
271907	78550	51
271908	78551	51
271909	78552	51
271910	78553	51
271911	78554	51
271912	78555	51
271913	78556	51
271914	78557	51
271915	78558	51
271916	78559	64
271917	78560	64
271918	78561	64
271919	78562	64
271920	78563	64
271921	78564	64
271922	78565	64
271923	78566	64
271924	78567	64
271925	78568	64
271926	78569	64
271927	78570	64
271928	78571	64
271929	78572	64
271930	78573	64
271931	78574	64
271932	78575	40
271933	78576	40
271934	78577	40
271935	78578	40
271936	78579	40
271937	78580	40
271938	78581	40
271939	78582	40
271940	78583	52
271941	78584	52
271942	78585	52
271943	78586	52
271944	78587	52
271945	78588	52
271946	78589	52
271947	78590	52
271948	78591	52
271949	78592	52
271950	78593	52
271951	78594	52
271952	78595	52
271953	78596	52
271954	78597	52
271955	78598	52
271956	78615	40
271957	78616	40
271958	78617	40
271959	78618	40
271960	78619	40
271961	78620	40
271962	78621	40
271963	78622	40
271964	78639	65
271965	78640	65
271966	78641	65
271967	78642	65
271968	78643	65
271969	78644	65
271970	78645	65
271971	78646	65
271972	78647	66
271973	78648	66
271974	78649	66
271975	78650	66
271976	78651	66
271977	78652	66
271978	78653	66
271979	78654	66
271980	78655	67
271981	78656	67
271982	78657	67
271983	78658	67
271984	78659	67
271985	78660	67
271986	78661	67
271987	78662	67
271988	78663	67
271989	78664	67
271990	78665	67
271991	78666	67
271992	78667	67
271993	78668	67
271994	78669	67
271995	78670	67
271996	78671	68
271997	78672	68
271998	78673	68
271999	78674	68
272000	78675	68
272001	78676	68
272002	78677	68
272003	78678	68
272004	78679	69
272005	78680	69
272006	78681	69
272007	78682	69
272008	78683	69
272009	78684	69
272010	78685	69
272011	78686	69
272012	78687	7
272013	78688	4
272014	78689	9
272015	78690	0
272016	78691	70
272017	78693	5
272018	78694	71
272019	78695	13
272020	78697	14
272021	78699	10
272022	78701	8
272023	78703	4
272024	78705	7
272025	78706	71
272026	78707	70
272027	78708	15
272028	78709	5
272029	78710	72
272030	78711	13
272031	78713	14
272032	78715	10
272033	78717	8
272034	78719	4
272035	78720	7
272036	78722	22
272037	78723	5
272038	78724	10
272039	78725	73
272040	78726	74
272041	78727	13
272042	78729	14
272043	78731	10
272044	78733	8
272045	78736	4
272046	78737	1
272047	78738	22
272048	78739	75
272049	78740	5
272050	78741	10
272051	78742	73
272052	78743	13
272053	78745	14
272054	78747	10
272055	78749	8
272056	78752	76
272057	78753	29
272058	78754	25
272059	78755	77
272060	78756	77
272061	78757	27
272062	78759	25
272063	78761	34
272064	78764	32
272065	78766	26
272066	78767	26
272067	78768	25
272068	78769	76
272069	78770	78
272070	78771	79
272071	78772	78
272072	78774	27
272073	78776	25
272074	78778	34
272075	78781	32
272076	78783	26
272077	78784	26
272078	78785	44
272079	78786	43
272080	78788	45
272081	78789	45
272082	78790	42
272083	78791	42
272084	78792	46
272085	78793	46
272086	78794	48
272087	78795	48
272088	78796	41
272089	78797	41
272090	78798	47
272091	78799	47
272092	78800	44
272093	78801	43
272094	78803	45
272095	78804	45
272096	78805	42
272097	78806	42
272098	78807	46
272099	78808	46
272100	78809	48
272101	78810	48
272102	78811	41
272103	78812	41
272104	78813	47
272105	78814	80
272106	78816	81
272107	78817	53
272108	78818	57
272109	78819	52
272110	78820	51
272111	78822	51
272112	78823	51
272113	78824	51
272114	78825	53
272115	78826	53
272116	78827	44
272117	78828	44
272118	78829	82
272119	78830	82
272120	78831	27
272121	78832	27
272122	78834	81
272123	78835	53
272124	78836	57
272125	78837	52
272126	78838	51
272127	78840	51
272128	78841	51
272129	78842	51
272130	78843	53
272131	78844	53
272132	78845	44
272133	78846	44
272134	78847	82
272135	78848	82
272136	78849	27
272137	78850	27
272138	78851	40
272139	78852	40
272140	78853	43
272141	78854	43
272142	78855	60
272143	78857	63
272144	78858	63
272145	78859	42
272146	78860	62
272147	78861	62
272148	78862	51
272149	78863	7
272150	78864	65
272151	78865	64
272152	78866	51
272153	78867	51
272154	78868	52
272155	78869	40
272156	78870	68
272157	78871	40
272158	78872	40
272159	78873	67
272160	78874	51
272161	78875	51
272162	78876	51
272163	78877	7
\.


--
-- TOC entry 3504 (class 0 OID 16436)
-- Dependencies: 234
-- Data for Name: sc_rasp18_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp18_rooms (id, rasp18_id, room) FROM stdin;
273532	76729	А-13
273533	76730	А-13
273534	76731	А-13
273535	76732	А-13
273536	76733	А-13
273537	76734	А-13
273538	76735	Б-209-2
273539	76736	Б-209-2
273540	76737	Б-209-2
273541	76738	Б-209-2
273542	76739	Б-209-2
273543	76740	Б-209-2
273544	76741	Б-209-2
273545	76742	Б-209-2
273546	76743	Б-209-2
273547	76744	Б-209-2
273548	76745	Б-209-2
273549	76746	Б-209-2
273550	76747	Б-209-2
273551	76748	Б-209-2
273552	76749	Б-209-2
273553	76750	Б-209-2
273554	76751	дист.
273555	76752	дист.
273556	76753	дист.
273557	76754	дист.
273558	76755	дист.
273559	76756	дист.
273560	76757	дист.
273561	76758	дист.
273562	76759	А-13
273563	76760	А-13
273564	76761	А-13
273565	76762	А-13
273566	76763	А-13
273567	76764	А-13
273568	76765	А-13
273569	76766	А-13
273570	76767	А-13
273571	76768	А-13
273572	76769	А-13
273573	76770	А-13
273574	76771	А-13
273575	76772	А-13
273576	76773	А-13
273577	76774	А-13
273578	76775	А-13
273579	76776	А-13
273580	76777	А-13
273581	76778	А-13
273582	76779	А-13
273583	76780	А-13
273584	76781	А-13
273585	76782	А-13
273586	76783	А-13
273587	76784	А-13
273588	76785	А-13
273589	76786	А-13
273590	76787	А-13
273591	76788	А-13
273592	76789	А-13
273593	76790	А-13
273594	76791	ФОК-3
273595	76792	ФОК-3
273596	76793	ФОК-3
273597	76794	ФОК-3
273598	76795	ФОК-3
273599	76796	ФОК-3
273600	76797	ФОК-3
273601	76798	ФОК-3
273602	76799	ФОК-3
273603	76800	ФОК-3
273604	76801	ФОК-3
273605	76802	ФОК-3
273606	76803	ФОК-3
273607	76804	ФОК-3
273608	76805	ФОК-3
273609	76806	ФОК-3
273610	76807	А-16
273611	76808	А-16
273612	76809	А-16
273613	76810	А-16
273614	76811	А-16
273615	76812	А-16
273616	76813	А-16
273617	76814	А-16
273618	76815	А-16
273619	76816	А-16
273620	76817	А-16
273621	76818	А-16
273622	76819	А-16
273623	76820	А-16
273624	76821	А-16
273625	76822	А-16
273626	76823	А-13
273627	76824	А-13
273628	76825	А-13
273629	76826	А-13
273630	76827	А-13
273631	76828	А-13
273632	76829	А-13
273633	76830	А-13
273634	76831	А-13
273635	76832	А-13
273636	76833	А-13
273637	76834	А-13
273638	76835	А-13
273639	76836	А-13
273640	76837	А-13
273641	76838	А-13
273642	76839	Г-413
273643	76840	Г-413
273644	76841	Г-413
273645	76842	Г-413
273646	76843	Г-413
273647	76844	Г-413
273648	76845	Г-413
273649	76846	Г-413
273650	76847	Г-413
273651	76848	Г-413
273652	76849	Г-413
273653	76850	Г-413
273654	76851	Г-413
273655	76852	Г-413
273656	76853	Г-413
273657	76854	Г-413
273658	76855	А-180
273659	76856	А-180
273660	76857	А-180
273661	76858	А-180
273662	76859	А-180
273663	76860	А-180
273664	76861	А-180
273665	76862	А-180
273666	76863	А-180
273667	76864	А-180
273668	76865	А-180
273669	76866	А-180
273670	76867	А-180
273671	76868	А-180
273672	76869	А-180
273673	76870	А-180
273674	76871	А-174-б
273675	76872	А-174-б
273676	76873	А-174-б
273677	76874	А-174-б
273678	76875	А-174-б
273679	76876	А-174-б
273680	76877	А-174-б
273681	76878	А-174-б
273682	76879	А-174-б
273683	76880	А-174-б
273684	76881	А-174-б
273685	76882	А-174-б
273686	76883	А-174-б
273687	76884	А-174-б
273688	76885	А-174-б
273689	76886	А-174-б
273690	76887	А-174-б
273691	76888	А-174-б
273692	76889	А-174-б
273693	76890	А-174-б
273694	76891	А-174-б
273695	76892	А-174-б
273696	76893	А-174-б
273697	76894	А-174-б
273698	76895	А-174-б
273699	76896	А-174-б
273700	76897	А-174-б
273701	76898	А-174-б
273702	76899	А-174-б
273703	76900	А-174-б
271994	75191	А-307
271995	75192	А-307
271996	75193	А-307
271997	75194	А-307
271998	75195	А-307
271999	75196	А-307
272000	75197	А-307
272001	75198	А-307
272002	75199	А-307
272003	75200	А-307
272004	75201	А-307
272005	75202	А-307
272006	75203	А-307
272007	75204	А-307
272008	75205	А-307
272009	75206	А-307
272010	75207	Д-210
272011	75208	Д-210
272012	75209	Д-210
272013	75210	Д-210
272014	75211	Д-210
272015	75212	Д-210
272016	75213	Д-210
272017	75214	Д-210
272018	75215	Д-210
272019	75216	Д-210
272020	75217	Д-210
272021	75218	Д-210
272022	75219	Д-210
272023	75220	Д-210
272024	75221	Д-210
272025	75222	Д-210
272026	75223	Г-102
272027	75224	Г-102
272028	75225	Г-102
272029	75226	Г-102
272030	75227	Г-102
272031	75228	Г-102
272032	75229	Г-102
272033	75230	Г-102
272034	75231	Г-102
272035	75232	Г-102
272036	75233	Г-102
272037	75234	Г-102
272038	75235	Г-102
272039	75236	Г-102
272040	75237	Г-102
272041	75238	Г-102
272042	75239	Б-209-2
272043	75240	Б-209-2
272044	75241	Б-209-2
272045	75242	Б-209-2
272046	75243	Б-209-2
272047	75244	Б-209-2
272048	75245	Б-209-2
272049	75246	Б-209-2
272050	75247	Б-209-2
272051	75248	Б-209-2
272052	75249	Б-209-2
272053	75250	Б-209-2
272054	75251	Б-209-2
272055	75252	Б-209-2
272056	75253	Б-209-2
272057	75254	Б-209-2
272058	75255	А-2
272059	75256	А-2
272060	75257	А-2
272061	75258	А-2
272062	75259	А-2
272063	75260	А-2
272064	75261	А-2
272065	75262	А-2
272066	75263	А-314
272067	75264	А-314
272068	75265	А-314
272069	75266	А-314
272070	75267	А-314
272071	75268	А-314
272072	75269	А-314
272073	75270	А-314
272074	75271	И-205-а
272075	75272	И-205-а
272076	75273	И-205-а
272077	75274	И-205-а
272078	75275	И-205-а
272079	75276	И-205-а
272080	75277	И-205-а
272081	75278	И-205-а
272082	75279	И-205-а
272083	75280	И-205-а
272084	75281	И-205-а
272085	75282	И-205-а
272086	75283	И-205-а
272087	75284	И-205-а
272088	75285	И-205-а
272089	75286	И-205-а
272090	75287	И-205-а
272091	75288	И-205-а
272092	75289	И-205-а
272093	75290	И-205-а
272094	75291	И-205-а
272095	75292	И-205-а
272096	75293	И-205-а
272097	75294	И-205-а
272098	75295	И-205-а
272099	75296	И-205-а
272100	75297	И-205-а
272101	75298	И-205-а
272102	75299	И-205-а
272103	75300	И-205-а
272104	75301	И-205-а
272105	75302	И-205-а
272106	75303	А-177
272107	75304	А-177
272108	75305	А-177
272109	75306	А-177
272110	75307	А-177
272111	75308	А-177
272112	75309	А-177
272113	75310	А-177
272114	75311	А-177
272115	75312	А-177
272116	75313	А-177
272117	75314	А-177
272118	75315	А-177
272119	75316	А-177
272120	75317	А-177
272121	75318	А-177
272122	75319	А-13
272123	75320	А-13
272124	75321	А-13
272125	75322	А-13
272126	75323	А-13
272127	75324	А-13
272128	75325	А-13
272129	75326	А-13
272130	75327	А-13
272131	75328	А-13
272132	75329	А-13
272133	75330	А-13
272134	75331	А-13
272135	75332	А-13
272136	75333	А-13
272137	75334	А-13
272138	75335	А-13
272139	75336	А-13
272140	75337	А-13
272141	75338	А-13
272142	75339	А-13
272143	75340	А-13
272144	75341	А-13
272145	75342	А-13
272146	75343	А-13
272147	75344	А-13
272148	75345	А-13
272149	75346	А-13
272150	75347	А-13
272151	75348	А-13
272152	75349	А-13
272153	75350	А-13
272154	75351	И-317
272155	75352	И-317
272156	75353	И-317
272157	75354	И-317
272158	75355	И-317
272159	75356	И-317
272160	75357	И-317
272161	75358	И-317
272162	75359	И-317
272163	75360	И-317
272164	75361	И-317
272165	75362	И-317
272166	75363	И-317
272167	75364	И-317
272168	75365	И-317
272169	75366	И-317
272170	75367	А-13
272171	75368	А-13
272172	75369	А-13
272173	75370	А-13
272174	75371	А-13
272175	75372	А-13
272176	75373	А-13
272177	75374	А-13
272178	75375	А-13
272179	75376	А-13
272180	75377	А-13
272181	75378	А-13
272182	75379	А-13
272183	75380	А-13
272184	75381	А-13
272185	75382	А-13
272186	75383	Б-115
272187	75384	Б-115
272188	75385	Б-115
272189	75386	Б-115
272190	75387	Б-115
272191	75388	Б-115
272192	75389	Б-115
272193	75390	Б-115
272194	75391	ФОК-9
272195	75392	ФОК-9
272196	75393	ФОК-9
272197	75394	ФОК-9
272198	75395	ФОК-9
272199	75396	ФОК-9
272200	75397	ФОК-9
272201	75398	ФОК-9
272202	75399	ФОК-9
272203	75400	ФОК-9
272204	75401	ФОК-9
272205	75402	ФОК-9
272206	75403	ФОК-9
272207	75404	ФОК-9
272208	75405	ФОК-9
272209	75406	ФОК-9
272210	75407	Б-209-2
272211	75408	Б-209-2
272212	75409	Б-209-2
272213	75410	Б-209-2
272214	75411	Б-209-2
272215	75412	Б-209-2
272216	75413	Б-209-2
272217	75414	Б-209-2
272218	75415	Б-209-2
272219	75416	Б-209-2
272220	75417	Б-209-2
272221	75418	Б-209-2
272222	75419	Б-209-2
272223	75420	Б-209-2
272224	75421	Б-209-2
272225	75422	Б-209-2
272226	75423	А-17
272227	75424	А-17
272228	75425	А-17
272229	75426	А-17
272230	75427	А-17
272231	75428	А-17
272232	75429	А-17
272233	75430	А-17
272234	75431	А-13
272235	75432	А-13
272236	75433	А-13
272237	75434	А-13
272238	75435	А-13
272239	75436	А-13
272240	75437	А-13
272241	75438	А-13
272242	75439	Б-209-2
272243	75440	Б-209-2
272244	75441	Б-209-2
272245	75442	Б-209-2
272246	75443	Б-209-2
272247	75444	Б-209-2
272248	75445	Б-209-2
272249	75446	Б-209-2
272250	75447	Г-102
272251	75448	Г-102
272252	75449	Г-102
272253	75450	Г-102
272254	75451	Г-102
272255	75452	Г-102
272256	75453	Г-102
272257	75454	Г-102
272258	75455	Г-102
272259	75456	Г-102
272260	75457	Г-102
272261	75458	Г-102
272262	75459	Г-102
272263	75460	Г-102
272264	75461	Г-102
272265	75462	Г-102
272266	75463	А-13
272267	75464	А-13
272268	75465	А-13
272269	75466	А-13
272270	75467	А-13
272271	75468	А-13
272272	75469	А-13
272273	75470	А-13
272274	75471	А-13
272275	75472	А-13
272276	75473	А-13
272277	75474	А-13
272278	75475	А-13
272279	75476	А-13
272280	75477	А-13
272281	75478	А-13
272282	75479	А-13
272283	75480	А-13
272284	75481	А-13
272285	75482	А-13
272286	75483	А-13
272287	75484	А-13
272288	75485	А-13
272289	75486	А-13
272290	75487	А-13
272291	75488	А-13
272292	75489	А-13
272293	75490	А-13
272294	75491	А-13
272295	75492	А-13
272296	75493	А-13
272297	75494	А-13
272298	75495	Б-209-2
272299	75496	Б-209-2
272300	75497	Б-209-2
272301	75498	Б-209-2
272302	75499	Б-209-2
272303	75500	Б-209-2
272304	75501	Б-209-2
272305	75502	Б-209-2
272306	75503	дист.
272307	75504	дист.
272308	75505	дист.
272309	75506	дист.
272310	75507	дист.
272311	75508	дист.
272312	75509	дист.
272313	75510	дист.
272314	75511	И-329\nИ-318
272315	75512	И-329\nИ-318
272316	75513	И-329\nИ-318
272317	75514	И-329\nИ-318
272318	75515	И-329\nИ-318
272319	75516	И-329\nИ-318
272320	75517	И-329\nИ-318
272321	75518	И-329\nИ-318
272322	75519	И-329\nИ-318
272323	75520	И-329\nИ-318
272324	75521	И-329\nИ-318
272325	75522	И-329\nИ-318
272326	75523	И-329\nИ-318
272327	75524	И-329\nИ-318
272328	75525	И-329\nИ-318
272329	75526	И-329\nИ-318
272330	75527	А-214
272331	75528	А-214
272332	75529	А-214
272333	75530	А-214
272334	75531	А-214
272335	75532	А-214
272336	75533	А-214
272337	75534	А-214
272338	75535	А-214
272339	75536	А-214
272340	75537	А-214
272341	75538	А-214
272342	75539	А-214
272343	75540	А-214
272344	75541	А-214
272345	75542	А-214
272346	75543	А-222
272347	75544	А-222
272348	75545	А-222
272349	75546	А-222
272350	75547	А-222
272351	75548	А-222
272352	75549	А-222
272353	75550	А-222
272354	75551	А-222
272355	75552	А-222
272356	75553	А-222
272357	75554	А-222
272358	75555	А-222
272359	75556	А-222
272360	75557	А-222
272361	75558	А-222
272362	75559	А-2
272363	75560	А-2
272364	75561	А-2
272365	75562	А-2
272366	75563	А-2
272367	75564	А-2
272368	75565	А-2
272369	75566	А-2
272370	75567	Б-209-2
272371	75568	Б-209-2
272372	75569	Б-209-2
272373	75570	Б-209-2
272374	75571	Б-209-2
272375	75572	Б-209-2
272376	75573	Б-209-2
272377	75574	Б-209-2
272378	75575	Б-209-2
272379	75576	Б-209-2
272380	75577	Б-209-2
272381	75578	Б-209-2
272382	75579	Б-209-2
272383	75580	Б-209-2
272384	75581	Б-209-2
272385	75582	Б-209-2
272386	75583	А-3
272387	75584	А-3
272388	75585	А-3
272389	75586	А-3
272390	75587	А-3
272391	75588	А-3
272392	75589	А-3
272393	75590	А-3
272394	75591	Г-102
272395	75592	Г-102
272396	75593	Г-102
272397	75594	Г-102
272398	75595	Г-102
272399	75596	Г-102
272400	75597	Г-102
272401	75598	Г-102
272402	75599	Г-102
272403	75600	Г-102
272404	75601	Г-102
272405	75602	Г-102
272406	75603	Г-102
272407	75604	Г-102
272408	75605	Г-102
272409	75606	Г-102
272410	75607	ФОК-11
272411	75608	ФОК-11
272412	75609	ФОК-11
272413	75610	ФОК-11
272414	75611	ФОК-11
272415	75612	ФОК-11
272416	75613	ФОК-11
272417	75614	ФОК-11
272418	75615	ФОК-11
272419	75616	ФОК-11
272420	75617	ФОК-11
272421	75618	ФОК-11
272422	75619	ФОК-11
272423	75620	ФОК-11
272424	75621	ФОК-11
272425	75622	ФОК-11
272426	75623	А-177
272427	75624	А-177
272428	75625	А-177
272429	75626	А-177
272430	75627	А-177
272431	75628	А-177
272432	75629	А-177
272433	75630	А-177
272434	75631	А-177
272435	75632	А-177
272436	75633	А-177
272437	75634	А-177
272438	75635	А-177
272439	75636	А-177
272440	75637	А-177
272441	75638	А-177
272442	75639	А-13
272443	75640	А-13
272444	75641	А-13
272445	75642	А-13
272446	75643	А-13
272447	75644	А-13
272448	75645	А-13
272449	75646	А-13
272450	75647	А-13
272451	75648	А-13
272452	75649	А-13
272453	75650	А-13
272454	75651	А-13
272455	75652	А-13
272456	75653	А-13
272457	75654	А-13
272458	75655	А-13
272459	75656	А-13
272460	75657	А-13
272461	75658	А-13
272462	75659	А-13
272463	75660	А-13
272464	75661	А-13
272465	75662	А-13
272466	75663	А-13
272467	75664	А-13
272468	75665	А-13
272469	75666	А-13
272470	75667	А-13
272471	75668	А-13
272472	75669	А-13
272473	75670	А-13
272474	75671	И-203-б
272475	75672	И-203-б
272476	75673	И-203-б
272477	75674	И-203-б
272478	75675	И-203-б
272479	75676	И-203-б
272480	75677	И-203-б
272481	75678	И-203-б
272482	75679	И-203-б
272483	75680	И-203-б
272484	75681	И-203-б
272485	75682	И-203-б
272486	75683	И-203-б
272487	75684	И-203-б
272488	75685	И-203-б
272489	75686	И-203-б
272490	75687	И-203-б
272491	75688	И-203-б
272492	75689	И-203-б
272493	75690	И-203-б
272494	75691	И-203-б
272495	75692	И-203-б
272496	75693	И-203-б
272497	75694	И-203-б
272498	75695	И-203-б
272499	75696	И-203-б
272500	75697	И-203-б
272501	75698	И-203-б
272502	75699	И-203-б
272503	75700	И-203-б
272504	75701	И-203-б
272505	75702	И-203-б
272506	75703	А-13
272507	75704	А-13
272508	75705	А-13
272509	75706	А-13
272510	75707	А-13
272511	75708	А-13
272512	75709	А-13
272513	75710	А-13
272514	75711	А-13
272515	75712	А-13
272516	75713	А-13
272517	75714	А-13
272518	75715	А-13
272519	75716	А-13
272520	75717	А-13
272521	75718	А-13
272522	75719	Б-115
272523	75720	Б-115
272524	75721	Б-115
272525	75722	Б-115
272526	75723	Б-115
272527	75724	Б-115
272528	75725	Б-115
272529	75726	Б-115
272530	75727	Б-209-2
272531	75728	Б-209-2
272532	75729	Б-209-2
272533	75730	Б-209-2
272534	75731	Б-209-2
272535	75732	Б-209-2
272536	75733	Б-209-2
272537	75734	Б-209-2
272538	75735	Б-209-2
272539	75736	Б-209-2
272540	75737	Б-209-2
272541	75738	Б-209-2
272542	75739	Б-209-2
272543	75740	Б-209-2
272544	75741	Б-209-2
272545	75742	Б-209-2
272546	75743	А-17
272547	75744	А-17
272548	75745	А-17
272549	75746	А-17
272550	75747	А-17
272551	75748	А-17
272552	75749	А-17
272553	75750	А-17
272554	75751	А-13
272555	75752	А-13
272556	75753	А-13
272557	75754	А-13
272558	75755	А-13
272559	75756	А-13
272560	75757	А-13
272561	75758	А-13
272562	75759	Б-209-2
272563	75760	Б-209-2
272564	75761	Б-209-2
272565	75762	Б-209-2
272566	75763	Б-209-2
272567	75764	Б-209-2
272568	75765	Б-209-2
272569	75766	Б-209-2
272570	75767	А-177
272571	75768	А-177
272572	75769	А-177
272573	75770	А-177
272574	75771	А-177
272575	75772	А-177
272576	75773	А-177
272577	75774	А-177
272578	75775	А-177
272579	75776	А-177
272580	75777	А-177
272581	75778	А-177
272582	75779	А-177
272583	75780	А-177
272584	75781	А-177
272585	75782	А-177
272586	75783	А-13
272587	75784	А-13
272588	75785	А-13
272589	75786	А-13
272590	75787	А-13
272591	75788	А-13
272592	75789	А-13
272593	75790	А-13
272594	75791	А-13
272595	75792	А-13
272596	75793	А-13
272597	75794	А-13
272598	75795	А-13
272599	75796	А-13
272600	75797	А-13
272601	75798	А-13
272602	75799	А-13
272603	75800	А-13
272604	75801	А-13
272605	75802	А-13
272606	75803	А-13
272607	75804	А-13
272608	75805	А-13
272609	75806	А-13
272610	75807	А-13
272611	75808	А-13
272612	75809	А-13
272613	75810	А-13
272614	75811	А-13
272615	75812	А-13
272616	75813	А-13
272617	75814	А-13
272618	75815	Б-209-2
272619	75816	Б-209-2
272620	75817	Б-209-2
272621	75818	Б-209-2
272622	75819	Б-209-2
272623	75820	Б-209-2
272624	75821	Б-209-2
272625	75822	Б-209-2
272626	75823	дист.
272627	75824	дист.
272628	75825	дист.
272629	75826	дист.
272630	75827	дист.
272631	75828	дист.
272632	75829	дист.
272633	75830	дист.
272634	75831	А-321
272635	75832	А-321
272636	75833	А-321
272637	75834	А-321
272638	75835	А-321
272639	75836	А-321
272640	75837	А-321
272641	75838	А-321
272642	75839	И-306\nИ-319
272643	75840	И-306\nИ-319
272644	75841	И-306\nИ-319
272645	75842	И-306\nИ-319
272646	75843	И-306\nИ-319
272647	75844	И-306\nИ-319
272648	75845	И-306\nИ-319
272649	75846	И-306\nИ-319
272650	75847	И-306\nИ-319
272651	75848	И-306\nИ-319
272652	75849	И-306\nИ-319
272653	75850	И-306\nИ-319
272654	75851	И-306\nИ-319
272655	75852	И-306\nИ-319
272656	75853	И-306\nИ-319
272657	75854	И-306\nИ-319
272658	75855	Г-102
272659	75856	Г-102
272660	75857	Г-102
272661	75858	Г-102
272662	75859	Г-102
272663	75860	Г-102
272664	75861	Г-102
272665	75862	Г-102
272666	75863	Г-102
272667	75864	Г-102
272668	75865	Г-102
272669	75866	Г-102
272670	75867	Г-102
272671	75868	Г-102
272672	75869	Г-102
272673	75870	Г-102
272674	75871	А-2
272675	75872	А-2
272676	75873	А-2
272677	75874	А-2
272678	75875	А-2
272679	75876	А-2
272680	75877	А-2
272681	75878	А-2
272682	75879	Б-209-2
272683	75880	Б-209-2
272684	75881	Б-209-2
272685	75882	Б-209-2
272686	75883	Б-209-2
272687	75884	Б-209-2
272688	75885	Б-209-2
272689	75886	Б-209-2
272690	75887	Б-209-2
272691	75888	Б-209-2
272692	75889	Б-209-2
272693	75890	Б-209-2
272694	75891	Б-209-2
272695	75892	Б-209-2
272696	75893	Б-209-2
272697	75894	Б-209-2
272698	75895	Б-209-2
272699	75896	Б-209-2
272700	75897	Б-209-2
272701	75898	Б-209-2
272702	75899	Б-209-2
272703	75900	Б-209-2
272704	75901	Б-209-2
272705	75902	Б-209-2
272706	75903	Б-209-2
272707	75904	Б-209-2
272708	75905	Б-209-2
272709	75906	Б-209-2
272710	75907	Б-209-2
272711	75908	Б-209-2
272712	75909	Б-209-2
272713	75910	Б-209-2
272714	75911	Г-102
272715	75912	Г-102
272716	75913	Г-102
272717	75914	Г-102
272718	75915	Г-102
272719	75916	Г-102
272720	75917	Г-102
272721	75918	Г-102
272722	75919	Г-102
272723	75920	Г-102
272724	75921	Г-102
272725	75922	Г-102
272726	75923	Г-102
272727	75924	Г-102
272728	75925	Г-102
272729	75926	Г-102
272730	75927	А-177
272731	75928	А-177
272732	75929	А-177
272733	75930	А-177
272734	75931	А-177
272735	75932	А-177
272736	75933	А-177
272737	75934	А-177
272738	75935	А-177
272739	75936	А-177
272740	75937	А-177
272741	75938	А-177
272742	75939	А-177
272743	75940	А-177
272744	75941	А-177
272745	75942	А-177
272746	75943	А-13
272747	75944	А-13
272748	75945	А-13
272749	75946	А-13
272750	75947	А-13
272751	75948	А-13
272752	75949	А-13
272753	75950	А-13
272754	75951	А-13
272755	75952	А-13
272756	75953	А-13
272757	75954	А-13
272758	75955	А-13
272759	75956	А-13
272760	75957	А-13
272761	75958	А-13
272762	75959	А-13
272763	75960	А-13
272764	75961	А-13
272765	75962	А-13
272766	75963	А-13
272767	75964	А-13
272768	75965	А-13
272769	75966	А-13
272770	75967	А-13
272771	75968	А-13
272772	75969	А-13
272773	75970	А-13
272774	75971	А-13
272775	75972	А-13
272776	75973	А-13
272777	75974	А-13
272778	75975	Г-420-1
272779	75976	Г-420-1
272780	75977	Г-420-1
272781	75978	Г-420-1
272782	75979	Г-420-1
272783	75980	Г-420-1
272784	75981	Г-420-1
272785	75982	Г-420-1
272786	75983	Г-420-1
272787	75984	Г-420-1
272788	75985	Г-420-1
272789	75986	Г-420-1
272790	75987	Г-420-1
272791	75988	Г-420-1
272792	75989	Г-420-1
272793	75990	Г-420-1
272794	75991	Г-420-1
272795	75992	Г-420-1
272796	75993	Г-420-1
272797	75994	Г-420-1
272798	75995	Г-420-1
272799	75996	Г-420-1
272800	75997	Г-420-1
272801	75998	Г-420-1
272802	75999	Г-420-1
272803	76000	Г-420-1
272804	76001	Г-420-1
272805	76002	Г-420-1
272806	76003	Г-420-1
272807	76004	Г-420-1
272808	76005	Г-420-1
272809	76006	Г-420-1
272810	76007	ФОК-4
272811	76008	ФОК-4
272812	76009	ФОК-4
272813	76010	ФОК-4
272814	76011	ФОК-4
272815	76012	ФОК-4
272816	76013	ФОК-4
272817	76014	ФОК-4
272818	76015	ФОК-4
272819	76016	ФОК-4
272820	76017	ФОК-4
272821	76018	ФОК-4
272822	76019	ФОК-4
272823	76020	ФОК-4
272824	76021	ФОК-4
272825	76022	ФОК-4
272826	76023	А-13
272827	76024	А-13
272828	76025	А-13
272829	76026	А-13
272830	76027	А-13
272831	76028	А-13
272832	76029	А-13
272833	76030	А-13
272834	76031	А-13
272835	76032	А-13
272836	76033	А-13
272837	76034	А-13
272838	76035	А-13
272839	76036	А-13
272840	76037	А-13
272841	76038	А-13
272842	76039	Б-115
272843	76040	Б-115
272844	76041	Б-115
272845	76042	Б-115
272846	76043	Б-115
272847	76044	Б-115
272848	76045	Б-115
272849	76046	Б-115
272850	76047	А-17
272851	76048	А-17
272852	76049	А-17
272853	76050	А-17
272854	76051	А-17
272855	76052	А-17
272856	76053	А-17
272857	76054	А-17
272858	76055	А-13
272859	76056	А-13
272860	76057	А-13
272861	76058	А-13
272862	76059	А-13
272863	76060	А-13
272864	76061	А-13
272865	76062	А-13
272866	76063	А-208
272867	76064	А-208
272868	76065	А-208
272869	76066	А-208
272870	76067	А-208
272871	76068	А-208
272872	76069	А-208
272873	76070	А-208
272874	76071	А-208
272875	76072	А-208
272876	76073	А-208
272877	76074	А-208
272878	76075	А-208
272879	76076	А-208
272880	76077	А-208
272881	76078	А-208
272882	76079	А-217
272883	76080	А-217
272884	76081	А-217
272885	76082	А-217
272886	76083	А-217
272887	76084	А-217
272888	76085	А-217
272889	76086	А-217
272890	76087	А-217
272891	76088	А-217
272892	76089	А-217
272893	76090	А-217
272894	76091	А-217
272895	76092	А-217
272896	76093	А-217
272897	76094	А-217
272898	76095	А-13
272899	76096	А-13
272900	76097	А-13
272901	76098	А-13
272902	76099	А-13
272903	76100	А-13
272904	76101	А-13
272905	76102	А-13
272906	76103	А-13
272907	76104	А-13
272908	76105	А-13
272909	76106	А-13
272910	76107	А-13
272911	76108	А-13
272912	76109	А-13
272913	76110	А-13
272914	76111	А-13
272915	76112	А-13
272916	76113	А-13
272917	76114	А-13
272918	76115	А-13
272919	76116	А-13
272920	76117	А-13
272921	76118	А-13
272922	76119	А-13
272923	76120	А-13
272924	76121	А-13
272925	76122	А-13
272926	76123	А-13
272927	76124	А-13
272928	76125	А-13
272929	76126	А-13
272930	76127	Б-209-2
272931	76128	Б-209-2
272932	76129	Б-209-2
272933	76130	Б-209-2
272934	76131	Б-209-2
272935	76132	Б-209-2
272936	76133	Б-209-2
272937	76134	Б-209-2
272938	76135	Б-209-2
272939	76136	Б-209-2
272940	76137	Б-209-2
272941	76138	Б-209-2
272942	76139	Б-209-2
272943	76140	Б-209-2
272944	76141	Б-209-2
272945	76142	Б-209-2
272946	76143	дист.
272947	76144	дист.
272948	76145	дист.
272949	76146	дист.
272950	76147	дист.
272951	76148	дист.
272952	76149	дист.
272953	76150	дист.
272954	76151	А-321
272955	76152	А-321
272956	76153	А-321
272957	76154	А-321
272958	76155	А-321
272959	76156	А-321
272960	76157	А-321
272961	76158	А-321
272962	76159	Г-102
272963	76160	Г-102
272964	76161	Г-102
272965	76162	Г-102
272966	76163	Г-102
272967	76164	Г-102
272968	76165	Г-102
272969	76166	Г-102
272970	76167	Г-102
272971	76168	Г-102
272972	76169	Г-102
272973	76170	Г-102
272974	76171	Г-102
272975	76172	Г-102
272976	76173	Г-102
272977	76174	Г-102
272978	76175	Г-412
272979	76176	Г-412
272980	76177	Г-412
272981	76178	Г-412
272982	76179	Г-412
272983	76180	Г-412
272984	76181	Г-412
272985	76182	Г-412
272986	76183	Г-412
272987	76184	Г-412
272988	76185	Г-412
272989	76186	Г-412
272990	76187	Г-412
272991	76188	Г-412
272992	76189	Г-412
272993	76190	Г-412
272994	76191	Г-412
272995	76192	Г-412
272996	76193	Г-412
272997	76194	Г-412
272998	76195	Г-412
272999	76196	Г-412
273000	76197	Г-412
273001	76198	Г-412
273002	76199	Г-412
273003	76200	Г-412
273004	76201	Г-412
273005	76202	Г-412
273006	76203	Г-412
273007	76204	Г-412
273008	76205	Г-412
273009	76206	Г-412
273010	76207	А-2
273011	76208	А-2
273012	76209	А-2
273013	76210	А-2
273014	76211	А-2
273015	76212	А-2
273016	76213	А-2
273017	76214	А-2
273018	76215	ФОК-5
273019	76216	ФОК-5
273020	76217	ФОК-5
273021	76218	ФОК-5
273022	76219	ФОК-5
273023	76220	ФОК-5
273024	76221	ФОК-5
273025	76222	ФОК-5
273026	76223	ФОК-5
273027	76224	ФОК-5
273028	76225	ФОК-5
273029	76226	ФОК-5
273030	76227	ФОК-5
273031	76228	ФОК-5
273032	76229	ФОК-5
273033	76230	ФОК-5
273034	76231	Г-102
273035	76232	Г-102
273036	76233	Г-102
273037	76234	Г-102
273038	76235	Г-102
273039	76236	Г-102
273040	76237	Г-102
273041	76238	Г-102
273042	76239	Г-102
273043	76240	Г-102
273044	76241	Г-102
273045	76242	Г-102
273046	76243	Г-102
273047	76244	Г-102
273048	76245	Г-102
273049	76246	Г-102
273050	76247	Б-209-2
273051	76248	Б-209-2
273052	76249	Б-209-2
273053	76250	Б-209-2
273054	76251	Б-209-2
273055	76252	Б-209-2
273056	76253	Б-209-2
273057	76254	Б-209-2
273058	76255	Б-209-2
273059	76256	Б-209-2
273060	76257	Б-209-2
273061	76258	Б-209-2
273062	76259	Б-209-2
273063	76260	Б-209-2
273064	76261	Б-209-2
273065	76262	Б-209-2
273066	76263	Б-209-2
273067	76264	Б-209-2
273068	76265	Б-209-2
273069	76266	Б-209-2
273070	76267	Б-209-2
273071	76268	Б-209-2
273072	76269	Б-209-2
273073	76270	Б-209-2
273074	76271	Б-209-2
273075	76272	Б-209-2
273076	76273	Б-209-2
273077	76274	Б-209-2
273078	76275	Б-209-2
273079	76276	Б-209-2
273080	76277	Б-209-2
273081	76278	Б-209-2
273082	76279	А-13
273083	76280	А-13
273084	76281	А-13
273085	76282	А-13
273086	76283	А-13
273087	76284	А-13
273088	76285	А-13
273089	76286	А-13
273090	76287	А-13
273091	76288	А-13
273092	76289	А-13
273093	76290	А-13
273094	76291	А-13
273095	76292	А-13
273096	76293	А-13
273097	76294	А-13
273098	76295	А-13
273099	76296	А-13
273100	76297	А-13
273101	76298	А-13
273102	76299	А-13
273103	76300	А-13
273104	76301	А-13
273105	76302	А-13
273106	76303	А-13
273107	76304	А-13
273108	76305	А-13
273109	76306	А-13
273110	76307	А-13
273111	76308	А-13
273112	76309	А-13
273113	76310	А-13
273114	76311	Г-102
273115	76312	Г-102
273116	76313	Г-102
273117	76314	Г-102
273118	76315	Г-102
273119	76316	Г-102
273120	76317	Г-102
273121	76318	Г-102
273122	76319	Г-102
273123	76320	Г-102
273124	76321	Г-102
273125	76322	Г-102
273126	76323	Г-102
273127	76324	Г-102
273128	76325	Г-102
273129	76326	Г-102
273130	76327	Д-210
273131	76328	Д-210
273132	76329	Д-210
273133	76330	Д-210
273134	76331	Д-210
273135	76332	Д-210
273136	76333	Д-210
273137	76334	Д-210
273138	76335	Д-210
273139	76336	Д-210
273140	76337	Д-210
273141	76338	Д-210
273142	76339	Д-210
273143	76340	Д-210
273144	76341	Д-210
273145	76342	Д-210
273146	76343	А-13
273147	76344	А-13
273148	76345	А-13
273149	76346	А-13
273150	76347	А-13
273151	76348	А-13
273152	76349	А-13
273153	76350	А-13
273154	76351	А-13
273155	76352	А-13
273156	76353	А-13
273157	76354	А-13
273158	76355	А-13
273159	76356	А-13
273160	76357	А-13
273161	76358	А-13
273162	76359	Б-115
273163	76360	Б-115
273164	76361	Б-115
273165	76362	Б-115
273166	76363	Б-115
273167	76364	Б-115
273168	76365	Б-115
273169	76366	Б-115
273170	76367	А-17
273171	76368	А-17
273172	76369	А-17
273173	76370	А-17
273174	76371	А-17
273175	76372	А-17
273176	76373	А-17
273177	76374	А-17
273178	76375	А-13
273179	76376	А-13
273180	76377	А-13
273181	76378	А-13
273182	76379	А-13
273183	76380	А-13
273184	76381	А-13
273185	76382	А-13
273186	76383	А-217
273187	76384	А-217
273188	76385	А-217
273189	76386	А-217
273190	76387	А-217
273191	76388	А-217
273192	76389	А-217
273193	76390	А-217
273194	76391	А-217
273195	76392	А-217
273196	76393	А-217
273197	76394	А-217
273198	76395	А-217
273199	76396	А-217
273200	76397	А-217
273201	76398	А-217
273202	76399	И-302\nИ-318
273203	76400	И-302\nИ-318
273204	76401	И-302\nИ-318
273205	76402	И-302\nИ-318
273206	76403	И-302\nИ-318
273207	76404	И-302\nИ-318
273208	76405	И-302\nИ-318
273209	76406	И-302\nИ-318
273210	76407	И-302\nИ-318
273211	76408	И-302\nИ-318
273212	76409	И-302\nИ-318
273213	76410	И-302\nИ-318
273214	76411	И-302\nИ-318
273215	76412	И-302\nИ-318
273216	76413	И-302\nИ-318
273217	76414	И-302\nИ-318
273218	76415	А-13
273219	76416	А-13
273220	76417	А-13
273221	76418	А-13
273222	76419	А-13
273223	76420	А-13
273224	76421	А-13
273225	76422	А-13
273226	76423	А-13
273227	76424	А-13
273228	76425	А-13
273229	76426	А-13
273230	76427	А-13
273231	76428	А-13
273232	76429	А-13
273233	76430	А-13
273234	76431	А-13
273235	76432	А-13
273236	76433	А-13
273237	76434	А-13
273238	76435	А-13
273239	76436	А-13
273240	76437	А-13
273241	76438	А-13
273242	76439	А-13
273243	76440	А-13
273244	76441	А-13
273245	76442	А-13
273246	76443	А-13
273247	76444	А-13
273248	76445	А-13
273249	76446	А-13
273250	76447	Б-209-2
273251	76448	Б-209-2
273252	76449	Б-209-2
273253	76450	Б-209-2
273254	76451	Б-209-2
273255	76452	Б-209-2
273256	76453	Б-209-2
273257	76454	Б-209-2
273258	76455	Б-209-2
273259	76456	Б-209-2
273260	76457	Б-209-2
273261	76458	Б-209-2
273262	76459	Б-209-2
273263	76460	Б-209-2
273264	76461	Б-209-2
273265	76462	Б-209-2
273266	76463	дист.
273267	76464	дист.
273268	76465	дист.
273269	76466	дист.
273270	76467	дист.
273271	76468	дист.
273272	76469	дист.
273273	76470	дист.
273274	76471	А-318
273275	76472	А-318
273276	76473	А-318
273277	76474	А-318
273278	76475	А-318
273279	76476	А-318
273280	76477	А-318
273281	76478	А-318
273282	76479	А-318
273283	76480	А-318
273284	76481	А-318
273285	76482	А-318
273286	76483	А-318
273287	76484	А-318
273288	76485	А-318
273289	76486	А-318
273290	76487	А-13
273291	76488	А-13
273292	76489	А-13
273293	76490	А-13
273294	76491	А-13
273295	76492	А-13
273296	76493	А-13
273297	76494	А-13
273298	76495	А-13
273299	76496	А-13
273300	76497	А-13
273301	76498	А-13
273302	76499	А-13
273303	76500	А-13
273304	76501	А-13
273305	76502	А-13
273306	76503	А-13
273307	76504	А-13
273308	76505	А-13
273309	76506	А-13
273310	76507	А-13
273311	76508	А-13
273312	76509	А-13
273313	76510	А-13
273314	76511	А-13
273315	76512	А-13
273316	76513	А-13
273317	76514	А-13
273318	76515	А-13
273319	76516	А-13
273320	76517	А-13
273321	76518	А-13
273322	76519	Б-209-2
273323	76520	Б-209-2
273324	76521	Б-209-2
273325	76522	Б-209-2
273326	76523	Б-209-2
273327	76524	Б-209-2
273328	76525	Б-209-2
273329	76526	Б-209-2
273330	76527	Б-209-2
273331	76528	Б-209-2
273332	76529	Б-209-2
273333	76530	Б-209-2
273334	76531	Б-209-2
273335	76532	Б-209-2
273336	76533	Б-209-2
273337	76534	Б-209-2
273338	76535	А-16
273339	76536	А-16
273340	76537	А-16
273341	76538	А-16
273342	76539	А-16
273343	76540	А-16
273344	76541	А-16
273345	76542	А-16
273346	76543	А-16
273347	76544	А-16
273348	76545	А-16
273349	76546	А-16
273350	76547	А-16
273351	76548	А-16
273352	76549	А-16
273353	76550	А-16
273354	76551	А-13
273355	76552	А-13
273356	76553	А-13
273357	76554	А-13
273358	76555	А-13
273359	76556	А-13
273360	76557	А-13
273361	76558	А-13
273362	76559	А-13
273363	76560	А-13
273364	76561	А-13
273365	76562	А-13
273366	76563	А-13
273367	76564	А-13
273368	76565	А-13
273369	76566	А-13
273370	76567	А-218
273371	76568	А-218
273372	76569	А-218
273373	76570	А-218
273374	76571	А-218
273375	76572	А-218
273376	76573	А-218
273377	76574	А-218
273378	76575	А-218
273379	76576	А-218
273380	76577	А-218
273381	76578	А-218
273382	76579	А-218
273383	76580	А-218
273384	76581	А-218
273385	76582	А-218
273386	76583	ФОК-12
273387	76584	ФОК-12
273388	76585	ФОК-12
273389	76586	ФОК-12
273390	76587	ФОК-12
273391	76588	ФОК-12
273392	76589	ФОК-12
273393	76590	ФОК-12
273394	76591	ФОК-12
273395	76592	ФОК-12
273396	76593	ФОК-12
273397	76594	ФОК-12
273398	76595	ФОК-12
273399	76596	ФОК-12
273400	76597	ФОК-12
273401	76598	ФОК-12
273402	76599	И-202-б
273403	76600	И-202-б
273404	76601	И-202-б
273405	76602	И-202-б
273406	76603	И-202-б
273407	76604	И-202-б
273408	76605	И-202-б
273409	76606	И-202-б
273410	76607	И-202-б
273411	76608	И-202-б
273412	76609	И-202-б
273413	76610	И-202-б
273414	76611	И-202-б
273415	76612	И-202-б
273416	76613	И-202-б
273417	76614	И-202-б
273418	76615	А-215
273419	76616	А-215
273420	76617	А-215
273421	76618	А-215
273422	76619	А-215
273423	76620	А-215
273424	76621	А-215
273425	76622	А-215
273426	76623	А-215
273427	76624	А-215
273428	76625	А-215
273429	76626	А-215
273430	76627	А-215
273431	76628	А-215
273432	76629	А-215
273433	76630	А-215
273434	76631	И-324
273435	76632	И-324
273436	76633	И-324
273437	76634	И-324
273438	76635	И-324
273439	76636	И-324
273440	76637	И-324
273441	76638	И-324
273442	76639	И-324
273443	76640	И-324
273444	76641	И-324
273445	76642	И-324
273446	76643	И-324
273447	76644	И-324
273448	76645	И-324
273449	76646	И-324
273450	76647	А-180
273451	76648	А-180
273452	76649	А-180
273453	76650	А-180
273454	76651	А-180
273455	76652	А-180
273456	76653	А-180
273457	76654	А-180
273458	76655	А-180
273459	76656	А-180
273460	76657	А-180
273461	76658	А-180
273462	76659	А-180
273463	76660	А-180
273464	76661	А-180
273465	76662	А-180
273466	76663	А-4
273467	76664	А-4
273468	76665	А-4
273469	76666	А-4
273470	76667	А-4
273471	76668	А-4
273472	76669	А-4
273473	76670	А-4
273474	76671	Б-209-2
273475	76672	Б-209-2
273476	76673	Б-209-2
273477	76674	Б-209-2
273478	76675	Б-209-2
273479	76676	Б-209-2
273480	76677	Б-209-2
273481	76678	Б-209-2
273482	76679	А-13
273483	76680	А-13
273484	76681	А-13
273485	76682	А-13
273486	76683	А-13
273487	76684	А-13
273488	76685	А-13
273489	76686	А-13
273490	76687	А-13
273491	76688	А-13
273492	76689	А-13
273493	76690	А-13
273494	76691	А-13
273495	76692	А-13
273496	76693	А-13
273497	76694	А-13
273498	76695	А-211
273499	76696	А-211
273500	76697	А-211
273501	76698	А-211
273502	76699	А-211
273503	76700	А-211
273504	76701	А-211
273505	76702	А-211
273506	76703	А-174-б
273507	76704	А-174-б
273508	76705	А-174-б
273509	76706	А-174-б
273510	76707	А-174-б
273511	76708	А-174-б
273512	76709	А-174-б
273513	76710	А-174-б
273514	76711	А-174-б
273515	76712	А-174-б
273516	76713	А-174-б
273517	76714	А-174-б
273518	76715	А-174-б
273519	76716	А-174-б
273520	76717	А-174-б
273521	76718	А-174-б
273522	76719	А-13
273523	76720	А-13
273524	76721	А-13
273525	76722	А-13
273526	76723	А-13
273527	76724	А-13
273528	76725	А-13
273529	76726	А-13
273530	76727	А-13
273531	76728	А-13
273704	76901	А-174-б
273705	76902	А-174-б
273706	76903	Б-209-2
273707	76904	Б-209-2
273708	76905	Б-209-2
273709	76906	Б-209-2
273710	76907	Б-209-2
273711	76908	Б-209-2
273712	76909	Б-209-2
273713	76910	Б-209-2
273714	76911	А-4
273715	76912	А-4
273716	76913	А-4
273717	76914	А-4
273718	76915	А-4
273719	76916	А-4
273720	76917	А-4
273721	76918	А-4
273722	76919	А-13
273723	76920	А-13
273724	76921	А-13
273725	76922	А-13
273726	76923	А-13
273727	76924	А-13
273728	76925	А-13
273729	76926	А-13
273730	76927	А-13
273731	76928	А-13
273732	76929	А-13
273733	76930	А-13
273734	76931	А-13
273735	76932	А-13
273736	76933	А-13
273737	76934	А-13
273738	76935	А-218
273739	76936	А-218
273740	76937	А-218
273741	76938	А-218
273742	76939	А-218
273743	76940	А-218
273744	76941	А-218
273745	76942	А-218
273746	76943	А-218
273747	76944	А-218
273748	76945	А-218
273749	76946	А-218
273750	76947	А-218
273751	76948	А-218
273752	76949	А-218
273753	76950	А-218
273754	76951	И-307\nИ-314
273755	76952	И-307\nИ-314
273756	76953	И-307\nИ-314
273757	76954	И-307\nИ-314
273758	76955	И-307\nИ-314
273759	76956	И-307\nИ-314
273760	76957	И-307\nИ-314
273761	76958	И-307\nИ-314
273762	76959	И-307\nИ-314
273763	76960	И-307\nИ-314
273764	76961	И-307\nИ-314
273765	76962	И-307\nИ-314
273766	76963	И-307\nИ-314
273767	76964	И-307\nИ-314
273768	76965	И-307\nИ-314
273769	76966	И-307\nИ-314
273770	76967	Б-209-2
273771	76968	Б-209-2
273772	76969	Б-209-2
273773	76970	Б-209-2
273774	76971	Б-209-2
273775	76972	Б-209-2
273776	76973	Б-209-2
273777	76974	Б-209-2
273778	76975	Б-209-2
273779	76976	Б-209-2
273780	76977	Б-209-2
273781	76978	Б-209-2
273782	76979	Б-209-2
273783	76980	Б-209-2
273784	76981	Б-209-2
273785	76982	Б-209-2
273786	76983	А-211
273787	76984	А-211
273788	76985	А-211
273789	76986	А-211
273790	76987	А-211
273791	76988	А-211
273792	76989	А-211
273793	76990	А-211
273794	76991	А-13
273795	76992	А-13
273796	76993	А-13
273797	76994	А-13
273798	76995	А-13
273799	76996	А-13
273800	76997	А-13
273801	76998	А-13
273802	76999	А-13
273803	77000	А-13
273804	77001	А-13
273805	77002	А-13
273806	77003	А-13
273807	77004	А-13
273808	77005	А-13
273809	77006	А-13
273810	77007	А-216
273811	77008	А-216
273812	77009	А-216
273813	77010	А-216
273814	77011	А-216
273815	77012	А-216
273816	77013	А-216
273817	77014	А-216
273818	77015	А-216
273819	77016	А-216
273820	77017	А-216
273821	77018	А-216
273822	77019	А-216
273823	77020	А-216
273824	77021	А-216
273825	77022	А-216
273826	77023	Б-209-2
273827	77024	Б-209-2
273828	77025	Б-209-2
273829	77026	Б-209-2
273830	77027	Б-209-2
273831	77028	Б-209-2
273832	77029	Б-209-2
273833	77030	Б-209-2
273834	77031	Б-209-2
273835	77032	Б-209-2
273836	77033	Б-209-2
273837	77034	Б-209-2
273838	77035	Б-209-2
273839	77036	Б-209-2
273840	77037	Б-209-2
273841	77038	Б-209-2
273842	77039	дист.
273843	77040	дист.
273844	77041	дист.
273845	77042	дист.
273846	77043	дист.
273847	77044	дист.
273848	77045	дист.
273849	77046	дист.
273850	77051	дист.
273851	77052	дист.
273852	77053	дист.
273853	77054	дист.
273854	77055	дист.
273855	77056	дист.
273856	77057	дист.
273857	77058	дист.
273858	77059	А-173
273859	77060	А-173
273860	77061	А-173
273861	77062	А-173
273862	77063	А-173
273863	77064	А-173
273864	77065	А-173
273865	77066	А-173
273866	77067	А-173
273867	77068	А-173
273868	77069	А-173
273869	77070	А-173
273870	77071	А-173
273871	77072	А-173
273872	77073	А-173
273873	77074	А-173
273874	77075	А-13
273875	77076	А-13
273876	77077	А-13
273877	77078	А-13
273878	77079	А-13
273879	77080	А-13
273880	77081	А-13
273881	77082	А-13
273882	77083	А-13
273883	77084	А-13
273884	77085	А-13
273885	77086	А-13
273886	77087	А-13
273887	77088	А-13
273888	77089	А-13
273889	77090	А-13
273890	77091	Б-209
273891	77092	Б-209
273892	77093	Б-209
273893	77094	Б-209
273894	77095	Б-209
273895	77096	Б-209
273896	77097	Б-209
273897	77098	Б-209
273898	77099	Б-209
273899	77100	Б-209
273900	77101	Б-209
273901	77102	Б-209
273902	77103	Б-209
273903	77104	Б-209
273904	77105	Б-209
273905	77106	Б-209
273906	77107	А-113
273907	77108	А-113
273908	77109	А-113
273909	77110	А-113
273910	77111	А-113
273911	77112	А-113
273912	77113	А-113
273913	77114	А-113
273914	77115	Б-209
273915	77116	Б-209
273916	77117	Б-209
273917	77118	Б-209
273918	77119	Б-209
273919	77120	Б-209
273920	77121	Б-209
273921	77122	Б-209
273922	77123	А-113
273923	77124	А-113
273924	77125	А-113
273925	77126	А-113
273926	77127	А-113
273927	77128	А-113
273928	77129	А-113
273929	77130	А-113
273930	77131	Б-209
273931	77132	Б-209
273932	77133	Б-209
273933	77134	Б-209
273934	77135	Б-209
273935	77136	Б-209
273936	77137	Б-209
273937	77138	Б-209
273938	77139	Б-209
273939	77140	Б-209
273940	77141	Б-209
273941	77142	Б-209
273942	77143	Б-209
273943	77144	Б-209
273944	77145	Б-209
273945	77146	Б-209
273946	77147	А-113
273947	77148	А-113
273948	77149	А-113
273949	77150	А-113
273950	77151	А-113
273951	77152	А-113
273952	77153	А-113
273953	77154	А-113
273954	77155	Б-209
273955	77156	Б-209
273956	77157	Б-209
273957	77158	Б-209
273958	77159	Б-209
273959	77160	Б-209
273960	77161	Б-209
273961	77162	Б-209
273962	77163	Б-209
273963	77164	Б-209
273964	77165	Б-209
273965	77166	Б-209
273966	77167	Б-209
273967	77168	Б-209
273968	77169	Б-209
273969	77170	Б-209
273970	77171	А-113
273971	77172	А-113
273972	77173	А-113
273973	77174	А-113
273974	77175	А-113
273975	77176	А-113
273976	77177	А-113
273977	77178	А-113
273978	77179	А-113
273979	77180	А-113
273980	77181	А-113
273981	77182	А-113
273982	77183	А-113
273983	77184	А-113
273984	77185	А-113
273985	77186	А-113
273986	77187	Б-209-1
273987	77188	Б-209-1
273988	77189	Б-209-1
273989	77190	Б-209-1
273990	77191	Б-209-1
273991	77192	Б-209-1
273992	77193	Б-209-1
273993	77194	Б-209-1
273994	77195	А-13
273995	77196	А-13
273996	77197	А-13
273997	77198	А-13
273998	77199	А-13
273999	77200	А-13
274000	77201	А-13
274001	77202	А-13
274002	77203	А-13
274003	77204	А-13
274004	77205	А-13
274005	77206	А-13
274006	77207	А-13
274007	77208	А-13
274008	77209	А-13
274009	77210	А-13
274010	77211	А-13
274011	77212	А-13
274012	77213	А-13
274013	77214	А-13
274014	77215	А-13
274015	77216	А-13
274016	77217	А-13
274017	77218	А-13
274018	77219	Б-209-2
274019	77220	Б-209-2
274020	77221	Б-209-2
274021	77222	Б-209-2
274022	77223	Б-209-2
274023	77224	Б-209-2
274024	77225	Б-209-2
274025	77226	Б-209-2
274026	77227	Б-209-2
274027	77228	Б-209-2
274028	77229	Б-209-2
274029	77230	Б-209-2
274030	77231	Б-209-2
274031	77232	Б-209-2
274032	77233	Б-209-2
274033	77234	Б-209-2
274034	77235	А-318
274035	77236	А-318
274036	77237	А-318
274037	77238	А-318
274038	77239	А-318
274039	77240	А-318
274040	77241	А-318
274041	77242	А-318
274042	77243	А-318
274043	77244	А-318
274044	77245	А-318
274045	77246	А-318
274046	77247	А-318
274047	77248	А-318
274048	77249	А-318
274049	77250	А-318
274050	77251	А-216
274051	77252	А-216
274052	77253	А-216
274053	77254	А-216
274054	77255	А-216
274055	77256	А-216
274056	77257	А-216
274057	77258	А-216
274058	77259	А-216
274059	77260	А-216
274060	77261	А-216
274061	77262	А-216
274062	77263	А-216
274063	77264	А-216
274064	77265	А-216
274065	77266	А-216
274066	77271	дист.
274067	77272	дист.
274068	77273	дист.
274069	77274	дист.
274070	77275	дист.
274071	77276	дист.
274072	77277	дист.
274073	77278	дист.
274074	77279	А-13
274075	77280	А-13
274076	77281	А-13
274077	77282	А-13
274078	77283	А-13
274079	77284	А-13
274080	77285	А-13
274081	77286	А-13
274082	77287	А-13
274083	77288	А-13
274084	77289	А-13
274085	77290	А-13
274086	77291	А-13
274087	77292	А-13
274088	77293	А-13
274089	77294	А-13
274090	77295	Б-209
274091	77296	Б-209
274092	77297	Б-209
274093	77298	Б-209
274094	77299	Б-209
274095	77300	Б-209
274096	77301	Б-209
274097	77302	Б-209
274098	77303	Б-209
274099	77304	Б-209
274100	77305	Б-209
274101	77306	Б-209
274102	77307	Б-209
274103	77308	Б-209
274104	77309	Б-209
274105	77310	Б-209
274106	77311	А-113
274107	77312	А-113
274108	77313	А-113
274109	77314	А-113
274110	77315	А-113
274111	77316	А-113
274112	77317	А-113
274113	77318	А-113
274114	77319	Б-209
274115	77320	Б-209
274116	77321	Б-209
274117	77322	Б-209
274118	77323	Б-209
274119	77324	Б-209
274120	77325	Б-209
274121	77326	Б-209
274122	77327	А-113
274123	77328	А-113
274124	77329	А-113
274125	77330	А-113
274126	77331	А-113
274127	77332	А-113
274128	77333	А-113
274129	77334	А-113
274130	77335	Б-209
274131	77336	Б-209
274132	77337	Б-209
274133	77338	Б-209
274134	77339	Б-209
274135	77340	Б-209
274136	77341	Б-209
274137	77342	Б-209
274138	77343	Б-209
274139	77344	Б-209
274140	77345	Б-209
274141	77346	Б-209
274142	77347	Б-209
274143	77348	Б-209
274144	77349	Б-209
274145	77350	Б-209
274146	77351	А-113
274147	77352	А-113
274148	77353	А-113
274149	77354	А-113
274150	77355	А-113
274151	77356	А-113
274152	77357	А-113
274153	77358	А-113
274154	77359	Б-209
274155	77360	Б-209
274156	77361	Б-209
274157	77362	Б-209
274158	77363	Б-209
274159	77364	Б-209
274160	77365	Б-209
274161	77366	Б-209
274162	77367	Б-209
274163	77368	Б-209
274164	77369	Б-209
274165	77370	Б-209
274166	77371	Б-209
274167	77372	Б-209
274168	77373	Б-209
274169	77374	Б-209
274170	77375	А-113
274171	77376	А-113
274172	77377	А-113
274173	77378	А-113
274174	77379	А-113
274175	77380	А-113
274176	77381	А-113
274177	77382	А-113
274178	77383	А-113
274179	77384	А-113
274180	77385	А-113
274181	77386	А-113
274182	77387	А-113
274183	77388	А-113
274184	77389	А-113
274185	77390	А-113
274186	77391	Б-209-1
274187	77392	Б-209-1
274188	77393	Б-209-1
274189	77394	Б-209-1
274190	77395	Б-209-1
274191	77396	Б-209-1
274192	77397	Б-209-1
274193	77398	Б-209-1
274194	77399	А-13
274195	77400	А-13
274196	77401	А-13
274197	77402	А-13
274198	77403	А-13
274199	77404	А-13
274200	77405	А-13
274201	77406	А-13
274202	77407	А-13
274203	77408	А-13
274204	77409	А-13
274205	77410	А-13
274206	77411	А-13
274207	77412	А-13
274208	77413	А-13
274209	77414	А-13
274210	77415	А-13
274211	77416	А-13
274212	77417	А-13
274213	77418	А-13
274214	77419	А-13
274215	77420	А-13
274216	77421	А-13
274217	77422	А-13
274218	77423	А-305
274219	77424	А-305
274220	77425	А-305
274221	77426	А-305
274222	77427	А-305
274223	77428	А-305
274224	77429	А-305
274225	77430	А-305
274226	77431	А-305
274227	77432	А-305
274228	77433	А-305
274229	77434	А-305
274230	77435	А-305
274231	77436	А-305
274232	77437	А-305
274233	77438	А-305
274234	77439	Б-209-1
274235	77440	Б-209-1
274236	77441	Б-209-1
274237	77442	Б-209-1
274238	77443	Б-209-1
274239	77444	Б-209-1
274240	77445	Б-209-1
274241	77446	Б-209-1
274242	77447	Б-209-1
274243	77448	Б-209-1
274244	77449	Б-209-1
274245	77450	Б-209-1
274246	77451	Б-209-1
274247	77452	Б-209-1
274248	77453	Б-209-1
274249	77454	Б-209-1
274250	77455	А-216
274251	77456	А-216
274252	77457	А-216
274253	77458	А-216
274254	77459	А-216
274255	77460	А-216
274256	77461	А-216
274257	77462	А-216
274258	77463	А-216
274259	77464	А-216
274260	77465	А-216
274261	77466	А-216
274262	77467	А-216
274263	77468	А-216
274264	77469	А-216
274265	77470	А-216
274266	77471	А-318
274267	77472	А-318
274268	77473	А-318
274269	77474	А-318
274270	77475	А-318
274271	77476	А-318
274272	77477	А-318
274273	77478	А-318
274274	77479	А-318
274275	77480	А-318
274276	77481	А-318
274277	77482	А-318
274278	77483	А-318
274279	77484	А-318
274280	77485	А-318
274281	77486	А-318
274282	77487	Б-209
274283	77488	Б-209
274284	77489	Б-209
274285	77490	Б-209
274286	77491	Б-209
274287	77492	Б-209
274288	77493	Б-209
274289	77494	Б-209
274290	77495	Б-209
274291	77496	Б-209
274292	77497	Б-209
274293	77498	Б-209
274294	77499	Б-209
274295	77500	Б-209
274296	77501	Б-209
274297	77502	Б-209
274298	77503	Б-209
274299	77504	Б-209
274300	77505	Б-209
274301	77506	Б-209
274302	77507	Б-209
274303	77508	Б-209
274304	77509	Б-209
274305	77510	Б-209
274306	77511	Б-209
274307	77512	Б-209
274308	77513	Б-209
274309	77514	Б-209
274310	77515	Б-209
274311	77516	Б-209
274312	77517	Б-209
274313	77518	Б-209
274314	77519	Б-209
274315	77520	Б-209
274316	77521	Б-209
274317	77522	Б-209
274318	77523	Б-209
274319	77524	Б-209
274320	77525	Б-209
274321	77526	Б-209
274322	77527	Б-209
274323	77528	Б-209
274324	77529	Б-209
274325	77530	Б-209
274326	77531	Б-209
274327	77532	Б-209
274328	77533	Б-209
274329	77534	Б-209
274330	77535	А-316
274331	77536	А-316
274332	77537	А-316
274333	77538	А-316
274334	77539	А-316
274335	77540	А-316
274336	77541	А-316
274337	77542	А-316
274338	77543	А-113
274339	77544	А-113
274340	77545	А-113
274341	77546	А-113
274342	77547	А-113
274343	77548	А-113
274344	77549	А-113
274345	77550	А-113
274346	77551	А-316
274347	77552	А-316
274348	77553	А-316
274349	77554	А-316
274350	77555	А-316
274351	77556	А-316
274352	77557	А-316
274353	77558	А-316
274354	77559	А-113
274355	77560	А-113
274356	77561	А-113
274357	77562	А-113
274358	77563	А-113
274359	77564	А-113
274360	77565	А-113
274361	77566	А-113
274362	77567	НИР
274363	77568	НИР
274364	77569	НИР
274365	77570	НИР
274366	77571	НИР
274367	77572	НИР
274368	77573	НИР
274369	77574	НИР
274370	77575	НИР
274371	77576	НИР
274372	77577	НИР
274373	77578	НИР
274374	77579	НИР
274375	77580	НИР
274376	77581	НИР
274377	77582	НИР
274378	77583	НИР
274379	77584	НИР
274380	77585	НИР
274381	77586	НИР
274382	77587	НИР
274383	77588	НИР
274384	77589	НИР
274385	77590	НИР
274386	77591	НИР
274387	77592	НИР
274388	77593	НИР
274389	77594	НИР
274390	77595	НИР
274391	77596	НИР
274392	77597	НИР
274393	77598	НИР
274394	77599	НИР
274395	77600	НИР
274396	77601	НИР
274397	77602	НИР
274398	77603	НИР
274399	77604	НИР
274400	77605	НИР
274401	77606	НИР
274402	77607	НИР
274403	77608	НИР
274404	77609	НИР
274405	77610	НИР
274406	77611	НИР
274407	77612	НИР
274408	77613	НИР
274409	77614	НИР
274410	77615	НИР
274411	77616	НИР
274412	77617	НИР
274413	77618	НИР
274414	77619	НИР
274415	77620	НИР
274416	77621	НИР
274417	77622	НИР
274418	77623	НИР
274419	77624	НИР
274420	77625	НИР
274421	77626	НИР
274422	77627	НИР
274423	77628	НИР
274424	77629	НИР
274425	77630	НИР
274426	77631	Б-209
274427	77632	Б-209
274428	77633	Б-209
274429	77634	Б-209
274430	77635	Б-209
274431	77636	Б-209
274432	77637	Б-209
274433	77638	Б-209
274434	77639	А-113
274435	77640	А-113
274436	77641	А-113
274437	77642	А-113
274438	77643	А-113
274439	77644	А-113
274440	77645	А-113
274441	77646	А-113
274442	77647	Б-209
274443	77648	Б-209
274444	77649	Б-209
274445	77650	Б-209
274446	77651	Б-209
274447	77652	Б-209
274448	77653	Б-209
274449	77654	Б-209
274450	77655	Б-115
274451	77656	Б-115
274452	77657	Б-115
274453	77658	Б-115
274454	77659	Б-115
274455	77660	Б-115
274456	77661	Б-115
274457	77662	Б-115
274458	77663	Б-115
274459	77664	Б-115
274460	77665	Б-115
274461	77666	Б-115
274462	77667	Б-115
274463	77668	Б-115
274464	77669	Б-115
274465	77670	Б-115
274466	77671	Г-102
274467	77672	Г-102
274468	77673	Г-102
274469	77674	Г-102
274470	77675	Г-102
274471	77676	Г-102
274472	77677	Г-102
274473	77678	Г-102
274474	77679	Г-102
274475	77680	Г-102
274476	77681	Г-102
274477	77682	Г-102
274478	77683	Г-102
274479	77684	Г-102
274480	77685	Г-102
274481	77686	Г-102
274482	77687	А-205
274483	77688	А-205
274484	77689	А-205
274485	77690	А-205
274486	77691	А-205
274487	77692	А-205
274488	77693	А-205
274489	77694	А-205
274490	77695	А-173
274491	77696	А-173
274492	77697	А-173
274493	77698	А-173
274494	77699	А-173
274495	77700	А-173
274496	77701	А-173
274497	77702	А-173
274498	77703	А-8
274499	77704	А-8
274500	77705	А-8
274501	77706	А-8
274502	77707	А-8
274503	77708	А-8
274504	77709	А-8
274505	77710	А-8
274506	77711	А-173
274507	77712	А-173
274508	77713	А-173
274509	77714	А-173
274510	77715	А-173
274511	77716	А-173
274512	77717	А-173
274513	77718	А-173
274514	77719	Б-115
274515	77720	Б-115
274516	77721	Б-115
274517	77722	Б-115
274518	77723	Б-115
274519	77724	Б-115
274520	77725	Б-115
274521	77726	Б-115
274522	77727	Б-115
274523	77728	Б-115
274524	77729	Б-115
274525	77730	Б-115
274526	77731	Б-115
274527	77732	Б-115
274528	77733	Б-115
274529	77734	Б-115
274530	77735	А-181
274531	77736	А-181
274532	77737	А-181
274533	77738	А-181
274534	77739	А-181
274535	77740	А-181
274536	77741	А-181
274537	77742	А-181
274538	77743	А-181
274539	77744	А-181
274540	77745	А-181
274541	77746	А-181
274542	77747	А-181
274543	77748	А-181
274544	77749	А-181
274545	77750	А-181
274546	77751	А-173
274547	77752	А-173
274548	77753	А-173
274549	77754	А-173
274550	77755	А-173
274551	77756	А-173
274552	77757	А-173
274553	77758	А-173
274554	77823	А-4
274555	77824	А-4
274556	77825	А-4
274557	77826	А-4
274558	77827	А-4
274559	77828	А-4
274560	77829	А-4
274561	77830	А-4
274562	77831	А-4
274563	77832	А-4
274564	77833	А-4
274565	77834	А-4
274566	77835	А-4
274567	77836	А-4
274568	77837	А-4
274569	77838	А-4
274570	77839	А-314
274571	77840	А-314
274572	77841	А-314
274573	77842	А-314
274574	77843	А-314
274575	77844	А-314
274576	77845	А-314
274577	77846	А-314
274578	77847	А-207
274579	77848	А-207
274580	77849	А-207
274581	77850	А-207
274582	77851	А-207
274583	77852	А-207
274584	77853	А-207
274585	77854	А-207
274586	77855	Б-209
274587	77856	Б-209
274588	77857	Б-209
274589	77858	Б-209
274590	77859	Б-209
274591	77860	Б-209
274592	77861	Б-209
274593	77862	Б-209
274594	77863	Б-209
274595	77864	Б-209
274596	77865	Б-209
274597	77866	Б-209
274598	77867	Б-209
274599	77868	Б-209
274600	77869	Б-209
274601	77870	Б-209
274602	77871	Б-209
274603	77872	Б-209
274604	77873	Б-209
274605	77874	Б-209
274606	77875	Б-209
274607	77876	Б-209
274608	77877	Б-209
274609	77878	Б-209
274610	77879	Б-209
274611	77880	Б-209
274612	77881	Б-209
274613	77882	Б-209
274614	77883	Б-209
274615	77884	Б-209
274616	77885	Б-209
274617	77886	Б-209
274618	77887	Б-209
274619	77888	Б-209
274620	77889	Б-209
274621	77890	Б-209
274622	77891	Б-209
274623	77892	Б-209
274624	77893	Б-209
274625	77894	Б-209
274626	77895	Б-209
274627	77896	Б-209
274628	77897	Б-209
274629	77898	Б-209
274630	77899	Б-209
274631	77900	Б-209
274632	77901	Б-209
274633	77902	Б-209
274634	77903	А-316
274635	77904	А-316
274636	77905	А-316
274637	77906	А-316
274638	77907	А-316
274639	77908	А-316
274640	77909	А-316
274641	77910	А-316
274642	77911	А-113
274643	77912	А-113
274644	77913	А-113
274645	77914	А-113
274646	77915	А-113
274647	77916	А-113
274648	77917	А-113
274649	77918	А-113
274650	77919	А-316
274651	77920	А-316
274652	77921	А-316
274653	77922	А-316
274654	77923	А-316
274655	77924	А-316
274656	77925	А-316
274657	77926	А-316
274658	77927	А-113
274659	77928	А-113
274660	77929	А-113
274661	77930	А-113
274662	77931	А-113
274663	77932	А-113
274664	77933	А-113
274665	77934	А-113
274666	77935	НИР
274667	77936	НИР
274668	77937	НИР
274669	77938	НИР
274670	77939	НИР
274671	77940	НИР
274672	77941	НИР
274673	77942	НИР
274674	77943	НИР
274675	77944	НИР
274676	77945	НИР
274677	77946	НИР
274678	77947	НИР
274679	77948	НИР
274680	77949	НИР
274681	77950	НИР
274682	77951	НИР
274683	77952	НИР
274684	77953	НИР
274685	77954	НИР
274686	77955	НИР
274687	77956	НИР
274688	77957	НИР
274689	77958	НИР
274690	77959	НИР
274691	77960	НИР
274692	77961	НИР
274693	77962	НИР
274694	77963	НИР
274695	77964	НИР
274696	77965	НИР
274697	77966	НИР
274698	77967	НИР
274699	77968	НИР
274700	77969	НИР
274701	77970	НИР
274702	77971	НИР
274703	77972	НИР
274704	77973	НИР
274705	77974	НИР
274706	77975	НИР
274707	77976	НИР
274708	77977	НИР
274709	77978	НИР
274710	77979	НИР
274711	77980	НИР
274712	77981	НИР
274713	77982	НИР
274714	77983	НИР
274715	77984	НИР
274716	77985	НИР
274717	77986	НИР
274718	77987	НИР
274719	77988	НИР
274720	77989	НИР
274721	77990	НИР
274722	77991	НИР
274723	77992	НИР
274724	77993	НИР
274725	77994	НИР
274726	77995	НИР
274727	77996	НИР
274728	77997	НИР
274729	77998	НИР
274730	77999	Б-209
274731	78000	Б-209
274732	78001	Б-209
274733	78002	Б-209
274734	78003	Б-209
274735	78004	Б-209
274736	78005	Б-209
274737	78006	Б-209
274738	78007	А-113
274739	78008	А-113
274740	78009	А-113
274741	78010	А-113
274742	78011	А-113
274743	78012	А-113
274744	78013	А-113
274745	78014	А-113
274746	78015	Б-209
274747	78016	Б-209
274748	78017	Б-209
274749	78018	Б-209
274750	78019	Б-209
274751	78020	Б-209
274752	78021	Б-209
274753	78022	Б-209
274754	78023	Б-115
274755	78024	Б-115
274756	78025	Б-115
274757	78026	Б-115
274758	78027	Б-115
274759	78028	Б-115
274760	78029	Б-115
274761	78030	Б-115
274762	78031	Б-115
274763	78032	Б-115
274764	78033	Б-115
274765	78034	Б-115
274766	78035	Б-115
274767	78036	Б-115
274768	78037	Б-115
274769	78038	Б-115
274770	78039	Г-102
274771	78040	Г-102
274772	78041	Г-102
274773	78042	Г-102
274774	78043	Г-102
274775	78044	Г-102
274776	78045	Г-102
274777	78046	Г-102
274778	78047	Г-102
274779	78048	Г-102
274780	78049	Г-102
274781	78050	Г-102
274782	78051	Г-102
274783	78052	Г-102
274784	78053	Г-102
274785	78054	Г-102
274786	78055	А-205
274787	78056	А-205
274788	78057	А-205
274789	78058	А-205
274790	78059	А-205
274791	78060	А-205
274792	78061	А-205
274793	78062	А-205
274794	78063	А-204
274795	78064	А-204
274796	78065	А-204
274797	78066	А-204
274798	78067	А-204
274799	78068	А-204
274800	78069	А-204
274801	78070	А-204
274802	78071	А-204
274803	78072	А-204
274804	78073	А-204
274805	78074	А-204
274806	78075	А-204
274807	78076	А-204
274808	78077	А-204
274809	78078	А-204
274810	78079	А-8
274811	78080	А-8
274812	78081	А-8
274813	78082	А-8
274814	78083	А-8
274815	78084	А-8
274816	78085	А-8
274817	78086	А-8
274818	78087	А-204
274819	78088	А-204
274820	78089	А-204
274821	78090	А-204
274822	78091	А-204
274823	78092	А-204
274824	78093	А-204
274825	78094	А-204
274826	78095	Б-115
274827	78096	Б-115
274828	78097	Б-115
274829	78098	Б-115
274830	78099	Б-115
274831	78100	Б-115
274832	78101	Б-115
274833	78102	Б-115
274834	78103	Б-115
274835	78104	Б-115
274836	78105	Б-115
274837	78106	Б-115
274838	78107	Б-115
274839	78108	Б-115
274840	78109	Б-115
274841	78110	Б-115
274842	78111	А-181
274843	78112	А-181
274844	78113	А-181
274845	78114	А-181
274846	78115	А-181
274847	78116	А-181
274848	78117	А-181
274849	78118	А-181
274850	78119	А-181
274851	78120	А-181
274852	78121	А-181
274853	78122	А-181
274854	78123	А-181
274855	78124	А-181
274856	78125	А-181
274857	78126	А-181
274858	78191	А-4
274859	78192	А-4
274860	78193	А-4
274861	78194	А-4
274862	78195	А-4
274863	78196	А-4
274864	78197	А-4
274865	78198	А-4
274866	78199	А-4
274867	78200	А-4
274868	78201	А-4
274869	78202	А-4
274870	78203	А-4
274871	78204	А-4
274872	78205	А-4
274873	78206	А-4
274874	78207	А-314
274875	78208	А-314
274876	78209	А-314
274877	78210	А-314
274878	78211	А-314
274879	78212	А-314
274880	78213	А-314
274881	78214	А-314
274882	78215	А-207
274883	78216	А-207
274884	78217	А-207
274885	78218	А-207
274886	78219	А-207
274887	78220	А-207
274888	78221	А-207
274889	78222	А-207
274890	78223	Б-209-1
274891	78224	Б-209-1
274892	78225	Б-209-1
274893	78226	Б-209-1
274894	78227	Б-209-1
274895	78228	Б-209-1
274896	78229	Б-209-1
274897	78230	Б-209-1
274898	78231	А-107
274899	78232	А-107
274900	78233	А-107
274901	78234	А-107
274902	78235	А-107
274903	78236	А-107
274904	78237	А-107
274905	78238	А-107
274906	78239	А-107
274907	78240	А-107
274908	78241	А-107
274909	78242	А-107
274910	78243	А-107
274911	78244	А-107
274912	78245	А-107
274913	78246	А-107
274914	78247	А-107
274915	78248	А-107
274916	78249	А-107
274917	78250	А-107
274918	78251	А-107
274919	78252	А-107
274920	78253	А-107
274921	78254	А-107
274922	78255	И-315
274923	78256	И-315
274924	78257	И-315
274925	78258	И-315
274926	78259	И-315
274927	78260	И-315
274928	78261	И-315
274929	78262	И-315
274930	78263	И-315
274931	78264	И-315
274932	78265	И-315
274933	78266	И-315
274934	78267	И-315
274935	78268	И-315
274936	78269	И-315
274937	78270	И-315
274938	78271	А-311
274939	78272	А-311
274940	78273	А-311
274941	78274	А-311
274942	78275	А-311
274943	78276	А-311
274944	78277	А-311
274945	78278	А-311
274946	78279	А-311
274947	78280	А-311
274948	78281	А-311
274949	78282	А-311
274950	78283	А-311
274951	78284	А-311
274952	78285	А-311
274953	78286	А-311
274954	78287	А-325
274955	78288	А-325
274956	78289	А-325
274957	78290	А-325
274958	78291	А-325
274959	78292	А-325
274960	78293	А-325
274961	78294	А-325
274962	78295	ИВЦ-117
274963	78296	ИВЦ-117
274964	78297	ИВЦ-117
274965	78298	ИВЦ-117
274966	78299	ИВЦ-117
274967	78300	ИВЦ-117
274968	78301	ИВЦ-117
274969	78302	ИВЦ-117
274970	78303	Б-209-1
274971	78304	Б-209-1
274972	78305	Б-209-1
274973	78306	Б-209-1
274974	78307	Б-209-1
274975	78308	Б-209-1
274976	78309	Б-209-1
274977	78310	Б-209-1
274978	78311	А-211
274979	78312	А-211
274980	78313	А-211
274981	78314	А-211
274982	78315	А-211
274983	78316	А-211
274984	78317	А-211
274985	78318	А-211
274986	78319	Б-209-1
274987	78320	Б-209-1
274988	78321	Б-209-1
274989	78322	Б-209-1
274990	78323	Б-209-1
274991	78324	Б-209-1
274992	78325	Б-209-1
274993	78326	Б-209-1
274994	78327	Б-209
274995	78328	Б-209
274996	78329	Б-209
274997	78330	Б-209
274998	78331	Б-209
274999	78332	Б-209
275000	78333	Б-209
275001	78334	Б-209
275002	78335	А-205
275003	78336	А-205
275004	78337	А-205
275005	78338	А-205
275006	78339	А-205
275007	78340	А-205
275008	78341	А-205
275009	78342	А-205
275010	78343	Б-209
275011	78344	Б-209
275012	78345	Б-209
275013	78346	Б-209
275014	78347	Б-209
275015	78348	Б-209
275016	78349	Б-209
275017	78350	Б-209
275018	78527	Б-209-1
275019	78528	Б-209-1
275020	78529	Б-209-1
275021	78530	Б-209-1
275022	78531	Б-209-1
275023	78532	Б-209-1
275024	78533	Б-209-1
275025	78534	Б-209-1
275026	78535	Б-209-1
275027	78536	Б-209-1
275028	78537	Б-209-1
275029	78538	Б-209-1
275030	78539	Б-209-1
275031	78540	Б-209-1
275032	78541	Б-209-1
275033	78542	Б-209-1
275034	78543	Б-209-1
275035	78544	Б-209-1
275036	78545	Б-209-1
275037	78546	Б-209-1
275038	78547	Б-209-1
275039	78548	Б-209-1
275040	78549	Б-209-1
275041	78550	Б-209-1
275042	78551	Б-209-1
275043	78552	Б-209-1
275044	78553	Б-209-1
275045	78554	Б-209-1
275046	78555	Б-209-1
275047	78556	Б-209-1
275048	78557	Б-209-1
275049	78558	Б-209-1
275050	78559	Г-423
275051	78560	Г-423
275052	78561	Г-423
275053	78562	Г-423
275054	78563	Г-423
275055	78564	Г-423
275056	78565	Г-423
275057	78566	Г-423
275058	78567	Г-423
275059	78568	Г-423
275060	78569	Г-423
275061	78570	Г-423
275062	78571	Г-423
275063	78572	Г-423
275064	78573	Г-423
275065	78574	Г-423
275066	78575	Г-213
275067	78576	Г-213
275068	78577	Г-213
275069	78578	Г-213
275070	78579	Г-213
275071	78580	Г-213
275072	78581	Г-213
275073	78582	Г-213
275074	78583	База
275075	78584	База
275076	78585	База
275077	78586	База
275078	78587	База
275079	78588	База
275080	78589	База
275081	78590	База
275082	78591	База
275083	78592	База
275084	78593	База
275085	78594	База
275086	78595	База
275087	78596	База
275088	78597	База
275089	78598	База
275090	78615	А-178
275091	78616	А-178
275092	78617	А-178
275093	78618	А-178
275094	78619	А-178
275095	78620	А-178
275096	78621	А-178
275097	78622	А-178
275098	78639	А-307
275099	78640	А-307
275100	78641	А-307
275101	78642	А-307
275102	78643	А-307
275103	78644	А-307
275104	78645	А-307
275105	78646	А-307
275106	78647	дист.
275107	78648	дист.
275108	78649	дист.
275109	78650	дист.
275110	78651	дист.
275111	78652	дист.
275112	78653	дист.
275113	78654	дист.
275114	78655	дист.
275115	78656	дист.
275116	78657	дист.
275117	78658	дист.
275118	78659	дист.
275119	78660	дист.
275120	78661	дист.
275121	78662	дист.
275122	78663	А-243-а\nМП-1
275123	78664	А-243-а\nМП-1
275124	78665	А-243-а\nМП-1
275125	78666	А-243-а\nМП-1
275126	78667	А-243-а\nМП-1
275127	78668	А-243-а\nМП-1
275128	78669	А-243-а\nМП-1
275129	78670	А-243-а\nМП-1
275130	78671	А-311
275131	78672	А-311
275132	78673	А-311
275133	78674	А-311
275134	78675	А-311
275135	78676	А-311
275136	78677	А-311
275137	78678	А-311
275138	78679	дист.
275139	78680	дист.
275140	78681	дист.
275141	78682	дист.
275142	78683	дист.
275143	78684	дист.
275144	78685	дист.
275145	78686	дист.
275146	78687	Г-102
275147	78688	Б-209-1
275148	78689	И-317
275149	78690	А-327
275150	78691	Б-209-2
275151	78692	ФОК-9
275152	78693	СДО
275153	78694	Б-209-1
275154	78695	дист
275155	78696	ИВЦ-103
275156	78697	дист
275157	78698	А-12
275158	78699	дист
275159	78700	А-12
275160	78701	дист
275161	78702	А-12
275162	78703	Б-209-1
275163	78704	ФОК-11
275164	78705	Г-102
275165	78706	Б-209-1
275166	78707	Б-209-2
275167	78708	А-409
275168	78709	СДО
275169	78710	И-329\nИ-318
275170	78711	дист
275171	78712	ИВЦ-103
275172	78713	дист
275173	78714	А-12
275174	78715	дист
275175	78716	А-12
275176	78717	дист
275177	78718	А-12
275178	78719	Б-209-1
275179	78720	Г-102
275180	78721	ФОК-4
275181	78722	А-405
275182	78723	СДО
275183	78724	Б-209-2
275184	78725	Б-209-1
275185	78726	И-306\nИ-319
275186	78727	дист
275187	78728	ИВЦ-103
275188	78729	дист
275189	78730	А-12
275190	78731	дист
275191	78732	А-12
275192	78733	дист
275193	78734	А-12
275194	78735	ФОК-5
275195	78736	Б-209-1
275196	78737	А-323
275197	78738	А-405
275198	78739	И-302\nИ-318
275199	78740	СДО
275200	78741	Б-209-2
275201	78742	Б-209-1
275202	78743	дист
275203	78744	ИВЦ-103
275204	78745	дист
275205	78746	А-12
275206	78747	дист
275207	78748	А-12
275208	78749	дист
275209	78750	А-12
275210	78751	ФОК-12
275211	78752	Б-209-2
275212	78753	И-324
275213	78754	А-182
275214	78755	Б-209-2
275215	78756	Б-209-2
275216	78757	дист
275217	78758	А-17
275218	78759	дист
275219	78760	А-17
275220	78761	дист
275221	78762	А-12
275222	78763	И-203-б
275223	78764	дист
275224	78765	А-16
275225	78766	дист
275226	78767	А-12
275227	78768	А-182
275228	78769	Б-209-2
275229	78770	Б-209-2
275230	78771	И-307\nИ-314
275231	78772	Б-209-2
275232	78773	ФОК-3
275233	78774	дист
275234	78775	А-17
275235	78776	дист
275236	78777	А-17
275237	78778	дист
275238	78779	А-12
275239	78780	И-203-б
275240	78781	дист
275241	78782	А-16
275242	78783	дист
275243	78784	А-12
275244	78785	Б-209-2
275245	78786	Б-209-1
275246	78787	СДО
275247	78788	Б-209-1
275248	78789	Б-209-1
275249	78790	дист
275250	78791	Б-209
275251	78792	Б-209
275252	78793	Б-209
275253	78794	дист
275254	78795	А-6
275255	78796	дист
275256	78797	А-17
275257	78798	дист
275258	78799	А-6
275259	78800	Б-209-2
275260	78801	Б-209-1
275261	78802	СДО
275262	78803	Б-209-1
275263	78804	Б-209-1
275264	78805	дист
275265	78806	Б-209
275266	78807	Б-209
275267	78808	Б-209
275268	78809	дист
275269	78810	А-6
275270	78811	дист
275271	78812	А-17
275272	78813	дист
275273	78814	А-7
275274	78816	Б-209
275275	78817	Г-213
275276	78818	А-150
275277	78819	Б-209
275278	78820	Б-209-2
275279	78821	А-12
275280	78822	Б-209-2
275281	78823	Б-209
275282	78824	Б-209
275283	78825	дист
275284	78826	А-6
275285	78827	дист
275286	78828	Б-209
275287	78829	дист
275288	78830	Б-209
275289	78831	дист
275290	78832	А-7
275291	78834	Б-209
275292	78835	Г-213
275293	78836	А-150
275294	78837	Б-209
275295	78838	Б-209-2
275296	78839	А-12
275297	78840	Б-209-2
275298	78841	Б-209
275299	78842	Б-209
275300	78843	дист
275301	78844	А-6
275302	78845	дист
275303	78846	Б-209
275304	78847	дист
275305	78848	Б-209
275306	78849	дист
275307	78850	А-7
275308	78851	дист.
275309	78852	ИВЦ-117
275310	78853	Б-209
275311	78854	Б-209
275312	78855	А-215
275313	78856	И-315
275314	78857	дист.
275315	78858	Б-209
275316	78859	Б-209
275317	78860	дист.
275318	78861	А-215
275319	78862	Б-209-2
275320	78863	Б-209-1
275321	78864	А-462 \n(МП-1)
275322	78865	Б-209-1
275323	78866	Б-209-1
275324	78867	Б-209-1
275325	78868	Б-209-1
275326	78869	Г-213
275327	78870	А-523\n (МП-1)
275328	78871	дист.
275329	78872	Г-213
275330	78873	А-525\n(МП-1)
275331	78874	Б-209-1
275332	78875	Б-209-1
275333	78876	Б-209-2
275334	78877	Б-209-1
\.


--
-- TOC entry 3506 (class 0 OID 16442)
-- Dependencies: 236
-- Data for Name: sc_rasp7; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp7 (id, semcode, version, disc_id, weekday, pair, weeksarray, weekstext) FROM stdin;
2142	242500	13	0	1	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2143	242500	13	1	1	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2144	242500	13	2	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2145	242500	13	3	1	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2146	242500	13	4	1	5	{2,4,6,8,10,12,14,16}	IIн
2147	242500	13	5	2	2	{2,4,6,8,10,12,14,16}	IIн
2148	242500	13	6	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2149	242500	13	6	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2150	242500	13	7	2	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2151	242500	13	1	3	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2152	242500	13	7	3	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2153	242500	13	8	3	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2154	242500	13	2	4	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2155	242500	13	3	4	2	{1,3,5,7,9,11,13,15}	Iн
2156	242500	13	9	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2157	242500	13	3	4	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2158	242500	13	10	5	1	{1,3,5,7,9,11,13,15}	Iн
2159	242500	13	6	5	1	{2,4,6,8,10,12,14,16}	IIн
2160	242500	13	10	5	2	{1,3,5,7,9,11,13,15}	Iн
2161	242500	13	11	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2162	242500	13	11	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2163	242500	13	0	5	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2164	242500	13	10	6	1	{1,3,5,7,9,11,13,15}	Iн
2165	242500	13	5	6	6	{1,3,5,7,9,11,13,15}	Iн
2166	242500	13	8	1	1	{2,4,6,8,10,12,14,16}	IIн
2167	242500	13	8	1	2	{2,4,6,8,10,12,14,16}	IIн
2168	242500	13	1	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2169	242500	13	0	1	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2170	242500	13	4	1	5	{2,4,6,8,10,12,14,16}	IIн
2171	242500	13	3	1	6	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2172	242500	13	5	2	3	{2,4,6,8,10,12,14,16}	IIн
2173	242500	13	11	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2174	242500	13	9	2	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2175	242500	13	7	2	6	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2176	242500	13	1	3	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2177	242500	13	7	3	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2178	242500	13	6	3	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2179	242500	13	6	3	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2180	242500	13	2	4	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2181	242500	13	3	4	2	{1,3,5,7,9,11,13,15}	Iн
2182	242500	13	3	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2183	242500	13	12	5	1	{1,3,5,7,9,11,13,15}	Iн
2184	242500	13	6	5	1	{2,4,6,8,10,12,14,16}	IIн
2185	242500	13	10	5	1	{2,4,6,8,10,12,14,16}	IIн
2186	242500	13	2	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2187	242500	13	11	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2188	242500	13	0	5	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2189	242500	13	12	6	2	{1,3,5,7,9,11,13,15}	Iн
2190	242500	13	5	6	6	{1,3,5,7,9,11,13,15}	Iн
2191	242500	13	5	1	2	{1,3,5,7,9,11,13,15}	Iн
2192	242500	13	8	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2193	242500	13	2	1	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2194	242500	13	4	1	5	{2,4,6,8,10,12,14,16}	IIн
2195	242500	13	3	2	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2196	242500	13	3	2	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2197	242500	13	11	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2198	242500	13	7	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2199	242500	13	1	3	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2200	242500	13	7	3	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2201	242500	13	6	3	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2202	242500	13	6	3	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2203	242500	13	9	3	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2204	242500	13	2	4	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2205	242500	13	3	4	2	{1,3,5,7,9,11,13,15}	Iн
2206	242500	13	12	5	1	{1,3,5,7,9,11,13,15}	Iн
2207	242500	13	6	5	1	{2,4,6,8,10,12,14,16}	IIн
2208	242500	13	13	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2209	242500	13	0	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2210	242500	13	11	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2211	242500	13	0	5	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2212	242500	13	10	6	2	{2,4,6,8,10,12,14,16}	IIн
2213	242500	13	10	6	3	{2,4,6,8,10,12,14,16}	IIн
2214	242500	13	5	6	6	{1,3,5,7,9,11,13,15}	Iн
2215	242500	13	5	1	1	{2,4,6,8,10,12,14,16}	IIн
2216	242500	13	2	1	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2217	242500	13	6	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2218	242500	13	6	1	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2219	242500	13	4	1	5	{2,4,6,8,10,12,14,16}	IIн
2220	242500	13	9	2	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2221	242500	13	11	2	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2222	242500	13	3	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2223	242500	13	3	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2224	242500	13	1	3	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2225	242500	13	7	3	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2226	242500	13	1	3	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2227	242500	13	7	3	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2228	242500	13	2	4	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2229	242500	13	3	4	2	{1,3,5,7,9,11,13,15}	Iн
2230	242500	13	10	5	1	{1,3,5,7,9,11,13,15}	Iн
2231	242500	13	6	5	1	{2,4,6,8,10,12,14,16}	IIн
2232	242500	13	0	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2233	242500	13	8	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2234	242500	13	11	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2235	242500	13	0	5	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2236	242500	13	10	6	4	{2,4,6,8,10,12,14,16}	IIн
2237	242500	13	10	6	5	{2,4,6,8,10,12,14,16}	IIн
2238	242500	13	5	6	6	{1,3,5,7,9,11,13,15}	Iн
2239	242500	13	14	1	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2240	242500	13	15	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2241	242500	13	14	1	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2242	242500	13	16	1	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2243	242500	13	7	2	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2244	242500	13	1	2	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2245	242500	13	7	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2246	242500	13	9	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2247	242500	13	17	2	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2248	242500	13	15	3	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2249	242500	13	8	3	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2250	242500	13	2	3	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2251	242500	13	18	4	1	{1,3,5,7,9,11,13,15}	Iн
2252	242500	13	18	4	1	{2,4,6,8,10,12,14,16}	IIн
2253	242500	13	2	4	2	{1,3,5,7,9,11,13,15}	Iн
2254	242500	13	17	4	2	{2,4,6,8,10,12,14,16}	IIн
2255	242500	13	1	5	1	{1,3,5,7,9,11,13,15}	Iн
2256	242500	13	19	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2257	242500	13	19	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2258	242500	13	16	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2259	242500	13	16	6	2	{1,3,5,7,9,11,13,15}	Iн
2260	242500	13	15	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2261	242500	13	14	1	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2262	242500	13	9	1	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2263	242500	13	20	2	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2264	242500	13	1	2	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2265	242500	13	17	3	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2266	242500	13	2	3	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2267	242500	13	21	3	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2268	242500	13	14	3	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2269	242500	13	18	3	5	{2,4,6,8,10,12,14,16}	IIн
2270	242500	13	18	4	1	{1,3,5,7,9,11,13,15}	Iн
2271	242500	13	2	4	2	{1,3,5,7,9,11,13,15}	Iн
2272	242500	13	17	4	2	{2,4,6,8,10,12,14,16}	IIн
2273	242500	13	20	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2274	242500	13	8	4	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2275	242500	13	16	5	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2276	242500	13	1	5	2	{1,3,5,7,9,11,13,15}	Iн
2277	242500	13	19	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2278	242500	13	15	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2279	242500	13	16	5	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2280	242500	13	16	6	2	{1,3,5,7,9,11,13,15}	Iн
2281	242500	13	22	1	1	{2}	2н
2282	242500	13	22	1	2	{2}	2н
2283	242500	13	22	1	3	{2}	2н
2284	242500	13	22	1	4	{2}	2н
2285	242500	13	23	1	6	{1,3,5,7,9,11,13,15}	Iн
2286	242500	13	24	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2287	242500	13	24	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2288	242500	13	25	3	1	{2,4,6,8,10,12,14,16}	IIн
2289	242500	13	26	3	2	{1,3,5,7,9,11,13,15}	Iн
2290	242500	13	26	3	2	{2,4,6,8,10,12,14,16}	IIн
2291	242500	13	26	3	3	{1,3,5,7,9,11,13,15}	Iн
2292	242500	13	26	3	3	{2,4,6,8,10,12,14,16}	IIн
2293	242500	13	27	3	4	{1,3,5,7,9,11,13,15}	Iн
2294	242500	13	27	3	5	{1,3,5,7,9,11,13,15}	Iн
2295	242500	13	25	3	6	{1,3,5,7,9,11,13,15}	Iн
2296	242500	13	28	4	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2297	242500	13	29	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2298	242500	13	28	4	4	{1,3,5,7,9,11,13,15}	Iн
2299	242500	13	30	5	1	{1,3,5,7,9,11,13,15}	Iн
2300	242500	13	31	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2301	242500	13	25	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2302	242500	13	30	6	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2303	242500	13	31	6	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2304	242500	13	32	1	1	{3}	3н
2305	242500	13	32	1	2	{3}	3н
2306	242500	13	32	1	3	{3}	3н
2307	242500	13	32	1	4	{3}	3н
2308	242500	13	23	1	6	{1,3,5,7,9,11,13,15}	Iн
2309	242500	13	24	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2310	242500	13	25	3	1	{2,4,6,8,10,12,14,16}	IIн
2311	242500	13	26	3	2	{1,3,5,7,9,11,13,15}	Iн
2312	242500	13	26	3	2	{2,4,6,8,10,12,14,16}	IIн
2313	242500	13	26	3	3	{1,3,5,7,9,11,13,15}	Iн
2314	242500	13	26	3	3	{2,4,6,8,10,12,14,16}	IIн
2315	242500	13	27	3	4	{1,3,5,7,9,11,13,15}	Iн
2316	242500	13	27	3	5	{1,3,5,7,9,11,13,15}	Iн
2317	242500	13	25	3	6	{1,3,5,7,9,11,13,15}	Iн
2318	242500	13	28	4	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2319	242500	13	29	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2320	242500	13	28	4	4	{2,4,6,8,10,12,14,16}	IIн
2321	242500	13	30	5	1	{1,3,5,7,9,11,13,15}	Iн
2322	242500	13	31	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2323	242500	13	24	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2324	242500	13	25	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2325	242500	13	31	6	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2326	242500	13	30	6	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2327	242500	13	33	1	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2328	242500	13	33	1	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2329	242500	13	34	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2330	242500	13	35	1	4	{1,3,5,7,9,11,13,15}	Iн
2331	242500	13	35	1	4	{2,4,6,8,10,12,14,16}	IIн
2332	242500	13	36	1	5	{1,3,5,7,9,11,13,15}	Iн
2333	242500	13	36	1	5	{2,4,6,8,10,12,14,16}	IIн
2334	242500	13	37	2	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2335	242500	13	37	2	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2336	242500	13	37	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2337	242500	13	37	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2338	242500	13	38	3	2	{2,4,6,8,10,12,14,16}	IIн
2339	242500	13	38	3	3	{1,3,5,7,9,11,13,15}	Iн
2340	242500	13	38	3	3	{2,4,6,8,10,12,14,16}	IIн
2341	242500	13	39	3	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2342	242500	13	39	3	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2343	242500	13	35	3	6	{1,3,5,7,9,11,13,15}	Iн
2344	242500	13	40	4	1	{2,4,6,8,10,12,14,16}	IIн
2345	242500	13	40	4	2	{1,3,5,7,9,11,13,15}	Iн
2346	242500	13	40	4	2	{2,4,6,8,10,12,14,16}	IIн
2347	242500	13	41	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2348	242500	13	41	4	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2349	242500	13	40	4	5	{1,3,5,7,9,11,13,15}	Iн
2350	242500	13	42	5	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2351	242500	13	42	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2352	242500	13	42	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2353	242500	13	42	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2354	242500	13	43	6	3	{1,3,5,7,9,11,13,15}	Iн
2355	242500	13	44	6	3	{2,4,6,8,10,12,14,16}	IIн
2356	242500	13	44	6	4	{1,3,5,7,9,11,13,15}	Iн
2357	242500	13	45	6	4	{2,4,6,8,10,12,14,16}	IIн
2358	242500	13	33	1	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2359	242500	13	33	1	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2360	242500	13	34	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2361	242500	13	35	1	4	{1,3,5,7,9,11,13,15}	Iн
2362	242500	13	35	1	4	{2,4,6,8,10,12,14,16}	IIн
2363	242500	13	36	1	5	{1,3,5,7,9,11,13,15}	Iн
2364	242500	13	36	1	5	{2,4,6,8,10,12,14,16}	IIн
2365	242500	13	37	2	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2366	242500	13	37	2	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2367	242500	13	37	2	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2368	242500	13	37	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2369	242500	13	38	3	2	{2,4,6,8,10,12,14,16}	IIн
2370	242500	13	38	3	3	{1,3,5,7,9,11,13,15}	Iн
2371	242500	13	38	3	3	{2,4,6,8,10,12,14,16}	IIн
2372	242500	13	39	3	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2373	242500	13	39	3	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2374	242500	13	35	3	6	{1,3,5,7,9,11,13,15}	Iн
2375	242500	13	40	4	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2376	242500	13	40	4	2	{1,3,5,7,9,11,13,15}	Iн
2377	242500	13	40	4	2	{2,4,6,8,10,12,14,16}	IIн
2378	242500	13	41	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2379	242500	13	41	4	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2380	242500	13	42	5	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2381	242500	13	42	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2382	242500	13	42	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2383	242500	13	42	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2384	242500	13	43	6	3	{1,3,5,7,9,11,13,15}	Iн
2385	242500	13	44	6	3	{2,4,6,8,10,12,14,16}	IIн
2386	242500	13	44	6	4	{1,3,5,7,9,11,13,15}	Iн
2387	242500	13	45	6	4	{2,4,6,8,10,12,14,16}	IIн
2388	242500	13	46	1	4	{2,4,6,8,10,12,14,16}	IIн
2389	242500	13	47	1	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2390	242500	13	47	1	6	{1,3,5,7,9,11,13,15}	Iн
2391	242500	13	8	1	6	{2,4,6,8,10,12,14,16}	IIн
2392	242500	13	8	1	7	{2,4,6,8,10,12,14,16}	IIн
2393	242500	13	48	2	2	{1,3,5,7,9,11,13,15}	Iн
2394	242500	13	48	2	3	{1,3,5,7,9,11,13,15}	Iн
2395	242500	13	49	3	3	{1,3,5,7,9,11,13,15}	Iн
2396	242500	13	49	3	4	{1,3,5,7,9,11,13,15}	Iн
2397	242500	13	50	3	4	{2,4,6,8,10,12,14,16}	IIн
2398	242500	13	51	3	5	{1,3,5,7,9,11,13,15}	Iн
2399	242500	13	50	3	5	{2,4,6,8,10,12,14,16}	IIн
2400	242500	13	46	3	6	{1,3,5,7,9,11,13,15}	Iн
2401	242500	13	51	3	6	{2,4,6,8,10,12,14,16}	IIн
2402	242500	13	46	3	7	{1,3,5,7,9,11,13,15}	Iн
2403	242500	13	42	4	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2404	242500	13	42	4	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2405	242500	13	42	4	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2406	242500	13	42	4	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2407	242500	13	42	5	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2408	242500	13	42	5	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2409	242500	13	42	5	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2410	242500	13	42	5	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2411	242500	13	42	1	1	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2412	242500	13	42	1	2	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2413	242500	13	42	1	3	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2414	242500	13	52	1	5	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2415	242500	13	53	1	6	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2416	242500	13	54	2	4	{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
2417	242500	13	55	2	6	{2,4,6,8,10,12,14,16}	IIн
2418	242500	13	56	3	1	{1,3,5,7,9,11,13,15}	Iн
2419	242500	13	56	3	2	{1,3,5,7,9,11,13,15}	Iн
2420	242500	13	42	3	3	{1,3,5,7,9,11,13,15}	Iн
2421	242500	13	42	3	4	{1,3,5,7,9,11,13,15}	Iн
2422	242500	13	57	3	4	{2,4,6,8,10,12,14,16}	IIн
2423	242500	13	42	3	5	{1,3,5,7,9,11,13,15}	Iн
2424	242500	13	42	3	6	{1,3,5,7,9,11,13,15}	Iн
2425	242500	13	58	3	6	{2,4,6,8,10,12,14,16}	IIн
2426	242500	13	59	4	1	{1,3,5,7,9,11,13,15}	Iн
2427	242500	13	60	4	1	{2,4,6,8,10,12,14,16}	IIн
2428	242500	13	60	4	6	{2,6,10,14}	2,6,10,14н
2429	242500	13	60	4	7	{2,6,10,14}	2,6,10,14н
2430	242500	13	61	5	6	{4,8,12,16}	4,8,12,16н
2431	242500	13	61	5	7	{4,8,12,16}	4,8,12,16н
2432	242500	13	62	6	5	{1,3,5,7,9,11,13,15}	Iн
\.


--
-- TOC entry 3507 (class 0 OID 16447)
-- Dependencies: 237
-- Data for Name: sc_rasp7_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp7_groups (id, rasp7_id, group_id, subgroup) FROM stdin;
2143	2142	0	0
2144	2143	0	0
2145	2144	0	0
2146	2145	0	1
2147	2146	0	0
2148	2147	0	0
2149	2148	0	0
2150	2149	0	0
2151	2150	0	0
2152	2151	0	0
2153	2152	0	0
2154	2153	0	0
2155	2154	0	0
2156	2155	0	0
2157	2156	0	0
2158	2157	0	2
2159	2158	0	0
2160	2159	0	0
2161	2160	0	1
2162	2161	0	0
2163	2162	0	0
2164	2163	0	0
2165	2164	0	2
2166	2165	0	0
2167	2166	1	0
2168	2167	1	0
2169	2168	1	0
2170	2169	1	0
2171	2170	1	0
2172	2171	1	2
2173	2172	1	0
2174	2173	1	0
2175	2174	1	0
2176	2175	1	0
2177	2176	1	0
2178	2177	1	0
2179	2178	1	0
2180	2179	1	0
2181	2180	1	0
2182	2181	1	0
2183	2182	1	1
2184	2183	1	0
2185	2184	1	0
2186	2185	1	1
2187	2186	1	0
2188	2187	1	0
2189	2188	1	0
2190	2189	1	2
2191	2190	1	0
2192	2191	2	0
2193	2192	2	0
2194	2193	2	0
2195	2194	2	0
2196	2195	2	2
2197	2196	2	1
2198	2197	2	0
2199	2198	2	0
2200	2199	2	0
2201	2200	2	0
2202	2201	2	0
2203	2202	2	0
2204	2203	2	0
2205	2204	2	0
2206	2205	2	0
2207	2206	2	0
2208	2207	2	0
2209	2208	2	0
2210	2209	2	0
2211	2210	2	0
2212	2211	2	0
2213	2212	2	1
2214	2213	2	2
2215	2214	2	0
2216	2215	3	0
2217	2216	3	0
2218	2217	3	0
2219	2218	3	0
2220	2219	3	0
2221	2220	3	0
2222	2221	3	0
2223	2222	3	2
2224	2223	3	1
2225	2224	3	0
2226	2225	3	0
2227	2226	3	0
2228	2227	3	0
2229	2228	3	0
2230	2229	3	0
2231	2230	3	0
2232	2231	3	0
2233	2232	3	0
2234	2233	3	0
2235	2234	3	0
2236	2235	3	0
2237	2236	3	1
2238	2237	3	2
2239	2238	3	0
2240	2239	4	0
2241	2240	4	0
2242	2241	4	0
2243	2242	4	1
2244	2243	4	0
2245	2244	4	0
2246	2245	4	0
2247	2246	4	0
2248	2247	4	0
2249	2248	4	0
2250	2249	4	0
2251	2250	4	0
2252	2251	4	0
2253	2252	4	0
2254	2253	4	0
2255	2254	4	0
2256	2255	4	0
2257	2256	4	0
2258	2257	4	0
2259	2258	4	2
2260	2259	4	0
2261	2260	5	0
2262	2261	5	0
2263	2262	5	0
2264	2263	5	0
2265	2264	5	0
2266	2265	5	0
2267	2266	5	0
2268	2267	5	0
2269	2268	5	0
2270	2269	5	0
2271	2270	5	0
2272	2271	5	0
2273	2272	5	0
2274	2273	5	0
2275	2274	5	0
2276	2275	5	2
2277	2276	5	0
2278	2277	5	0
2279	2278	5	0
2280	2279	5	1
2281	2280	5	0
2282	2281	6	0
2283	2282	6	0
2284	2283	6	0
2285	2284	6	0
2286	2285	6	0
2287	2286	6	0
2288	2287	6	0
2289	2288	6	0
2290	2289	6	0
2291	2290	6	0
2292	2291	6	0
2293	2292	6	0
2294	2293	6	0
2295	2294	6	0
2296	2295	6	0
2297	2296	6	0
2298	2297	6	0
2299	2298	6	0
2300	2299	6	0
2301	2300	6	0
2302	2301	6	0
2303	2302	6	0
2304	2303	6	0
2305	2304	7	0
2306	2305	7	0
2307	2306	7	0
2308	2307	7	0
2309	2308	7	0
2310	2309	7	0
2311	2310	7	0
2312	2311	7	0
2313	2312	7	0
2314	2313	7	0
2315	2314	7	0
2316	2315	7	0
2317	2316	7	0
2318	2317	7	0
2319	2318	7	0
2320	2319	7	0
2321	2320	7	0
2322	2321	7	0
2323	2322	7	0
2324	2323	7	0
2325	2324	7	0
2326	2325	7	0
2327	2326	7	0
2328	2327	8	0
2329	2328	8	0
2330	2329	8	0
2331	2330	8	0
2332	2331	8	0
2333	2332	8	0
2334	2333	8	0
2335	2334	8	0
2336	2335	8	0
2337	2336	8	0
2338	2337	8	0
2339	2338	8	0
2340	2339	8	0
2341	2340	8	0
2342	2341	8	0
2343	2342	8	0
2344	2343	8	0
2345	2344	8	0
2346	2345	8	0
2347	2346	8	0
2348	2347	8	0
2349	2348	8	0
2350	2349	8	0
2351	2350	8	0
2352	2351	8	0
2353	2352	8	0
2354	2353	8	0
2355	2354	8	0
2356	2355	8	0
2357	2356	8	0
2358	2357	8	0
2359	2358	9	0
2360	2359	9	0
2361	2360	9	0
2362	2361	9	0
2363	2362	9	0
2364	2363	9	0
2365	2364	9	0
2366	2365	9	0
2367	2366	9	0
2368	2367	9	0
2369	2368	9	0
2370	2369	9	0
2371	2370	9	0
2372	2371	9	0
2373	2372	9	0
2374	2373	9	0
2375	2374	9	0
2376	2375	9	0
2377	2376	9	0
2378	2377	9	0
2379	2378	9	0
2380	2379	9	0
2381	2380	9	0
2382	2381	9	0
2383	2382	9	0
2384	2383	9	0
2385	2384	9	0
2386	2385	9	0
2387	2386	9	0
2388	2387	9	0
2389	2388	10	0
2390	2389	10	0
2391	2390	10	0
2392	2391	10	0
2393	2392	10	0
2394	2393	10	0
2395	2394	10	0
2396	2395	10	0
2397	2396	10	0
2398	2397	10	0
2399	2398	10	0
2400	2399	10	0
2401	2400	10	0
2402	2401	10	0
2403	2402	10	0
2404	2403	10	0
2405	2404	10	0
2406	2405	10	0
2407	2406	10	0
2408	2407	10	0
2409	2408	10	0
2410	2409	10	0
2411	2410	10	0
2412	2411	11	0
2413	2412	11	0
2414	2413	11	0
2415	2414	11	0
2416	2415	11	0
2417	2416	11	0
2418	2417	11	0
2419	2418	11	0
2420	2419	11	0
2421	2420	11	0
2422	2421	11	0
2423	2422	11	0
2424	2423	11	0
2425	2424	11	0
2426	2425	11	0
2427	2426	11	0
2428	2427	11	0
2429	2428	11	0
2430	2429	11	0
2431	2430	11	0
2432	2431	11	0
2433	2432	11	0
\.


--
-- TOC entry 3510 (class 0 OID 16452)
-- Dependencies: 240
-- Data for Name: sc_rasp7_preps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp7_preps (id, rasp7_id, prep_id) FROM stdin;
1807	2142	0
1808	2143	1
1809	2144	2
1810	2145	3
1811	2146	4
1812	2147	5
1813	2148	6
1814	2149	6
1815	2150	7
1816	2151	8
1817	2152	7
1818	2153	9
1819	2154	10
1820	2155	11
1821	2157	11
1822	2158	12
1823	2159	13
1824	2160	12
1825	2161	14
1826	2162	14
1827	2163	15
1828	2164	16
1829	2165	5
1830	2166	17
1831	2167	17
1832	2168	1
1833	2169	15
1834	2170	4
1835	2171	4
1836	2172	5
1837	2173	18
1838	2175	7
1839	2176	8
1840	2177	7
1841	2178	6
1842	2179	6
1843	2180	10
1844	2181	11
1845	2182	11
1846	2183	12
1847	2184	13
1848	2185	12
1849	2186	2
1850	2187	14
1851	2188	15
1852	2189	16
1853	2190	5
1854	2191	5
1855	2192	19
1856	2193	20
1857	2194	4
1858	2195	10
1859	2196	10
1860	2197	18
1861	2198	7
1862	2199	8
1863	2200	7
1864	2201	21
1865	2202	21
1866	2204	10
1867	2205	11
1868	2206	12
1869	2207	13
1870	2208	1
1871	2209	22
1872	2210	14
1873	2211	15
1874	2212	23
1875	2213	23
1876	2214	5
1877	2215	5
1878	2216	2
1879	2217	21
1880	2218	21
1881	2219	4
1882	2221	18
1883	2222	10
1884	2223	10
1885	2224	8
1886	2225	7
1887	2226	8
1888	2227	1
1889	2228	10
1890	2229	11
1891	2230	12
1892	2231	13
1893	2232	22
1894	2233	24
1895	2234	14
1896	2235	15
1897	2236	23
1898	2237	23
1899	2238	5
1900	2239	25
1901	2240	26
1902	2241	25
1903	2242	3
1904	2243	27
1905	2244	25
1906	2245	27
1907	2247	28
1908	2248	26
1909	2249	29
1910	2250	10
1911	2251	30
1912	2252	31
1913	2253	32
1914	2254	33
1915	2255	25
1916	2256	34
1917	2257	34
1918	2258	35
1919	2259	36
1920	2260	26
1921	2261	25
1922	2263	27
1923	2264	25
1924	2265	28
1925	2266	10
1926	2267	34
1927	2268	34
1928	2269	30
1929	2270	30
1930	2271	32
1931	2272	33
1932	2273	37
1933	2274	38
1934	2275	39
1935	2276	25
1936	2277	34
1937	2278	26
1938	2279	35
1939	2280	36
1940	2286	40
1941	2287	41
1942	2288	42
1943	2289	43
1944	2290	43
1945	2291	43
1946	2292	43
1947	2293	44
1948	2294	44
1949	2295	42
1950	2296	45
1951	2297	46
1952	2298	45
1953	2299	47
1954	2300	48
1955	2301	12
1956	2302	47
1957	2303	48
1958	2309	41
1959	2310	42
1960	2311	43
1961	2312	43
1962	2313	43
1963	2314	43
1964	2315	44
1965	2316	44
1966	2317	42
1967	2318	45
1968	2319	46
1969	2320	45
1970	2321	47
1971	2322	48
1972	2323	41
1973	2324	12
1974	2325	48
1975	2326	47
1976	2327	49
1977	2328	49
1978	2329	50
1979	2330	51
1980	2332	52
1981	2338	44
1982	2339	44
1983	2340	44
1984	2341	53
1985	2342	53
1986	2343	54
1987	2344	55
1988	2345	27
1989	2346	55
1990	2347	53
1991	2348	53
1992	2349	55
1993	2354	56
1994	2355	57
1995	2356	57
1996	2357	58
1997	2358	49
1998	2359	49
1999	2360	50
2000	2361	51
2001	2363	52
2002	2369	44
2003	2370	44
2004	2371	44
2005	2372	53
2006	2373	53
2007	2374	54
2008	2375	27
2009	2376	27
2010	2377	27
2011	2378	53
2012	2379	53
2013	2384	56
2014	2385	57
2015	2386	57
2016	2387	58
2017	2388	59
2018	2389	60
2019	2390	60
2020	2391	61
2021	2392	61
2022	2393	62
2023	2394	62
2024	2395	40
2025	2396	40
2026	2397	43
2027	2398	42
2028	2399	43
2029	2400	63
2030	2401	42
2031	2402	63
2032	2414	51
2033	2415	51
2034	2416	64
2035	2417	40
2036	2418	52
2037	2419	52
2038	2422	40
2039	2425	65
2040	2426	66
2041	2427	67
2042	2428	67
2043	2429	67
2044	2430	68
2045	2431	68
2046	2432	69
\.


--
-- TOC entry 3512 (class 0 OID 16456)
-- Dependencies: 242
-- Data for Name: sc_rasp7_rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_rasp7_rooms (id, rasp7_id, room) FROM stdin;
2142	2142	А-307
2143	2143	Д-210
2144	2144	Г-102
2145	2145	Б-209-2
2146	2146	А-2
2147	2147	А-314
2148	2148	И-205-а
2149	2149	И-205-а
2150	2150	А-177
2151	2151	А-13
2152	2152	А-13
2153	2153	И-317
2154	2154	А-13
2155	2155	Б-115
2156	2156	ФОК-9
2157	2157	Б-209-2
2158	2158	А-17
2159	2159	А-13
2160	2160	Б-209-2
2161	2161	Г-102
2162	2162	А-13
2163	2163	А-13
2164	2164	Б-209-2
2165	2165	дист.
2166	2166	И-329\nИ-318
2167	2167	И-329\nИ-318
2168	2168	А-214
2169	2169	А-222
2170	2170	А-2
2171	2171	Б-209-2
2172	2172	А-3
2173	2173	Г-102
2174	2174	ФОК-11
2175	2175	А-177
2176	2176	А-13
2177	2177	А-13
2178	2178	И-203-б
2179	2179	И-203-б
2180	2180	А-13
2181	2181	Б-115
2182	2182	Б-209-2
2183	2183	А-17
2184	2184	А-13
2185	2185	Б-209-2
2186	2186	А-177
2187	2187	А-13
2188	2188	А-13
2189	2189	Б-209-2
2190	2190	дист.
2191	2191	А-321
2192	2192	И-306\nИ-319
2193	2193	Г-102
2194	2194	А-2
2195	2195	Б-209-2
2196	2196	Б-209-2
2197	2197	Г-102
2198	2198	А-177
2199	2199	А-13
2200	2200	А-13
2201	2201	Г-420-1
2202	2202	Г-420-1
2203	2203	ФОК-4
2204	2204	А-13
2205	2205	Б-115
2206	2206	А-17
2207	2207	А-13
2208	2208	А-208
2209	2209	А-217
2210	2210	А-13
2211	2211	А-13
2212	2212	Б-209-2
2213	2213	Б-209-2
2214	2214	дист.
2215	2215	А-321
2216	2216	Г-102
2217	2217	Г-412
2218	2218	Г-412
2219	2219	А-2
2220	2220	ФОК-5
2221	2221	Г-102
2222	2222	Б-209-2
2223	2223	Б-209-2
2224	2224	А-13
2225	2225	А-13
2226	2226	Г-102
2227	2227	Д-210
2228	2228	А-13
2229	2229	Б-115
2230	2230	А-17
2231	2231	А-13
2232	2232	А-217
2233	2233	И-302\nИ-318
2234	2234	А-13
2235	2235	А-13
2236	2236	Б-209-2
2237	2237	Б-209-2
2238	2238	дист.
2239	2239	А-318
2240	2240	А-13
2241	2241	А-13
2242	2242	Б-209-2
2243	2243	А-16
2244	2244	А-13
2245	2245	А-218
2246	2246	ФОК-12
2247	2247	И-202-б
2248	2248	А-215
2249	2249	И-324
2250	2250	А-180
2251	2251	А-4
2252	2252	Б-209-2
2253	2253	А-13
2254	2254	А-13
2255	2255	А-211
2256	2256	А-174-б
2257	2257	А-13
2258	2258	Б-209-2
2259	2259	дист.
2260	2260	А-13
2261	2261	А-13
2262	2262	ФОК-3
2263	2263	А-16
2264	2264	А-13
2265	2265	Г-413
2266	2266	А-180
2267	2267	А-174-б
2268	2268	А-174-б
2269	2269	Б-209-2
2270	2270	А-4
2271	2271	А-13
2272	2272	А-13
2273	2273	А-218
2274	2274	И-307\nИ-314
2275	2275	Б-209-2
2276	2276	А-211
2277	2277	А-13
2278	2278	А-216
2279	2279	Б-209-2
2280	2280	дист.
2281	2281	None
2282	2282	None
2283	2283	None
2284	2284	None
2285	2285	дист.
2286	2286	А-173
2287	2287	А-13
2288	2288	Б-209
2289	2289	Б-209
2290	2290	А-113
2291	2291	Б-209
2292	2292	А-113
2293	2293	Б-209
2294	2294	Б-209
2295	2295	А-113
2296	2296	Б-209
2297	2297	А-113
2298	2298	Б-209-1
2299	2299	А-13
2300	2300	А-13
2301	2301	Б-209-2
2302	2302	А-318
2303	2303	А-216
2304	2304	None
2305	2305	None
2306	2306	None
2307	2307	None
2308	2308	дист.
2309	2309	А-13
2310	2310	Б-209
2311	2311	Б-209
2312	2312	А-113
2313	2313	Б-209
2314	2314	А-113
2315	2315	Б-209
2316	2316	Б-209
2317	2317	А-113
2318	2318	Б-209
2319	2319	А-113
2320	2320	Б-209-1
2321	2321	А-13
2322	2322	А-13
2323	2323	А-305
2324	2324	Б-209-1
2325	2325	А-216
2326	2326	А-318
2327	2327	Б-209
2328	2328	Б-209
2329	2329	Б-209
2330	2330	А-316
2331	2331	А-113
2332	2332	А-316
2333	2333	А-113
2334	2334	НИР
2335	2335	НИР
2336	2336	НИР
2337	2337	НИР
2338	2338	Б-209
2339	2339	А-113
2340	2340	Б-209
2341	2341	Б-115
2342	2342	Г-102
2343	2343	А-205
2344	2344	А-173
2345	2345	А-8
2346	2346	А-173
2347	2347	Б-115
2348	2348	А-181
2349	2349	А-173
2350	2350	None
2351	2351	None
2352	2352	None
2353	2353	None
2354	2354	А-4
2355	2355	А-4
2356	2356	А-314
2357	2357	А-207
2358	2358	Б-209
2359	2359	Б-209
2360	2360	Б-209
2361	2361	А-316
2362	2362	А-113
2363	2363	А-316
2364	2364	А-113
2365	2365	НИР
2366	2366	НИР
2367	2367	НИР
2368	2368	НИР
2369	2369	Б-209
2370	2370	А-113
2371	2371	Б-209
2372	2372	Б-115
2373	2373	Г-102
2374	2374	А-205
2375	2375	А-204
2376	2376	А-8
2377	2377	А-204
2378	2378	Б-115
2379	2379	А-181
2380	2380	None
2381	2381	None
2382	2382	None
2383	2383	None
2384	2384	А-4
2385	2385	А-4
2386	2386	А-314
2387	2387	А-207
2388	2388	Б-209-1
2389	2389	А-107
2390	2390	А-107
2391	2391	И-315
2392	2392	И-315
2393	2393	А-311
2394	2394	А-311
2395	2395	А-325
2396	2396	ИВЦ-117
2397	2397	Б-209-1
2398	2398	А-211
2399	2399	Б-209-1
2400	2400	Б-209
2401	2401	А-205
2402	2402	Б-209
2403	2403	None
2404	2404	None
2405	2405	None
2406	2406	None
2407	2407	None
2408	2408	None
2409	2409	None
2410	2410	None
2411	2411	None
2412	2412	None
2413	2413	None
2414	2414	Б-209-1
2415	2415	Б-209-1
2416	2416	Г-423
2417	2417	Г-213
2418	2418	База
2419	2419	База
2420	2420	None
2421	2421	None
2422	2422	А-178
2423	2423	None
2424	2424	None
2425	2425	А-307
2426	2426	дист.
2427	2427	дист.
2428	2428	А-243-а\nМП-1
2429	2429	А-243-а\nМП-1
2430	2430	А-311
2431	2431	А-311
2432	2432	дист.
\.


--
-- TOC entry 3515 (class 0 OID 16463)
-- Dependencies: 245
-- Data for Name: sc_worktypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sc_worktypes (id, title) FROM stdin;
0	пр
1	лк
2	лб
10	конс
11	экз
12	зач
13	зач-д
14	кр
15	кп
\.


--
-- TOC entry 3517 (class 0 OID 16469)
-- Dependencies: 247
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, first_name, middle_name, last_name, email, login, add_date, subgroup, locked) FROM stdin;
\.


--
-- TOC entry 3519 (class 0 OID 16475)
-- Dependencies: 249
-- Data for Name: tg_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tg_users (tg_id, source_type, source_name, subgroup) FROM stdin;
426967054	group	КМБО-21-24	1
\.


--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 218
-- Name: sc_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_department_id_seq', 1, false);


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 224
-- Name: sc_rasp18_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_days_id_seq', 6683, true);


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 226
-- Name: sc_rasp18_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_groups_id_seq', 387383, true);


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 227
-- Name: sc_rasp18_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_id_seq', 78877, true);


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 229
-- Name: sc_rasp18_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_info_id_seq', 1, false);


--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 231
-- Name: sc_rasp18_move_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_move_id_seq', 1, false);


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 233
-- Name: sc_rasp18_preps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_preps_id_seq', 272163, true);


--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 235
-- Name: sc_rasp18_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp18_rooms_id_seq', 275334, true);


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 238
-- Name: sc_rasp7_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp7_groups_id_seq', 2433, true);


--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 239
-- Name: sc_rasp7_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp7_id_seq', 2432, true);


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 241
-- Name: sc_rasp7_preps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp7_preps_id_seq', 2046, true);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 243
-- Name: sc_rasp7_rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp7_rooms_id_seq', 2432, true);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 244
-- Name: sc_rasp7_version_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_rasp7_version_seq', 1, false);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 246
-- Name: sc_worktypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sc_worktypes_id_seq', 1, false);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 248
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 1, false);


--
-- TOC entry 3307 (class 2606 OID 16495)
-- Name: sc_department sc_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_department
    ADD CONSTRAINT sc_department_pkey PRIMARY KEY (id);


--
-- TOC entry 3309 (class 2606 OID 16497)
-- Name: sc_disc sc_disc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_disc
    ADD CONSTRAINT sc_disc_pkey PRIMARY KEY (id);


--
-- TOC entry 3311 (class 2606 OID 16499)
-- Name: sc_group sc_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_group
    ADD CONSTRAINT sc_group_pkey PRIMARY KEY (id);


--
-- TOC entry 3313 (class 2606 OID 16501)
-- Name: sc_prep sc_prep_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_prep
    ADD CONSTRAINT sc_prep_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 16503)
-- Name: sc_rasp18_days sc_rasp18_days_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_days
    ADD CONSTRAINT sc_rasp18_days_pkey PRIMARY KEY (id);


--
-- TOC entry 3319 (class 2606 OID 16505)
-- Name: sc_rasp18_groups sc_rasp18_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_groups
    ADD CONSTRAINT sc_rasp18_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3321 (class 2606 OID 16507)
-- Name: sc_rasp18_info sc_rasp18_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_info
    ADD CONSTRAINT sc_rasp18_info_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 16509)
-- Name: sc_rasp18_move sc_rasp18_move_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_move
    ADD CONSTRAINT sc_rasp18_move_pkey PRIMARY KEY (id);


--
-- TOC entry 3315 (class 2606 OID 16511)
-- Name: sc_rasp18 sc_rasp18_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18
    ADD CONSTRAINT sc_rasp18_pkey PRIMARY KEY (id);


--
-- TOC entry 3325 (class 2606 OID 16513)
-- Name: sc_rasp18_preps sc_rasp18_preps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_preps
    ADD CONSTRAINT sc_rasp18_preps_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 16515)
-- Name: sc_rasp18_rooms sc_rasp18_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp18_rooms
    ADD CONSTRAINT sc_rasp18_rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 16517)
-- Name: sc_rasp7_groups sc_rasp7_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7_groups
    ADD CONSTRAINT sc_rasp7_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 3329 (class 2606 OID 16519)
-- Name: sc_rasp7 sc_rasp7_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7
    ADD CONSTRAINT sc_rasp7_pkey PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 16521)
-- Name: sc_rasp7_preps sc_rasp7_preps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7_preps
    ADD CONSTRAINT sc_rasp7_preps_pkey PRIMARY KEY (id);


--
-- TOC entry 3335 (class 2606 OID 16523)
-- Name: sc_rasp7_rooms sc_rasp7_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_rasp7_rooms
    ADD CONSTRAINT sc_rasp7_rooms_pkey PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 16525)
-- Name: sc_worktypes sc_worktypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sc_worktypes
    ADD CONSTRAINT sc_worktypes_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 16527)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- TOC entry 3341 (class 2606 OID 16529)
-- Name: tg_users tg_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tg_users
    ADD CONSTRAINT tg_users_pkey PRIMARY KEY (tg_id);


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-01-23 14:25:47

--
-- PostgreSQL database dump complete
--

