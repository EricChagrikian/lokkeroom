--
-- PostgreSQL database dump
--

-- Dumped from database version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: lobby; Type: TABLE; Schema: public; Owner: messaging_app_admin
--

CREATE TABLE public.lobby (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    admin_id integer NOT NULL
);


ALTER TABLE public.lobby OWNER TO messaging_app_admin;

--
-- Name: lobby_id_seq; Type: SEQUENCE; Schema: public; Owner: messaging_app_admin
--

CREATE SEQUENCE public.lobby_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lobby_id_seq OWNER TO messaging_app_admin;

--
-- Name: lobby_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: messaging_app_admin
--

ALTER SEQUENCE public.lobby_id_seq OWNED BY public.lobby.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: messaging_app_admin
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    text text NOT NULL,
    author_id integer NOT NULL,
    lobby_id integer NOT NULL,
    created timestamp(0) without time zone NOT NULL,
    edited timestamp(0) without time zone
);


ALTER TABLE public.messages OWNER TO messaging_app_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: messaging_app_admin
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO messaging_app_admin;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: messaging_app_admin
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: messaging_app_admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    nickname character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO messaging_app_admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: messaging_app_admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO messaging_app_admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: messaging_app_admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_in_lobby; Type: TABLE; Schema: public; Owner: messaging_app_admin
--

