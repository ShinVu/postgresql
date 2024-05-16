DROP DATABASE IF EXISTS billing;

CREATE DATABASE billing
    WITH
    OWNER = admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE billing
    IS 'Database for cloud billing dataset';

GRANT ALL ON DATABASE billing TO admin;


\c billing;

CREATE SCHEMA IF NOT EXISTS billing_data AUTHORIZATION admin;

BEGIN;


CREATE TABLE IF NOT EXISTS billing_data.fact_sales
(
    sale_id serial NOT NULL,
    date_id integer,
    store_sur_id integer,
    totalsales numeric(16, 2),
    PRIMARY KEY (sale_id)
);

CREATE TABLE IF NOT EXISTS billing_data.dim_store
(
    store_sur_id serial NOT NULL,
    store_id integer,
    city text,
    country text,
    PRIMARY KEY (store_sur_id)
);

CREATE TABLE IF NOT EXISTS billing_data.dim_date
(
    date_id serial NOT NULL,
    date date,
    day smallint,
    month smallint,
    year smallint,
    quarter smallint,
    PRIMARY KEY (date_id)
);

ALTER TABLE IF EXISTS billing_data.fact_sales
    ADD FOREIGN KEY (date_id)
    REFERENCES billing_data.dim_date (date_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS billing_data.fact_sales
    ADD FOREIGN KEY (store_sur_id)
    REFERENCES billing_data.dim_store (store_sur_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;