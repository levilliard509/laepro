--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

-- Started on 2018-06-17 00:47:37 EDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 148365)
-- Name: lae_db; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lae_db;


ALTER SCHEMA lae_db OWNER TO postgres;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA lae_db; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA lae_db IS 'standard public schema';


SET search_path = lae_db, pg_catalog;

--
-- TOC entry 246 (class 1255 OID 148366)
-- Name: createemployee(integer, character varying, character varying, character varying, character varying, character varying, character varying, character, character varying, character varying, boolean, character varying, timestamp without time zone, character varying, timestamp without time zone, date); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION createemployee(addr_id integer, firstname character varying, lastname character varying, funct character varying, card_id character varying, etype character varying, details character varying, sex character, tels character varying, email character varying, isactive boolean, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, bdate date) RETURNS integer
    LANGUAGE plpgsql
    AS $$

    DECLARE 
        tmp int;
    BEGIN
        SELECT employee_id into tmp FROM lae_db.employee 
        WHERE address_id = addr_id
        AND employee_firstname = lastname
        AND employee_lastname = firstname
        AND employee_email = email
        AND employee_tels = tels ;

        if tmp IS NOT NULL THEN
            RETURN tmp;

        ELSE
            INSERT INTO lae_db.employee(
                address_id, 
                employee_firstname, 
                employee_lastname, 
                employee_func, 
                employee_card_id, 
                employee_type, 
                employee_details,
                employee_sex, 
                employee_tels, 
                employee_email, 
                employee_active, 
                created_by, 
                date_created, 
                modified_by, 
                date_modified,
                employee_birthday)
            values(
                    addr_id,
                    firstname,
                    lastname,
                    funct,
                    card_id,
                    etype,
                    details,
                    sex,
                    tels,
                    email,
                    isactive,
                    cby,
                    dcreated,
                    mby,
                    dmodified,
                    bdate);
            SELECT CURRVAL('lae_db.employee_employee_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;

$$;


ALTER FUNCTION lae_db.createemployee(addr_id integer, firstname character varying, lastname character varying, funct character varying, card_id character varying, etype character varying, details character varying, sex character, tels character varying, email character varying, isactive boolean, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, bdate date) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 148367)
-- Name: createstudent(integer, integer, integer, integer, character varying, character varying, date, character varying, character, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, timestamp without time zone, character varying, boolean, integer, text); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION createstudent(ins_id integer, par_id integer, pref_id integer, inscid integer, std_firstname character varying, std_lastname character varying, std_birthday date, std_birthplace character varying, std_sex character, std_mtonge character varying, std_skills character varying, std_tels character varying, std_email character varying, std_addr character varying, std_religion character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, std_img character varying, std_active boolean, pf_id integer, std_address text) RETURNS integer
    LANGUAGE plpgsql
    AS $$

    DECLARE 
        tmp int;
    BEGIN
        SELECT student_id into tmp FROM lae_db.student 
        WHERE parent_id = par_id
        AND  person_ref_id  = pref_id
        AND institution_class_id = inscid
        AND student_lastname = std_lastname
        AND student_birthplace = std_birthplace
        AND student_firstname = std_firstname
        AND student_birthday = std_birthday ;

        if tmp IS NOT NULL THEN
            RETURN tmp;

        ELSE
         
            INSERT INTO lae_db.student(
            institution_id,
            parent_id,
            person_ref_id,
            institution_class_id,
            student_firstname,
            student_lastname,
            student_birthday,
            student_birthplace,
            student_sex,
            student_mother_tonge,
            student_skills,
            student_tels,
            student_email,
            student_addr,
            student_religion,
            created_by,
            date_created,
            modified_by,
            date_modified,
            student_img,
            student_active,
            parentf_id,
            student_address)
            values(
                ins_id,
                par_id,
                pref_id,
                inscid,
                std_firstname,
                std_lastname,
                std_birthday,
                std_birthplace,
                std_sex,
                std_mtonge,
                std_skills,
                std_tels,
                std_email,
                std_addr,
                std_religion,
                cby,
                dcreated,
                mby,
                dmodified,
                std_img,
                std_active,
                pf_id,
                std_address);
            SELECT CURRVAL('lae_db.student_student_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;
$$;


ALTER FUNCTION lae_db.createstudent(ins_id integer, par_id integer, pref_id integer, inscid integer, std_firstname character varying, std_lastname character varying, std_birthday date, std_birthplace character varying, std_sex character, std_mtonge character varying, std_skills character varying, std_tels character varying, std_email character varying, std_addr character varying, std_religion character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, std_img character varying, std_active boolean, pf_id integer, std_address text) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 148368)
-- Name: insertaddress(character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, timestamp without time zone); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION insertaddress(country character varying, cstate character varying, city character varying, street character varying, zipcode character varying, details character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
    AS $$

	DECLARE 
    	tmp int;
    BEGIN
        SELECT address_id into tmp FROM lae_db.address 
        WHERE address_country = country
        AND address_state = cstate 
        AND address_city = city
        AND address_street = street;

        if tmp IS NOT NULL THEN
        	RETURN tmp;
        ELSE
            INSERT INTO lae_db.address(address_country, address_state, address_city, address_street, address_zipcode, address_details, created_by, date_created, modified_by, date_modified) 
            values(country, cstate, city, street, zipcode, details, cby, dcreated, mby, dmodified);
            SELECT CURRVAL('lae_db.address_address_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;

$$;


ALTER FUNCTION lae_db.insertaddress(country character varying, cstate character varying, city character varying, street character varying, zipcode character varying, details character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 148369)
-- Name: insertinstclass(integer, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, timestamp without time zone); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION insertinstclass(inst_id integer, inst_class_name character varying, inst_class_level character varying, inst_class_desc character varying, inst_class_code character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone) RETURNS integer
    LANGUAGE plpgsql
    AS $$

    DECLARE 
        tmp int;
    BEGIN
        SELECT institution_class_id into tmp FROM lae_db.institution_class 
        WHERE institution_id = inst_id
        AND institution_class_name = inst_class_name
        AND institution_class_level = inst_class_level
        AND institution_class_code = inst_class_code;

        if tmp IS NOT NULL THEN
            RETURN tmp;
        ELSE
            INSERT INTO lae_db.institution_class(institution_id, institution_class_name, institution_class_level, institution_class_desc, institution_class_code, created_by, date_created, modified_by, date_modified) 
            values(inst_id, inst_class_name, inst_class_level, inst_class_desc, inst_class_code, cby, dcreated, mby, dmodified);
            SELECT CURRVAL('lae_db.institution_class_institution_class_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;

$$;


ALTER FUNCTION lae_db.insertinstclass(inst_id integer, inst_class_name character varying, inst_class_level character varying, inst_class_desc character varying, inst_class_code character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 148370)
-- Name: insertparent(character varying, character varying, character varying, character, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, timestamp without time zone, text); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION insertparent(firstname character varying, lastname character varying, title character varying, sex character, tels character varying, email character varying, religion character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, p_addr text) RETURNS integer
    LANGUAGE plpgsql
    AS $$

    DECLARE 
        tmp int;
    BEGIN
        SELECT parent_id into tmp FROM lae_db.parent 
        WHERE parent_firstname = firstname
        AND parent_lastname = lastname
        AND parent_email = email
        AND parent_tels = tels ;

        if tmp IS NOT NULL THEN
            RETURN tmp;
        ELSE
            INSERT INTO lae_db.parent(parent_firstname, parent_lastname, parent_title, parent_sex, parent_tels, parent_email, parent_religion, created_by, date_created, modified_by, date_modified, parent_address)
            values(firstname, lastname, title, sex, tels, email, religion, cby, dcreated, mby, dmodified, p_addr);
            SELECT CURRVAL('lae_db.parent_parent_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;

$$;


ALTER FUNCTION lae_db.insertparent(firstname character varying, lastname character varying, title character varying, sex character, tels character varying, email character varying, religion character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, p_addr text) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 148371)
-- Name: insertpref(character varying, character varying, character, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, timestamp without time zone, text); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION insertpref(firstname character varying, lastname character varying, sex character, tels character varying, email character varying, pdesc character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, p_ref text) RETURNS integer
    LANGUAGE plpgsql
    AS $$

    DECLARE 
        tmp int;
    BEGIN
        SELECT person_ref_id into tmp FROM lae_db.person_ref 
        WHERE person_ref_firstname = firstname
        AND person_ref_lastname = lastname
        AND person_ref_email = email
        AND person_ref_tels = tels ;

        if tmp IS NOT NULL THEN
            RETURN tmp;

        ELSE
            INSERT INTO lae_db.person_ref(person_ref_firstname, person_ref_lastname, person_ref_sex, person_ref_tels, person_ref_email, person_ref_desc, created_by, date_created, modified_by, date_modified, person_ref_address)
            values(firstname, lastname, sex, tels, email, pdesc, cby, dcreated, mby, dmodified, p_ref);
            SELECT CURRVAL('lae_db.person_ref_person_ref_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;

$$;


ALTER FUNCTION lae_db.insertpref(firstname character varying, lastname character varying, sex character, tels character varying, email character varying, pdesc character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, p_ref text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 181 (class 1259 OID 148372)
-- Name: absence; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE absence (
    absence_id integer NOT NULL,
    student_id integer NOT NULL,
    absence_motif text,
    absence_details text,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE absence OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 148378)
-- Name: absence_absence_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE absence_absence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE absence_absence_id_seq OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 182
-- Name: absence_absence_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE absence_absence_id_seq OWNED BY absence.absence_id;


--
-- TOC entry 183 (class 1259 OID 148380)
-- Name: address; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE address (
    address_id integer NOT NULL,
    address_country character varying(30) NOT NULL,
    address_state character varying(45) NOT NULL,
    address_city character varying(45),
    address_street character varying(100),
    address_zipcode character varying(10),
    address_details character varying(100),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE address OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 148383)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE address_address_id_seq OWNER TO postgres;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 184
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE address_address_id_seq OWNED BY address.address_id;


--
-- TOC entry 185 (class 1259 OID 148385)
-- Name: class_cours; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE class_cours (
    class_cours_id integer NOT NULL,
    institution_class_id integer NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE class_cours OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 148388)
-- Name: class_cours_class_cours_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE class_cours_class_cours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE class_cours_class_cours_id_seq OWNER TO postgres;

--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 186
-- Name: class_cours_class_cours_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE class_cours_class_cours_id_seq OWNED BY class_cours.class_cours_id;


--
-- TOC entry 187 (class 1259 OID 148390)
-- Name: payment_class; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE payment_class (
    payment_class_id integer NOT NULL,
    institution_class_id integer NOT NULL,
    payment_class_begin_fee_value double precision NOT NULL,
    payment_class_period_value double precision NOT NULL,
    payment_class_freq integer NOT NULL,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE payment_class OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 148393)
-- Name: class_payment_class_payment_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE class_payment_class_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE class_payment_class_payment_id_seq OWNER TO postgres;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 188
-- Name: class_payment_class_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE class_payment_class_payment_id_seq OWNED BY payment_class.payment_class_id;


--
-- TOC entry 189 (class 1259 OID 148395)
-- Name: cours; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE cours (
    cours_id integer NOT NULL,
    cours_level character varying(20),
    cours_title character varying(200),
    cours_desc character varying(300),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE cours OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 148401)
-- Name: cours_cours_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE cours_cours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cours_cours_id_seq OWNER TO postgres;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 190
-- Name: cours_cours_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE cours_cours_id_seq OWNED BY cours.cours_id;


--
-- TOC entry 232 (class 1259 OID 148835)
-- Name: course; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE course (
    course_id integer NOT NULL,
    periode_id integer,
    institution_class_id integer,
    course_level numeric(6,2),
    course_title character varying(100) NOT NULL,
    course_short_name character varying(25),
    course_credit_hours numeric(6,2),
    course_desc character varying(400),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE course OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 148403)
-- Name: employee; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE employee (
    employee_id integer NOT NULL,
    address_id integer NOT NULL,
    employee_firstname character varying(40) NOT NULL,
    employee_lastname character varying(40) NOT NULL,
    employee_func character varying(50) NOT NULL,
    employee_card_id character varying(20),
    employee_type character varying(100),
    employee_details character varying(200),
    employee_sex character(1),
    employee_tels character varying(40),
    employee_email character varying(100),
    employee_active boolean,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    employee_birthday date
);


ALTER TABLE employee OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 148409)
-- Name: employee_employee_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE employee_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE employee_employee_id_seq OWNER TO postgres;

--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 192
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE employee_employee_id_seq OWNED BY employee.employee_id;


--
-- TOC entry 193 (class 1259 OID 148411)
-- Name: employee_salary; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE employee_salary (
    employee_salary_id integer NOT NULL,
    employee_id integer NOT NULL,
    employee_salary_value double precision NOT NULL,
    employee_salary_payment_freq integer NOT NULL,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE employee_salary OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 148414)
-- Name: employee_salary_employee_salary_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE employee_salary_employee_salary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE employee_salary_employee_salary_id_seq OWNER TO postgres;

--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 194
-- Name: employee_salary_employee_salary_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE employee_salary_employee_salary_id_seq OWNED BY employee_salary.employee_salary_id;


--
-- TOC entry 195 (class 1259 OID 148416)
-- Name: event; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE event (
    event_id integer NOT NULL,
    user_id integer,
    event_title character varying(100) NOT NULL,
    event_desc character varying(400) NOT NULL,
    event_dstart timestamp(6) without time zone,
    event_dend timestamp(6) without time zone,
    event_concerns character varying(100),
    event_details character varying(300),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE event OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 148422)
-- Name: event_event_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE event_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE event_event_id_seq OWNER TO postgres;

--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 196
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE event_event_id_seq OWNED BY event.event_id;


--
-- TOC entry 197 (class 1259 OID 148424)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 148426)
-- Name: huser; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE huser (
    user_id integer NOT NULL,
    user_privilege integer NOT NULL,
    user_firstname character varying(40) NOT NULL,
    user_lastname character varying(40) NOT NULL,
    user_title character varying(50),
    user_sex character(1),
    user_phone character varying(24),
    user_email character varying(50),
    user_username character varying(20),
    user_password character varying(200),
    user_code character varying(8),
    user_img character varying(100),
    user_details character varying(300),
    user_active boolean,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE huser OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 148432)
-- Name: institution; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE institution (
    institution_id integer NOT NULL,
    address_id integer NOT NULL,
    institution_name character varying(200),
    institution_details character varying(300),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    school_begin_date date,
    school_end_date date
);


ALTER TABLE institution OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 148438)
-- Name: institution_class; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE institution_class (
    institution_class_id integer NOT NULL,
    institution_id integer NOT NULL,
    institution_class_name character varying(45) NOT NULL,
    institution_class_level character varying(20) NOT NULL,
    institution_class_desc character varying(200),
    institution_class_code character varying(10),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE institution_class OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 148441)
-- Name: institution_class_institution_class_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE institution_class_institution_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE institution_class_institution_class_id_seq OWNER TO postgres;

--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 201
-- Name: institution_class_institution_class_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE institution_class_institution_class_id_seq OWNED BY institution_class.institution_class_id;


--
-- TOC entry 202 (class 1259 OID 148443)
-- Name: institution_institution_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE institution_institution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE institution_institution_id_seq OWNER TO postgres;

--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 202
-- Name: institution_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE institution_institution_id_seq OWNED BY institution.institution_id;


--
-- TOC entry 203 (class 1259 OID 148451)
-- Name: parent; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE parent (
    parent_id integer NOT NULL,
    parent_firstname character varying(40) NOT NULL,
    parent_lastname character varying(40) NOT NULL,
    parent_title character varying(50),
    parent_sex character(1),
    parent_tels character varying(40),
    parent_email character varying(100),
    parent_religion character varying(100),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    parent_address text
);


ALTER TABLE parent OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 148457)
-- Name: parent_parent_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE parent_parent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE parent_parent_id_seq OWNER TO postgres;

--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 204
-- Name: parent_parent_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE parent_parent_id_seq OWNED BY parent.parent_id;


--
-- TOC entry 205 (class 1259 OID 148459)
-- Name: parent_student; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE parent_student (
    parent_student_id integer NOT NULL,
    parent_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE parent_student OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 148462)
-- Name: parent_student_parent_student_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE parent_student_parent_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE parent_student_parent_student_id_seq OWNER TO postgres;

--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 206
-- Name: parent_student_parent_student_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE parent_student_parent_student_id_seq OWNED BY parent_student.parent_student_id;


--
-- TOC entry 207 (class 1259 OID 148464)
-- Name: payment_employee; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE payment_employee (
    payment_employee_id integer NOT NULL,
    employee_id integer,
    payment_employee_value double precision NOT NULL,
    payment_employee_details character varying(100),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE payment_employee OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 148467)
-- Name: payment_employee_payment_employee_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE payment_employee_payment_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment_employee_payment_employee_id_seq OWNER TO postgres;

--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 208
-- Name: payment_employee_payment_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE payment_employee_payment_employee_id_seq OWNED BY payment_employee.payment_employee_id;


--
-- TOC entry 209 (class 1259 OID 148469)
-- Name: payment_periode; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE payment_periode (
    payment_periode_id integer NOT NULL,
    institution_class_id integer,
    periode_id integer NOT NULL,
    payment_periode_value double precision,
    payment_periode_date_start date,
    payment_periode_date_end date,
    payment_periode_details character varying(200),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE payment_periode OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 148472)
-- Name: payment_periode_payment_periode_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE payment_periode_payment_periode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment_periode_payment_periode_id_seq OWNER TO postgres;

--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 210
-- Name: payment_periode_payment_periode_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE payment_periode_payment_periode_id_seq OWNED BY payment_periode.payment_periode_id;


--
-- TOC entry 211 (class 1259 OID 148474)
-- Name: payment_student; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE payment_student (
    payment_student_id integer NOT NULL,
    student_id integer,
    payment_student_value double precision NOT NULL,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE payment_student OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 148477)
-- Name: payment_student_payment_student_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE payment_student_payment_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE payment_student_payment_student_id_seq OWNER TO postgres;

--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 212
-- Name: payment_student_payment_student_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE payment_student_payment_student_id_seq OWNED BY payment_student.payment_student_id;


--
-- TOC entry 213 (class 1259 OID 148479)
-- Name: penality; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE penality (
    penalty_id integer NOT NULL,
    penality_type_id integer,
    penalty_desc text,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE penality OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 148485)
-- Name: penality_penalty_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE penality_penalty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE penality_penalty_id_seq OWNER TO postgres;

--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 214
-- Name: penality_penalty_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE penality_penalty_id_seq OWNED BY penality.penalty_id;


--
-- TOC entry 215 (class 1259 OID 148487)
-- Name: penality_type; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE penality_type (
    penality_type_id integer NOT NULL,
    penality_type_name character varying(45),
    penality_type_desc text,
    penality_type_fee double precision,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE penality_type OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 148493)
-- Name: penality_type_penality_type_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE penality_type_penality_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE penality_type_penality_type_id_seq OWNER TO postgres;

--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 216
-- Name: penality_type_penality_type_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE penality_type_penality_type_id_seq OWNED BY penality_type.penality_type_id;


--
-- TOC entry 231 (class 1259 OID 148824)
-- Name: periode; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE periode (
    periode_id integer NOT NULL,
    institution_id integer NOT NULL,
    periode_no integer NOT NULL,
    periode_name character varying(100),
    periode_dstart date,
    periode_dend date,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE periode OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 148822)
-- Name: periode_periode_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE periode_periode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE periode_periode_id_seq OWNER TO postgres;

--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 230
-- Name: periode_periode_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE periode_periode_id_seq OWNED BY periode.periode_id;


--
-- TOC entry 217 (class 1259 OID 148495)
-- Name: person_ref; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE person_ref (
    person_ref_id integer NOT NULL,
    person_ref_firstname character varying(40) NOT NULL,
    person_ref_lastname character varying(40) NOT NULL,
    person_ref_sex character(1),
    person_ref_tels character varying(40),
    person_ref_email character varying(100),
    person_ref_addr character varying(100),
    person_ref_desc character varying(100) NOT NULL,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    person_ref_address text
);


ALTER TABLE person_ref OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 148501)
-- Name: person_ref_person_ref_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE person_ref_person_ref_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person_ref_person_ref_id_seq OWNER TO postgres;

