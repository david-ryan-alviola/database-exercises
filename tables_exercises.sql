# Exercises for tables_exercises.sql

# Use the employees table
USE employees;

# List all the tables in the database
SHOW TABLES;

# Explore the employees table
DESCRIBE employees;

# Which tables do you think contain a numeric type column?
DESCRIBE salaries;
# salaries has a salary column;employees table has a emp_no column

# Which tables do you think contain a string type column?
DESCRIBE titles;
DESCRIBE departments;
# employees table has columns for names; titles has a title column; departments has a dept_name column

# Which tables do you think contain a date type column?
DESCRIBE current_dept_emp;
# employees table has a hire_date column; current_dept_emp has from_date and to_date columns;

# What is the relationship between the employees and departments tables?
DESCRIBE employees;
DESCRIBE departments;
# There is no direct relationship, but the two tables can be joined with the dept_emp table

# Show the SQL that created the dept_maanger table
SHOW CREATE TABLE dept_manager;
/* CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 */