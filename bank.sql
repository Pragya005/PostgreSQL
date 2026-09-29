CREATE TABLE users
(id SERIAL PRIMARY KEY,
name TEXT,
email TEXT CHECK(email ~* '^[A-Z0-9._]+@[A-Z0-9]+\.[A-Z]+$'),
account_id INTEGER
);

CREATE TABLE accounts
(id SERIAL PRIMARY KEY,
account_no TEXT CHECK(account_no ~ '^[0-9]{9,18}$'),
balance NUMERIC(20,2) CHECK (balance > 0)
);

-- add foreign key
ALTER TABLE users
ADD constraint fk_users FOREIGN KEY(account_id)
REFERENCES accounts(id);


INSERT INTO accounts(account_no, balance) VALUES
('179972347899',5240.00),
('434168014726',30000.00),
('345534354343',2.00);

INSERT INTO users(name, email, account_id) VALUES
('Pragya', 'pragya2005@gmail.com',1),
('Drashti', 'varshney2002@mail.com', 3),
('Sanjeev', 'sanjeev.2000@yahoo.in', 2);


-- user deposits Rs. 1000 in his account
BEGIN;

UPDATE accounts
SET balance = balance + 1000
FROM users
WHERE users.account_id = accounts.id
AND users.name = 'Pragya';

COMMIT;


--user withdraws Rs. 500 
BEGIN;

UPDATE accounts
SET balance = balance - 500
FROM users
WHERE users.account_id = accounts.id
AND users.name = 'Pragya';

--ROLLBACK;
COMMIT;


--userA transfers Rs 200 to userB's account
BEGIN;

UPDATE accounts
SET balance = balance - 200
FROM users
WHERE users.account_id = accounts.id
AND users.name = 'Pragya';

UPDATE accounts
SET balance = balance + 200
FROM users
WHERE users.account_id = accounts.id
AND users.name = 'Drashti';

COMMIT;

