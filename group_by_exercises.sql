# 1. group_by_exercises.sql
USE employees;

# 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT title
	FROM titles;
/* Senior Engineer
   Staff
   Engineer
   Senior Staff
   Assistant Engineer
   Technique Leader
   Manager */

# 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
	FROM employees
	WHERE last_name LIKE 'E%e'
	GROUP BY last_name;
/* Eldridge
   Erbe
   Erde
   Erie
   Etalle */

# 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT concat(first_name, ' ', last_name) AS full_name
	FROM employees
	WHERE last_name LIKE 'E%e'
	GROUP BY full_name;
# 846 results

# 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
	FROM employees
	WHERE last_name LIKE '%q%'
		AND last_name NOT LIKE '%qu%'
	GROUP BY last_name;
/* Chleq
   Lindqvist
   Qiwen */

# 6. Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others
SELECT last_name, count(*)
	FROM employees
	WHERE last_name LIKE '%q%'
		AND last_name NOT LIKE '%qu%'
	GROUP BY last_name
	ORDER BY count(*) DESC;

# 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT gender, count(*)
	FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	GROUP BY gender;
/* M	441
   F	268 */
   
# 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT LOWER(
	CONCAT(
    	SUBSTR(first_name, 1, 1),
        SUBSTR(last_name, 1, 4),
        '_',
        SUBSTR(CAST(birth_date AS CHAR), 6, 2),
        SUBSTR(CAST(birth_date AS CHAR), 3, 2)
        )
	) AS username, count(*)
    FROM employees
    GROUP BY username
    ORDER BY count(*) DESC;