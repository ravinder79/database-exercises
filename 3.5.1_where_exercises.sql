USE employees;

SELECT * 
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'maya');


SELECT * 
FROM employees
WHERE last_name LIKE ('E%');

SELECT * 
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';


SELECT *
FROM employees
WHERE (MONTH(birth_date) = 12) AND (DAY(birth_date) =25);


SELECT *
FROM employees
WHERE last_name LIKE '%q%';


SELECT * 
FROM employees
WHERE first_name ='Irena' OR first_name ='Vidya' OR first_name= 'maya';


SELECT *
FROM employees
WHERE gender = 'M' AND (first_name ='Irena' OR first_name ='Vidya' OR first_name= 'maya');


SELECT * 
FROM employees
WHERE last_name LIKE ('E%') OR last_name LIKE ('%E');


SELECT * 
FROM employees
WHERE last_name LIKE ('E%') AND last_name LIKE ('%E');

SELECT * 
FROM employees
WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND (MONTH(birth_date) = 12) AND (DAY(birth_date) =25);

SELECT*
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
