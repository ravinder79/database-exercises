/* Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN). */

SELECT * FROM employees
WHERE `first_name` IN ('Irene', 'Vidya', 'Maya');

/* Find all employees whose last name starts with 'E' */

SELECT * FROM employees
WHERE last_name LIKE 'E%';

/* Find all employees hired in the 90s */
SELECT * FROM  employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

/* Find all employees born on Christmas */

SELECT * FROM employees
WHERE birth_date LIKE '%%%%-12-25';

/* Find all employees with a 'q' in their last name  */

SELECT * FROM employees
WHERE last_name LIKE '%q%';


/* Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN */

SELECT * FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

/* Add a condition to the previous query to find everybody with those names who is also male */

SELECT * FROM `employees`
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';


/* Find all employees whose last name starts or ends with 'E'  */

SELECT * FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

/* Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' */

SELECT * FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';

/* Find all employees with a 'q' in their last name but not 'qu' */

SELECT * FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';


/* Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson */
SELECT Unix_timestamp() - unix_timestamp('1979-10-16');

SELECT datediff(CURDATE(), '1979-10-16');

SELECT 1 + '4', '3' - 1, CONCAT('Here is a number: ', 123);

SELECT CAST(123 AS CHAR), CAST('123' AS UNSIGNED);

/* Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name. */

SELECT upper(CONCAT(first_name, ' ', last_name)) FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';

/* For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()) */

SELECT emp_no, first_name, last_name, datediff(curdate(), hire_date) AS days_with_company
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';

/* Find the smallest and largest salary from the salaries table. */
SELECT max(salary), min(salary) FROM salaries;

/* Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. */

SELECT first_name, last_name, birth_date, lower(CONCAT(first_name, substr(last_name, 1,4), '_', substr(birth_date, 6,2), substr(birth_date,1,4))) AS 'username'
FROM employees;

SELECT
    IFNULL(
        (SELECT DISTINCT salary
        FROM salaries
        ORDER BY salary DESC
        LIMIT 1 OFFSET 1
        ), NULL) AS SecondHighestSalary
FROM salaries
LIMIT 1;

SELECT IFNULL((SELECT salary
FROM salaries
ORDER BY salary DESC
LIMIT 1 OFFSET 1), NULL)
FROM salaries
LIMIT 1;

SELECT salary, count
FROM 
 (SELECT salary, count(salary) AS count
 FROM salaries
 GROUP BY salary) AS s
WHERE count >1 ;


SELECT salary, count(salary) AS count FROM salaries
GROUP BY salary
HAVING count >1;

/* 
PROBLEM #3: Rising Temperature
Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates. */

SELECT a.ID
FROM weather a weather b
WHERE a.temp > b.temp AND datediff(a.recorddate, b.recorddate) = 1;

/* /highest salary from each department */
SELECT emp_no, salary, dept_no FROM employees
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
WHERE emp_no IN (SELECT );

/* Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department. */

SELECT dept_name, concat(first_name, ' ', last_name) AS 'current_manager' FROM departments
JOIN dept_manager USING (dept_no)
LEFT JOIN employees USING (emp_no)
WHERE to_date LIKE '9999%';


/* Find the name of all departments currently managed by women. */

SELECT dept_name, concat(first_name, ' ', last_name) AS 'current_manager' FROM departments
JOIN dept_manager USING (dept_no)
LEFT JOIN employees USING (emp_no)
WHERE to_date LIKE '9999%' AND gender = 'F';

/* Find the current titles of employees currently working in the Customer Service department. */

SELECT title, count(title) FROM dept_emp
JOIN titles USING (emp_no)
WHERE dept_no = 'd009' AND titles.to_date > now()
GROUP BY title;

/* Find the current salary of all current managers. */

SELECT dept_name, salary, concat(first_name, ' ', last_name) AS 'manager' FROM dept_manager
JOIN salaries USING (emp_no)
JOIN departments USING (dept_no)
JOIN employees USING (emp_no)
WHERE dept_manager.to_date > now() AND salaries.to_date > now();


/* Find the number of employees in each department. */

SELECT dept_no, count(dept_no) FROM `dept_emp`
WHERE to_date > now()
GROUP BY dept_no