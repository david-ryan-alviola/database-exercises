# join_exercises.sql

# Join Example Database
# 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
	FROM users;
SELECT *
	FROM roles;

# 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT *
	FROM users
		JOIN roles ON users.role_id = roles.id;
	
# 4 results with no nulls for the role

SELECT *
	FROM users
		LEFT JOIN roles ON users.role_id = roles.id;

# 6 results with two users that have no roles assigned

SELECT *
	FROM users
		RIGHT JOIN roles ON users.role_id = roles.id;

# 5 results where the commenter role did not have a user assigned

# 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name, count(*) AS users_with_role
	FROM roles
		JOIN users ON roles.id = users.role_id
	GROUP BY roles.name;
	
# Employee Database
# 1. Use the employees database.

USE employees;

# 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) AS "Department Manager"
	FROM departments
		JOIN dept_manager USING(dept_no)
		JOIN employees USING(emp_no)
	WHERE to_date > curdate()
	ORDER BY dept_name;
	
# 3. Find the name of all departments currently managed by women.

SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) AS "Department Manager"
	FROM departments
		JOIN dept_manager USING(dept_no)
		JOIN employees USING(emp_no)
	WHERE to_date > curdate()
		AND gender = 'F'
	ORDER BY dept_name;
	
# 4. Find the current titles of employees currently working in the Customer Service department.

SELECT title AS 'Title', count(title) AS 'Count'
	FROM titles
		JOIN employees USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE titles.to_date > curdate()
		AND dept_emp.to_date > curdate()
		AND dept_name = 'Customer Service'
	GROUP BY title;
	
# 5. Find the current salary of all current managers.

SELECT dept_name AS 'Department Name', concat(first_name, " ", last_name) AS 'Name', salary AS 'Salary'
	FROM departments
		JOIN dept_manager USING(dept_no)
		JOIN employees USING(emp_no)
		JOIN salaries USING(emp_no)
	WHERE dept_manager.to_date > curdate()
		AND salaries.to_date > curdate()
	ORDER BY dept_name;
	
# 6. Find the number of current employees in each department.

SELECT dept_no, dept_name, count(*) AS num_employees
	FROM departments
		JOIN dept_emp USING(dept_no)
		JOIN employees USING(emp_no)
	WHERE dept_emp.to_date > curdate()
	GROUP BY dept_no;
	
# 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salary) AS average_salary
	FROM salaries
		JOIN employees USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	GROUP BY dept_name
	ORDER BY average_salary DESC
	LIMIT 1;
	
# 8. Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name
	FROM salaries
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
		JOIN employees USING(emp_no)
	WHERE dept_name = 'Marketing'
	ORDER BY salary DESC
	LIMIT 1;
	
# 9. Which current department manager has the highest salary?

SELECT first_name, last_name, salary, dept_name
	FROM departments
		JOIN dept_manager USING(dept_no)
		JOIN employees USING(emp_no)
		JOIN salaries USING(emp_no)
	WHERE dept_manager.to_date > curdate()
		AND salaries.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1;
	
# 10. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT concat(e.first_name, ' ', e.last_name) AS 'Employee Name',
	dept_name AS 'Department Name',
	concat(m.first_name, ' ', m.last_name) AS 'Manager Name'
	FROM employees AS e
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
		JOIN dept_manager USING(dept_no)
		JOIN 
			(SELECT emp_no, first_name, last_name
				FROM dept_manager
					JOIN employees USING(emp_no)
				WHERE to_date > curdate()) AS m ON dept_manager.emp_no = m.emp_no
	WHERE dept_emp.to_date > curdate()
		AND dept_manager.to_date > curdate()
	ORDER BY dept_name;
	
# 11. Bonus Who is the highest paid employee within each department.

(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Sales'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Marketing'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Finance'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Human Resources'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Production'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION 
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Development'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Quality Management'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Research'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1)
UNION
(SELECT first_name, last_name, salary, dept_name
	FROM employees
		JOIN salaries USING(emp_no)
		JOIN dept_emp USING(emp_no)
		JOIN departments USING(dept_no)
	WHERE dept_name = 'Customer Service'
		AND salaries.to_date > curdate()
		AND dept_emp.to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1);