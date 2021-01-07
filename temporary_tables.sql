# temporary_tables.sql

USE easley_1265;

SELECT * FROM employees.dept_emp;

# 1. Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS (
	SELECT *
		FROM employees.employees AS e
			JOIN employees.dept_emp AS de USING(emp_no)
			JOIN employees.departments AS d USING(dept_no)
		WHERE de.to_date > curdate());
		
SELECT *
	FROM employees_with_departments;
	
# a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

DESCRIBE employees_with_departments;

ALTER TABLE employees_with_departments
	ADD full_name VARCHAR(30);
DESCRIBE employees_with_departments;

# b. Update the table so that full name column contains the correct data

UPDATE employees_with_departments
	SET full_name = concat(first_name, ' ', last_name);
SELECT full_name, first_name, last_name
	FROM employees_with_departments;
	
# c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments
	DROP COLUMN first_name;
ALTER TABLE employees_with_departments
	DROP COLUMN last_name;
DESCRIBE employees_with_departments;

# d. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE employees_with_dept_alternate AS (
	SELECT concat(first_name, ' ', last_name) AS full_name,
	dept_no,
	emp_no,
	birth_date,
	gender,
	hire_date,
	from_date,
	to_date,
	dept_name
		FROM employees.employees AS e
			JOIN employees.dept_emp AS de USING(emp_no)
			JOIN employees.departments AS d USING(dept_no)
		WHERE de.to_date > curdate());
		
DESCRIBE employees_with_dept_alternate;
SELECT *
	FROM employees_with_dept_alternate;

# 2. Create a temporary table based on the payment table from the sakila database.
# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

CREATE TEMPORARY TABLE payment_temp AS (
	SELECT *
		FROM sakila.payment);
DESCRIBE payment_temp;

ALTER TABLE payment_temp
	ADD amount_in_cents INT(3);
UPDATE payment_temp
	SET amount_in_cents = amount * 100;
SELECT amount, amount_in_cents
	FROM payment_temp;

ALTER TABLE payment_temp
	DROP COLUMN amount;
DESCRIBE payment_temp;

ALTER TABLE payment_temp
	ADD amount INT(3);
UPDATE payment_temp
	SET amount = amount_in_cents;
SELECT amount, amount_in_cents
	FROM payment_temp;

ALTER TABLE payment_temp
	DROP COLUMN amount_in_cents;
SELECT *
	FROM payment_temp;

# Can use MODIFY keyword to alter the column type without dropping the column
	
# 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

CREATE TEMPORARY TABLE current_salaries_temp AS (
	SELECT dept_name AS department, round(AVG(salary), 2) AS current_avg_salary
		FROM employees.salaries AS s
			JOIN employees.dept_emp AS de ON s.emp_no = de.emp_no
				AND de.to_date > curdate()
			JOIN employees.departments USING(dept_no)
		WHERE s.to_date > curdate()
		GROUP BY dept_name);
SELECT *
	FROM current_salaries_temp;

SELECT round(AVG(salary), 2)
	FROM employees.salaries;
# Average historical salary is 63810.74

# Add column to hold historical avg salary value
ALTER TABLE current_salaries_temp
	ADD historical_avg_salary DECIMAL(11, 2);
DESCRIBE current_salaries_temp;

UPDATE current_salaries_temp
	SET historical_avg_salary = (
		SELECT round(AVG(salary), 2)
	FROM employees.salaries);
SELECT *
	FROM current_salaries_temp;

# Add column to hold z_scores
ALTER TABLE current_salaries_temp
	ADD z_score DECIMAL(11, 4);
DESCRIBE current_salaries_temp;

# Add column to hold the STDDEV value
ALTER TABLE current_salaries_temp
	ADD std DECIMAL(11, 4);
DESCRIBE current_salaries_temp;

# Create another temp table to calculate the STDDEV
CREATE TEMPORARY TABLE std_temp AS (
	SELECT dept_name AS department, round(AVG(salary), 2) AS current_avg_salary
		FROM employees.salaries AS s
			JOIN employees.dept_emp AS de ON s.emp_no = de.emp_no
				AND de.to_date > curdate()
			JOIN employees.departments USING(dept_no)
		WHERE s.to_date > curdate()
		GROUP BY dept_name);
		
UPDATE current_salaries_temp
	SET std = (
		SELECT std(current_avg_salary)
			FROM std_temp);

SELECT *
	FROM current_salaries_temp;

UPDATE current_salaries_temp
	SET z_score = (current_avg_salary - historical_avg_salary) / std;
	
ALTER TABLE current_salaries_temp
	DROP COLUMN historical_avg_salary;
ALTER TABLE current_salaries_temp
	DROP COLUMN std;

SELECT *
	FROM current_salaries_temp
	ORDER BY z_score DESC;
	
# Sales has the highest z-score and thus is the most standard deviations above the mean, so on average, salaries in sales are highest.
# HR has the lowest z-score so it has the average salary that is the closest to the average historical salary.