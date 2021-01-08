# case_exercises.sql

# 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;

SELECT emp_no, dept_no, hire_date, to_date,
	IF(to_date > curdate(), TRUE, FALSE) AS is_current_employee
	FROM employees
		JOIN dept_emp USING(emp_no);
		
SELECT *
	FROM employees
		JOIN dept_emp USING(emp_no);
# FIXME:  Check the solution for this. You are including employees twice if the worked for multiple departments.		

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
# Can also use left(last_name, 1) instead of substr()

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

# Alternate solution
SELECT
	CASE
		WHEN birth_date LIKE '195%' THEN '50s'
		ELSE '60s'
	END AS decade,
	count(*)
	FROM employees
	GROUP BY decade;

# Bonus 1. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

USE employees;

SELECT round(AVG(salary), 2) AS average_group_salary,
	CASE
		WHEN dept_no IN ('d001', 'd007') THEN 'Sales & Marketing'
		WHEN dept_no IN ('d002', 'd003') THEN 'Finance & HR'
		WHEN dept_no IN ('d004', 'd006') THEN 'Prod & QM'
		WHEN dept_no IN ('d005', 'd008') THEN 'R&D'
		ELSE dept_name
	END AS dept_group
	FROM salaries AS s
		JOIN dept_emp AS de ON s.emp_no = de.emp_no
			AND de.to_date > curdate()
		JOIN departments AS d USING(dept_no)
	WHERE s.to_date > curdate()
	GROUP BY dept_group;