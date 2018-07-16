--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

-- Started on 2018-07-01 06:35:20 EDT

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
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA lae_db; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA lae_db IS 'standard public schema';


SET search_path = lae_db, pg_catalog;

--
-- TOC entry 245 (class 1255 OID 148366)
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
-- TOC entry 250 (class 1255 OID 165633)
-- Name: createstudent(integer, integer, integer, integer, character varying, character varying, date, character varying, character, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, character varying, timestamp without time zone, character varying, boolean, integer, text, text); Type: FUNCTION; Schema: lae_db; Owner: postgres
--

CREATE FUNCTION createstudent(ins_id integer, par_id integer, pref_id integer, inscid integer, std_firstname character varying, std_lastname character varying, std_birthday date, std_birthplace character varying, std_sex character, std_mtonge character varying, std_skills character varying, std_tels character varying, std_email character varying, std_addr character varying, std_religion character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, std_img character varying, std_active boolean, pf_id integer, std_address text, old_school text) RETURNS integer
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
            student_address,
            student_old_school)
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
                std_address,
            	old_school);
            SELECT CURRVAL('lae_db.student_student_id_seq') into tmp;
            RETURN tmp;
        END IF;
   END;
$$;


ALTER FUNCTION lae_db.createstudent(ins_id integer, par_id integer, pref_id integer, inscid integer, std_firstname character varying, std_lastname character varying, std_birthday date, std_birthplace character varying, std_sex character, std_mtonge character varying, std_skills character varying, std_tels character varying, std_email character varying, std_addr character varying, std_religion character varying, cby character varying, dcreated timestamp without time zone, mby character varying, dmodified timestamp without time zone, std_img character varying, std_active boolean, pf_id integer, std_address text, old_school text) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 148368)
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
-- TOC entry 247 (class 1255 OID 148369)
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
-- TOC entry 248 (class 1255 OID 148370)
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
-- TOC entry 249 (class 1255 OID 148371)
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
-- TOC entry 3395 (class 0 OID 0)
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
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 184
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE address_address_id_seq OWNED BY address.address_id;


--
-- TOC entry 185 (class 1259 OID 148385)
-- Name: class_course; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE class_course (
    class_course_id integer NOT NULL,
    institution_class_id integer NOT NULL,
    course_id integer NOT NULL,
    class_course_details character varying(200),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    date_start timestamp(6) without time zone,
    date_end timestamp(6) without time zone,
    teacher_id integer NOT NULL
);


ALTER TABLE class_course OWNER TO postgres;

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
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 186
-- Name: class_cours_class_cours_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE class_cours_class_cours_id_seq OWNED BY class_course.class_course_id;


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
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 188
-- Name: class_payment_class_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE class_payment_class_payment_id_seq OWNED BY payment_class.payment_class_id;


--
-- TOC entry 231 (class 1259 OID 165640)
-- Name: course; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE course (
    course_id integer NOT NULL,
    periode_id integer,
    institution_class_id integer,
    course_title character varying(100) NOT NULL,
    course_short_name character varying(25),
    course_desc character varying(400),
    created_by character varying(45),
    date_created timestamp(6) without time zone,
    modified_by character varying(45),
    date_modified timestamp(6) without time zone,
    course_level character varying(100),
    course_credit_hours character varying(20)
);


ALTER TABLE course OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 165638)
-- Name: course_course_id_seq; Type: SEQUENCE; Schema: lae_db; Owner: postgres
--

CREATE SEQUENCE course_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE course_course_id_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 230
-- Name: course_course_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE course_course_id_seq OWNED BY course.course_id;


--
-- TOC entry 189 (class 1259 OID 148403)
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
-- TOC entry 190 (class 1259 OID 148409)
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
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 190
-- Name: employee_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE employee_employee_id_seq OWNED BY employee.employee_id;


--
-- TOC entry 191 (class 1259 OID 148411)
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
-- TOC entry 192 (class 1259 OID 148414)
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
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 192
-- Name: employee_salary_employee_salary_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE employee_salary_employee_salary_id_seq OWNED BY employee_salary.employee_salary_id;


--
-- TOC entry 193 (class 1259 OID 148416)
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
-- TOC entry 194 (class 1259 OID 148422)
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
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 194
-- Name: event_event_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE event_event_id_seq OWNED BY event.event_id;


--
-- TOC entry 195 (class 1259 OID 148424)
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
-- TOC entry 196 (class 1259 OID 148426)
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
-- TOC entry 197 (class 1259 OID 148432)
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
-- TOC entry 198 (class 1259 OID 148438)
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
-- TOC entry 199 (class 1259 OID 148441)
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
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 199
-- Name: institution_class_institution_class_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE institution_class_institution_class_id_seq OWNED BY institution_class.institution_class_id;


--
-- TOC entry 200 (class 1259 OID 148443)
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
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 200
-- Name: institution_institution_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE institution_institution_id_seq OWNED BY institution.institution_id;


--
-- TOC entry 201 (class 1259 OID 148451)
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
-- TOC entry 202 (class 1259 OID 148457)
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
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 202
-- Name: parent_parent_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE parent_parent_id_seq OWNED BY parent.parent_id;


--
-- TOC entry 203 (class 1259 OID 148459)
-- Name: parent_student; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE parent_student (
    parent_student_id integer NOT NULL,
    parent_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE parent_student OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 148462)
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
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 204
-- Name: parent_student_parent_student_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE parent_student_parent_student_id_seq OWNED BY parent_student.parent_student_id;


--
-- TOC entry 205 (class 1259 OID 148464)
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
-- TOC entry 206 (class 1259 OID 148467)
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
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 206
-- Name: payment_employee_payment_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE payment_employee_payment_employee_id_seq OWNED BY payment_employee.payment_employee_id;


--
-- TOC entry 207 (class 1259 OID 148469)
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
-- TOC entry 208 (class 1259 OID 148472)
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
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 208
-- Name: payment_periode_payment_periode_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE payment_periode_payment_periode_id_seq OWNED BY payment_periode.payment_periode_id;


--
-- TOC entry 209 (class 1259 OID 148474)
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
-- TOC entry 210 (class 1259 OID 148477)
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
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 210
-- Name: payment_student_payment_student_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE payment_student_payment_student_id_seq OWNED BY payment_student.payment_student_id;


--
-- TOC entry 211 (class 1259 OID 148479)
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
-- TOC entry 212 (class 1259 OID 148485)
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
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 212
-- Name: penality_penalty_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE penality_penalty_id_seq OWNED BY penality.penalty_id;


--
-- TOC entry 213 (class 1259 OID 148487)
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
-- TOC entry 214 (class 1259 OID 148493)
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
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 214
-- Name: penality_type_penality_type_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE penality_type_penality_type_id_seq OWNED BY penality_type.penality_type_id;


--
-- TOC entry 229 (class 1259 OID 148824)
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
-- TOC entry 228 (class 1259 OID 148822)
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
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 228
-- Name: periode_periode_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE periode_periode_id_seq OWNED BY periode.periode_id;


--
-- TOC entry 215 (class 1259 OID 148495)
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
-- TOC entry 216 (class 1259 OID 148501)
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
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 216
-- Name: person_ref_person_ref_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE person_ref_person_ref_id_seq OWNED BY person_ref.person_ref_id;


--
-- TOC entry 217 (class 1259 OID 148503)
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
    student_address text,
    student_old_school text
);


ALTER TABLE student OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 148509)
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
-- TOC entry 219 (class 1259 OID 148515)
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
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 219
-- Name: student_penality_penalty_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE student_penality_penalty_id_seq OWNED BY student_penality.penality_id;


--
-- TOC entry 220 (class 1259 OID 148517)
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
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 220
-- Name: student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE student_student_id_seq OWNED BY student.student_id;


--
-- TOC entry 221 (class 1259 OID 148519)
-- Name: teach_cours; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE teach_cours (
    teach_cours_id integer NOT NULL,
    teacher_id integer NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE teach_cours OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 148522)
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
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 222
-- Name: teach_cours_teach_cours_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE teach_cours_teach_cours_id_seq OWNED BY teach_cours.teach_cours_id;


--
-- TOC entry 223 (class 1259 OID 148524)
-- Name: teach_in_class; Type: TABLE; Schema: lae_db; Owner: postgres
--

CREATE TABLE teach_in_class (
    teach_in_class_id integer NOT NULL,
    teacher_id integer NOT NULL,
    institution_class_id integer NOT NULL
);


