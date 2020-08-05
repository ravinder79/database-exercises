/*
Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of
those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first.
If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically.
Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order.
If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
Write a query to help Eve.*/

select if (grade > 7, name, NULL), GRADE, marks from STUDENTS
JOIN grades on students.marks between Grades.Min_mark and Grades.Max_mark
order by GRADE DESC, name, marks;

/*
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score.
 If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.*/


select t.h_id, t.name
from (
SELECT submissions.hacker_id as h_id, name as name, count(submissions.hacker_id) as count1  from Submissions
JOIN Challenges using (challenge_id)
JOIN difficulty using (difficulty_level)
JOIN Hackers on submissions.hacker_id = hackers.hacker_id
where Difficulty.score = Submissions.score
group by submissions.hacker_id, name
order by count(submissions.hacker_id) DESC, submissions.hacker_id) as t
where t.count1>1;

/*
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.*/

SELECT start_date, MIN(End_Date)
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT end_date FROM PROJECTS WHERE end_date NOT IN (SELECT start_date FROM PROJECTS)) b
where start_date < end_date
GROUP BY start_date
ORDER BY datediff(start_date, MIN(end_date)) DESC, start_date


/*
Write a query to output the names of those students whose best friends got offered a higher salary than them.
 Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.*/

select s.name from Students s
Join Friends f ON f.id = s.id
join Packages p ON p.id = s.id
Join Students s1 ON s1.id = f.Friend_ID
JOIN Packages p1 on p1.id = f.Friend_ID
where p1.Salary > p.Salary
order by p1.Salary

/*
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X.*/

select f1.X, f1.Y from Functions f1
INNER Join Functions f2 on f2.X = f1.Y and  f1.X = f2.Y
group by f1.X, f1.y
having  COUNT(f1.X)>1 or f1.X < f1.Y
order by f1.X



/*
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your resultuery here.
*/
select s.hacker_id, s.name, sum(s.max_score) from (
select hacker_id, challenge_id, name, max(score) as max_score from Submissions
left join hackers using (hacker_id)
group by hacker_id, challenge_id, name) as s
group by s.hacker_id, s.name
having sum(s.max_score)>0
order by sum(s.max_score) desc, s.hacker_id

/*
Consider  and  to be two points on a 2D plane where  are the respective minimum and maximum values of Northern Latitude (LAT_N)
 and  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.*/

select round(sqrt((min(lat_n)-max(lat_n))* (min(lat_n)-max(lat_n)) + (min(long_w)-max(long_w)) * (min(long_w)-max(long_w))),4) from STATION

CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(6) unsigned NOT NULL,
  `name` varchar(3) NOT NULL,
  `activity` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `activities` (
  `id` int(6) unsigned NOT NULL,
  `activity` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `friends` (`id`, `name`, `activity`) VALUES
  ('1', 'a', 'Horseriding'),
  ('2', 'b', 'reading'),
  ('3', 'c', 'Horseriding'),
  ('4', 'd', 'Horseriding'),
   ('5', 'e', 'eating'),

  ('6', 'f', 'eating'),
  ('7', 'g', 'reading'),
  ('8', 'h', 'sleeping');
  
 INSERT INTO `activities` (`id`, `activity`) VALUES
  ('1', 'Horseriding'),
  ('2',  'reading'),
  ('3', 'eating'),
  ('4', 'sleeping'),
  ('5', 'running');
 
  
;



SELECT *
FROM
  (SELECT activities.activity,
          IFNULL(count2, 0) AS activity_count
   FROM activities
   LEFT JOIN
     (SELECT activity,
             count(activity) AS count2
      FROM friends
      GROUP BY activity) AS b ON activities.activity = b.activity) c
WHERE activity_count !=
    (SELECT max(count1)
     FROM
       (SELECT activity,
               count(activity) count1
        FROM friends
        GROUP BY activity) AS a)
  AND activity_count !=
    (SELECT min(count1)
     FROM
       (SELECT activity,
               count(activity) count1
        FROM friends
        GROUP BY activity) AS a) ;


/* max salary in dept*/

SELECT  dept_no, max(salary) FROM `employees`
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
WHERE salaries.to_date > now()
GROUP BY dept_no
ORDER BY max(salary);

SELECT first_name, last_name, emp_no, dept_no, salary FROM employees
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
WHERE (dept_no, salary) IN 
(SELECT dept_no, max(salary) FROM salaries
JOIN dept_emp USING (emp_no)
GROUP BY dept_no ) AND
salaries.to_date > now();