--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 218
-- Name: person_ref_person_ref_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE person_ref_person_ref_id_seq OWNED BY person_ref.person_ref_id;


--
-- TOC entry 219 (class 1259 OID 148503)
-- Name: student; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE student (
    student_id integer NOT NULL,
    institution_id integer NOT NULL,
    parent_id integer,
    person_ref_id integer,
    institution_class_id integer NOT NULL,
    student_firstname character varying(40) NOT NULL,
    student_lastname character varying(40) NOT NULL,
    student_birthday date NOT NULL,
    student_birthplace character varying(100),
    student_sex character(1),
    student_mother_tonge character varying(45),
    student_skills character varying(200),
    student_tels character varying(40),
    student_email character varying(100),
    student_addr character varying(100),
    student_religion character varying(20),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    student_img character varying(100),
    student_active boolean,
    parentf_id integer,
    student_address text
);


ALTER TABLE student OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 148509)
-- Name: student_penality; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE student_penality (
    penality_id integer NOT NULL,
    penality_type_id integer,
    student_id integer,
    penality_desc text,
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone
);


ALTER TABLE student_penality OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 148515)
-- Name: student_penality_penalty_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE student_penality_penalty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE student_penality_penalty_id_seq OWNER TO postgres;

--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 221
-- Name: student_penality_penalty_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE student_penality_penalty_id_seq OWNED BY student_penality.penality_id;


