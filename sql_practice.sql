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
GROUP BY dept_no;


/* Which department has the highest average salary? Hint: Use current not historic information. */

SELECT dept_no, AVG(salary) FROM salaries AS s
JOIN dept_emp USING (emp_no)
WHERE s.to_date > now() AND dept_emp.to_date > now()
GROUP BY dept_no
ORDER BY AVG(salary) DESC
LIMIT 1;

/* Who is the highest paid employee in the Marketing department? */

SELECT first_name, last_name FROM employees
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
WHERE dept_emp.dept_no = 'd001' AND dept_emp.to_date > now()
ORDER BY salary DESC
LIMIT 1;


/* Which current department manager has the highest salary? */

SELECT first_name, last_name, dept_no, salary FROM dept_manager AS d
LEFT JOIN salaries ON d.emp_no = salaries.emp_no
LEFT JOIN employees ON d.emp_no = employees.emp_no
WHERE d.to_date > now() AND salaries.to_date > now()
ORDER BY salary DESC
LIMIT 1;


/* Find the highest paid employee in each department. */
SELECT * FROM employees AS e
JOIN salaries s ON e.emp_no = s.emp_no
JOIN dept_emp d ON e.emp_no = d.emp_no
WHERE d.to_date > now() AND s.to_date > now() AND (dept_no, salary) IN 
(SELECT dept_no, max(salary) FROM employees e1
JOIN salaries s1 ON e1.emp_no = s1.emp_no
JOIN dept_emp d1 ON e1.emp_no = d1.emp_no
GROUP BY d1.dept_no);

/* Find all the employees with the same hire date as employee 101010 using a sub-query. */

SELECT * FROM employees e
WHERE hire_date IN (SELECT hire_date FROM employees e2 WHERE e2.emp_no = 101010);

/* Find all the titles held by all employees with the first name Aamod. */
SELECT title, count(title) FROM employees e
JOIN titles USING (emp_no)
WHERE first_name = 'Aamod'
GROUP BY title;

CREATE TABLE emps AS
SELECT
	e.*,
	s.salary,
	d.dept_name AS department,
	d.dept_no
FROM employees.employees e
JOIN employees.salaries s USING (emp_no)
JOIN employees.dept_emp de USING (emp_no)
JOIN employees.departments d USING (dept_no);

ALTER TABLE emps ADD  mean_salary FLOAT;
ALTER TABLE emps ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;

DROP TABLE salary_agg;

CREATE TEMPORARY TABLE salary_agg AS 
SELECT AVG(salary) AS mean , stddev(salary) AS sd FROM emps;

SELECT * FROM salary_agg;

UPDATE emps SET mean_salary = (SELECT mean FROM salary_agg);
UPDATE emps SET sd_salary = (SELECT sd FROM salary_agg);
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;



select * from customers;

select * from calls;

select name, abc.outgoing, sum(cr1 + cr2)
from (
select incoming, outgoing, cr1,cr2 
from 
((select incoming, sum(duration) as cr1 from calls
 where date like '2020-07-%%'
group by incoming) as inc
left  join
(select outgoing, sum(if (duration > 120, 500 + (duration-120)*2 , 500)) as cr2
from calls 
where date like '2020-07-%%'
group by outgoing) as outg ON
inc.incoming = outg.outgoing)

union

(select ifnull(incoming,outgoing), ifnull(outgoing,incoming), ifnull(cr1,0),ifnull(cr2,0)  from 
(select incoming, sum(duration) as cr1 from calls
 where date like '2020-07-%%'
group by incoming) as inc
right  join
(select outgoing, sum(if (duration > 120, 500 + (duration-120)*2 , 500)) as cr2
from calls   
 where date like '2020-07-%%'
group by outgoing) as outg ON
inc.incoming = outg.outgoing)) as abc
left join customers
ON abc.outgoing = customers.number
group by outgoing;


-- Another solution

select incoming, sum(cr1) from 
(select * from 
(select incoming, sum(duration) as cr1 from calls
where date like '2020-07-%%'
group by incoming) as inc

union 

select * from (
select outgoing, sum(if (duration > 120, 500 + (duration-120)*2 , 500)) 
as cr2 from calls
where date like '2020-07-%%'
group by outgoing) as outgo) as grouped
group by incoming;

/*write a query that shows each department along with the name of the current manager for that department.*/

SELECT dept_name, concat(first_name, ' ', last_name) FROM departments
LEFT JOIN dept_manager USING (dept_no)
LEFT JOIN employees USING (emp_no)
WHERE dept_manager.to_date > now();

/*Find the name of all departments currently managed by women.*/
SELECT dept_name FROM departments
LEFT JOIN dept_manager USING (`dept_no`)
LEFT JOIN employees USING (emp_no)
WHERE dept_manager.to_date > now() AND gender = 'F';

/*Find the current titles of employees currently working in the Customer Service department.*/
SELECT title, count(*) FROM titles
JOIN dept_emp USING (emp_no)
WHERE titles.to_date> now() AND dept_no = 'd009'
GROUP BY title;

/*Find the current salary of all current managers.*/
SELECT dept_no, salary FROM dept_manager
LEFT JOIN salaries USING (emp_no)
WHERE dept_manager.to_date > now() AND salaries.to_date > now();

/*Find the smallest and largest current salary from the salaries table.*/
SELECT salary FROM salaries
WHERE to_date > now()
ORDER BY salary DESC
LIMIT 1;


/* MYSQL */
SELECT * FROM employees
JOIN salaries USING (emp_no)
ORDER BY salaries.from_date;


SELECT * FROM salaries s1
WHERE s1.from_date = (SELECT s2.emp_no FROM salaries s2 WHERE s2.emp_no = s1.emp_no ORDER BY s2.from_date DESC LIMIT 1);


SELECT * FROM 
(SELECT emp_no, min(from_date) AS min_date FROM salaries
WHERE YEAR(from_date) = 1986
GROUP BY `emp_no`) AS s1
INNER JOIN salaries s2 ON (s2.emp_no = s1.emp_no AND s2.from_date = s1.min_date);

/*Use Unbounded Preceding to make sure you don't include extra rows if 2 rows evaluate to the same thing*/
select 
name, sum(weight) over (order by weight DESC ROWS between unbounded preceding and current row) as running_total_weight
 from cats 

/*row_number() lets us index the ordered items. Each number is unique */
 select 
row_number()over (order by color, name), name, color 
 from cats 

/* rank() lets us index the ordered items. Unlike row_number() it allows duplicate numbers  */
 select 
rank() over (order by weight DESC, name) as ranking, weight, name
 from cats 


/*dense_rank() differs from rank() as it increases sequentially.
Consider a race where 2 people finished first. Dense_rank assigns the next person 2nd. Rank assigns them 3rd. */

select 
dense_rank() over (order by age DESC) as ranking, name, age
 from cats order by ranking, name

/* percent_rank() scores everything from 0 - 1 allowing us to generate distributions or percentiles */

select 
name, weight, percent_rank() over (order by weight)*100 as percent  
 from cats order by weight

/* cume_dist() is similar to percent_rank(). The difference is the first entry in cume_dist is not 0.*/
select 
name, weight, cast (cume_dist() over (order by weight)*100 as integer) as percentile
 from cats order by weight