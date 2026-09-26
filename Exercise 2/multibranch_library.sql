CREATE TABLE Branch
(
BCode TEXT PRIMARY KEY,
Librarian TEXT,
Address TEXT
);

CREATE TABLE Titles
(
Title TEXT PRIMARY KEY ,
Author TEXT,
Publisher TEXT
);

CREATE TABLE Holdings
(
Branch TEXT REFERENCES Branch(BCode),
Title TEXT REFERENCES Titles(Title),
copies INTEGER
);

INSERT INTO Branch VALUES
('B1','John Smith','2 Anglesea Rd'),
('B2','Mary Jones','34 Pearse St'),
('B3','Francis Owens','Grange X');

INSERT INTO Titles VALUES
('Susannah','Ann Brown', 'Macmillan'),
('How to Fish','Amy Fly', 'Stop Press'),
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('The Wife', 'Ann Brown', 'Macmillan');

INSERT INTO Holdings VALUES
('B1','Susannah',3),
('B1','How to Fish', 2),
('B1','A History of Dublin',1),
('B2','How to Fish',4),
('B2','Computers',2),
('B2','The Wife',3),
('B3','A History of Dublin',1),
('B3','Computers',4),
('B3','Susannah',3),
('B3','The Wife',1);

--
SELECT Title FROM Titles
WHERE Publisher = 'Macmillan';

--
SELECT DISTINCT Branch FROM Holdings 
WHERE Title IN
(
	SELECT Title FROM Titles
	WHERE Author = 'Ann Brown'
);

--
SELECT DISTINCT h.Branch
FROM Holdings h
JOIN Titles t ON t.Title = h.Title
WHERE t.Author = 'Ann Brown';

--
SELECT Branch, SUM(copies) AS total_books
FROM Holdings
GROUP BY Branch;