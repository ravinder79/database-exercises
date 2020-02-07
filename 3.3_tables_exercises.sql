#List all the tables in the database#
SHOW TABLES;
#current_dept_emp
#departments
#dept_emp
#dept_emp_latest_date
#dept_manager
#employees
#employees_with_departments
#salaries
#titles

#Explore the employees table. What different data types are present on this table?#
# INT, Date, VARCHAR, DATE, ENUM
DESCRIBE `employees`;

#Which table(s) do you think contain a numeric type column?
# Answer: Salaries, employees_with_departments, employees, dept_manager, dept_emp#
SHOW TABLES;


#Which TABLE(s) DO you think contain a STRING TYPE COLUMN?
# departments, dept_emp, dept_manager, employees, employees_with_departments, titles#

#Which TABLE(s) DO you think contain a DATE TYPE COLUMN?
# dept_emp, dept_manager, employees, salaries, titles

#What is the relationship between the employees and the departments tables?
#no relationship

#SHOW the SQL that created the dept_manager table.
SHOW CREATE TABLE dept_manager;

#dept_manager	CREATE TABLE `dept_manager` (↵  `emp_no` int(11) NOT NULL,↵  `dept_no` char(4) NOT NULL,↵  `from_date` date NOT NULL,↵  `to_date` date NOT NULL,↵  PRIMARY KEY (`emp_no`,`dept_no`),↵  KEY `dept_no` (`dept_no`),↵  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,↵  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE↵) ENGINE=InnoDB DEFAULT CHARSET=latin1