--
-- TOC entry 222 (class 1259 OID 148517)
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE student_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE student_student_id_seq OWNER TO postgres;

--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 222
-- Name: student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE student_student_id_seq OWNED BY student.student_id;


--
-- TOC entry 223 (class 1259 OID 148519)
-- Name: teach_cours; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE teach_cours (
    teach_cours_id integer NOT NULL,
    teacher_id integer NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE teach_cours OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 148522)
-- Name: teach_cours_teach_cours_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE teach_cours_teach_cours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teach_cours_teach_cours_id_seq OWNER TO postgres;

--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 224
-- Name: teach_cours_teach_cours_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE teach_cours_teach_cours_id_seq OWNED BY teach_cours.teach_cours_id;


--
-- TOC entry 225 (class 1259 OID 148524)
-- Name: teach_in_class; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE teach_in_class (
    teach_in_class_id integer NOT NULL,
    teacher_id integer NOT NULL,
    institution_class_id integer NOT NULL
);


ALTER TABLE teach_in_class OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 148527)
-- Name: teach_in_class_teach_in_class_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE teach_in_class_teach_in_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teach_in_class_teach_in_class_id_seq OWNER TO postgres;

--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 226
-- Name: teach_in_class_teach_in_class_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE teach_in_class_teach_in_class_id_seq OWNED BY teach_in_class.teach_in_class_id;


