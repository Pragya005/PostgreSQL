CREATE TABLE Tastes(
Name TEXT,
Filling TEXT,
PRIMARY KEY (Name, Filling)
);

CREATE TABLE Locations
(LName TEXT PRIMARY KEY, Phone TEXT, Address TEXT);

CREATE TABLE Sandwiches(
Location TEXT REFERENCES Locations(LName),
Bread TEXT,
Filling TEXT,
PRICE NUMERIC(10,2),
PRIMARY KEY(Location, Bread, Filling)
);

INSERT INTO Tastes (Name, Filling) VALUES
('Brown', 'Turkey'),
('Brown', 'Beef'),
('Brown', 'Ham'),
('Jones', 'Cheese'),
('Green', 'Beef'),
('Green', 'Turkey'),
('Green', 'Cheese');

INSERT INTO Locations (LName, Phone, Address) VALUES
('Lincoln', '683 4523', 'Lincoln Place'),
('O''Neils', '674 2134', 'Pearse St'),
('Old Nag', '767 8132', 'Dame St'),
('Buttery', '702 3421', 'College St');

INSERT INTO Sandwiches (Location, Bread, Filling, Price) VALUES
('Lincoln', 'Rye', 'Ham', 1.25),
('O''Neils', 'White', 'Cheese', 1.200),
('O''Neils', 'Whole', 'Ham', 1.25),
('Old Nag', 'Rye', 'Beef', 1.35),
('Buttery', 'White', 'Cheese', 1.00),
('O''Neils', 'White', 'Turkey', 1.35),
('Buttery', 'White', 'Ham', 1.10),
('Lincoln', 'Rye', 'Beef', 1.35),
('Lincoln', 'White', 'Ham', 1.30),
('Old Nag', 'Rye', 'Ham', 1.40);

-- places where Jones can eat(subquery)
SELECT * FROM LOCATIONS 
WHERE LName IN
(
	SELECT Location FROM Sandwiches
	WHERE Filling IN
	(
		SELECT Filling FROM Tastes
		WHERE Name = 'Jones'
	)
);

--places where Jones can eat(join)
SELECT l.Lname, l.Phone, l.Address FROM Locations l
JOIN Sandwiches s ON s.Location = l.LName
JOIN Tastes t ON t.Filling = s.Filling
WHERE t.Name = 'Jones';

-- for each location the number of people who can eat there
SELECT l.LName AS "Location", COUNT(DISTINCT t.Name) AS no_of_people
FROM Locations l
JOIN Sandwiches s ON s.Location = l.LName
JOIN Tastes t ON t.Filling = s.Filling
GROUP BY l.LName;