# subqueries_exercises.sql

# 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT *
	FROM employees
	JOIN dept_emp USING(emp_no)
	WHERE hire_date = 
		(SELECT hire_date
			FROM employees
			WHERE emp_no = '101010')
		AND to_date > curdate();

# 55 results all hired on 1990-10-22

# 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT title
	FROM titles
	WHERE emp_no IN (
		SELECT emp_no
			FROM employees
				JOIN dept_emp USING(emp_no)
			WHERE first_name = 'Aamod'
				AND to_date > curdate()
		)
	GROUP BY title;

/* Assistant Engineer
Engineer
Senior Engineer
Senior Staff
Staff
Technique Leader */

# 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT count(*)
	FROM employees
	WHERE emp_no NOT IN (
		SELECT emp_no
			FROM employees
				JOIN dept_emp USING(emp_no)
			WHERE to_date > curdate());

# 59900 employees are no longer working for the company. Find which employees numbers are not in the current employees results

# 4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT concat(first_name, ' ', last_name) AS 'Current Female Department Managers'
	FROM dept_manager
	JOIN employees USING(emp_no)
	WHERE emp_no IN (
		SELECT emp_no
			FROM employees
			WHERE gender = 'F')
		AND to_date > curdate();

/* Isamu Legleitner
Karsten Sigstam
Leon DasSarma
Hilary Kambil */

# 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT first_name, last_name, salary
	FROM employees AS e
		JOIN salaries AS s ON e.emp_no = s.emp_no 
			AND to_date > curdate()
	WHERE salary > (SELECT AVG(salary)
						FROM salaries)
	ORDER BY salary;
	
# Average historical salary of 63810.74 and 154543 employees with current salary above average

# 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT concat(count(*) / (
	SELECT count(*)
		FROM salaries
		WHERE to_date > curdate()
	) * 100, "%") AS 'Percentage of current salaries within 1STD of current highest salary'
	FROM salaries
	WHERE ((
		SELECT max(salary)
			FROM salaries
			WHERE to_date > curdate()
		) - salary) < (
		SELECT std(salary)
			FROM salaries
			WHERE to_date > curdate()
		)
		AND to_date > curdate();


# Standard deviation of current salaries:  17309.95933634675
# Highest current salary:  158220
# 83 current salaries that are within 1STD of the max current salary
# 240124 current salaries total
# 83/240124 ~ .0003 or .03%

# Bonus 1. Find all the department names that currently have female managers.

SELECT dept_name AS 'Departments currently managed by females'
	FROM departments
		JOIN dept_manager USING(dept_no)
	WHERE emp_no IN (
		SELECT emp_no
			FROM dept_manager
				JOIN employees USING(emp_no)
			WHERE emp_no IN (
				SELECT emp_no
					FROM employees
					WHERE gender = 'F')
						AND to_date > curdate()
	);

/* Research
Human Resources
Finance
Development */

# 2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name, salary
	FROM employees
		JOIN salaries USING(emp_no) 
	WHERE salary = (
		SELECT max(salary)
			FROM salaries
			WHERE to_date > curdate()
	);

# Max current salary of 158220 belongs to Tokuyasu Pesch

# 3. Find the department name that the employee with the highest salary works in.

SELECT dept_name
	FROM departments
		JOIN dept_emp USING(dept_no)
	WHERE emp_no IN (
		SELECT emp_no
			FROM employees
				JOIN salaries USING(emp_no) 
			WHERE salary = (
				SELECT max(salary)
					FROM salaries
					WHERE to_date > curdate()
		)
	);
	
# Tokuyasu Pesch works in the Sales department