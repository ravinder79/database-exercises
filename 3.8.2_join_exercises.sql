SELECT* 
FROM users;

SELECT* 
FROM roles;

SELECT* 
FROM users
JOIN roles
ON users.role_id = roles.id;

SELECT* 
FROM users
left JOIN roles
ON users.role_id = roles.id;


SELECT* 
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;


SELECT roles.name, count(*)
FROM roles
LEFT JOIN users
ON roles.id = users.role_id
GROUP BY roles.name;


/*employees database exercises*/

/*write a query that shows each department along with the name of the current manager for that department.*/

SELECT dept_name, concat (first_name, ' ', last_name)
from departments
JOIN dept_manager
ON dept_manager.dept_no = departments.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE now() BETWEEN dept_manager.from_date AND dept_manager.to_date
order by dept_name;



/*Find the name of all departments currently managed by women.*/

SELECT dept_name, concat (first_name, ' ', last_name)
from departments
JOIN dept_manager
ON dept_manager.dept_no = departments.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE now() BETWEEN dept_manager.from_date AND dept_manager.to_date AND employees.gender = 'F'
order by dept_name;




/*Find the current titles of employees currently working in the Customer Service department.*/

SELECT title, count(*)
FROM titles

JOIN dept_emp AS de
ON titles.emp_no = de.emp_no
JOIN departments
ON de.dept_no = departments.dept_no
WHERE dept_name LIKE "Customer Service" AND NOW() BETWEEN titles.from_date AND titles.to_date
AND now() BETWEEN de.from_date AND de.to_date
GROUP BY title;





/*Find the current salary of all current managers.*/

SELECT dept_name, concat (first_name, ' ', last_name), salary
FROM dept_manager
JOIN salaries
ON dept_manager.emp_no = salaries.emp_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
WHERE (NOW() BETWEEN dept_manager.from_date AND dept_manager.to_date)
 AND (NOW() BETWEEN salaries.from_date AND salaries.to_date)
ORDER BY departments.dept_name;



/*Find the number of employees in each department.*/

SELECT dept_emp.dept_no, departments.dept_name, count(*)
FROM dept_emp
JOIN departments
ON dept_emp.dept_no = departments.dept_no
JOIN employees
ON employees.emp_no = dept_emp.emp_no
WHERE now() BETWEEN dept_emp.from_date AND dept_emp.to_date
GROUP BY dept_no;



/*Which department has the highest average salary?*/

SELECT departments.dept_name,  AVG(salary)
FROM employees
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON  dept_emp.dept_no = departments.dept_no
WHERE now() BETWEEN salaries.from_date AND salaries.to_date 
AND now() BETWEEN dept_emp.from_date AND dept_emp.to_date 
GROUP BY dept_emp.dept_no
ORDER BY AVG(salary) DESC
LIMIT 1;



/*Who is the highest paid employee in the Marketing department?*/

SELECT first_name, last_name
FROM employees
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON  dept_emp.dept_no = departments.dept_no
WHERE now() BETWEEN salaries.from_date AND salaries.to_date 
AND now() BETWEEN dept_emp.from_date AND dept_emp.to_date 
AND dept_name LIKE 'Marketing'
ORDER BY salary DESC
LIMIT 1;




/*Which current department manager has the highest salary?*/

SELECT salary, first_name, last_name, dept_name
FROM employees
LEFT JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
WHERE now() BETWEEN salaries.from_date AND salaries.to_date 
AND now() BETWEEN dept_manager.from_date AND dept_manager.to_date 
ORDER BY salary DESC
LIMIT 1;

-------------------------------------------------------------





/*Bonus Find the names of all current employees, their department name, and their current manager's name*/

SELECT concat(employees.first_name, ' ',employees.last_name) AS Employee_name, concat(REF.first_name, ' ', REF.last_name)  AS manager_name, dept_name

FROM dept_emp de
JOIN dept_manager AS dm
ON de.dept_no = dm.dept_no
JOIN employees 
ON  de.emp_no = employees.emp_no
JOIN departments
ON de.dept_no = departments.dept_no
JOIN employees AS REF
ON dm.emp_no = REF.emp_no
WHERE now() BETWEEN de.from_date AND de.to_date
AND  now() BETWEEN dm.from_date AND dm.to_date;






/*Bonus Find the highest paid employee in each department.*/
SELECT first_name, last_name, (SELECT max(salary) FROM salaries WHERE salaries.emp_no =  employees.emp_no) AS max_salary, (SELECT max(dept_no) FROM dept_emp WHERE dept_emp.emp_no = employees.emp_no) AS dept_number, (SELECT max(dept_name) FROM departments WHERE departments.dept_no=dept_number) AS department_name

FROM employees WHERE emp_no IN

(SELECT emp_no
FROM salaries WHERE salary IN (
SELECT max(salary) AS max_salary
FROM employees
JOIN salaries
ON salaries.emp_no = employees.emp_no
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE now() BETWEEN salaries.from_date AND salaries.to_date
AND now() BETWEEN dept_emp.from_date AND dept_emp.to_date
GROUP BY dept_name)AND now() BETWEEN salaries.from_date AND salaries.to_date);



