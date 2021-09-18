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
