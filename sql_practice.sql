/* Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN). */

SELECT * FROM employees
WHERE `first_name` IN ('Irene', 'Vidya', 'Maya');

/* Find all employees whose last name starts with 'E' */

SELECT * FROM employees
WHERE last_name LIKE 'E%';

/* Find all employees hired in the 90s */
SELECT * FROM  employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

