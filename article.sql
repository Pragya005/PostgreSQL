CREATE SCHEMA article_schema;


CREATE TABLE article_schema.Users(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name TEXT NOT NULL CHECK(name <> ''),
	role TEXT CHECK(role IN ('admin', 'normal'))
);


CREATE TABLE article_schema.Categories(
	Cname TEXT PRIMARY KEY
);


CREATE TABLE article_schema.Articles(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	topic TEXT,
	content TEXT,
	user_id INT REFERENCES article_schema.Users(id),
	category TEXT REFERENCES article_schema.Categories(Cname)
);


CREATE TABLE article_schema.Comments(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	comment TEXT,
	article_id INT REFERENCES article_schema.Articles(id),
	user_id INT REFERENCES article_schema.Users(id)
);


--dummy data
INSERT INTO article_schema.Users (name, role) VALUES
('user1', 'admin'),
('user2', 'normal'),
('user3', 'normal');

INSERT INTO article_schema.Categories (Cname) VALUES
('Technology'),
('Science'),
('Education');

INSERT INTO article_schema.Articles (topic, content, user_id, category) VALUES
('Machine Learning',
 'Machine learning enables computers to learn patterns from data.',
 1, 'Technology'),

('Cybersecurity',
 'Cybersecurity protects systems, networks, and data from digital attacks.',
 2, 'Technology'),

('Climate Change',
 'Climate change refers to long-term shifts in temperatures and weather patterns.',
 3, 'Science'),

('Renewable Energy',
 'Solar and wind energy are important sources of renewable power.',
 1, 'Science'),

('Online Learning',
 'Online learning allows students to access educational resources over the internet.',
 3, 'Education'),

('Artificial Neural Networks',
 'Neural networks are computational models inspired by the human brain.',
 1, 'Technology');

INSERT INTO article_schema.Comments (comment, article_id, user_id) VALUES
('Very informative!', 1, 2),
('Great explanation!', 5, 2),
('Looking forward to more.', 2, 3),
('Interesting topic!', 3, 2)
('Looking forward to seeing more',3,2);

SELECT * FROM article_schema.Users;
SELECT * FROM article_schema.Categories;
SELECT * FROM article_schema.Articles;
SELECT * FROM article_schema.Comments;


--select all articles whose author's name is user3
SELECT a.id, topic, content FROM article_schema.Articles a
JOIN article_schema.Users u ON a.user_id = u.id
WHERE name = 'user3';

-- select all articles from above query and comments associated with those articles(join)
SELECT topic, content, comment FROM article_schema.Articles a
JOIN article_schema.Users u ON a.user_id = u.id
JOIN article_schema.Comments c ON a.id = c.article_id
WHERE u.name = 'user3';

--select all articles from above query and comments associated with those articles(subquery)
SELECT article_id, topic, content, comment FROM article_schema.Comments c
JOIN article_schema.Articles a ON a.id = c.article_id 
WHERE a.user_id IN
(
	SELECT id FROM article_schema.Users
	WHERE name = 'user3'
)

--query to select all articles with zero comments.
SELECT * FROM article_schema.Articles
WHERE id NOT IN
(
	SELECT DISTINCT article_id
	FROM article_schema.Comments
);

--query to select article with maximum comments
SELECT * FROM article_schema.Articles 
WHERE id =(SELECT article_id
	FROM article_schema.Comments
	GROUP BY article_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

-- query to select article which does not have more than one comment by same user
SELECT a.id, a.topic
FROM article_schema.Articles a
LEFT JOIN article_schema.Comments c
ON a.id = c.article_id
GROUP BY a.id
HAVING COUNT(c.id) <= COUNT(DISTINCT c.user_id);

