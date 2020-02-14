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
WHERE emp_no NOT IN 
(SELECT emp_no
FROM dept_emp
WHERE now() < to_date);



/*Find ALL the current department managers that are female.*/

SELECT first_name, last_name
FROM employees
WHERE gender = 'f' AND emp_no IN 
(SELECT emp_no
FROM dept_manager
WHERE now() BETWEEN from_date and to_date);


/*Find all the employees that currently have a higher than average salary.*/
SELECT  first_name, last_name,
    (SELECT max(salary) 
     FROM salaries 
     WHERE salaries.emp_no = employees.emp_no) employee_salary
FROM employees
WHERE emp_no IN     
    (SELECT emp_no FROM salaries 
    WHERE salary >  
        (SELECT  AVG(salary)
        FROM salaries)
    AND now() BETWEEN from_date AND to_date);


/*How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.What percentage of all salaries is this?*/

SELECT 
	(SELECT count(*) 
	 FROM salaries
    WHERE salary BETWEEN 
	((SELECT max(salary) FROM salaries)-(SELECT stddev(salary) FROM salaries)) AND (SELECT max(salary) FROM salaries) 
   AND (now() BETWEEN salaries.from_date AND salaries.to_date)) AS salary_count,  (SELECT count(*) AS salary_count
FROM salaries
WHERE salary BETWEEN 
	((SELECT max(salary) FROM salaries)-(SELECT stddev(salary) FROM salaries)) AND (SELECT max(salary) FROM salaries) 
  AND (now() BETWEEN salaries.from_date AND salaries.to_date))/count(*)*100 AS percent_of_total_salaries
  FROM salaries
  WHERE to_date>curdate();



/*BONUS Find ALL the department NAMES that currently have female managers.*/


SELECT (SELECT dept_name FROM departments WHERE departments.dept_no IN 
(SELECT dept_no FROM dept_emp WHERE dept_emp.emp_no = employees.emp_no))

FROM employees
WHERE emp_no IN
(SELECT emp_no FROM dept_manager AS dm
WHERE now() BETWEEN dm.from_date AND dm.to_date) AND gender = 'f';

/*BONUS Find the FIRST AND LAST NAME of the employee WITH the highest salary.*/
SELECT first_name, last_name
FROM employees
WHERE emp_no =
(SELECT emp_no 
FROM salaries 
WHERE salary =
(SELECT max(salary) FROM salaries));

/*BONUS Find the department name that the employee with the highest salary works in.*/
SELECT dept_name 
FROM departments
WHERE dept_no =
(SELECT dept_no
FROM dept_emp
WHERE emp_no =
(SELECT emp_no
FROM employees
WHERE emp_no =
(SELECT emp_no 
FROM salaries 
WHERE salary =
(SELECT max(salary) FROM salaries))));