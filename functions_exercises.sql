# 1. functions_exercises.sql
USE employees;

# 2. Write a query to to find all current employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
	FROM employees
	WHERE last_name LIKE 'E%e';

# 3. Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
	FROM employees
	WHERE last_name LIKE 'E%e';
	
# 4. Find all previous employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()).
SELECT CONCAT(first_name, ' ', last_name) AS full_name, DATEDIFF(NOW(), hire_date) AS days_at_company
	FROM employees
	WHERE hire_date LIKE '199%'
		AND birth_date LIKE '%-12-25';

# 5. Find the smallest and largest current salary from the salaries table.
SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary
	FROM salaries
	WHERE to_date > CURDATE();

# 6. Use your knowledge of built in SQL functions to generate a username for all of the current and previous employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.
SELECT CONCAT(
			LOWER(
				CONCAT(
					SUBSTR(first_name, 1, 1),
					SUBSTR(last_name, 1, 4),
					'_',
					SUBSTR(CAST(birth_date AS CHAR), 6, 2),
					SUBSTR(CAST(birth_date AS CHAR), 3, 2)
				)
			)
		) AS username,
		first_name, last_name, birth_date
	FROM employees;