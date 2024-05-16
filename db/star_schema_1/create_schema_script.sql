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


CREATE TABLE IF NOT EXISTS billing_data.fact_billing
(
    billing_id serial NOT NULL,
    time_id integer,
    customer_sur__id integer,
    billedamount numeric(7, 5),
    PRIMARY KEY (billing_id)
);

CREATE TABLE IF NOT EXISTS billing_data.dimension_time
(
    time_id serial NOT NULL,
    month smallint,
    quarter smallint,
    year smallint,
    PRIMARY KEY (time_id)
);

CREATE TABLE IF NOT EXISTS billing_data.dimension_customer
(
    customer_sur_id serial NOT NULL,
    customer_id integer,
    category text,
    country text,
    industry text,
    PRIMARY KEY (customer_sur_id)
);

ALTER TABLE IF EXISTS billing_data.fact_billing
    ADD FOREIGN KEY (time_id)
    REFERENCES billing_data.dimension_time (time_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS billing_data.fact_billing
    ADD FOREIGN KEY (customer_sur__id)
    REFERENCES billing_data.dimension_customer (customer_sur_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;