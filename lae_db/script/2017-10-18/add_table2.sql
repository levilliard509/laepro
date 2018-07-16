
--	|  

CREATE TABLE lae_db.payment_periode(
	payment_periode_id serial PRIMARY KEY,
	payment_periode_value double precision,
	payment_periode_date_start date,
	payment_periode_date_end date,
    created_by character varying(45),
    date_created timestamp(6),
    modified_by character varying(45),
    date_modified timestamp(6)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE lae_db.payment_periode OWNER TO postgres;



-- | 


