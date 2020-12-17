# select_exercises.sql

# Use albums_db
USE albums_db;

# Explore albums_db
SHOW TABLES;
DESCRIBE albums_db.albums;

# Name of all albums by Pink Floyd
SELECT name AS 'Pink Floyd Albums'
	FROM albums
	WHERE artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date AS 'Year Sgt. Pepper''s Lonely Hearts Club Band Released'
	FROM albums
	WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';

# The genre for Nevermind
SELECT genre AS 'Genre for Nevermind'
	FROM albums
	WHERE name = 'Nevermind';

# Albums that were released in the 90s
SELECT name AS 'Albums released in 1990s'
	FROM albums
	WHERE release_date BETWEEN 1990 AND 1999;
	
# Which albums had less than 20 million certified sales
SELECT name AS 'Albums with less than 20 million sales' 
	FROM albums
	WHERE sales < 20000000;

# All the albums with a genre of "Rock"
SELECT name AS 'Only rock albums'
	FROM albums
	WHERE genre = 'Rock';
# To include all types of rock
SELECT name AS 'All types of rock albums'
	FROM albums
	WHERE genre LIKE '%rock%';