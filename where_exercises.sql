# 1. where_exercises.sql

# Use the employees database
USE employees;
SHOW TABLES;
DESCRIBE employees;

# 2. Find all current/previous employees with first names Irena, Vidya, or Maya
SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya');

# 3. Same query but use OR instead of IN
SELECT *
	FROM employees
	WHERE first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya';
# Both counts match:  709

# 4. Find all previous results AND male employees
SELECT *
	FROM employees
	WHERE (first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya')
		AND gender = 'M';
# Count:  441

# 5. Find all current/previous employees whose last name starts with 'E'
SELECT *
	FROM employees
	WHERE last_name LIKE 'E%';
# Count:  7330

# 6. Find all current/previous employees whose last name starts or ends with 'E'
SELECT *
	FROM employees
	WHERE last_name LIKE 'E%'
		OR last_name LIKE '%e';
# Count:  30723

# How many employees have a last name that ends with 'e' but doesn't start with 'E'
SELECT *
	FROM employees
	WHERE last_name LIKE '%e'
		AND last_name NOT LIKE 'E%';
# Count:  23393

# 7. Find all current/previous employees whose last name that starts and ends with 'E'
SELECT *
	FROM employees
	WHERE last_name LIKE 'E%'
		AND last_name LIKE '%e';
# Count:  899

#Altnerate solution
SELECT *
	FROM employees
	WHERE last_name LIKE 'E%e';

# Find all current/previous employees whose last name end with 'e'
SELECT *
	FROM employees
	WHERE last_name LIKE '%e';
# Count:  24292

# 8. Find all current/previous employees hired in the 90s
SELECT *
	FROM employees
	WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
# Count:  135214

# 9. Find all current/previous employees born on Christmas
SELECT *
	FROM employees
	WHERE birth_date LIKE '%-12-25';
# Count:  842

# 10. Find all current/previous employees hired in the 90s and born on Christmas
SELECT *
	FROM (SELECT *
			FROM employees
			WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31') AS n
	WHERE n.birth_date LIKE '%-12-25';
# Count:  362

# Double check without view
SELECT *
	FROM employees
	WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND birth_date LIKE '%-12-25';
# Count:  362

# 11. Find all current/previous employees with a 'q' in their last name
SELECT *
	FROM employees
	WHERE last_name LIKE '%q%';
# Count:  1873

# 12. Find all current/previous employees with a 'q' in their last name but not 'qu'
SELECT *
	FROM employees
	WHERE last_name LIKE '%q%'
		AND last_name NOT LIKE '%qu%';
# Count 547