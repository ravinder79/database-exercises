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


SELECT lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS username
, first_name AS First_Name, last_name AS Last_Name, birth_date AS Birth_Date 
FROM employees;

/*Find the number of years each employee has been with the company, not just the
# number of days.*/

Select *, year(now())-year(hire_date) as Years_with_company
from employees;


/*Find out how old each employee was when they were hired.*/

SELECT *, year(hire_date)-year(birth_date) as Age_when_hired
from employees;

/*Find the most recent date in the dataset. What does this tell you? Does this
  explain the distribution of employee ages?*/

SELECT max(birth_date), max(hire_date)
FROM employees;

/* the last data for "hire_date" is from year 2000, so seems like database is not updated since then.*/
