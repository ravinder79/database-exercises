/*Find all the employees with the same hire date as employee 101010 using a sub-query.*/

SELECT *
FROM employees

WHERE hire_date IN 
(SELECT hire_date
FROM employees
WHERE emp_no =101010);


/*Find all the titles held by all employees with the first name Aamod.*/

SELECT title, count(title)
FROM titles

WHERE emp_no IN
(SELECT emp_no
FROM employees
WHERE first_name = 'Aamod')
GROUP BY title;



/*How many people in the employees table are no longer working for the company?*/

SELECT count(*)
FROM employees
WHERE emp_no IN 
(SELECT emp_no
FROM dept_emp
WHERE now() > to_date);


/*Find ALL the current department managers that are female.*/

SELECT first_name, last_name
FROM employees
WHERE gender = 'f' AND emp_no IN 
(SELECT emp_no
FROM dept_manager
WHERE now() BETWEEN from_date and to_date);

/*work in progress*/
SELECT *
FROM employees
WHERE emp_no IN
(SELECT emp_no FROM salaries
WHERE salary >
(
SELECT AVG(salary)
FROM salaries
WHERE now() BETWEEN from_date AND to_date
GROUP BY salary
));