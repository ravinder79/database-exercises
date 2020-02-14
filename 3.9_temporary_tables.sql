/*1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns*/
ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

/* 1b Update the table so that full name column contains the correct data*/

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, " ", last_name);


/* 1c Remove the first_name and last_name columns from the table.*/

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;


/* 1d What is another way you could have ended up with this same table?*/
UPDATE employees_with_departments
SET first_name = CONCAT(first_name, " ", last_name) as full_name
ALTER TABLE employees_with_departments DROP COLUMN last_name;



/*Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. */
CREATE TEMPORARY TABLE payments_temp AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment;

ALTER TABLE payments_temp MODIFY amount FLOAT; /* this modifies 'amount' to 'float' */
UPDATE payments_temp SET amount = amount*100; /*this modifies 'amount' to cents*/


/*Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department TO WORK FOR? The worst?*/
CREATE  TABLE temp_emp AS
SELECT salaries.emp_no, salary, salaries.to_date, salaries.from_date, dept_emp.to_date AS e_to_date, dept_emp.from_date AS e_from_date, dept_name, dept_emp.dept_no
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

CREATE TABLE avg_table AS
(SELECT dept_name, AVG(salary) AS avg_salary
FROM temp_emp
 WHERE now() < to_date AND now() < e_to_date
 GROUP BY dept_name);


ALTER TABLE avg_table ADD z_score FLOAT;
UPDATE avg_table SET z_score = (avg_salary- (SELECT AVG(salary) 
    FROM temp_emp WHERE now() < to_date AND now() < e_to_date))/(SELECT stddev(salary) 
    FROM temp_emp WHERE now() < to_date AND now() < e_to_date) ;

/** the best dept to work for is SALES (highest z score) and worst is HUMAN RESOURCES (lowest z score)**/