--
-- TOC entry 227 (class 1259 OID 148529)
-- Name: teacher; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE teacher (
    teacher_id integer NOT NULL,
    address_id integer NOT NULL,
    teacher_firstname character varying(40) NOT NULL,
    teacher_lastname character varying(40) NOT NULL,
    teacher_level character varying(20) NOT NULL,
    teacher_domain character varying(60) NOT NULL,
    teacher_birthday date NOT NULL,
    teacher_sex character(1),
    teacher_tels character varying(40),
    teacher_email character varying(100),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    teacher_active boolean
);


ALTER TABLE teacher OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 148532)
-- Name: teacher_teacher_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE teacher_teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE teacher_teacher_id_seq OWNER TO postgres;

--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 228
-- Name: teacher_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE teacher_teacher_id_seq OWNED BY teacher.teacher_id;


--
-- TOC entry 229 (class 1259 OID 148534)
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_user_id_seq OWNER TO postgres;

--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 229
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE user_user_id_seq OWNED BY huser.user_id;


--
-- TOC entry 3115 (class 2604 OID 148536)
-- Name: absence_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY absence ALTER COLUMN absence_id SET DEFAULT nextval('absence_absence_id_seq'::regclass);


--
-- TOC entry 3116 (class 2604 OID 148537)
-- Name: address_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY address ALTER COLUMN address_id SET DEFAULT nextval('address_address_id_seq'::regclass);


