-- Find the smallest and largest current salary from the salaries table.

select * from salaries
order by salary DESC
limit 5 ;

SELECT first_name, COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%'
GROUP BY first_name;

-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

select DISTINCT title from titles;

select title, count(*) from titles
Group by title;

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
select last_name, count(last_name) from employees
where last_name like 'e%e'
group by last_name;

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

select first_name, last_name, count(last_name) from employees
where last_name like 'e%e'
group by last_name, first_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

select last_name from employees
where last_name like '%q%'
AND NOT last_name LIKE '%qu%'
group by last_name;

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
select last_name, count(*) from employees
where last_name like '%q%'
AND NOT last_name LIKE '%qu%'
group by last_name;

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

select first_name, gender ,count(first_name) from employees
where first_name IN ('Irena', 'Vidya','Maya')
group by first_name, gender
;

/* Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there? */


-- Find the historic average salary for all employees. Now determine the current average salary.

select avg(salary) from salaries;

select avg(salary) from salaries
where to_date > curdate();


-- Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.
select emp_no, avg(salary) from salaries
group by emp_no;

-- Find the current average salary for each employee.
select *, avg(salary) over(partition by emp_no) as 'avg_salary'
from salaries;

-- Find the maximum salary for each current employee.

select max(salary), emp_no
from salaries
group by emp_no;

select emp_no, salary, max(salary) over(partition by emp_no) as 'max salary'
from salaries;

-- Now find the max salary for each current employee where that max salary is greater than $150,000.
select emp_no, max(salary) from salaries
group by emp_no
having max(salary) > 150000;

-- Find the current average salary for each employee where that average salary is between $80k and $90k.

select emp_no, avg(salary) from salaries
where to_date > curdate()
group by emp_no
having avg(salary) between 80000 and 90000;



/* Joins */
-- write a query that shows each department along with the name of the current manager for that department.

select dept_name, concat (first_name, ' ', last_name) from departments as d
Join dept_manager as dm ON d.dept_no = dm.dept_no
Join employees using(emp_no)
where dm.to_date LIKE '9999%'
order by dept_name;

-- Find the name of all departments currently managed by women.

select dept_name, concat (first_name, ' ', last_name) from departments as d
Join dept_manager as dm ON d.dept_no = dm.dept_no
Join employees using(emp_no)
where dm.to_date LIKE '9999%' AND gender = 'F'
order by dept_name;

-- Find the current titles of employees currently working in the Customer Service department.

select title, count(*) from titles as t
join dept_emp as de ON t.emp_no = de.emp_no
join departments as d on d.dept_no = de.dept_no
Where t.to_date LIKE '9999%'
AND de.to_date LIKE '9999%'
AND d.dept_name LIKE 'Customer%'
group by title;

-- Find the current salary of all current managers.

select salary, concat(first_name, ' ', last_name), dept_name from salaries as s
join employees using(emp_no)
join dept_manager using(emp_no)
join departments using(dept_no)
where dept_manager.to_date > curdate()
AND s.to_date > now()
order by dept_name;

-- Find the number of current employees in each department.

select dept_no, dept_name, count(*) from dept_emp as de
join departments using(dept_no)
where de.to_date > now()
group by dept_name
order by dept_no;

-- Which department has the highest average salary? Hint: Use current not historic information.
select d.dept_name, avg(salary) from salaries s
join dept_emp de using(emp_no)
join departments d ON d.dept_no = de.dept_no
where s.to_date > now()
AND de.to_date > now()
group by de.dept_no
order by avg(salary) desc
limit 1;

-- Who is the highest paid employee in the Marketing department?


select dept_name, s.emp_no, first_name, last_name, salary from dept_emp as de
join departments d using(dept_no)
join salaries s on s.emp_no = de.emp_no
join employees e on e.emp_no = de.emp_no
where de.to_date > now()
and s.to_date > now() 
and d.dept_name LIKE 'Marketing'
order by salary DESC
limit 1;

-- Which current department manager has the highest salary?

select first_name, last_name, dept_name, salary from dept_manager
join departments d using(dept_no)
join salaries s using(emp_no)
join employees using(emp_no)
where s.to_date > now()
and dept_manager.to_date > now()
order by salary DESC
limit 1;


-- Find all the current employees with the same hire date as employee 101010 using a sub-query.

select * 
from  employees
join salaries using(emp_no)
WHERE hire_date = (select hire_date from employees where emp_no = 101010 )
AND salaries.to_date > now();


-- Find all the titles ever held by all current employees with the first name Aamod.
select title from titles
where emp_no IN 
(select emp_no from titles
join employees using(emp_no)
where titles.to_date > now()
AND first_name = 'Aamod');

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

select * from employees
where emp_no NOT IN (select emp_no from titles
where to_date like '9999%');


-- BONUS: How many duplicate usernames are there? 

SELECT count(username_counts.number_of_duplicates), sum(username_counts.number_of_duplicates)
FROM(
SELECT 
	LOWER(
			CONCAT(
				SUBSTR(first_name, 1, 1),
				SUBSTR(last_name, 1, 4),
				'_',
				SUBSTR(birth_date, 6, 2),
				SUBSTR(birth_date, 3, 2)
				)
			) AS username,
	COUNT(*) AS number_of_duplicates
FROM employees
GROUP BY username
having number_of_duplicates >1
ORDER BY number_of_duplicates DESC) as username_counts;