ALTER TABLE teach_in_class OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 148527)
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
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 224
-- Name: teach_in_class_teach_in_class_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE teach_in_class_teach_in_class_id_seq OWNED BY teach_in_class.teach_in_class_id;


--
-- TOC entry 225 (class 1259 OID 148529)
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
-- TOC entry 226 (class 1259 OID 148532)
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
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 226
-- Name: teacher_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE teacher_teacher_id_seq OWNED BY teacher.teacher_id;


--
-- TOC entry 227 (class 1259 OID 148534)
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
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 227
-- Name: user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: lae_db; Owner: postgres
--

ALTER SEQUENCE user_user_id_seq OWNED BY huser.user_id;


--
-- TOC entry 3110 (class 2604 OID 148536)
-- Name: absence_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY absence ALTER COLUMN absence_id SET DEFAULT nextval('absence_absence_id_seq'::regclass);


--
-- TOC entry 3111 (class 2604 OID 148537)
-- Name: address_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY address ALTER COLUMN address_id SET DEFAULT nextval('address_address_id_seq'::regclass);


--
-- TOC entry 3112 (class 2604 OID 148538)
-- Name: class_course_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_course ALTER COLUMN class_course_id SET DEFAULT nextval('class_cours_class_cours_id_seq'::regclass);


--
-- TOC entry 3133 (class 2604 OID 165643)
-- Name: course_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course ALTER COLUMN course_id SET DEFAULT nextval('course_course_id_seq'::regclass);


--
-- TOC entry 3114 (class 2604 OID 148540)
-- Name: employee_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee ALTER COLUMN employee_id SET DEFAULT nextval('employee_employee_id_seq'::regclass);


--
-- TOC entry 3115 (class 2604 OID 148541)
-- Name: employee_salary_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee_salary ALTER COLUMN employee_salary_id SET DEFAULT nextval('employee_salary_employee_salary_id_seq'::regclass);


--
-- TOC entry 3116 (class 2604 OID 148542)
-- Name: event_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY event ALTER COLUMN event_id SET DEFAULT nextval('event_event_id_seq'::regclass);


--
-- TOC entry 3117 (class 2604 OID 148543)
-- Name: user_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY huser ALTER COLUMN user_id SET DEFAULT nextval('user_user_id_seq'::regclass);


--
-- TOC entry 3118 (class 2604 OID 148544)
-- Name: institution_class_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution_class ALTER COLUMN institution_class_id SET DEFAULT nextval('institution_class_institution_class_id_seq'::regclass);


--
-- TOC entry 3119 (class 2604 OID 148545)
-- Name: parent_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent ALTER COLUMN parent_id SET DEFAULT nextval('parent_parent_id_seq'::regclass);


--
-- TOC entry 3120 (class 2604 OID 148546)
-- Name: parent_student_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student ALTER COLUMN parent_student_id SET DEFAULT nextval('parent_student_parent_student_id_seq'::regclass);


--
-- TOC entry 3113 (class 2604 OID 148547)
-- Name: payment_class_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class ALTER COLUMN payment_class_id SET DEFAULT nextval('class_payment_class_payment_id_seq'::regclass);


--
-- TOC entry 3121 (class 2604 OID 148548)
-- Name: payment_employee_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_employee ALTER COLUMN payment_employee_id SET DEFAULT nextval('payment_employee_payment_employee_id_seq'::regclass);


--
-- TOC entry 3122 (class 2604 OID 148549)
-- Name: payment_periode_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_periode ALTER COLUMN payment_periode_id SET DEFAULT nextval('payment_periode_payment_periode_id_seq'::regclass);


--
-- TOC entry 3123 (class 2604 OID 148550)
-- Name: payment_student_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_student ALTER COLUMN payment_student_id SET DEFAULT nextval('payment_student_payment_student_id_seq'::regclass);


--
-- TOC entry 3124 (class 2604 OID 148551)
-- Name: penalty_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality ALTER COLUMN penalty_id SET DEFAULT nextval('penality_penalty_id_seq'::regclass);


--
-- TOC entry 3125 (class 2604 OID 148552)
-- Name: penality_type_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality_type ALTER COLUMN penality_type_id SET DEFAULT nextval('penality_type_penality_type_id_seq'::regclass);


--
-- TOC entry 3132 (class 2604 OID 148827)
-- Name: periode_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode ALTER COLUMN periode_id SET DEFAULT nextval('periode_periode_id_seq'::regclass);


--
-- TOC entry 3126 (class 2604 OID 148553)
-- Name: person_ref_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY person_ref ALTER COLUMN person_ref_id SET DEFAULT nextval('person_ref_person_ref_id_seq'::regclass);


--
-- TOC entry 3127 (class 2604 OID 148554)
-- Name: student_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student ALTER COLUMN student_id SET DEFAULT nextval('student_student_id_seq'::regclass);


--
-- TOC entry 3128 (class 2604 OID 148555)
-- Name: penality_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality ALTER COLUMN penality_id SET DEFAULT nextval('student_penality_penalty_id_seq'::regclass);


--
-- TOC entry 3129 (class 2604 OID 148556)
-- Name: teach_cours_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours ALTER COLUMN teach_cours_id SET DEFAULT nextval('teach_cours_teach_cours_id_seq'::regclass);


--
-- TOC entry 3130 (class 2604 OID 148557)
-- Name: teach_in_class_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class ALTER COLUMN teach_in_class_id SET DEFAULT nextval('teach_in_class_teach_in_class_id_seq'::regclass);


--
-- TOC entry 3131 (class 2604 OID 148558)
-- Name: teacher_id; Type: DEFAULT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher ALTER COLUMN teacher_id SET DEFAULT nextval('teacher_teacher_id_seq'::regclass);


--
-- TOC entry 3339 (class 0 OID 148372)
-- Dependencies: 181
-- Data for Name: absence; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY absence (absence_id, student_id, absence_motif, absence_details, created_by, date_created, modified_by, date_modified) FROM stdin;
1	1	Aucun	Personne ne sait l'objet de l'absence	levilliard	2017-10-23 20:38:00	\N	\N
2	9	Maladie	L'eleve est malade	TizonDife	2017-10-23 23:55:55		2017-10-23 23:55:55
3	12	Aucun	Chaque Jour	TizonDife	2017-12-21 10:14:26		2017-12-21 10:14:26
\.


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 182
-- Name: absence_absence_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('absence_absence_id_seq', 3, true);


