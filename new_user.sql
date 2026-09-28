CREATE DATABASE vtapp;

CREATE USER vtapp_user
WITH VALID UNTIL '2027-01-01';

-- grant all privileges on database
GRANT ALL PRIVILEGES ON DATABASE vtapp to vtapp_user;

/*
-- give access to schema
CREATE SCHEMA new_schema;
GRANT USAGE ON SCHEMA new_schema TO vtapp_user;


-- give only SELECT, INSERT permissions on all tables in particular schema
GRANT SELECT, INSERT ON ALL TABLES IN SCHEMA new_schema TO vtapp_user;


-- Grant particular permissions to only particular table
CREATE TABLE new_schema.new_table
(id SERIAL PRIMARY KEY,
name TEXT
);
GRANT SELECT,INSERT ON TABLE new_schema.new_table TO vtapp_user;
*/

ALTER USER vtapp_user PASSWORD 'root';




