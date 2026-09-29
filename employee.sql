CREATE SCHEMA emp;

CREATE TABLE emp.Departments
(id SERIAL PRIMARY KEY, name TEXT);

CREATE TABLE emp.Employees
(id SERIAL PRIMARY KEY,
name TEXT,
salary INTEGER,
department_id INTEGER REFERENCES emp.Departments(id) NOT NULL
);

CREATE TABLE emp.Commissions
(id SERIAL PRIMARY KEY,
employee_id INTEGER REFERENCES emp.Employees(id),
commission_amount INTEGER
);

INSERT INTO emp.Departments (name) VALUES
('Banking'),
('Insurance'),
('Services');

INSERT INTO emp.Employees (name, salary, department_id) VALUES
('Chris Gayle', 1000000, 1),
('Michael Clarke', 800000, 2),
('Rahul Dravid', 700000, 1),
('Ricky Pointing', 600000, 2),
('Albie Morkel', 650000, 2),
('Wasim Akram', 750000, 3);

INSERT INTO emp.Commissions (employee_id, commission_amount) VALUES
(1, 5000),
(2, 3000),
(3, 4000),
(1, 4000),
(2, 3000),
(4, 2000),
(5, 1000),
(6, 5000);

SELECT * FROM emp.Departments;
SELECT * FROM emp.Employees;
SELECT * FROM emp.Commissions;


-- total_commission of each employee in desc order
SELECT employee_id, SUM(commission_amount) AS sum
FROM emp.Commissions
GROUP BY employee_id
ORDER BY sum DESC;


-- employee who gets the highest total commission
SELECT id, name, department_id FROM emp.Employees
WHERE id = (
	SELECT employee_id
	FROM emp.Commissions
	GROUP BY employee_id
	ORDER BY SUM(commission_amount) DESC
	LIMIT 1
);


-- employee with 4th Highest salary from employee table
SELECT id, name
FROM emp.Employees
ORDER BY salary DESC
OFFSET 3
LIMIT 1;


-- department giving highest commission
SELECT d.name, SUM(c.commission_amount)
FROM emp.Departments d
JOIN emp.Employees e ON d.id = e.department_id
JOIN emp.Commissions c ON e.id = c.employee_id
GROUP BY d.id, d.name
HAVING SUM(c.commission_amount) = (
    SELECT MAX(total_commission)
    FROM (
        SELECT SUM(c.commission_amount) AS total_commission
        FROM emp.Commissions c
        JOIN emp.Employees e
        ON c.employee_id = e.id
        GROUP BY e.department_id
    )
);


--employees getting commission more than 3000
EXPLAIN SELECT e.name, SUM(commission_amount) AS total_commission
FROM emp.Commissions c
JOIN emp.Employees e ON e.id = c.employee_id 
GROUP BY e.id, e.name
HAVING SUM(commission_amount)>3000
ORDER BY total_commission;