--
-- TOC entry 3341 (class 0 OID 148380)
-- Dependencies: 183
-- Data for Name: address; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY address (address_id, address_country, address_state, address_city, address_street, address_zipcode, address_details, created_by, date_created, modified_by, date_modified) FROM stdin;
49	Haiti	Ouest	Port-au-Prince	56, Test	\N	Details Test	tizondife	2017-09-02 09:48:12	tizondife	2017-09-02 09:48:12
2	Haiti	OUEST	Croix-des-Bouquets	23, Ruelle Arzace, Beudet 12	HT4510		levilliard	2017-09-16 00:00:00		2017-09-16 00:00:00
3	Haiti	OUEST	Croix-des-Bouquets	50, Ruelle Jenjacques, Lilavois 54	HT4510		levilliard	2017-09-16 00:00:00		2017-09-16 00:00:00
4	Haiti	OUEST	Delmas 43	50, Ruelle Pierre	HT9510		levilliard	2017-09-16 00:00:00		2017-09-16 00:00:00
50	Haiti	Ouest	Port-au-Prince	23, Test	\N	Test	tizondife	2017-09-02 09:58:45	tizondife	2017-09-02 09:58:45
51	Haiti	Ouesi	Port-au-Prince	34, Test	\N	Detail test	tizondife	2017-09-05 17:55:00	tizondife	2017-09-05 17:55:00
52	Haiti	Ouest	Port-au-Prince	34, test	\N	test details	tizondife	2017-09-05 18:06:44	tizondife	2017-09-05 18:06:44
53	haiti	Ouest	Port-au-Prince	23, Test	\N	Details	tizondife	2017-09-05 18:43:38	tizondife	2017-09-05 18:43:38
31	Haiti	Ouest	Croix-Des-Bouquets	34, Test	\N	Test	tizondife	2017-08-06 13:20:06	tizondife	2017-08-06 13:20:06
32	Haiti	Ouest	Croix-Des-Bouquets	45, Test	\N	Test	tizondife	2017-08-06 13:20:06	tizondife	2017-08-06 13:20:06
34	Haiti	Ouest	Croix-Des-Bouquets	Test Pam	\N	Test Pam	tizondife	2017-08-06 13:49:34	tizondife	2017-08-06 13:49:34
35	Haiti	Ouest	Croix-Des-Bouquets	54, Test	\N	Test	tizondife	2017-08-06 14:23:56	tizondife	2017-08-06 14:23:56
36	GHaiti	OUEST	Croix-des-Bouquets	50, Ruelle Jenjacques, Lilavois 54	\N	yuiyuiyui	tizondife	2017-09-04 22:15:52	tizondife	2017-09-04 22:15:52
37	gfdgdfjghfgjh	hfsjkfhsdjfh	fsdfksdhfjdfh	fjhdfjshdfsdhf	\N	fhsdjfhsjdfhjsdf	tizondife	2017-09-05 23:04:36	tizondife	2017-09-05 23:04:36
38	rwerwehrhh	hfsdjfsdjfh	ksdhfsjhfdjfh	fjkhsfsdfdsfh	\N	werhjhfshfsdf	tizondife	2017-09-05 23:08:44	tizondife	2017-09-05 23:08:44
39	Haiti	Ouest	Port-au-Prince	4545, Test rue	\N	ffsdfd	tizondife	2017-09-06 13:38:30	tizondife	2017-09-06 13:38:30
40	Haiti	Ouest	Port-au-Prince	23, test	\N	Test li ye	tizondife	2017-09-06 15:57:52	tizondife	2017-09-06 15:57:52
41	Haiti	Ouest	Port-au-Prince	tertert	\N	test@gmail.com	tizondife	2017-09-06 15:57:52	tizondife	2017-09-06 15:57:52
42	Haiti	Ouest	Port-au-Prince	54, Test	\N	Test Pam	tizondife	2017-09-06 16:09:33	tizondife	2017-09-06 16:09:33
43	Hait	Ouest	Croix-Des-Bouquets	45, Test	\N	test@gmail.com	tizondife	2017-09-06 16:09:33	tizondife	2017-09-06 16:09:33
44	Haiti	Ouest	Croix-Des-Bouquets	34m test	\N	Test	tizondife	2017-09-06 16:09:33	tizondife	2017-09-06 16:09:33
45					\N		tizondife	2017-09-06 21:00:37	tizondife	2017-09-06 21:00:37
46	Haiti	Ouest	Croix-Des-Bouquets	566, Test	\N	Teszt	tizondife	2017-09-06 21:25:19	tizondife	2017-09-06 21:25:19
47	Haiti	Ouest	Croix-Des-Bouquets	23, Test	\N	Details	tizondife	2017-09-06 21:25:19	tizondife	2017-09-06 21:25:19
48	Haiti	Ouest	Port-au-Prince	22, Test	\N	Test Emp	tizondife	2017-09-02 09:39:15	tizondife	2017-09-02 09:39:15
54	Haiti	Ouest	Ville Vi	54, 4yyewe	\N	Testlkjdf	tizondife	2017-09-30 18:35:27	tizondife	2017-09-30 18:35:27
55	Haiti	Ouest	Port-au-Prince	34, Test 509	\N	Details test	tizondife	2017-09-30 18:58:26	tizondife	2017-09-30 18:58:26
56	Haiti	Ouest	Pv ville	34, tet-est	\N	Details test	tizondife	2017-09-30 19:02:17	tizondife	2017-09-30 19:02:17
57	Haiti	Ouest	ville post	65, testt	\N	Details test	tizondife	2017-09-30 19:06:29	tizondife	2017-09-30 19:06:29
58	Haiti	Ouest	Pv Ville	45, Test	\N	Details	tizondife	2017-09-30 19:13:30	tizondife	2017-09-30 19:13:30
59	Haiti	Ouest	PV Ville	34, Test	\N	Dteails	tizondife	2017-09-30 19:18:37	tizondife	2017-09-30 19:18:37
60	Hai	Ouesi	Pv Test	34, Test	\N	Details Test	tizondife	2017-10-01 19:02:04	tizondife	2017-10-01 19:02:04
61	Haiti	Ouest	Po	Test	\N	Test	tizondife	2017-10-01 19:02:04	tizondife	2017-10-01 19:02:04
62	Haiti	Pam 	Ville Pam	34, Test	\N	Test Details	tizondife	2017-10-01 21:49:27	tizondife	2017-10-01 21:49:27
63	Haiti	Ouest	Reg Villiard	45, Test	\N	Deta gdfg	tizondife	2017-10-01 22:29:41	tizondife	2017-10-01 22:29:41
64	Haiti	Ouest	Lascahobas	43, Test	\N	Details	tizondife	2017-10-01 22:29:41	tizondife	2017-10-01 22:29:41
65	Haiti	test	Villiard	34, Test	\N	Details 	tizondife	2017-10-01 22:29:41	tizondife	2017-10-01 22:29:41
66	Haiti	OUEST	Test	34, Test	\N		tizondife	2017-10-05 22:21:58	tizondife	2017-10-05 22:21:58
67	Haiti	OUEST	Cghsfh	343, rtet	\N	ertretrettretretrt	tizondife	2017-10-05 22:21:58	tizondife	2017-10-05 22:21:58
68	Haiti	OUEST	desource	45, Tye	\N	Details	tizondife	2017-10-05 22:21:58	tizondife	2017-10-05 22:21:58
69	Haiti	OUEST	test	509	\N		TizonDife	2017-10-06 16:59:14		2017-10-06 16:59:14
70	Haiti	OUEST	fsffd	sdfdfdf	\N	sfsdfsdfdf	TizonDife	2017-10-06 16:59:14		2017-10-06 16:59:14
71	Haiti	OUEST	ertertr	ertretr	\N	retret	TizonDife	2017-10-06 16:59:14		2017-10-06 16:59:14
72	Haiti	OUEST	adasdasd	eqwe	\N	e34rwerr	TizonDife	2017-10-06 16:59:14		2017-10-06 16:59:14
73	Haiti	Ouest	Croix-Des-Bouquets	Test 3444	\N	Rue 300003	TizonDife	2018-01-15 18:41:06	 	2018-01-15 18:41:06
74	trytrytryrtyt	ryrutyrutytrytry	Croix-Des-Bouquets	ytryrutyutry	\N	rtyrtyrtyutryrtytry	TizonDife	2018-01-15 18:51:14	 	2018-01-15 18:51:14
75	fsfsdfsdf	wrwererwr	Croix-Des-Bouquets	ewrwrwerwer	\N	wrwerwerere	TizonDife	2018-01-15 18:57:12	 	2018-01-15 18:57:12
76	Haiti	Ouest	Croix-Des-Bouquets	324	\N	23434	TizonDife	2018-01-16 03:53:56	 	2018-01-16 03:53:56
77	Haiti	Ouest	Port-au-Prince	34 433	\N	Test addd	TizonDife	2018-01-16 03:59:09	 	2018-01-16 03:59:09
78	Haiti	Ouest	Port-au-Prince	34 test 	\N		TizonDife	2018-01-16 04:06:38	 	2018-01-16 04:06:38
79	Haiti	Ouest	Port-au-Prince	483433	\N		TizonDife	2018-01-16 04:28:57	 	2018-01-16 04:28:57
80	Haiti	Ouest	Croix-Des-Bouquets	232	\N		TizonDife	2018-01-16 04:43:56	 	2018-01-16 04:43:56
33	Haiti	Ouest	Port-au-Prince	34, Test	\N	ffsdfd	2017-10-06 08:52:33	2018-01-16 14:17:24	TizonDife	2018-01-16 14:17:24
81	Haiti	Ouest	Port-au-Prince	34	\N		TizonDife	2018-01-19 07:28:50	 	2018-01-19 07:28:50
1	Haiti	OUEST	Croix-des-Bouquets	34, Impasse Test, Pacifique	\N	 	TizonDife	2018-06-14 16:44:04	TizonDife	2018-06-14 16:44:04
\.


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 184
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('address_address_id_seq', 81, true);


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 186
-- Name: class_cours_class_cours_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('class_cours_class_cours_id_seq', 4, true);


--
-- TOC entry 3343 (class 0 OID 148385)
-- Dependencies: 185
-- Data for Name: class_course; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY class_course (class_course_id, institution_class_id, course_id, class_course_details, created_by, date_created, modified_by, date_modified, date_start, date_end, teacher_id) FROM stdin;
\.


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 188
-- Name: class_payment_class_payment_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('class_payment_class_payment_id_seq', 12, true);


