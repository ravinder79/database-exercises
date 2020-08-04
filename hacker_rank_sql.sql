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