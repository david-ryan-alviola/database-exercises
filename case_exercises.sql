# case_exercises.sql

# 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;

SELECT emp_no, dept_no, hire_date, to_date,
	IF(to_date > curdate(), TRUE, FALSE) AS is_current_employee
	FROM employees
		JOIN dept_emp USING(emp_no);
		
# 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT first_name, last_name,
	CASE
		WHEN substr(last_name, 1, 1)
			IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H')
			THEN 'A-H'
		WHEN substr(last_name, 1, 1)
			IN ('I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q')
			THEN 'I-Q'
		ELSE 'R-Z'
	END AS alpha_group
	FROM employees
	ORDER BY last_name;
	
# 3. How many employees (current or previous) were born in each decade?

SELECT max(substr(birth_date, 1, 4))
	FROM employees;
# max birth year 1965

SELECT min(substr(birth_date, 1, 4))
	FROM employees;
# min birth year 1952

USE easley_1265;

CREATE TEMPORARY TABLE fifties_babies AS (
	SELECT birth_date,
		IF(substr(birth_date, 1, 4) LIKE '195%', TRUE, FALSE) AS birth_decade
		FROM employees.employees);

SELECT sum(birth_decade)
	FROM fifties_babies;
# 182886 total employees born in the 1950s

CREATE TEMPORARY TABLE sixties_babies AS (
	SELECT birth_date,
		IF(substr(birth_date, 1, 4) LIKE '196%', TRUE, FALSE) AS birth_decade
		FROM employees.employees);
		
SELECT sum(birth_decade)
	FROM sixties_babies;
# 117138 total employees born in the 1960s

# Bonus 1. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?