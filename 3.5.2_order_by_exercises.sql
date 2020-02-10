USE employees;

SELECT * FROM employees
 WHERE first_name
   IN  ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;


SELECT * FROM employees
 WHERE first_name
   IN  ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;


SELECT * FROM employees
 WHERE first_name
   IN  ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;


SELECT * 
FROM employees
WHERE last_name LIKE ('%E%')
ORDER BY emp_no;

SELECT * 
FROM employees
WHERE last_name LIKE ('%E%')
ORDER BY emp_no DESC;

SELECT * FROM employees
 WHERE first_name
   IN  ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;


SELECT * 
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (MONTH(birth_date) = 12) AND (DAY(birth_date) =25)
ORDER BY birth_date DESC, hire_date DESC;