--
-- TOC entry 3389 (class 0 OID 165640)
-- Dependencies: 231
-- Data for Name: course; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY course (course_id, periode_id, institution_class_id, course_title, course_short_name, course_desc, created_by, date_created, modified_by, date_modified, course_level, course_credit_hours) FROM stdin;
\.


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 230
-- Name: course_course_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('course_course_id_seq', 1, false);


--
-- TOC entry 3347 (class 0 OID 148403)
-- Dependencies: 189
-- Data for Name: employee; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY employee (employee_id, address_id, employee_firstname, employee_lastname, employee_func, employee_card_id, employee_type, employee_details, employee_sex, employee_tels, employee_email, employee_active, created_by, date_created, modified_by, date_modified, employee_birthday) FROM stdin;
7	3	James	Vaillant	Gerant	53455534545	smallstaff	Responsable des barrieres.	M	5464564546	test@pam.com	t	levilliard	2017-09-25 00:00:00	levilliard	2017-09-25 00:00:00	2010-09-25
12	53	Power	Black	gardien	945834573457	smallstaff	Test Tate re 	M	534534545	test@we.com	t	tizondife	2017-09-05 18:43:38	tizondife	2017-09-05 18:43:38	2013-01-14
14	73	Villiard	Elisée	Prof de math	323232323232	teacher	Bon Prof  Pam nan	F	+50936729264	levilliard@gmail.com	t	TizonDife	2018-01-15 18:41:06	 	2018-01-15 18:41:06	2010-06-09
13	33	Tota Ti	Jacques	Cours de math	349053459	teacher	Test Detail	M	65465656	test@tst.com	t	2017-10-06 08:52:33	2018-01-16 14:17:24	TizonDife	2018-01-16 14:17:24	2013-02-12
21	80	Villiard	Elisée 0	Test	32323233	teacher		M	+50936729264	levilliard@gmail.com	f	TizonDife	2018-01-16 04:43:56	 	2018-01-16 04:43:56	2016-12-01
22	81	Bonard	Zac	Prof la	424892462	teacher	Test Details	F	53533534545	test@test.com	f	TizonDife	2018-01-19 07:28:50	 	2018-01-19 07:28:50	2001-02-06
\.


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 190
-- Name: employee_employee_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('employee_employee_id_seq', 22, true);


--
-- TOC entry 3349 (class 0 OID 148411)
-- Dependencies: 191
-- Data for Name: employee_salary; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY employee_salary (employee_salary_id, employee_id, employee_salary_value, employee_salary_payment_freq, created_by, date_created, modified_by, date_modified) FROM stdin;
1	7	10000	10	levilliard	2017-09-25 00:00:00	levilliard	2017-09-25 00:00:00
3	12	2000	12	tizondife	2017-09-05 18:43:38	tizondife	2017-09-05 18:43:38
5	14	1500	10	TizonDife	2018-01-15 18:41:06	 	2018-01-15 18:41:06
12	21	101010	10	TizonDife	2018-01-16 04:43:56	 	2018-01-16 04:43:56
4	13	11000	12	tizondife	2018-01-16 14:17:24	TizonDife	2018-01-16 14:17:24
13	22	10000	12	TizonDife	2018-01-19 07:28:50	 	2018-01-19 07:28:50
\.


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 192
-- Name: employee_salary_employee_salary_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('employee_salary_employee_salary_id_seq', 13, true);


--
-- TOC entry 3351 (class 0 OID 148416)
-- Dependencies: 193
-- Data for Name: event; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY event (event_id, user_id, event_title, event_desc, event_dstart, event_dend, event_concerns, event_details, created_by, date_created, modified_by, date_modified) FROM stdin;
19	4	Hey	Hey Bkljdfg sldkfj slkdfjsdf jkhfsdf f iruwe ekruwier ewore   uiwejdsf	2018-06-12 14:22:00	2018-06-04 16:44:00	Student, Teacher	Hey sa se tessssss	TizonDife	2018-06-10 17:39:26.401	\N	\N
2	4	Test Event 3434	Test evetn lot ernman tufdfj bsdf kasdh fodsie ofdsfj  eallkdsd preprer kdsfd kdfuwyer lsdjlfd pweirerkdf 	2018-05-20 18:00:00	2018-05-20 22:00:00	Parent, eleve, tests	Test 545454	laepro	2018-06-20 07:24:09.504	laepro	2018-06-20 07:24:09.504
\.


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 194
-- Name: event_event_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('event_event_id_seq', 2, true);


--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 195
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 40, true);


--
-- TOC entry 3354 (class 0 OID 148426)
-- Dependencies: 196
-- Data for Name: huser; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY huser (user_id, user_privilege, user_firstname, user_lastname, user_title, user_sex, user_phone, user_email, user_username, user_password, user_code, user_img, user_details, user_active, created_by, date_created, modified_by, date_modified) FROM stdin;
4	1	Lae	Pro		M	367292645	laepro@gmail.com	laepro	d85bbcd3c9ecb343bf86d0eb15b334b6d964850e	\N	\N	\N	t	TizonDife	2017-10-11 13:04:15	TizonDife	2018-01-27 09:27:18
6	1	Villiard	Elisee		M	+509 33 14 6889	levilliard@gmail.com	levilliard	f9573a596de90b99bcf07fa870bce07f3ba978ee	\N	\N	\N	t	laepro	2018-05-13 12:44:14	laepro	2018-05-13 12:44:14
\.


--
-- TOC entry 3355 (class 0 OID 148432)
-- Dependencies: 197
-- Data for Name: institution; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY institution (institution_id, address_id, institution_name, institution_details, created_by, date_created, modified_by, date_modified, school_begin_date, school_end_date) FROM stdin;
1	1	Le Petit Monde	Ecole Primaire	TizonDife	2018-06-14 16:44:04	TizonDife	2018-06-14 16:44:04	2018-01-01	2019-05-06
\.


--
-- TOC entry 3356 (class 0 OID 148438)
-- Dependencies: 198
-- Data for Name: institution_class; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY institution_class (institution_class_id, institution_id, institution_class_name, institution_class_level, institution_class_desc, institution_class_code, created_by, date_created, modified_by, date_modified) FROM stdin;
1	1	Classe Papillons	Premiere Annee	Pour les Enfants Amusants	CL001A	TizonDife	2018-01-13 16:01:51	TizonDife	2018-01-13 16:01:51
6	1	Classe Moutons	Premiere Annee	Pour Enfants Sages	CL001A	TizonDife	2018-01-13 16:03:18	TizonDife	2018-01-13 16:03:18
16	1	LaePro Classe	Deuxieme Annees F	Details sur classe	\N	TizonDife	2018-01-13 16:07:29	TizonDife	2018-01-13 16:07:29
5	1	Hibiscus	Deuxieme Annee Fond.	Classe des Moyens		TizonDife	2018-01-13 16:14:07	TizonDife	2018-01-13 16:14:07
21	1	Hacking Class	High Level CL	Best Hacking class 2018	\N	TizonDife	2018-01-17 16:32:32	TizonDife	2018-01-17 16:32:32
22	1	Christner	Secondaire	Test Sur classe	\N	laepro	2018-04-26 15:16:24	laepro	2018-04-26 15:16:24
\.


--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 199
-- Name: institution_class_institution_class_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('institution_class_institution_class_id_seq', 22, true);


--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 200
-- Name: institution_institution_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('institution_institution_id_seq', 1, true);