-- Find the historic average salary for all employees. Now determine the current average salary.

SELECT avg(salary) from salaries;

SELECT avg(salary) from salaries
where salaries.to_date > now();


-- Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.

select emp_no, avg(salary) from salaries
group by emp_no;


-- Find the current average salary for each employee.

select emp_no, avg(salary) from salaries
where salaries.to_date > now()
group by emp_no;

-- Find the maximum salary for each current employee.
select emp_no, max(salary) from salaries
where salaries.to_date > now()
group by emp_no;

-- Now find the max salary for each current employee where that max salary is greater than $150,000.
select emp_no, max(salary) from salaries
where salaries.to_date > now()
group by emp_no
having max(salary) > 150000;

-- Find the current average salary for each employee where that average salary is between $80k and $90k.

select emp_no, avg(salary) from salaries
where salaries.to_date > now()
group by emp_no
having avg(salary) BETWEEN 80000 and 90000;


-- Join exercises

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT dept_name, concat(first_name, ' ', last_name) as 'department manager' 
FROM dept_manager as dm
JOIN employees using(emp_no)
JOIN departments d using(dept_no)
where dm.to_date > now()
order by dept_name;

SELECT dept_name, concat(first_name, ' ', last_name) as 'department manager' 
FROM employees as e
JOIN dept_manager dm using(emp_no)
JOIN departments d using(dept_no)
where dm.to_date > now()
order by dept_name;

-- Find the name of all departments currently managed by women.

SELECT dept_name, concat(first_name, ' ', last_name) as 'department manager' 
FROM dept_manager as dm
JOIN employees using(emp_no)
JOIN departments d using(dept_no)
where dm.to_date > now()
and gender = 'F'
order by dept_name;

-- Find the current titles of employees currently working in the Customer Service department.

select title, count(*)
from titles t
join dept_emp de using(emp_no)
join departments d using(dept_no)
where t.to_date > now()
and de.to_date > now()
and d.dept_name LIKE 'Cust%'
group by t.title;


-- Find the current salary of all current managers.
SELECT dept_name, salary, concat(first_name, ' ', last_name)
from dept_manager dm
join employees e using(emp_no)
LEFT join salaries s using(emp_no)
join departments d using(dept_no)
where dm.to_date > now()
AND s.to_date > now()
order by dept_name;


SELECT dept_name, salary, first_name
from salaries s
join dept_manager dm using(emp_no)
join departments d using(dept_no)
join employees e using(emp_no)
where dm.to_date > now()
AND s.to_date > now()
order by dept_name;

-- Find the number of current employees in each department.
SELECT dept_no, dept_name, count(*)
FROM dept_emp de
join departments d using(dept_no)
where de.to_date > now()
group by dept_name
order by dept_no;


-- Which department has the highest average salary? Hint: Use current not historic information.

select dept_name, avg(salary) from
salaries s
join dept_emp de using(emp_no)
join departments d using(dept_no)
where de.to_date>now()
and s.to_date > now()
group by dept_name


order by avg(salary) DESC
Limit 1;

-- Who is the highest paid employee in the Marketing department?

select first_name, last_name, salary 
from salaries s
join employees e using(emp_no)
join dept_emp de using(emp_no)
join departments d using(dept_no)
where s.to_date > now()
AND de.to_date > now()
AND dept_name LIKE 'Marketing%'
order by salary DESC
limit 1;

-- Which current department manager has the highest salary?
select first_name, last_name, dept_name, salary
from salaries s
join dept_manager dm using(emp_no)
join departments d using(dept_no)
join employees e using(emp_no)
where s.to_date > now()
and dm.to_date > now()
order by salary desc
limit 1;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.

select concat(managers.first_name,managers.last_name) as 'manager_name', concat(employees.first_name, ' ', employees.last_name) as employees_name, d.dept_name
from employees as managers
join dept_manager dm using(emp_no)
join departments d using(dept_no)
join dept_emp de using(dept_no)
join employees on de.emp_no = employees.emp_no
where de.to_date > now()
and dm.to_date > now();

-- Another way - start with dept_emp - for employees. Later self join with employees to bring in managers.
select concat(e.first_name, " ",e.last_name) as "manager_name", dept_name, concat(managers.first_name, " ", managers.last_name) as "Employee Name"
from dept_emp de
join departments using(dept_no)
join employees e using(emp_no)
join dept_manager dm using(dept_no)
join employees as managers on dm.emp_no = managers.emp_no
where dm.to_date > now()
AND de.to_date > now();



-- Bonus Who is the highest paid employee within each department.
select first_name, last_name, salary, dept_name, dept_no,
max(salary) OVER(partition by dept_no) as 'max salary'
from salaries s
join employees e using(emp_no)
join dept_emp de using(emp_no)
join departments using(dept_no)
where s.to_date > now()
and de.to_date > now();


select salary, dept_name, first_name, last_name
from employees e
join salaries sa using(emp_no)
join dept_emp using(emp_no)
join departments using(dept_no)
WHERE salary IN 
(select max(salary)
from salaries s
join employees e using(emp_no)
join dept_emp de using(emp_no)
join departments using(dept_no)
where s.to_date > now()
and de.to_date > now()
group by dept_name);

