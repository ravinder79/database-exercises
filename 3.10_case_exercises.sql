/*Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.*/

SELECT emp_no, dept_no, to_date, from_date,
CASE
  
     WHEN now()<to_date THEN 1
     ELSE 0
      END AS is_current_employee
FROM dept_emp;



/*Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/



/*Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/

SELECT first_name, last_name,
CASE

WHEN substr(last_name,1,1) IN ('a', 'b','c','d','e','f','g','h') THEN "A-H"
WHEN substr(last_name,1,1) IN ('i','j','k','l','m','n','o','p','q') THEN "I-Q"
ELSE "R-Z"
END AS alpha_group
FROM employees;


/*How many employees were born in each decade?*/
CREATE TABLE decades AS 
SELECT *,
CASE
WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN "60s"

WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN "50s"
ELSE "other"

END AS decade
FROM employees.employees;


SELECT decade, count(*)
FROM decades
GROUP BY decade;


/*What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/

CREATE TABLE avg_salary_group AS

SELECT first_name,last_name,salary, dept_no, dept_name,emp_no FROM employees.employees
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
JOIN employees.salaries USING (emp_no);



SELECT 
    AVG(CASE
    WHEN dept_name IN ('research', 'development') THEN salary
    END) AS R_D_avg_sal,

    AVG(CASE
    WHEN dept_name IN ('sales', 'marketing')  THEN salary
    END) AS Sales_Mkt,

    AVG(CASE
    WHEN dept_name IN ('production', 'quality management')  THEN salary
    END) AS Prod_QM,

    AVG(CASE
    WHEN dept_name IN ('Finance', 'human resources')  THEN salary
    END) AS Fin_HR,

    AVG(CASE
    WHEN dept_name IN ('Customer Service')  THEN salary
    END) AS Cust_service
FROM avg_salary_group;

