

SELECT
DISTINCT title
FROM titles;


SELECT last_name
from employees
where last_name LIKE 'E%E'
GROUP BY last_name;

SELECT last_name, first_name
from employees
where last_name LIKE 'E%E'
GROUP BY last_name, first_name;

/*Find the unique last names with a 'q' but not 'qu'*/
SELECT  last_name
FROM employees
where last_name like '%q%' AND last_name not like '%qu%'
group by last_name;


/*Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.*/

SELECT  last_name, count(*) AS count
FROM employees
where last_name like '%q%' AND last_name not like '%qu%'
group by last_name
order by last_name;


/*Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. Your results should be:*/

SELECT count(*) as count, gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'maya')
GROUP BY gender;


/* #8    */

SELECT lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS username, count(*)
FROM employees
GROUP BY username;




Bonus
/* HAVING count(username) > 1. 13251 usernames appear more than once*/

SELECT count(*) AS duplicates 
FROM
	(SELECT lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS 		username, count(*)
	FROM employees
	GROUP BY username
	HAVING count(username) >1) 
AS dup;