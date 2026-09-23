CREATE TABLE IF NOT EXISTS testing_table(
name TEXT,
contact_name TEXT,
roll_no TEXT
);

ALTER TABLE testing_table
DROP COLUMN name,
ADD COLUMN first_name TEXT,
ADD COLUMN last_name TEXT,
ALTER COLUMN roll_no TYPE INTEGER USING roll_no::INTEGER;

ALTER TABLE testing_table
RENAME COLUMN contact_name TO username;