--
-- TOC entry 3117 (class 2604 OID 148538)
-- Name: class_cours_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_cours ALTER COLUMN class_cours_id SET DEFAULT nextval('class_cours_class_cours_id_seq'::regclass);


--
-- TOC entry 3119 (class 2604 OID 148539)
-- Name: cours_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY cours ALTER COLUMN cours_id SET DEFAULT nextval('cours_cours_id_seq'::regclass);


--
-- TOC entry 3120 (class 2604 OID 148540)
-- Name: employee_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee ALTER COLUMN employee_id SET DEFAULT nextval('employee_employee_id_seq'::regclass);


--
-- TOC entry 3121 (class 2604 OID 148541)
-- Name: employee_salary_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee_salary ALTER COLUMN employee_salary_id SET DEFAULT nextval('employee_salary_employee_salary_id_seq'::regclass);


--
-- TOC entry 3122 (class 2604 OID 148542)
-- Name: event_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY event ALTER COLUMN event_id SET DEFAULT nextval('event_event_id_seq'::regclass);


--
-- TOC entry 3123 (class 2604 OID 148543)
-- Name: user_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY huser ALTER COLUMN user_id SET DEFAULT nextval('user_user_id_seq'::regclass);


--
-- TOC entry 3124 (class 2604 OID 148544)
-- Name: institution_class_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution_class ALTER COLUMN institution_class_id SET DEFAULT nextval('institution_class_institution_class_id_seq'::regclass);


--
-- TOC entry 3125 (class 2604 OID 148545)
-- Name: parent_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent ALTER COLUMN parent_id SET DEFAULT nextval('parent_parent_id_seq'::regclass);


--
-- TOC entry 3126 (class 2604 OID 148546)
-- Name: parent_student_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student ALTER COLUMN parent_student_id SET DEFAULT nextval('parent_student_parent_student_id_seq'::regclass);


--
-- TOC entry 3118 (class 2604 OID 148547)
-- Name: payment_class_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class ALTER COLUMN payment_class_id SET DEFAULT nextval('class_payment_class_payment_id_seq'::regclass);


