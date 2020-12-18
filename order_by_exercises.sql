# 1. order_by_exercises.sql

# 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
USE employees;
SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY first_name;
# First row:  Irena Reutenauer; Last row:  Vidya Simmen

# 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY first_name, last_name;
# First row:  Irena Acton; Last row:  Vidya Zweizig

# 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	ORDER BY last_name, first_name;
# First row:  Irena Acton; Last row:  Maya Zyda

# 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT *
	FROM employees
	WHERE last_name LIKE 'E%e'
	ORDER BY emp_no;
# Results:  899; First row:  10021, Ramzi Erde; Last row:  499648, Tadahiro Erde

# 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
SELECT *
	FROM employees
	WHERE last_name LIKE 'E%e'
	ORDER BY hire_date DESC;
# Results:  899; Newest employee:  Teiji Eldridge; Oldest employee:  Sergi Erde

# 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.
SELECT *
	FROM employees
	WHERE hire_date LIKE '199%'
		AND birth_date LIKE '%-12-25'
	ORDER BY birth_date ASC, hire_date DESC;
# Results:  362; Oldest employee hired last:  Khun Bernini; Youngest employee hired first:  Douadi Pettis