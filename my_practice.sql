INSERT INTO mysql_test_posts (author_initials, title, body, created_at) 
VALUES ('DR', 'A New Post', 'This is another post. Good times are had by all.', NOW());

--------------------------------------- WEEK 2 ---------------------------------------
-- create posts week 2 table
CREATE TABLE test_posts_2 (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  author_initials CHAR(2) DEFAULT '**',
  title VARCHAR(255),
  body TEXT,
  active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW()
);  

-- insert without author intials
INSERT INTO test_posts_2 (title, body, created_at) VALUES ('My Anonymous Post', "I do not have an account on this website, but that won't stop be from blabbering on.  Here I go...", NOW());

-- insert with author intitals
INSERT INTO test_posts_2 (author_initials, title, body, created_at) VALUES ('DR', 'Author Post', 'Yep I have an account', NOW());

-- insert with NULL title.
INSERT INTO test_posts_2 (body, created_at) VALUES ('Post with a NULL title', NOW());

-- insert with blank string title
INSERT INTO test_posts_2 (title, body, created_at) VALUES (' ', 'Post with a blank string title', NOW());

-- insert with blank title
INSERT INTO test_posts_2 (title, body, created_at) VALUES ('', 'Post with an empty title', NOW());

-- insert without created_at value
INSERT INTO test_posts_2 (author_initials, title, body) VALUES ('DR', 'My Title', 'No timstamp value here.');



-- select with where clause
SELECT * FROM test_posts_2 WHERE author_initials = '**';

-- string without quotes.  it will fail.
SELECT * FROM test_posts_2 WHERE author_initials = DR;

-- where clause with integer
SELECT * FROM test_posts_2 WHERE id = 1;

-- greater than comparison operator
SELECT * FROM test_posts_2 WHERE id > 2;

-- comparison of DATETIME
SELECT * FROM test_posts_2 WHERE created_at > '2012-01-01';
SELECT * FROM test_posts_2 WHERE created_at > '2013-01-01';
SELECT * FROM test_posts_2 WHERE created_at < NOW();

-- comparison by NULL values
SELECT * FROM test_posts_2 WHERE title IS NULL;
SELECT * FROM test_posts_2 WHERE title IS NOT NULL;

-- improper NULL queries
SELECT * FROM test_posts_2 WHERE title = NULL;
SELECT * FROM test_posts_2 WHERE title = 'NULL';


-- trivial IN query
SELECT * FROM test_posts_2 WHERE title IN ('My Anonymous Post', 'My Title');

-- trivial NOT IN query
SELECT * FROM test_posts_2 WHERE title NOT IN ('My Anonymous Post', 'My Title');

-- multiple conditions (AND)
SELECT * FROM test_posts_2 WHERE author_initials = 'DR' AND title = 'My Title';

-- OR operator
SELECT * FROM test_posts_2 WHERE title = 'My Title' OR title = 'Author Post';



-- my_Foods Table
CREATE TABLE my_foods (
  id INT(11) AUTO_INCREMENT,
  name VARCHAR(255),
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY(id)
);
-- insert some data
INSERT INTO my_foods (name, description) VALUES ('Stir Fry', "Tasty and healthy");
INSERT INTO my_foods (name, description) VALUES ('Carob Covered Almonds', "Tasty and expensive");
INSERT INTO my_foods (name, description) VALUES ('Shanua Roll', "Freakin' Delish!");

-- select with verbose column naming
SELECT my_foods.name, my_foods.description, my_foods.created_at FROM my_foods;

-- select with column aliases
SELECT my_foods.name AS 'My Foodie Name', my_foods.description AS Descrip, my_foods.created_at AS creation_date
FROM my_foods;

-- select with table alias
SELECT f.name, f.description, f.created_at
FROM my_foods AS f;

-- select with table and column aliases
SELECT f.name AS 'Food Name', f.description AS 'Food Description', f.created_at AS 'Creation Date'
FROM my_foods AS f;








-- create les_authors table
CREATE TABLE les_authors (
  id INT(11) AUTO_INCREMENT,
  email VARCHAR(255),
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY(id)
);
-- insert data into les_authors table
INSERT INTO les_authors (email, first_name, last_name) VALUES ('georgerr@winterfell.com', 'George', 'Martin');
INSERT INTO les_authors (email, first_name, last_name) VALUES ('jamie@lanister.com', 'Jamie', 'Lanister');
INSERT INTO les_authors (email, first_name, last_name) VALUES ('tyrion@lanister.com', 'Tyrion', 'Lanister');
INSERT INTO les_authors (email, first_name, last_name) VALUES ('john@winterfell.com', 'John', 'Snow');
INSERT INTO les_authors (email, first_name, last_name) VALUES ('ayra@winterfell.com', 'Arya', 'Stark');
INSERT INTO les_authors (email, first_name, last_name) VALUES ('ned@winterfell.com', 'Ned', 'Stark');
INSERT INTO les_authors (email, first_name, last_name) VALUES ('tywin@lanister.com', 'Tywin', 'Lanister');


-- improved posts table
CREATE TABLE improved_test_posts_2 (
  id INT(11) AUTO_INCREMENT,
  author_id INT(11),
  title VARCHAR(255),
  body TEXT,
  active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY(id)
);

-- example improved_test_posts_2 insert
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (1, 'Next Book ?', 'One day I will finish.  Get off my back you nerds!');

-- insert data into improved_test_posts_2
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (2, 'About Me', 'Damn it feels good to be a Lanister!');
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (3, 'The Dwarf', 'I am by far the most likeable character.');
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (3, 'My Family', 'Rich but stupid.');
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (5, 'The Starks', 'Noble but stupid.');
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (3, 'The Imp', 'I hate that name.');
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (5, 'Me too', 'Also possibly the most likeable character.');
INSERT INTO improved_test_posts_2 (author_id, title, body) VALUES (4, 'The Bastard', "Just literally.  I'm a very honrable guy.");


-- join using the where clause
SELECT les_authors.id, les_authors.first_name, les_authors.last_name, improved_test_posts_2.id, improved_test_posts_2.title
FROM les_authors, improved_test_posts_2
WHERE les_authors.id = improved_test_posts_2.author_id;

-- join using INNER JOIN
SELECT les_authors.id, les_authors.first_name, les_authors.last_name, improved_test_posts_2.id, improved_test_posts_2.title
FROM les_authors INNER JOIN improved_test_posts_2 ON (les_authors.id = improved_test_posts_2.author_id);

-- cleaner INNER JOIN
SELECT a.id AS author_id, a.first_name, a.last_name, p.id AS post_id, p.title, p.body
FROM les_authors AS a INNER JOIN improved_test_posts_2 AS p ON (a.id = p.author_id)
WHERE a.last_name = 'Lanister';


-- join without conditions
SELECT les_authors.id, improved_test_posts_2.id
FROM les_authors INNER JOIN improved_test_posts_2;