--
-- TOC entry 3127 (class 2604 OID 148548)
-- Name: payment_employee_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_employee ALTER COLUMN payment_employee_id SET DEFAULT nextval('payment_employee_payment_employee_id_seq'::regclass);


--
-- TOC entry 3128 (class 2604 OID 148549)
-- Name: payment_periode_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_periode ALTER COLUMN payment_periode_id SET DEFAULT nextval('payment_periode_payment_periode_id_seq'::regclass);


--
-- TOC entry 3129 (class 2604 OID 148550)
-- Name: payment_student_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_student ALTER COLUMN payment_student_id SET DEFAULT nextval('payment_student_payment_student_id_seq'::regclass);


--
-- TOC entry 3130 (class 2604 OID 148551)
-- Name: penalty_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality ALTER COLUMN penalty_id SET DEFAULT nextval('penality_penalty_id_seq'::regclass);


--
-- TOC entry 3131 (class 2604 OID 148552)
-- Name: penality_type_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality_type ALTER COLUMN penality_type_id SET DEFAULT nextval('penality_type_penality_type_id_seq'::regclass);


--
-- TOC entry 3138 (class 2604 OID 148827)
-- Name: periode_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode ALTER COLUMN periode_id SET DEFAULT nextval('periode_periode_id_seq'::regclass);


--
-- TOC entry 3132 (class 2604 OID 148553)
-- Name: person_ref_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY person_ref ALTER COLUMN person_ref_id SET DEFAULT nextval('person_ref_person_ref_id_seq'::regclass);


--
-- TOC entry 3133 (class 2604 OID 148554)
-- Name: student_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student ALTER COLUMN student_id SET DEFAULT nextval('student_student_id_seq'::regclass);


--
-- TOC entry 3134 (class 2604 OID 148555)
-- Name: penality_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality ALTER COLUMN penality_id SET DEFAULT nextval('student_penality_penalty_id_seq'::regclass);


--
-- TOC entry 3135 (class 2604 OID 148556)
-- Name: teach_cours_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours ALTER COLUMN teach_cours_id SET DEFAULT nextval('teach_cours_teach_cours_id_seq'::regclass);


--
-- TOC entry 3136 (class 2604 OID 148557)
-- Name: teach_in_class_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class ALTER COLUMN teach_in_class_id SET DEFAULT nextval('teach_in_class_teach_in_class_id_seq'::regclass);


--
-- TOC entry 3137 (class 2604 OID 148558)
-- Name: teacher_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher ALTER COLUMN teacher_id SET DEFAULT nextval('teacher_teacher_id_seq'::regclass);



SELECT pg_catalog.setval('absence_absence_id_seq', 3, true);

SELECT pg_catalog.setval('address_address_id_seq', 81, true);


SELECT pg_catalog.setval('class_cours_class_cours_id_seq', 1, false);


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 188
-- Name: class_payment_class_payment_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('class_payment_class_payment_id_seq', 12, true);


--
-- TOC entry 3357 (class 0 OID 148395)
-- Dependencies: 189
-- Data for Name: cours; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--



--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 190
-- Name: cours_cours_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('cours_cours_id_seq', 1, false);


SELECT pg_catalog.setval('employee_employee_id_seq', 22, true);



SELECT pg_catalog.setval('employee_salary_employee_salary_id_seq', 13, true);


SELECT pg_catalog.setval('event_event_id_seq', 2, true);


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 197
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 35, true);


--
-- TOC entry 3366 (class 0 OID 148426)
-- Dependencies: 198
-- Data for Name: huser; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

INSERT INTO huser (user_id, user_privilege, user_firstname, user_lastname, user_title, user_sex, user_phone, user_email, user_username, user_password, user_code, user_img, user_details, user_active, created_by, date_created, modified_by, date_modified) VALUES (4, 1, 'Lae', 'Pro', '', 'M', '367292645', 'laepro@gmail.com', 'laepro', 'd85bbcd3c9ecb343bf86d0eb15b334b6d964850e', NULL, NULL, NULL, true, 'TizonDife', '2017-10-11 13:04:15', 'TizonDife', '2018-01-27 09:27:18');


SELECT pg_catalog.setval('institution_class_institution_class_id_seq', 22, true);


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 202
-- Name: institution_institution_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('institution_institution_id_seq', 1, true);



SELECT pg_catalog.setval('parent_parent_id_seq', 37, true);


SELECT pg_catalog.setval('parent_student_parent_student_id_seq', 1, false);


--
-- TOC entry 3355 (class 0 OID 148390)
-- Dependencies: 187
-- Data for Name: payment_class; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('payment_employee_payment_employee_id_seq', 11, true);


SELECT pg_catalog.setval('payment_periode_payment_periode_id_seq', 6, true);

SELECT pg_catalog.setval('payment_student_payment_student_id_seq', 17, true);


--
-- TOC entry 3381 (class 0 OID 148479)
-- Dependencies: 213
-- Data for Name: penality; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--



--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 214
-- Name: penality_penalty_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('penality_penalty_id_seq', 1, false);

SELECT pg_catalog.setval('penality_type_penality_type_id_seq', 5, true);


SELECT pg_catalog.setval('periode_periode_id_seq', 1, true);


SELECT pg_catalog.setval('person_ref_person_ref_id_seq', 21, true);


