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