CREATE TABLE public.users_in_lobby (
    id integer NOT NULL,
    lobby_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.users_in_lobby OWNER TO messaging_app_admin;

--
-- Name: users_in_lobby_id_seq; Type: SEQUENCE; Schema: public; Owner: messaging_app_admin
--

CREATE SEQUENCE public.users_in_lobby_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_in_lobby_id_seq OWNER TO messaging_app_admin;

--
-- Name: users_in_lobby_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: messaging_app_admin
--

ALTER SEQUENCE public.users_in_lobby_id_seq OWNED BY public.users_in_lobby.id;


--
-- Name: lobby id; Type: DEFAULT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.lobby ALTER COLUMN id SET DEFAULT nextval('public.lobby_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_in_lobby id; Type: DEFAULT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users_in_lobby ALTER COLUMN id SET DEFAULT nextval('public.users_in_lobby_id_seq'::regclass);


--
-- Data for Name: lobby; Type: TABLE DATA; Schema: public; Owner: messaging_app_admin
--

COPY public.lobby (id, name, admin_id) FROM stdin;
1	Cool discussions	19
2	Random stuff	33
3	Politics and silly memes	39
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: messaging_app_admin
--

COPY public.messages (id, text, author_id, lobby_id, created, edited) FROM stdin;
442	Lorem ipsum dolor sit amet, consectetur adipiscing elit	38	2	2022-06-19 00:05:23	\N
443	Vivamus finibus aliquet pharetra	43	2	2022-05-26 13:44:36	\N
444	Vestibulum ac velit eget felis hendrerit cursus	25	1	2022-06-24 03:21:42	\N
445	Etiam ut libero in arcu sodales gravida	40	1	2022-05-22 06:27:51	\N
446	Aliquam nibh orci, tempor non efficitur sed, consectetur vel urna	31	1	2022-06-06 13:31:15	\N
447	Phasellus quis lorem est	7	2	2022-06-23 15:22:03	\N
448	Duis id nibh at lacus suscipit sollicitudin	3	2	2022-06-27 01:10:00	\N
449	Etiam vel metus accumsan, posuere dui nec, commodo turpis	25	1	2022-05-28 20:42:57	\N
450	Fusce tincidunt augue at porttitor molestie	10	2	2022-06-17 20:35:26	\N
451	Aenean porttitor felis sit amet nisi hendrerit, nec semper turpis ultrices	2	2	2022-07-04 21:42:38	\N
452	Suspendisse fringilla augue libero, ut mattis eros consectetur ac	49	2	2022-06-09 07:16:55	\N
453	Proin ut molestie justo	48	2	2022-05-28 20:34:18	\N
454	Maecenas suscipit tortor non leo ultricies fringilla	10	1	2022-06-02 14:59:32	\N
455	Etiam consectetur in nisl auctor mattis	47	2	2022-06-24 04:12:09	\N
456	Praesent nunc ligula, luctus eu consequat vel, iaculis vitae nunc	47	1	2022-06-08 00:00:39	\N
457	Ut aliquet placerat neque, at eleifend leo gravida eu	16	1	2022-06-19 20:32:52	\N
458	Aliquam ac urna ipsum	22	1	2022-06-04 21:22:28	\N
459	Maecenas tristique tincidunt nisi, tempus consequat quam rutrum id	34	1	2022-06-12 12:55:50	\N
460	Ut ipsum tortor, dictum vel ornare at, elementum vitae eros	44	1	2022-06-19 20:58:21	\N
461	Proin eget nisl nibh	37	2	2022-06-16 19:50:58	\N
462	Etiam at risus in magna vulputate fermentum posuere et dolor	34	2	2022-05-19 15:47:04	\N
463	Pellentesque porttitor nulla at sem vestibulum rutrum	22	2	2022-06-18 21:12:21	\N
464	Nam semper elit metus, tincidunt posuere libero egestas in.Nullam et ligula ac arcu aliquet suscipit eu ut nisi	38	2	2022-07-02 21:05:44	\N
465	Nunc commodo lacus vitae lorem bibendum porta	14	2	2022-05-24 01:46:34	\N
466	Curabitur eget dictum justo	37	2	2022-07-07 15:10:24	\N
467	Duis dapibus quis ligula quis interdum	29	1	2022-06-08 01:02:58	\N
468	Phasellus sit amet dui purus	23	2	2022-05-29 20:57:13	\N
469	Etiam sollicitudin blandit diam et varius	26	2	2022-05-25 09:28:33	\N
470	Nam fringilla vel tortor quis mattis	12	1	2022-06-06 14:33:33	\N
471	Nam luctus aliquam felis, in vestibulum metus	46	2	2022-07-01 12:38:22	\N
472	Integer non ornare sem, non tristique eros	40	1	2022-05-23 06:28:27	\N
473	Aliquam erat volutpat	7	2	2022-06-03 18:36:45	\N
474	Vestibulum at nisi lobortis, auctor sem et, fermentum nisi	16	1	2022-05-25 09:32:07	\N
475	Interdum et malesuada fames ac ante ipsum primis in faucibus	24	2	2022-06-29 12:26:15	\N
476	Nullam nec neque lacinia, scelerisque lorem ut, aliquet ligula	37	2	2022-05-21 00:21:56	\N
477	In convallis nibh dui, eleifend auctor est eleifend id	8	2	2022-06-08 21:43:23	\N
478	Quisque luctus massa nec risus vulputate, vel mollis lorem lacinia	36	1	2022-06-06 09:20:09	\N
479	Lorem ipsum dolor sit amet, consectetur adipiscing elit	12	1	2022-06-21 00:22:17	\N
480	Pellentesque id sagittis enim	43	1	2022-06-25 13:32:45	\N
481	Donec eu nisl erat	23	1	2022-05-23 21:49:52	\N
482	Aenean ut placerat orci	38	1	2022-05-22 21:51:44	\N
483	Suspendisse in ipsum lobortis, eleifend leo id, fermentum eros	28	2	2022-07-08 00:09:49	\N
484	Phasellus venenatis turpis sem, sit amet cursus nulla efficitur ac	4	1	2022-06-20 08:54:51	\N
485	Donec luctus cursus condimentum	1	1	2022-06-30 23:37:23	\N
486	Aliquam suscipit magna est	39	2	2022-05-23 16:10:47	\N
487	Praesent auctor orci leo	23	2	2022-06-07 12:25:43	\N
488	Nullam eleifend id sapien nec pharetra	25	1	2022-07-01 00:06:12	\N
489	Nam consectetur in risus non malesuada	30	1	2022-06-28 06:25:11	\N
490	Sed ornare blandit blandit	20	2	2022-06-23 16:57:20	\N
491	Integer euismod semper dui, sed accumsan massa congue sit amet	29	1	2022-06-04 11:27:49	\N
492	In mollis at leo vel aliquet	41	1	2022-06-26 19:38:46	\N
493	Maecenas dictum congue velit	38	1	2022-06-26 16:29:36	\N
494	Nam quis elit efficitur, ullamcorper nisl non, dignissim mauris	3	2	2022-06-18 22:17:33	\N
495	Vestibulum imperdiet justo in viverra mattis	16	2	2022-05-30 13:44:48	\N
496	Proin id nunc non tellus ullamcorper rutrum sed non sem	48	1	2022-06-09 15:04:23	\N
497	Morbi elementum tortor eget pellentesque tempor	9	1	2022-06-27 17:58:56	\N
498	Donec hendrerit convallis velit nec finibus	1	2	2022-05-26 23:05:17	\N
499	Sed dictum accumsan imperdiet	30	1	2022-06-25 17:09:10	\N
500	Nulla ullamcorper tempor erat, at consequat arcu laoreet non	26	2	2022-06-08 07:14:40	\N
501	Sed elementum justo in odio fringilla dignissim	12	2	2022-05-31 17:10:06	\N
502	Nunc eget scelerisque lectus, blandit tincidunt tellus	9	1	2022-06-25 08:56:30	\N
503	Sed sed malesuada lectus, vel consequat nunc	1	1	2022-05-20 09:44:15	\N
504	Praesent euismod iaculis leo, non condimentum dui volutpat nec	30	1	2022-06-13 12:08:58	\N
505	Praesent euismod fermentum neque aliquet rutrum	17	1	2022-06-03 08:41:59	\N
506	Praesent convallis dictum ipsum vitae cursus	16	2	2022-06-05 11:35:58	\N
507	Suspendisse potenti	5	1	2022-06-13 18:20:25	\N
508	Aliquam ultrices pulvinar odio, sed laoreet nibh vehicula ut	9	2	2022-05-28 13:03:38	\N
509	Quisque et tellus imperdiet dui ultricies maximus	35	2	2022-07-02 04:21:39	\N
510	Integer a ex elit	32	1	2022-06-10 09:49:42	\N
511	Duis commodo augue rhoncus, tristique magna eget, tincidunt velit	20	1	2022-06-09 21:40:34	\N
512	Suspendisse potenti	49	1	2022-06-27 12:57:53	\N
513	Pellentesque interdum, dolor nec pretium molestie, ipsum nibh bibendum augue, in mollis lectus elit ac lorem	37	2	2022-06-08 14:09:25	\N
514	Integer nec tellus sed mi maximus consequat	47	1	2022-05-26 07:06:46	\N
515	Suspendisse condimentum sapien nec euismod rutrum	8	1	2022-06-23 04:52:31	\N
516	Praesent leo tellus, malesuada sit amet nisi id, feugiat porta odio	22	1	2022-05-20 00:53:53	\N
517	Etiam iaculis et velit eu blandit	49	1	2022-05-30 03:06:49	\N
518	Duis eu ligula fringilla diam ullamcorper malesuada	22	2	2022-06-27 13:34:38	\N
519	Sed sollicitudin, nunc sed lacinia fringilla, metus nulla scelerisque justo, eget malesuada sem tellus sollicitudin lorem	47	2	2022-05-20 16:00:12	\N
520	Phasellus nec magna quis sem fringilla interdum eget at leo	43	1	2022-06-08 18:37:40	\N
521	Nunc nec orci sed nulla placerat condimentum	3	1	2022-06-02 11:37:54	\N
522	Cras non nibh a urna pellentesque efficitur at id ante	41	2	2022-07-03 09:29:40	\N
523	In laoreet leo commodo neque auctor dapibus	41	2	2022-06-28 01:56:58	\N
524	Interdum et malesuada fames ac ante ipsum primis in faucibus	39	1	2022-06-07 22:21:23	\N
525	Vivamus dignissim non mi a luctus	10	2	2022-06-02 13:31:29	\N
526	Duis at egestas ex, vestibulum sodales elit	28	1	2022-07-02 08:10:46	\N
527	Fusce erat mi, rutrum sit amet metus vitae, sollicitudin ullamcorper neque	38	1	2022-07-07 23:29:36	\N
528	Suspendisse non varius augue	40	1	2022-06-18 04:50:12	\N
529	Proin gravida auctor enim, ac dictum lectus tincidunt sed	12	2	2022-05-27 11:16:57	\N
530	Aliquam congue leo in congue malesuada	9	1	2022-06-26 14:00:40	\N
531	Etiam vel tempus elit	42	1	2022-06-30 11:35:55	\N
532	Aliquam cursus porttitor vulputate	32	1	2022-06-27 06:14:31	\N
533	Integer leo magna, facilisis ut fringilla at, porta vitae sapien	8	2	2022-06-14 14:59:07	\N
534	Praesent dapibus rhoncus massa, et molestie diam accumsan vel	38	2	2022-06-18 00:40:05	\N
535	Vestibulum sit amet consequat lacus	45	2	2022-05-26 19:17:40	\N
536	Nunc maximus, urna in euismod dictum, nibh purus consequat mi, nec porttitor dui turpis nec massa	13	2	2022-05-30 11:27:39	\N
537	Vivamus ultrices mollis ipsum	43	2	2022-06-30 09:54:45	\N
538	Morbi quis felis malesuada, imperdiet felis efficitur, interdum ex	31	2	2022-06-24 00:12:07	\N
539	Fusce vitae finibus nisi	47	1	2022-05-19 21:29:09	\N
540	Mauris lacinia consectetur neque tristique consectetur	31	2	2022-06-25 00:45:34	\N
541	Aliquam lectus quam, ultricies in felis commodo, vulputate gravida nulla	10	1	2022-06-20 09:09:25	\N
542	Aenean a consectetur lorem	21	1	2022-05-20 21:15:58	\N
543	Nunc interdum, nisl sit amet dignissim sagittis, ligula lacus porta nisl, vitae dictum erat arcu nec velit	4	1	2022-06-22 16:58:05	\N
544	Morbi urna nisi, bibendum id ornare posuere, imperdiet quis nunc	36	2	2022-05-30 15:08:41	\N
545	Cras eget finibus quam	30	1	2022-05-24 23:17:49	\N
546	Sed iaculis, quam in euismod suscipit, dolor lacus efficitur felis, gravida aliquam orci dolor in justo	37	1	2022-06-07 19:58:45	\N
547	Cras eget orci ante	36	2	2022-06-16 18:03:36	\N
548	Fusce id commodo libero	9	1	2022-05-31 17:09:27	\N
549	Maecenas aliquet fringilla tristique	17	1	2022-05-21 04:15:40	\N
550	Vivamus nec ex lobortis eros cursus tincidunt	34	1	2022-06-07 05:06:52	\N
551	Phasellus interdum.	8	2	2022-06-27 04:47:43	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: messaging_app_admin
--

COPY public.users (id, email, nickname, password) FROM stdin;
1	mmissenden0@ameblo.jp	Merv	$2b$10$f93gCjZ46GLFucBqj2NhS.GXkB/u7.QoUYeJdoBlHyFxuB6xi2Spu
2	cbiffen1@usnews.com	Concordia	$2b$10$pCTjz3DOEay5sqK70r5ZVeRUlXWixwpdpBoe2f.JqDCe3RRkG/JfG
3	cglowinski2@va.gov	Carey	$2b$10$iGarBkiqkMKtnXQ22wNos..fYLUtcKJWo4/0oJoMG4.UES9N9kHIO
4	mbiddulph3@yale.edu	Marie-ann	$2b$10$ibPA9XEntAzSqsx2ISjM0O7K6T96VCcrKPY/Bbgkn3.rLkEff7uVe
5	oors4@dot.gov	Otto	$2b$10$3DB.RBhMr/i.S95imvVv8.COGVHc4iLR94xRrqRgKs9ySqbOCS4iC
6	vkeeri5@clickbank.net	Valentin	$2b$10$s6KApwJO0yCo1L6E0xVvLO8KHgZYLKyYISFDeIzFpE7NQ7Z5mBiDm
7	fmandrake6@bizjournals.com	Fax	$2b$10$b4ZeLZdioRqovAeadbCR.eirfIEidZX3b.QoBkO1pGBvyrVRAdFvq
8	lmordue7@seesaa.net	Les	$2b$10$Gld8AfIkaANzPt1By4hIburULTMNmL0mxNxSuuiBVNZlSYCbFVwpq
9	mpeche8@narod.ru	Montague	$2b$10$sI0aVKx/XACubDxfOnDKku/gvidFt/vCsM6GhvtVlvN9eQQKFvoB2
10	kmcrorie9@w3.org	Kaila	$2b$10$30mE74042p2M61a5AZOhHeN0LSeu0CaeaOfQaixoOxHd02zHXq7.m
11	ocampoa@mac.com	Ody	$2b$10$8YikETXxtYoYQ2iE0NLCXeJBMevcZiFYQ.VD/BFpMfa7Zc6/tOqP6
12	ssmeesb@google.fr	Shelia	$2b$10$/ryOWC6vDX1BA9tQ4c/gxufZDxE1thlhazNt6NZ2tfFaPXHwEOelS
13	hvakhrushinc@cnbc.com	Howard	$2b$10$SOnMcprA4agAIc156H8zt.sbATTg5R7qmX4GEynWpx6YwxFeERih6
14	jschneiderd@soundcloud.com	Jo-ann	$2b$10$CP.7azxQq.oSSXeZzwYwKevbP7.cK6IGySB/gQK7amz/t7mBIHU0W
15	isnodine@google.co.jp	Isabella	$2b$10$QIHZ.ziKrZQ92TlDas3xI.jQ8GSshcVVh8aA2G/boS1xb5Xo80LJe
16	kbreartyf@omniture.com	Katrinka	$2b$10$JRj2moA1Yy.ZVDQACtpx8uU4tapPFS7pD4osBa4qiI6SActSZGtvi
17	vnorburyg@ezinearticles.com	Victoir	$2b$10$u4ctu.hSlPz5Vjotc..FwuSflg67HU5lCbzQCq8fU1F/iOaWAs/Y2
18	ubaseh@cmu.edu	Umeko	$2b$10$E8S/NSmm6rf6AOc2uq8ENOEZlbzECJ6rq.1rmEClyPUEmtwHoLOgK
19	kturtlei@google.com	Kurtis	$2b$10$WzKAUA6o1UEE7Hv1Uv62B.NU8dQvBOJwVgMRwVo0tQ3OtyjLEj4Sy
20	jbugdellj@theglobeandmail.com	Joycelin	$2b$10$zezPjmcCAhyZFEdmQvaujenVUa9rRNvfQYpINil7tTxNHMeVsQb2G
21	kseyersk@exblog.jp	Kirsten	$2b$10$Ykrz1vhw.Lx8zq/17XDSreBwsyLI1/UpmgrAWBWiMmomhKHQfPiTq
22	lavannl@aol.com	Lezley	$2b$10$7pgRYAQMZQ7PIaMlBTcEr.vD1/grkDjb.CgiKEKxL22/urH4ODb4C
23	kdowem@virginia.edu	Killy	$2b$10$/GCe1zRUemqNu/Z8nGtPKu3sJMWiT3/MuRHViBXqy/.sOzj8o5F1i
24	econan@live.com	Ernesto	$2b$10$3bBUzFNYu8J6Catgc8nzVe4X3LJiATHJw5PIyryDJtxX.M42IdFsG
25	aleyborneo@wix.com	Ashia	$2b$10$dHBDnVsgDN/upHWpchIcHeuHEMJ0OVrV/wsE/x3bOhbNpEfj.pr5m
26	mwahnckep@t-online.de	Miles	$2b$10$OQdpgF7qyr6q9gXx0yHz8Oe/MKn7YN16UPZ7uIl0SAgQELfVKRpVq
27	etrimnellq@joomla.org	Emmet	$2b$10$vV.h7D7fFmoMICG9rG2m/uavGEEKkqVlA4Ah6I.zbTVHHUe.E9I.W
28	lasquezr@angelfire.com	Lanna	$2b$10$8wd3.A0DIART.GSVqI/LOupsLPY2q0k5AX47bvvSyEwTY7P0/XQoy
29	lweeds@jiathis.com	Loise	$2b$10$a7hoEDpmKXO/sVDAtrDT.ersB4SzOk/tHnlxGZwymPu8xI00fIjnK
30	rslocombet@mashable.com	Rochell	$2b$10$lUat6zD.BEigT5Llif1T6ujZSoRehLlwaA8Vpjg6IbwoHbzxj7Q4m
31	jlockieru@163.com	Jillene	$2b$10$cMhYzQyswz7ERW1fjwtQReOs5suHq08SQGAwxA86VVazI0HNO//eW
32	dbarcroftv@163.com	Dorry	$2b$10$ummD/OuHqPB80RKFZZvWdOZNwCj03V/TWg6LROfJxqQ6TtbM4MQbC
33	tawtonw@nps.gov	Tadio	$2b$10$UdBPqm/T3QpV7crWyNuUpeptMmIOm0O9c7/R3enDptgqkLbDSnTCu
34	twitherbyx@yolasite.com	Thaddeus	$2b$10$5g91WrOdv.w82RZHG8i26uiHWYhxHYLlF4ny1rZv18SMOfs6jJNZC
35	ahilandy@reddit.com	Ardisj	$2b$10$KqFalmLP7f7ehy8Zmu.NCubWYwMZIgbUOMLGmq09drzxoPk.HMoYS
36	gharkessz@sciencedirect.com	Gerrard	$2b$10$kdyFVFNR1srsY3M5AUsbYupGX0klFFDkdzDa4cOyL9pQPe7TsRox2
37	ldearing10@taobao.com	Lawrence	$2b$10$EDwu7ijqKqNuLARrC51dzukyDNHMsYLdAdoPKy5zUq3I8MgDqyPqC
38	mschaumann11@de.vu	Mord	$2b$10$mgP.Ujx6aUW3nJ5BVOTGhOCGbnJDpI7w1bubw1sDjGSA1kN/tAXeq
39	mbeardsdale12@seesaa.net	Mirabelle	$2b$10$Rs3FeFyJyXwnsL0D/On7Iuv3lznpu2O85HyoBUuaEMeY5o7Zq49ZC
40	lniesegen13@deliciousdays.com	Lou	$2b$10$s1.UMPF1555s.nvwQvD2IeOWsplzO1cL23KYrF1Qam8MqX8S37ss6
41	aship14@vistaprint.com	Alia	$2b$10$hJW7eRvpZWmRRDtAU1952O5is35/O2eAj9hMFy46BrfboLmxRFl3W
42	dsollars15@opera.com	Davis	$2b$10$t3JhUvGO4Y..w8pLT3PFVe5PsiOCYz5FBh898bUMon5lY2ieqQVYK
43	astubbings16@intel.com	Alyson	$2b$10$z2b3K.9icwSla1A6CkzpR.5x3xKtiI.r/TW/nNRgA2w0cQC2kEpqS
44	vferminger17@state.tx.us	Vonnie	$2b$10$AdDr9gAWxKqzYDhhdkt2beIBSrVI5YFuvfOTxqVZ0E5n.soU4IsiC
45	munger18@csmonitor.com	Milzie	$2b$10$zir614nUBz4BXYR0e10Gb.2MemWGuevs.XtFbm/t0wYyx3RtMndlW
46	merasmus19@tinyurl.com	Marcelle	$2b$10$1OEEZU0ZcnCyamEQN7lIFusuE.ViRj4uDe4bMu1UUHRAuPSrB30wm
47	blawrinson1a@mediafire.com	Baird	$2b$10$.rzFv9z0lX/yDb2K3rBbHeDLGJK4lvWRFJnNYb2A7oe.l0U9jV/OO
48	tgerardin1b@harvard.edu	Torrin	$2b$10$cXAaHBbjOQJfiIpTjSaCG.xvvNyVfggyt6vXopHyvP1M1vDxLXqxa
49	kgleader1c@arizona.edu	Kary	$2b$10$xjhY75vWVqhXlZHjwd9t6.5R2PU.//kpakuYBrY4VaiHDizsygIha
50	rkimbell1d@kickstarter.com	Roxi	$2b$10$BSeF7VgfsmmP5icHHc9wguIZ8ui1XP88lG5YHP9na4vql8bTfrH4.
\.


--
-- Data for Name: users_in_lobby; Type: TABLE DATA; Schema: public; Owner: messaging_app_admin
--

COPY public.users_in_lobby (id, lobby_id, user_id) FROM stdin;
272	2	38
273	2	43
274	1	25
275	1	40
276	1	31
277	2	7
278	2	3
279	2	10
280	2	2
281	2	49
282	2	48
283	1	10
284	2	47
285	1	47
286	1	16
287	1	22
288	1	34
289	1	44
290	2	37
291	2	34
292	2	22
293	2	14
294	1	29
295	2	23
296	2	26
297	1	12
298	2	46
299	2	24
300	2	8
301	1	36
302	1	43
303	1	23
304	1	38
305	2	28
306	1	4
307	1	1
308	2	39
309	1	30
310	2	20
311	1	41
312	2	16
313	1	48
314	1	9
315	2	1
316	2	12
317	1	17
318	1	5
319	2	9
320	2	35
321	1	32
322	1	20
323	1	49
324	1	8
325	1	3
326	2	41
327	1	39
328	1	28
329	1	42
330	2	45
331	2	13
332	2	31
333	1	21
334	2	36
335	1	37
\.


--
-- Name: lobby_id_seq; Type: SEQUENCE SET; Schema: public; Owner: messaging_app_admin
--

SELECT pg_catalog.setval('public.lobby_id_seq', 3, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: messaging_app_admin
--

SELECT pg_catalog.setval('public.messages_id_seq', 551, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: messaging_app_admin
--

SELECT pg_catalog.setval('public.users_id_seq', 50, true);


--
-- Name: users_in_lobby_id_seq; Type: SEQUENCE SET; Schema: public; Owner: messaging_app_admin
--

SELECT pg_catalog.setval('public.users_in_lobby_id_seq', 335, true);


--
-- Name: lobby lobby_pkey; Type: CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.lobby
    ADD CONSTRAINT lobby_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_in_lobby users_in_lobby_pkey; Type: CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users_in_lobby
    ADD CONSTRAINT users_in_lobby_pkey PRIMARY KEY (id);


--
-- Name: users users_nickname_key; Type: CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nickname_key UNIQUE (nickname);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: lobby lobby_admin_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.lobby
    ADD CONSTRAINT lobby_admin_id_foreign FOREIGN KEY (admin_id) REFERENCES public.users(id);


--
-- Name: messages messages_author_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_author_id_foreign FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: messages messages_lobby_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_lobby_id_foreign FOREIGN KEY (lobby_id) REFERENCES public.lobby(id);


--
-- Name: users_in_lobby users_in_lobby_lobby_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users_in_lobby
    ADD CONSTRAINT users_in_lobby_lobby_id_foreign FOREIGN KEY (lobby_id) REFERENCES public.lobby(id);


--
-- Name: users_in_lobby users_in_lobby_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: messaging_app_admin
--

ALTER TABLE ONLY public.users_in_lobby
    ADD CONSTRAINT users_in_lobby_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

