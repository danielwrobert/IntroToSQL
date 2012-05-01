-- EXAMPLE QUERY:
SELECT posts_week_4.title, posts_week_4.body, labels.name AS label_name 
FROM posts_week_4 INNER JOIN posts_labels ON (posts_week_4.id = posts_labels.post_id)
  INNER JOIN labels ON (posts_labels.label_id = labels.id)
WHERE labels.name = 'funny';


-- This week please use the data_set.sql for your homework data.

-- 1.  Find the oldest age among all of our employees.
SELECT MAX(age) FROM employees;


-- 2.  Write a query that returns the number of employees that work at 'Lynch-Windler' company.  The query must return a number.  You cannot manually count rows to get this answer.
SELECT COUNT(employees.id)
FROM employees INNER JOIN companies ON (employees.company_id = companies.id)
WHERE companies.name = 'Lynch-Windler';


-- 3.  Write a query that returns the combined age of all employees that work at 'Batz LLC' company.  The query must return a number.
SELECT SUM(employees.age)
FROM employees INNER JOIN companies ON (employees.company_id = companies.id)
WHERE companies.name = 'Batz LLC';


-- 4.  We have a catalog that lists our employees (last_name, first_name) by alphabetical order of the last name.  It also lists 10 employees per page.  Write a query that would return the employees that would be listed on page 3 of this catalog.
SELECT employees.first_name, employees.last_name
FROM employees ORDER BY last_name ASC
	LIMIT 30, 10;


-- 5.  Create the following 2 resource tables blog_posts and tags.  Give them a many to many relationship using an intersection table.  You will need a total of 3 tables to accomplish this task.  Create a few blog_posts and tags with INSERT INTO statements.  Create a few relationships between your blog_posts and tags by inserting data into your intersection table.  Write a query fetching all the blog_posts and their related tags.
SELECT blog_posts.*, tags.*
FROM blog_posts bp INNER JOIN blog_posts_tags bpt ON (bp.id = bpt.blog_posts_id)
	INNER JOIN tags t (t.id = bpt.tags_id);


-- 6.  Write a query that will find employees id, first name, last name and all skill names for the first 10 employees that have skills.
SELECT e.id, e.first_name, e.last_name, s.name
FROM employees e INNER JOIN employees_skills es ON (e.id = es.employee_id)
	INNER JOIN skills s ON (s.id = es.skill_id) GROUP BY e.id LIMIT 10;


-- 7.  Write a query to find return employee first name, last name, and all skill names for employees that work for 'Lebsack-Frami' company.
SELECT e.first_name, e.last_name, s.name
FROM companies c INNER JOIN employees e ON (e.company_id = c.id)
	INNER JOIN employees_skills es ON (e.id = es.employee_id)
	INNER JOIN skills s ON (s.id = es.skill_id)
WHERE c.name = 'Lebsack-Frami';


-- 8.  Write a query to find return employee first name, last name, age, company name, and all skill names for employees that work for 'Watsica-Marquardt' or 'Bechtelar, Turcotte and Hettinger' and are younger than 70.  
SELECT e.first_name, e.last_name, e.age, c.name "Company Name", s.name "Skill Name"
FROM companies c INNER JOIN employees e ON (e.company_id = c.id)
	INNER JOIN employees_skills es ON (e.id = es.employee_id)
	INNER JOIN skills s ON (s.id = es.skill_id)
WHERE (c.name = 'Lebsack-Frami' OR c.name = "Bechtelar, Turcotte and Hettinger")
AND e.age < 70;


-- BONUS:

-- Write a query that will return employee first name, last name, and the number of skills they have.  (hint: use GROUP BY and COUNT)
SELECT e.id, e.first_name, e.last_name, COUNT(s.id) AS "Number of Skills"
FROM employees e INNER JOIN employees_skills es ON (e.id = es.employee_id)
	INNER JOIN skills s ON (s.id = es.skill_id) GROUP BY e.id;


-- Write a query that will return employee first name, last name, and the number of skills they have for employees with more that 1 skill. (hint: use GROUP BY, COUNT, and HAVING)
SELECT e.id, e.first_name, e.last_name, COUNT(s.id) AS "Number of Skills"
FROM employees e INNER JOIN employees_skills es ON (e.id = es.employee_id)
	INNER JOIN skills s ON (s.id = es.skill_id) GROUP BY e.id HAVING (COUNT(s.id) > 1);

-- OR

SELECT e.id, e.first_name, e.last_name, COUNT(es.skill_id) AS "Number of Skills"
FROM employees e INNER JOIN employees_skills es ON (e.id = es.employee_id)
GROUP BY es.employee_id HAVING (COUNT(es.skill_id) > 1);




