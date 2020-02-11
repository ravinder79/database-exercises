USE employees;



SELECT concat(first_name,' ', last_name) as Full_name
FROM employees
WHERE last_name LIKE ('E%E')
ORDER BY emp_no;


SELECT UPPER(concat(first_name,' ', last_name)) as FULL_NAME
FROM employees
WHERE last_name LIKE ('E%E')
ORDER BY emp_no;



SELECT * ,datediff(now(), hire_date)
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (MONTH(birth_date) = 12) AND (DAY(birth_date) =25)
ORDER BY birth_date DESC, hire_date DESC;

SELECT max(salary) AS Max_Salary, min(salary) AS Min_Salary
FROM salaries;

SELECT lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,1,4))) AS username
, first_name AS First_Name, last_name AS Last_Name, birth_date AS Birth_Date 
FROM employees;