SELECT pg_catalog.setval('student_penality_penalty_id_seq', 6, true);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 222
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('student_student_id_seq', 13, true);


SELECT pg_catalog.setval('teach_cours_teach_cours_id_seq', 1, false);



SELECT pg_catalog.setval('teach_in_class_teach_in_class_id_seq', 1, false);

SELECT pg_catalog.setval('teacher_teacher_id_seq', 2, true);


SELECT pg_catalog.setval('user_user_id_seq', 7, true);


ALTER TABLE ONLY absence
    ADD CONSTRAINT absence_pkey PRIMARY KEY (absence_id);


--
-- TOC entry 3142 (class 2606 OID 148562)
-- Name: address_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 3144 (class 2606 OID 148564)
-- Name: class_cours_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_cours
    ADD CONSTRAINT class_cours_pkey PRIMARY KEY (class_cours_id);


--
-- TOC entry 3146 (class 2606 OID 148566)
-- Name: class_payment_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class
    ADD CONSTRAINT class_payment_pkey PRIMARY KEY (payment_class_id);


--
-- TOC entry 3150 (class 2606 OID 148568)
-- Name: cours_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY cours
    ADD CONSTRAINT cours_pkey PRIMARY KEY (cours_id);


--
-- TOC entry 3204 (class 2606 OID 148842)
-- Name: course_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- TOC entry 3152 (class 2606 OID 148570)
-- Name: employee_employee_card_id_employee_tels_employee_email_key; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_employee_card_id_employee_tels_employee_email_key UNIQUE (employee_card_id, employee_tels, employee_email);


--
-- TOC entry 3154 (class 2606 OID 148572)
-- Name: employee_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3156 (class 2606 OID 148574)
-- Name: employee_salary_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee_salary
    ADD CONSTRAINT employee_salary_pkey PRIMARY KEY (employee_salary_id);


--
-- TOC entry 3158 (class 2606 OID 148576)
-- Name: event_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3166 (class 2606 OID 148578)
-- Name: institution_class_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution_class
    ADD CONSTRAINT institution_class_pkey PRIMARY KEY (institution_class_id);


--
-- TOC entry 3164 (class 2606 OID 148580)
-- Name: institution_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (institution_id);


--
-- TOC entry 3168 (class 2606 OID 148584)
-- Name: parent_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent
    ADD CONSTRAINT parent_pkey PRIMARY KEY (parent_id);


--
-- TOC entry 3172 (class 2606 OID 148586)
-- Name: parent_student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student
    ADD CONSTRAINT parent_student_pkey PRIMARY KEY (parent_student_id);


ALTER TABLE ONLY payment_employee
    ADD CONSTRAINT payment_employee_pkey PRIMARY KEY (payment_employee_id);


--
-- TOC entry 3176 (class 2606 OID 148592)
-- Name: payment_periode_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_periode
    ADD CONSTRAINT payment_periode_pkey PRIMARY KEY (payment_periode_id);


--
-- TOC entry 3178 (class 2606 OID 148594)
-- Name: payment_student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_student
    ADD CONSTRAINT payment_student_pkey PRIMARY KEY (payment_student_id);


--
-- TOC entry 3190 (class 2606 OID 148596)
-- Name: penality_student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality
    ADD CONSTRAINT penality_student_pkey PRIMARY KEY (penality_id);


--
-- TOC entry 3180 (class 2606 OID 148598)
-- Name: penality_type_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality_type
    ADD CONSTRAINT penality_type_pkey PRIMARY KEY (penality_type_id);


--
-- TOC entry 3200 (class 2606 OID 148829)
-- Name: periode_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT periode_pkey PRIMARY KEY (periode_id);


--
-- TOC entry 3182 (class 2606 OID 148600)
-- Name: person_ref_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY person_ref
    ADD CONSTRAINT person_ref_pkey PRIMARY KEY (person_ref_id);

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


ALTER TABLE ONLY teach_in_class
    ADD CONSTRAINT teach_in_class_pkey PRIMARY KEY (teach_in_class_id);


--
-- TOC entry 3192 (class 2606 OID 148854)
-- Name: teacher_course_pk; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours
    ADD CONSTRAINT teacher_course_pk PRIMARY KEY (course_id);


--
-- TOC entry 3196 (class 2606 OID 148612)
-- Name: teacher_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id);


--
-- TOC entry 3198 (class 2606 OID 148614)
-- Name: teacher_tel_email_uq; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_tel_email_uq UNIQUE (teacher_tels, teacher_email);


--
-- TOC entry 3202 (class 2606 OID 156994)
-- Name: ukey_no; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT ukey_no UNIQUE (periode_no);


--
-- TOC entry 3148 (class 2606 OID 148616)
-- Name: unique_class_payment_id; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class
    ADD CONSTRAINT unique_class_payment_id UNIQUE (institution_class_id);


--
-- TOC entry 3160 (class 2606 OID 148618)
-- Name: user_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY huser
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3162 (class 2606 OID 148620)
-- Name: username_uq_key; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY huser
    ADD CONSTRAINT username_uq_key UNIQUE (user_username);


--
-- TOC entry 3206 (class 2606 OID 148860)
-- Name: class_course_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_cours
    ADD CONSTRAINT class_course_fk FOREIGN KEY (class_cours_id) REFERENCES course(course_id);


