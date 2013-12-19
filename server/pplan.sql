--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE pplan;
--
-- Name: pplan; Type: DATABASE; Schema: -; Owner: pplan
--

CREATE DATABASE pplan WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE pplan OWNER TO pplan;

\connect pplan

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pplan
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pplan;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pplan
--

COMMENT ON SCHEMA public IS 'standard public schema';


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
-- Name: episode; Type: TABLE; Schema: public; Owner: pplan; Tablespace: 
--

CREATE TABLE episode (
    id integer NOT NULL,
    programme_id integer NOT NULL,
    title character varying(100) NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    length interval DEFAULT '00:00:00'::interval NOT NULL
);


ALTER TABLE public.episode OWNER TO pplan;

--
-- Name: event; Type: TABLE; Schema: public; Owner: pplan; Tablespace: 
--

CREATE TABLE event (
    id integer NOT NULL,
    episode_id integer NOT NULL,
    start_date timestamp with time zone
);


ALTER TABLE public.event OWNER TO pplan;

--
-- Name: programme; Type: TABLE; Schema: public; Owner: pplan; Tablespace: 
--

CREATE TABLE programme (
    pid integer NOT NULL,
    title character varying(100) NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.programme OWNER TO pplan;

--
-- Name: episode_events; Type: MATERIALIZED VIEW; Schema: public; Owner: pplan; Tablespace: 
--

CREATE MATERIALIZED VIEW episode_events AS
 SELECT p.pid AS programme_id,
    p.title,
    ep.id AS episode_id,
    ep.title AS episode_title,
    ev.start_date AS event_start,
    ep.length AS episode_length,
    (ev.start_date + ep.length) AS event_end
   FROM programme p,
    episode ep,
    event ev
  WHERE ((p.pid = ep.programme_id) AND (ep.id = ev.episode_id))
  WITH NO DATA;


ALTER TABLE public.episode_events OWNER TO pplan;

--
-- Name: episode_id_seq; Type: SEQUENCE; Schema: public; Owner: pplan
--

CREATE SEQUENCE episode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.episode_id_seq OWNER TO pplan;

--
-- Name: episode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pplan
--

ALTER SEQUENCE episode_id_seq OWNED BY episode.id;


--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: pplan
--

CREATE SEQUENCE event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO pplan;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pplan
--

ALTER SEQUENCE event_id_seq OWNED BY event.id;


--
-- Name: program_pid_seq; Type: SEQUENCE; Schema: public; Owner: pplan
--

CREATE SEQUENCE program_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_pid_seq OWNER TO pplan;

--
-- Name: program_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pplan
--

ALTER SEQUENCE program_pid_seq OWNED BY programme.pid;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: pplan
--

ALTER TABLE ONLY episode ALTER COLUMN id SET DEFAULT nextval('episode_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: pplan
--

ALTER TABLE ONLY event ALTER COLUMN id SET DEFAULT nextval('event_id_seq'::regclass);


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: pplan
--

ALTER TABLE ONLY programme ALTER COLUMN pid SET DEFAULT nextval('program_pid_seq'::regclass);


--
-- Data for Name: episode; Type: TABLE DATA; Schema: public; Owner: pplan
--

INSERT INTO episode VALUES (1, 1, 'Funky fools with fire', 'The wittle bear Funky tries to set fire to things, and succeeds quite often!', '00:14:40');
INSERT INTO episode VALUES (2, 1, 'Bear hugging', 'Funky and his friends hug everyone they meet', '00:14:40');
INSERT INTO episode VALUES (3, 1, 'Beer drinking', 'One of Funky''s friends finds lots of bottles with a strange, malty liquid. They all drink the stuff and hilarity ensues!', '00:14:40');


--
-- Name: episode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pplan
--

SELECT pg_catalog.setval('episode_id_seq', 2, true);


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: pplan
--

INSERT INTO event VALUES (1, 1, '2013-12-12 11:45:10.0+01');
INSERT INTO event VALUES (2, 1, '2013-12-12 19:45:10.0+01');
INSERT INTO event VALUES (3, 2, '2013-12-19 11:45:10.0+01');
INSERT INTO event VALUES (4, 2, '2013-12-19 19:45:10.0+01');
INSERT INTO event VALUES (5, 3, '2013-12-26 11:45:10.0+01');
INSERT INTO event VALUES (6, 3, '2013-12-26 19:45:10.0+01');


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pplan
--

SELECT pg_catalog.setval('event_id_seq', 1, true);


--
-- Name: program_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: pplan
--

SELECT pg_catalog.setval('program_pid_seq', 1, true);


--
-- Data for Name: programme; Type: TABLE DATA; Schema: public; Owner: pplan
--

INSERT INTO programme VALUES (1, 'Funky the Bear', 'Funky and his friends entertains all children.');
INSERT INTO programme VALUES (2, 'Deep into the kitchen with Arny', 'Arny is a master chef who travels the seven seas to cook.');
INSERT INTO programme VALUES (3, 'Arguably Argued', 'A political talk-fest with satiric undertones.');
INSERT INTO programme VALUES (4, 'The almost new news', 'The best news show on this channel.');


--
-- Name: episode_pkey; Type: CONSTRAINT; Schema: public; Owner: pplan; Tablespace: 
--

ALTER TABLE ONLY episode
    ADD CONSTRAINT episode_pkey PRIMARY KEY (id);


--
-- Name: event_pkey; Type: CONSTRAINT; Schema: public; Owner: pplan; Tablespace: 
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: program_pkey; Type: CONSTRAINT; Schema: public; Owner: pplan; Tablespace: 
--

ALTER TABLE ONLY programme
    ADD CONSTRAINT program_pkey PRIMARY KEY (pid);


--
-- Name: episode_program_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pplan
--

ALTER TABLE ONLY episode
    ADD CONSTRAINT episode_program_id_fkey FOREIGN KEY (programme_id) REFERENCES programme(pid);


--
-- Name: event_episode_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pplan
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_episode_id_fkey FOREIGN KEY (episode_id) REFERENCES episode(id);


--
-- Name: episode_events; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: pplan
--

REFRESH MATERIALIZED VIEW episode_events;


--
-- Name: public; Type: ACL; Schema: -; Owner: pplan
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM pplan;
GRANT ALL ON SCHEMA public TO pplan;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