--
-- TOC entry 3359 (class 0 OID 148451)
-- Dependencies: 201
-- Data for Name: parent; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY parent (parent_id, parent_firstname, parent_lastname, parent_title, parent_sex, parent_tels, parent_email, parent_religion, created_by, date_created, modified_by, date_modified, parent_address) FROM stdin;
24	Palo	Joseph	\N	M	423423423434	\N	\N	TizonDife	2017-12-21 11:14:06	TizonDife	2017-12-21 11:14:06	25, Rue Babiole
25	Polene	Pierre	\N	F	4234324	\N	\N	TizonDife	2017-12-21 11:14:06	TizonDife	2017-12-21 11:14:06	Polene Addr
14	Jean	Jean	Ing. Agro	M	343434884	levi@test.com	est reg	tizondife	2017-10-01 22:29:41	tizondife	2017-10-01 22:29:41	Test Addr
11	Jacques	Morant	Agronome	M	5656565656	lliard@gmail.com	Test Reg	tizondife	2017-09-06 21:25:19	tizondife	2017-09-06 21:25:19	Test Addr
7	Elisée	Villiard	Ing. Test	M	5435435	levilliard@gmail.com	Test Advt	tizondife	2017-08-06 13:49:34	tizondife	2017-08-06 13:49:34	Test Addr
8	Elisée	Villiard	Ing. Test	M	455453534	levilliard@gmail.com	Teest Reg	tizondife	2017-08-06 14:23:56	tizondife	2017-08-06 14:23:56	Test Addr
9	Joe	Jean	Ing. Arg.	M	345345345	test@test.com	Vodou	tizondife	2017-09-06 15:57:52	tizondife	2017-09-06 15:57:52	Test Addr
12	Jacques	Cantaves	Ing. Test	M	83481023832`	leve@t.com	Advtrtr	tizondife	2017-10-01 19:02:04	tizondife	2017-10-01 19:02:04	Test Addr
10	Daniel	Joe	Ing. Test	M	343454334	test@test.com	Test Reg	tizondife	2017-09-06 16:09:33	tizondife	2017-09-06 16:09:33	Test Addr
26			\N	M		\N	\N	TizonDife	2017-11-02 22:33:21		2017-11-02 22:33:21	
30	Pep	Sauveur	\N	M	054359458	\N	\N	TizonDife	2017-11-03 10:34:20		2017-11-03 10:34:20	hfsfjhdjfhhsdff
31	Tatine	Sauveur	\N	F	4324343	\N	\N	TizonDife	2017-11-03 10:34:20		2017-11-03 10:34:20	345345435
32	sdfhsjdfj	ksjdfhsdjfhd	\N	M	43543587485	\N	\N	TizonDife	2017-11-03 10:51:05		2017-11-03 10:51:05	fkjhsfkjshdfdjfh
33	lsfdjsdkfjsdkfh	skdlfsdfhdsf	\N	F	90454309543059	\N	\N	TizonDife	2017-11-03 10:51:05		2017-11-03 10:51:05	kfsfhsdjfhskfjdhjh
18	Dev	Wash	\N	M	343444234	\N	\N	tizondife	2018-01-17 16:46:33	TizonDife	2018-01-17 16:46:33	3, Beudet 14
19	Danielle	Jos	\N	F	34545, tetret	\N	\N	tizondife	2018-01-17 16:46:33	TizonDife	2018-01-17 16:46:33	3, Beudet 12 
35	Test	Joseph	\N	F	45454545	\N	\N	TizonDife	2018-01-18 13:25:02	TizonDife	2018-01-18 13:25:02	25, Rue Babiole
34	Jacques	Fernand	\N	M	+50936729264	\N	\N	TizonDife	2018-01-18 13:25:02	TizonDife	2018-01-18 13:25:02	3, Beudet 12
36	vfvfgef	fvfevfvef	\N	M	fvefvefe	\N	\N	TizonDife	2018-01-18 18:56:16	TizonDife	2018-01-18 18:56:16	vfvfvf
37	bdbgbgf	vfvfvsd	\N	F	50900000000	\N	\N	TizonDife	2018-01-18 18:56:16	TizonDife	2018-01-18 18:56:16	fbvferegre
13	Jc Tatine	Jean	\N	F	09545457	\N	\N	tizondife	2018-01-18 21:38:30	TizonDife	2018-01-18 21:38:30	M Addr
1	Jean H.	Pierre-Louis	\N	M	50999009900	\N	\N	tizondife	2018-01-18 21:38:30	TizonDife	2018-01-18 21:38:30	P Addr
38	Eliséem	Villiardm	\N	F	+50933146885	\N	\N	TizonDife	2018-06-29 16:27:12		2018-06-29 16:27:12	3, Beudet 1233
39	Elisée44	Villiard44	\N	M	+50933144489	\N	\N	TizonDife	2018-06-29 16:27:12		2018-06-29 16:27:12	3, Beudet 12
40	Elisée33	Villiard3	\N	M	+509331468893	\N	\N	laepro	2018-06-29 16:29:39		2018-06-29 16:29:39	3, Beudet 123
42	Elisée	Villiard	\N	M	+50933146889	\N	\N	laepro	2018-06-29 16:33:49		2018-06-29 16:33:49	3, Beudet 12
43	Elisées	Villiardss	\N	F	+50933146889	\N	\N	laepro	2018-06-29 16:33:49		2018-06-29 16:33:49	3, Beudet 12
20	JP Buena	Pierre	\N	M	5454354	\N	\N	TizonDife	2018-06-29 16:34:43	laepro	2018-06-29 16:34:43	Test Addr
21	Lala	Lolo	\N	F	3434734	\N	\N	TizonDife	2018-06-29 16:34:43	laepro	2018-06-29 16:34:43	Test Addr
45	Elisée232e	Villiard233	\N	F	+50933146889	\N	\N	laepro	2018-06-29 16:44:07	laepro	2018-06-29 16:44:07	3, Beudet 12
44	Eliséeee	Villiardee	\N	M	+50933146884	\N	\N	laepro	2018-06-29 16:44:07	laepro	2018-06-29 16:44:07	3, Beudet 12
\.


--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 202
-- Name: parent_parent_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('parent_parent_id_seq', 45, true);


--
-- TOC entry 3361 (class 0 OID 148459)
-- Dependencies: 203
-- Data for Name: parent_student; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY parent_student (parent_student_id, parent_id, student_id) FROM stdin;
\.


--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 204
-- Name: parent_student_parent_student_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('parent_student_parent_student_id_seq', 1, false);


--
-- TOC entry 3345 (class 0 OID 148390)
-- Dependencies: 187
-- Data for Name: payment_class; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY payment_class (payment_class_id, institution_class_id, payment_class_begin_fee_value, payment_class_period_value, payment_class_freq, created_by, date_created, modified_by, date_modified) FROM stdin;
1	5	10000	1300	10	TizonDife	2017-10-01 22:42:32	TizonDife	2017-10-01 22:42:32
2	1	10000	2000	10	TizonDife	2017-10-01 23:02:56	TizonDife	2017-10-01 23:02:56
4	6	10000	2000	10	TizonDife	2017-10-01 23:13:30	TizonDife	2017-10-01 23:13:30
\.


--
-- TOC entry 3363 (class 0 OID 148464)
-- Dependencies: 205
-- Data for Name: payment_employee; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY payment_employee (payment_employee_id, employee_id, payment_employee_value, payment_employee_details, created_by, date_created, modified_by, date_modified) FROM stdin;
5	7	1500		TizonDife	2017-09-05 17:33:27	TizonDife	2017-09-05 17:33:27
6	12	2000		TizonDife	2017-09-05 18:46:51	TizonDife	2017-09-05 18:46:51
7	13	2000		TizonDife	2017-10-03 09:40:43	TizonDife	2017-10-03 09:40:43
8	13	2000		TizonDife	2017-10-03 09:43:57	TizonDife	2017-10-03 09:43:57
9	13	100		TizonDife	2017-10-03 09:53:02	TizonDife	2017-10-03 09:53:02
10	13	100		TizonDife	2017-10-03 09:53:28	TizonDife	2017-10-03 09:53:28
\.


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 206
-- Name: payment_employee_payment_employee_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('payment_employee_payment_employee_id_seq', 11, true);


--
-- TOC entry 3365 (class 0 OID 148469)
-- Dependencies: 207
-- Data for Name: payment_periode; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY payment_periode (payment_periode_id, institution_class_id, periode_id, payment_periode_value, payment_periode_date_start, payment_periode_date_end, payment_periode_details, created_by, date_created, modified_by, date_modified) FROM stdin;
1	1	1	10000	2017-09-01	2017-09-01	Test	levilliard	2017-09-01 00:00:00	\N	\N
4	6	1	5454	2017-09-02	2017-09-02	Test	test	2017-09-02 00:00:00	\N	\N
6	5	1	11000	2017-09-01	2017-09-01	\N	TizonDife	2018-01-16 19:00:00	TizonDife	2018-01-16 19:00:00
2	5	2	4000	2017-09-01	2017-09-01	\N	TizonDife	2018-01-16 19:00:00	TizonDife	2018-01-16 19:00:00
5	16	1	22000	2017-09-01	2017-09-01	\N	TizonDife	2018-01-16 19:00:00	TizonDife	2018-01-16 19:00:00
12	21	1	55000	2017-12-31	2018-01-30	\N	TizonDife	2018-01-16 19:00:00	TizonDife	2018-01-16 19:00:00
13	1	2	5000	2018-01-07	2018-01-22	\N	TizonDife	2018-01-17 19:00:00	TizonDife	2018-01-17 19:00:00
15	5	3	5000	2017-12-31	2018-01-23	\N	TizonDife	2018-01-18 19:00:00	TizonDife	2018-01-18 19:00:00
16	16	2	2000	2018-01-02	2018-03-03	\N	laepro	2018-03-17 20:00:00	laepro	2018-03-17 20:00:00
17	22	1	5000	2017-12-31	2018-03-02	\N	laepro	2018-04-25 20:00:00	laepro	2018-04-25 20:00:00
37	16	3	454545	2018-06-08	2018-06-12	\N	laepro	2018-06-24 20:00:00	laepro	2018-06-24 20:00:00
39	1	3	433243	2018-01-14	2018-07-04	Frais D'entree	laepro	2018-06-28 20:00:00	laepro	2018-06-28 20:00:00
\.


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 208
-- Name: payment_periode_payment_periode_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('payment_periode_payment_periode_id_seq', 6, true);


--
-- TOC entry 3367 (class 0 OID 148474)
-- Dependencies: 209
-- Data for Name: payment_student; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY payment_student (payment_student_id, student_id, payment_student_value, created_by, date_created, modified_by, date_modified) FROM stdin;
2	1	5200	levilliard	2017-09-21 00:00:00	levilliard	2017-09-21 00:00:00
4	3	5000	levilliard	2017-09-21 00:00:00	levilliard	2017-09-21 00:00:00
5	3	2000	levilliard	2017-09-21 00:00:00	levilliard	2017-09-21 00:00:00
6	1	1000	TizonDife	2017-09-06 14:24:21	TizonDife	2017-09-06 14:24:21
7	3	2500	TizonDife	2017-09-06 16:13:16	TizonDife	2017-09-06 16:13:16
8	3	500	TizonDife	2017-09-06 17:00:34	TizonDife	2017-09-06 17:00:34
9	3	10000	TizonDife	2017-09-06 00:02:35	TizonDife	2017-09-06 00:02:35
10	3	100	TizonDife	2017-09-06 00:06:10	TizonDife	2017-09-06 00:06:10
11	3	100	TizonDife	2017-09-06 00:08:02	TizonDife	2017-09-06 00:08:02
12	3	100	TizonDife	2017-09-29 00:42:00	TizonDife	2017-09-29 00:42:00
13	13	10000	TizonDife	2018-01-17 15:13:34	TizonDife	2018-01-17 15:13:34
14	12	5000	TizonDife	2018-01-18 11:42:40	TizonDife	2018-01-18 11:42:40
15	13	2500	TizonDife	2018-01-26 21:04:30	TizonDife	2018-01-26 21:04:30
16	13	2510	TizonDife	2018-01-26 21:07:28	TizonDife	2018-01-26 21:07:28
17	9	1000	TizonDife	2018-01-26 21:28:13	TizonDife	2018-01-26 21:28:13
\.


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 210
-- Name: payment_student_payment_student_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('payment_student_payment_student_id_seq', 17, true);


--
-- TOC entry 3369 (class 0 OID 148479)
-- Dependencies: 211
-- Data for Name: penality; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY penality (penalty_id, penality_type_id, penalty_desc, created_by, date_created, modified_by, date_modified) FROM stdin;
\.


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 212
-- Name: penality_penalty_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('penality_penalty_id_seq', 1, false);


--
-- TOC entry 3371 (class 0 OID 148487)
-- Dependencies: 213
-- Data for Name: penality_type; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY penality_type (penality_type_id, penality_type_name, penality_type_desc, penality_type_fee, created_by, date_created, modified_by, date_modified) FROM stdin;
2	Lecon non su	Pour les lecon non su	200	\N	\N	\N	\N
3	Irrespect	Manque a une personne au sein de l'établ	1000	TizonDife	2017-12-25 13:54:12	TizonDife	2017-12-25 13:54:12
5	Expulsion	Vol, Agression physique	0	laepro	2018-03-18 19:15:03	laepro	2018-03-18 19:15:03
\.


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 214
-- Name: penality_type_penality_type_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('penality_type_penality_type_id_seq', 5, true);


--
-- TOC entry 3387 (class 0 OID 148824)
-- Dependencies: 229
-- Data for Name: periode; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY periode (periode_id, institution_id, periode_no, periode_name, periode_dstart, periode_dend, created_by, date_created, modified_by, date_modified) FROM stdin;
33	1	1	Test	2018-07-03	2018-12-24	TizonDife	2018-06-16 13:44:57.683	TizonDife	\N
\.


--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 228
-- Name: periode_periode_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('periode_periode_id_seq', 1, true);


--
-- TOC entry 3373 (class 0 OID 148495)
-- Dependencies: 215
-- Data for Name: person_ref; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY person_ref (person_ref_id, person_ref_firstname, person_ref_lastname, person_ref_sex, person_ref_tels, person_ref_email, person_ref_addr, person_ref_desc, created_by, date_created, modified_by, date_modified, person_ref_address) FROM stdin;
11	Gary	Pierre	M	433434343	levilliard@t.com	\N	Kouzin 	tizondife	2017-10-01 22:29:41	tizondife	2017-10-01 22:29:41	\N
14	Lalo	Louis	M	456456546	\N	\N	Cousin pam	TizonDife	2017-10-20 20:40:04		2017-10-20 20:40:04	jhghgh
8	Jeff	Badin	M	+50936729265	liard@gmail.com	\N	Cousin	tizondife	2017-09-06 21:25:19	tizondife	2017-09-06 21:25:19	Test Addr
4	Elisée	Villiard	M	+50936729264	levilliard@gmail.com	\N	Cousin	tizondife	2017-08-06 13:49:34	tizondife	2017-08-06 13:49:34	Test Addr
5	Joe	Joseph	M	4564564	levilliard@gmail.com	\N	fdkjgkjertert	tizondife	2017-09-06 15:57:52	tizondife	2017-09-06 15:57:52	Test Addr
9	Jude	Jean	M	93478349734	agr@test.com	\N	Black Test	tizondife	2017-10-01 19:02:04	tizondife	2017-10-01 19:02:04	personAddress
10	Nicolas	Joseph	M	655650956	levilliard@gmail.com	\N	Kouzin	tizondife	2017-10-01 21:49:27	tizondife	2017-10-01 21:49:27	personAddress
16			 		\N	\N		TizonDife	2017-11-02 22:33:21		2017-11-02 22:33:21	
18	Jacques	Pap	M	32312343	\N	\N	Cousin pam	TizonDife	2017-11-03 10:34:20		2017-11-03 10:34:20	oiteorihgfdgfddddg
19	sfdfjkhsdfskd	fshfjdhfjksfhd	M	584395843958	\N	\N	sfdhfksjfhjfh	TizonDife	2017-11-03 10:51:05		2017-11-03 10:51:05	28423904894
15	Jacque	Sadou	M	2342394893	\N	\N	Cousin Pam	TizonDife	2017-12-21 11:14:06	TizonDife	2017-12-21 11:14:06	hfhere, fjhfjsdf
12	Jude	Jean	M	842384738	\N	\N	Kouzin pam	tizondife	2018-01-17 16:46:33	TizonDife	2018-01-17 16:46:33	blablabla
20	Gary	Abe	M	65656465	\N	\N	Test Pam	TizonDife	2018-01-18 13:25:02	TizonDife	2018-01-18 13:25:02	44, Test
21	t5y5y5	hjkhkhk	F	50900000000	\N	\N	frgere	TizonDife	2018-01-18 18:56:16	TizonDife	2018-01-18 18:56:16	svds
1	Sam	Joseph	M	50999679900	\N	\N	Oncle	levilliard	2018-01-18 21:38:30	TizonDife	2018-01-18 21:38:30	person Address
22	Eliséehh	Villiardhh	M	+5093314688955	\N	\N	Rsdfsdf sdfsdf	TizonDife	2018-06-29 16:27:12		2018-06-29 16:27:12	3, Beudet 12666
23	Elisée11	Villiard11	M	+5093314688911	\N	\N	Esf  fdsfd	laepro	2018-06-29 16:29:39		2018-06-29 16:29:39	3, Beudet 12
24	Elisée	Villiard	M	+5093314688944	\N	\N	dsdsadasd	laepro	2018-06-29 16:33:49		2018-06-29 16:33:49	3, Beudet 12
13	Jacques	Test	M	3742347347	\N	\N	Kouzin	TizonDife	2018-06-29 16:34:43	laepro	2018-06-29 16:34:43	Test Addr
25	Eliséeui	Villiarduuy	F	+50933146884	\N	\N	Ttdfdfdf	laepro	2018-06-29 16:44:07	laepro	2018-06-29 16:44:07	3, Beudet 12
\.


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 216
-- Name: person_ref_person_ref_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('person_ref_person_ref_id_seq', 25, true);


--
-- TOC entry 3375 (class 0 OID 148503)
-- Dependencies: 217
-- Data for Name: student; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY student (student_id, institution_id, parent_id, person_ref_id, institution_class_id, student_firstname, student_lastname, student_birthday, student_birthplace, student_sex, student_mother_tonge, student_skills, student_tels, student_email, student_addr, student_religion, created_by, date_created, modified_by, date_modified, student_img, student_active, parentf_id, student_address, student_old_school) FROM stdin;
3	1	8	4	6	Joseph	Nelson	2000-12-10	Last Test	F	\N	\N	36729264	levilliard@gmail.com	\N	Vaudou	tizondife	2017-09-06 00:01:53	tizondife	2017-09-06 00:01:53		\N	13	Test Addr	\N
11	1	32	19	5	dasdhaskdhs	Tesdasd	2015-12-08	sjfksfjdfjdf	M	\N	\N	43558458	sjfhsjdfhsdj	\N	fdsfjhjsdfhdsfh	TizonDife	2017-11-03 10:51:05		2017-11-03 10:51:05		f	33	sdfsjdfhsjdfhj	\N
8	1	18	12	21	Wash	Denzel	2011-06-14	Last Test	M	\N	\N	545555555	Test	\N	sdfsdfsdfsdf	tizondife	2018-01-17 16:46:33	TizonDife	2018-01-17 16:46:33		t	19	Test Addr	\N
12	1	34	20	5	Fernand	Odel	2015-12-16	Lascahobas	M	\N	\N	+50936729264	gilliard@gmail.com	\N	Advtt	TizonDife	2018-01-18 13:25:02	TizonDife	2018-01-18 13:25:02		t	35	3, Beudet 12	\N
13	1	36	21	1	jean	Jeanne	2015-12-01	qwe	F	\N	\N	50934456567	tototototot@yqhoo.fr	\N	ert	TizonDife	2018-01-18 18:56:16	TizonDife	2018-01-18 18:56:16		t	37	degegegtrttt	\N
1	1	1	1	21	Jeff Gadin	Pierre-Louis	2012-09-16	Croix-des-Bouquets	M	\N	\N	5676566565	test@test.com	\N	Adventiste	tizondife	2018-01-18 21:38:30	TizonDife	2018-01-18 21:38:30		t	13	Std Addr	\N
9	1	20	13	6	Pierre	Jean	2011-06-14	Lascahobas	M	\N	\N	435435435		\N	\N	TizonDife	2018-06-29 16:34:43	laepro	2018-06-29 16:34:43		t	21	dsasdsdsdsd	Teewewewew
16	1	42	24	21	Villiard	Elisée	2017-06-07	DDas	M	\N	\N	+50933146000	levilliard@gmail.com	\N	\N	laepro	2018-06-29 16:33:49		2018-06-29 16:33:49		f	43	3, Beudet 12	dasdasd
17	1	44	25	21	Villiard	Elisée	2017-06-06	Teadadasd	M	\N	\N	+50933146889	levilliard@gmail.com	\N	\N	laepro	2018-06-29 16:44:07	laepro	2018-06-29 16:44:07		t	45	3, Beudet 12	TEST ANC ppp
\.


--
-- TOC entry 3376 (class 0 OID 148509)
-- Dependencies: 218
-- Data for Name: student_penality; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY student_penality (penality_id, penality_type_id, student_id, penality_desc, created_by, date_created, modified_by, date_modified) FROM stdin;
3	3	9	Manque de respect prof Villiard	TizonDife	2017-10-23 18:49:39		2017-10-23 18:49:39
5	3	9	Sans respect pou moun	TizonDife	2017-12-21 10:12:39		2017-12-21 10:12:39
\.


--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 219
-- Name: student_penality_penalty_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('student_penality_penalty_id_seq', 6, true);


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 220
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('student_student_id_seq', 17, true);


--
-- TOC entry 3379 (class 0 OID 148519)
-- Dependencies: 221
-- Data for Name: teach_cours; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY teach_cours (teach_cours_id, teacher_id, course_id) FROM stdin;
\.


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 222
-- Name: teach_cours_teach_cours_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('teach_cours_teach_cours_id_seq', 1, false);


--
-- TOC entry 3381 (class 0 OID 148524)
-- Dependencies: 223
-- Data for Name: teach_in_class; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY teach_in_class (teach_in_class_id, teacher_id, institution_class_id) FROM stdin;
\.


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 224
-- Name: teach_in_class_teach_in_class_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('teach_in_class_teach_in_class_id_seq', 1, false);


--
-- TOC entry 3383 (class 0 OID 148529)
-- Dependencies: 225
-- Data for Name: teacher; Type: TABLE DATA; Schema: lae_db; Owner: postgres
--

COPY teacher (teacher_id, address_id, teacher_firstname, teacher_lastname, teacher_level, teacher_domain, teacher_birthday, teacher_sex, teacher_tels, teacher_email, created_by, date_created, modified_by, date_modified, teacher_active) FROM stdin;
1	4	Taylor	Guerrier	Secondaire	Math	1980-04-15	M	50945343289	tc@test.com	levilliard	2017-09-16 00:00:00		2017-09-16 00:00:00	\N
2	38	Villiard	Olivier 	Secondaire	Mathematique	2017-09-13	M	5345354545	test@gmail.com	tizondife	2017-09-05 23:08:44	tizondife	2017-09-05 23:08:44	\N
\.


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 226
-- Name: teacher_teacher_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('teacher_teacher_id_seq', 2, true);


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 227
-- Name: user_user_id_seq; Type: SEQUENCE SET; Schema: lae_db; Owner: postgres
--

SELECT pg_catalog.setval('user_user_id_seq', 7, true);


--
-- TOC entry 3135 (class 2606 OID 148560)
-- Name: absence_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY absence
    ADD CONSTRAINT absence_pkey PRIMARY KEY (absence_id);


--
-- TOC entry 3137 (class 2606 OID 148562)
-- Name: address_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 3139 (class 2606 OID 148564)
-- Name: class_cours_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_course
    ADD CONSTRAINT class_cours_pkey PRIMARY KEY (class_course_id);


--
-- TOC entry 3141 (class 2606 OID 148566)
-- Name: class_payment_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class
    ADD CONSTRAINT class_payment_pkey PRIMARY KEY (payment_class_id);


--
-- TOC entry 3193 (class 2606 OID 165648)
-- Name: course_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- TOC entry 3145 (class 2606 OID 148570)
-- Name: employee_employee_card_id_employee_tels_employee_email_key; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_employee_card_id_employee_tels_employee_email_key UNIQUE (employee_card_id, employee_tels, employee_email);


--
-- TOC entry 3147 (class 2606 OID 148572)
-- Name: employee_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3149 (class 2606 OID 148574)
-- Name: employee_salary_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee_salary
    ADD CONSTRAINT employee_salary_pkey PRIMARY KEY (employee_salary_id);


--
-- TOC entry 3151 (class 2606 OID 148576)
-- Name: event_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3159 (class 2606 OID 148578)
-- Name: institution_class_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution_class
    ADD CONSTRAINT institution_class_pkey PRIMARY KEY (institution_class_id);


--
-- TOC entry 3157 (class 2606 OID 148580)
-- Name: institution_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (institution_id);


--
-- TOC entry 3161 (class 2606 OID 148584)
-- Name: parent_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent
    ADD CONSTRAINT parent_pkey PRIMARY KEY (parent_id);


--
-- TOC entry 3163 (class 2606 OID 148586)
-- Name: parent_student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student
    ADD CONSTRAINT parent_student_pkey PRIMARY KEY (parent_student_id);


--
-- TOC entry 3165 (class 2606 OID 148590)
-- Name: payment_employee_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_employee
    ADD CONSTRAINT payment_employee_pkey PRIMARY KEY (payment_employee_id);


--
-- TOC entry 3167 (class 2606 OID 148592)
-- Name: payment_periode_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_periode
    ADD CONSTRAINT payment_periode_pkey PRIMARY KEY (payment_periode_id);


--
-- TOC entry 3169 (class 2606 OID 148594)
-- Name: payment_student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_student
    ADD CONSTRAINT payment_student_pkey PRIMARY KEY (payment_student_id);


--
-- TOC entry 3179 (class 2606 OID 148596)
-- Name: penality_student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality
    ADD CONSTRAINT penality_student_pkey PRIMARY KEY (penality_id);


--
-- TOC entry 3171 (class 2606 OID 148598)
-- Name: penality_type_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality_type
    ADD CONSTRAINT penality_type_pkey PRIMARY KEY (penality_type_id);


--
-- TOC entry 3189 (class 2606 OID 148829)
-- Name: periode_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT periode_pkey PRIMARY KEY (periode_id);


--
-- TOC entry 3173 (class 2606 OID 148600)
-- Name: person_ref_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY person_ref
    ADD CONSTRAINT person_ref_pkey PRIMARY KEY (person_ref_id);


--
-- TOC entry 3175 (class 2606 OID 148604)
-- Name: student_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 3177 (class 2606 OID 148606)
-- Name: student_uq_tel; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_uq_tel UNIQUE (student_tels);


--
-- TOC entry 3183 (class 2606 OID 148610)
-- Name: teach_in_class_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class
    ADD CONSTRAINT teach_in_class_pkey PRIMARY KEY (teach_in_class_id);


--
-- TOC entry 3181 (class 2606 OID 148854)
-- Name: teacher_course_pk; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours
    ADD CONSTRAINT teacher_course_pk PRIMARY KEY (course_id);


--
-- TOC entry 3185 (class 2606 OID 148612)
-- Name: teacher_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (teacher_id);


--
-- TOC entry 3187 (class 2606 OID 148614)
-- Name: teacher_tel_email_uq; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_tel_email_uq UNIQUE (teacher_tels, teacher_email);


--
-- TOC entry 3191 (class 2606 OID 156994)
-- Name: ukey_no; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT ukey_no UNIQUE (periode_no);


--
-- TOC entry 3143 (class 2606 OID 148616)
-- Name: unique_class_payment_id; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class
    ADD CONSTRAINT unique_class_payment_id UNIQUE (institution_class_id);


--
-- TOC entry 3153 (class 2606 OID 148618)
-- Name: user_pkey; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY huser
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3155 (class 2606 OID 148620)
-- Name: username_uq_key; Type: CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY huser
    ADD CONSTRAINT username_uq_key UNIQUE (user_username);


--
-- TOC entry 3196 (class 2606 OID 165664)
-- Name: class_course_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_course
    ADD CONSTRAINT class_course_fk FOREIGN KEY (course_id) REFERENCES course(course_id);


--
-- TOC entry 3223 (class 2606 OID 165649)
-- Name: course_inst_class_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_inst_class_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3224 (class 2606 OID 165654)
-- Name: course_periode_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_periode_fk FOREIGN KEY (periode_id) REFERENCES periode(periode_id) ON DELETE CASCADE;


--
-- TOC entry 3199 (class 2606 OID 148621)
-- Name: employee_addr_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee
    ADD CONSTRAINT employee_addr_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- TOC entry 3194 (class 2606 OID 148626)
-- Name: fk_absence_std; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY absence
    ADD CONSTRAINT fk_absence_std FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;


--
-- TOC entry 3200 (class 2606 OID 148631)
-- Name: fk_employe_salary; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY employee_salary
    ADD CONSTRAINT fk_employe_salary FOREIGN KEY (employee_id) REFERENCES employee(employee_id);


--
-- TOC entry 3198 (class 2606 OID 148636)
-- Name: fk_payment_institution_class; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_class
    ADD CONSTRAINT fk_payment_institution_class FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3208 (class 2606 OID 148641)
-- Name: fk_payment_student; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_student
    ADD CONSTRAINT fk_payment_student FOREIGN KEY (student_id) REFERENCES student(student_id);


--
-- TOC entry 3215 (class 2606 OID 148646)
-- Name: fk_penality_student; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality
    ADD CONSTRAINT fk_penality_student FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;


--
-- TOC entry 3216 (class 2606 OID 148651)
-- Name: fk_penality_type; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student_penality
    ADD CONSTRAINT fk_penality_type FOREIGN KEY (penality_type_id) REFERENCES penality_type(penality_type_id) ON DELETE CASCADE;


--
-- TOC entry 3209 (class 2606 OID 148656)
-- Name: fk_penality_type2; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY penality
    ADD CONSTRAINT fk_penality_type2 FOREIGN KEY (penality_type_id) REFERENCES penality_type(penality_type_id) ON DELETE CASCADE;


--
-- TOC entry 3202 (class 2606 OID 148661)
-- Name: inst_addr_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT inst_addr_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- TOC entry 3207 (class 2606 OID 148666)
-- Name: inst_class_periode_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_periode
    ADD CONSTRAINT inst_class_periode_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3203 (class 2606 OID 148671)
-- Name: institution_class_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY institution_class
    ADD CONSTRAINT institution_class_fk FOREIGN KEY (institution_id) REFERENCES institution(institution_id) ON DELETE CASCADE;


--
-- TOC entry 3204 (class 2606 OID 148706)
-- Name: parent_student_pr_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student
    ADD CONSTRAINT parent_student_pr_fk FOREIGN KEY (parent_id) REFERENCES parent(parent_id) ON DELETE CASCADE;


--
-- TOC entry 3205 (class 2606 OID 148711)
-- Name: parent_student_st_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY parent_student
    ADD CONSTRAINT parent_student_st_fk FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;


--
-- TOC entry 3206 (class 2606 OID 148716)
-- Name: payment_employee_employee_id_fkey; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY payment_employee
    ADD CONSTRAINT payment_employee_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE;


--
-- TOC entry 3222 (class 2606 OID 148830)
-- Name: periode_inst_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY periode
    ADD CONSTRAINT periode_inst_fk FOREIGN KEY (institution_id) REFERENCES institution(institution_id) ON DELETE CASCADE;


--
-- TOC entry 3210 (class 2606 OID 148721)
-- Name: student_class_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_class_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3211 (class 2606 OID 148726)
-- Name: student_inst_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_inst_fk FOREIGN KEY (institution_id) REFERENCES institution(institution_id) ON DELETE CASCADE;


--
-- TOC entry 3212 (class 2606 OID 148731)
-- Name: student_parent_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_parent_fk FOREIGN KEY (parent_id) REFERENCES parent(parent_id) ON DELETE CASCADE;


--
-- TOC entry 3213 (class 2606 OID 148736)
-- Name: student_parentf_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_parentf_fk FOREIGN KEY (parentf_id) REFERENCES parent(parent_id);


--
-- TOC entry 3214 (class 2606 OID 148741)
-- Name: student_personf_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_personf_fk FOREIGN KEY (person_ref_id) REFERENCES person_ref(person_ref_id) ON DELETE CASCADE;


--
-- TOC entry 3197 (class 2606 OID 148756)
-- Name: teach_crs_inst_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_course
    ADD CONSTRAINT teach_crs_inst_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3218 (class 2606 OID 148761)
-- Name: teach_crs_th_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours
    ADD CONSTRAINT teach_crs_th_fk FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id) ON DELETE CASCADE;


--
-- TOC entry 3219 (class 2606 OID 148766)
-- Name: teach_in_ch_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class
    ADD CONSTRAINT teach_in_ch_fk FOREIGN KEY (institution_class_id) REFERENCES institution_class(institution_class_id) ON DELETE CASCADE;


--
-- TOC entry 3220 (class 2606 OID 148771)
-- Name: teach_in_th_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_in_class
    ADD CONSTRAINT teach_in_th_fk FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id) ON DELETE CASCADE;


--
-- TOC entry 3221 (class 2606 OID 148776)
-- Name: teacher_add_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teacher
    ADD CONSTRAINT teacher_add_fk FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;


--
-- TOC entry 3195 (class 2606 OID 157424)
-- Name: teacher_class_course_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY class_course
    ADD CONSTRAINT teacher_class_course_fk FOREIGN KEY (teacher_id) REFERENCES employee(employee_id);


--
-- TOC entry 3217 (class 2606 OID 165669)
-- Name: teacher_course_fk; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY teach_cours
    ADD CONSTRAINT teacher_course_fk FOREIGN KEY (course_id) REFERENCES course(course_id);


--
-- TOC entry 3201 (class 2606 OID 148781)
-- Name: user_event_fkey; Type: FK CONSTRAINT; Schema: lae_db; Owner: postgres
--

ALTER TABLE ONLY event
    ADD CONSTRAINT user_event_fkey FOREIGN KEY (user_id) REFERENCES huser(user_id) ON DELETE CASCADE;


-- Completed on 2018-07-01 06:35:25 EDT

--
-- PostgreSQL database dump complete
--

