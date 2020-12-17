# select_exercises.sql

# Use albums_db
USE albums_db;

# Explore albums_db
SHOW TABLES;
DESCRIBE albums_db.albums;

# Name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist = 'Pink Floyd';

# The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';

# The genre for Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';

# Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20000000;

# All the albums with a genre of "Rock"
SELECT name FROM albums WHERE genre = 'Rock';
# To include all types of rock
SELECT name FROM albums WHERE genre LIKE '%rock%';