--
-- TOC entry 3234 (class 2606 OID 148848)
-- Name: course_inst_class_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_inst_class_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3233 (class 2606 OID 148843)
-- Name: course_periode_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_periode_fk FOREIGN KEY (periode_id) REFERENCES periode(periode_id) ON DELETE CASCADE;


--
-- TOC entry 3209 (class 2606 OID 148621)
-- Name: employee_addr_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_addr_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- TOC entry 3205 (class 2606 OID 148626)
-- Name: fk_absence_std; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY absence
    ADD CONSTRAINT fk_absence_std FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;


--
-- TOC entry 3210 (class 2606 OID 148631)
-- Name: fk_employe_salary; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee_salary
    ADD CONSTRAINT fk_employe_salary FOREIGN KEY (employee_id) REFERENCES employee(employee_id);


--
-- TOC entry 3208 (class 2606 OID 148636)
-- Name: fk_payment_institution_class; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class
    ADD CONSTRAINT fk_payment_institution_class FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3218 (class 2606 OID 148641)
-- Name: fk_payment_student; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_student
    ADD CONSTRAINT fk_payment_student FOREIGN KEY (student_id) REFERENCES student(student_id);


--
-- TOC entry 3225 (class 2606 OID 148646)
-- Name: fk_penality_student; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality
    ADD CONSTRAINT fk_penality_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;


--
-- TOC entry 3226 (class 2606 OID 148651)
-- Name: fk_penality_type; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality
    ADD CONSTRAINT fk_penality_type FOREIGN KEY (penality_type_id) REFERENCES penality_type(penality_type_id) ON DELETE CASCADE;


--
-- TOC entry 3219 (class 2606 OID 148656)
-- Name: fk_penality_type2; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality
    ADD CONSTRAINT fk_penality_type2 FOREIGN KEY (penality_type_id) REFERENCES penality_type(penality_type_id) ON DELETE CASCADE;


--
-- TOC entry 3212 (class 2606 OID 148661)
-- Name: inst_addr_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT inst_addr_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- TOC entry 3217 (class 2606 OID 148666)
-- Name: inst_class_periode_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_periode
    ADD CONSTRAINT inst_class_periode_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3213 (class 2606 OID 148671)
-- Name: institution_class_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution_class
    ADD CONSTRAINT institution_class_fk FOREIGN KEY (institution_id) REFERENCES institution(institution_id) ON DELETE CASCADE;


--
-- TOC entry 3214 (class 2606 OID 148706)
-- Name: parent_student_pr_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student
    ADD CONSTRAINT parent_student_pr_fk FOREIGN KEY (parent_id) REFERENCES parent(parent_id) ON DELETE CASCADE;


--
-- TOC entry 3215 (class 2606 OID 148711)
-- Name: parent_student_st_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student
    ADD CONSTRAINT parent_student_st_fk FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;


--
-- TOC entry 3216 (class 2606 OID 148716)
-- Name: payment_employee_employee_id_fkey; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_employee
    ADD CONSTRAINT payment_employee_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE;


--
-- TOC entry 3232 (class 2606 OID 148830)
-- Name: periode_inst_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT periode_inst_fk FOREIGN KEY (institution_id) REFERENCES institution(institution_id) ON DELETE CASCADE;


--
-- TOC entry 3220 (class 2606 OID 148721)
-- Name: student_class_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_class_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3221 (class 2606 OID 148726)
-- Name: student_inst_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_inst_fk FOREIGN KEY (institution_id) REFERENCES institution(institution_id) ON DELETE CASCADE;


--
-- TOC entry 3222 (class 2606 OID 148731)
-- Name: student_parent_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_parent_fk FOREIGN KEY (parent_id) REFERENCES parent(parent_id) ON DELETE CASCADE;


--
-- TOC entry 3223 (class 2606 OID 148736)
-- Name: student_parentf_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_parentf_fk FOREIGN KEY (parentf_id) REFERENCES parent(parent_id);


--
-- TOC entry 3224 (class 2606 OID 148741)
-- Name: student_personf_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_personf_fk FOREIGN KEY (person_ref_id) REFERENCES person_ref(person_ref_id) ON DELETE CASCADE;


--
-- TOC entry 3207 (class 2606 OID 148756)
-- Name: teach_crs_inst_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_cours
    ADD CONSTRAINT teach_crs_inst_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3228 (class 2606 OID 148761)
-- Name: teach_crs_th_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours
    ADD CONSTRAINT teach_crs_th_fk FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id) ON DELETE CASCADE;


--
-- TOC entry 3229 (class 2606 OID 148766)
-- Name: teach_in_ch_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class
    ADD CONSTRAINT teach_in_ch_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3230 (class 2606 OID 148771)
-- Name: teach_in_th_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class
    ADD CONSTRAINT teach_in_th_fk FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id) ON DELETE CASCADE;


--
-- TOC entry 3231 (class 2606 OID 148776)
-- Name: teacher_add_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_add_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- TOC entry 3227 (class 2606 OID 148855)
-- Name: teacher_course_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours
    ADD CONSTRAINT teacher_course_fk FOREIGN KEY (course_id) REFERENCES course(course_id);


--
-- TOC entry 3211 (class 2606 OID 148781)
-- Name: user_event_fkey; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT user_event_fkey FOREIGN KEY (user_id) REFERENCES huser(user_id) ON DELETE CASCADE;


-- Completed on 2018-06-17 00:47:41 EDT

--
-- PostgreSQL database dump complete
--

