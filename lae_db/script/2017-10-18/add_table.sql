
--	|  

CREATE TABLE lae_db.penality_type(
	penality_type_id serial PRIMARY KEY,
	penalty_type_name character varying(45),
	penality_type_desc text,
	penality_type_free double precision,
    created_by character varying(45),
    date_created timestamp(6),
    modified_by character varying(45),
    date_modified timestamp(6)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE lae_db.penality_type OWNER TO postgres;


CREATE TABLE lae_db.penality(
    penalty_id serial PRIMARY KEY,
    penality_type_id integer,
    penalty_desc text,
    penalty_fee double precision,
    created_by character varying(45),
    date_created timestamp(6),
    modified_by character varying(45),
    date_modified timestamp(6),

    CONSTRAINT fk_penality_type FOREIGN KEY (penality_type_id)
    REFERENCES lae_db.penality_type (penality_type_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE lae_db.penality OWNER TO postgres;


--	|	

CREATE TABLE lae_db.absence(
	absence_id serial PRIMARY KEY,
	student_id integer NOT NULL,
	absence_motif text,
	absence_details text,
	created_by character varying(45),
    date_created timestamp(6),
    modified_by character varying(45),
    date_modified timestamp(6),
    CONSTRAINT fk_absence_std FOREIGN KEY (student_id)
    REFERENCES lae_db.student (student_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE lae_db.absence OWNER TO postgres;

-- | 


