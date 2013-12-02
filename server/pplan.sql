--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pplan;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
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
-- Name: program; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE program (
    pid integer NOT NULL,
    title character varying(100) NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.program OWNER TO pplan;

--
-- Name: program_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE program_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.program_pid_seq OWNER TO pplan;

--
-- Name: program_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE program_pid_seq OWNED BY program.pid;


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY program ALTER COLUMN pid SET DEFAULT nextval('program_pid_seq'::regclass);


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO program VALUES (1, 'Funky the Bear', 'Funky and his friends entertains all children.');
INSERT INTO program VALUES (2, 'Deep into the kitchen with Arny', 'Arny is a master chef who travels the seven seas to cook.');
INSERT INTO program VALUES (3, 'Arguably Argued', 'A political talk-fest with satiric undertones.');
INSERT INTO program VALUES (4, 'The almost new news', 'The best news show on this channel.');


--
-- Name: program_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('program_pid_seq', 1, true);


--
-- Name: program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY program
    ADD CONSTRAINT program_pkey PRIMARY KEY (pid);


--
-- PostgreSQL database dump complete
--

