-- Create the database
CREATE DATABASE movie_analytics;
USE movie_analytics;

-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS WatchHistory, Ratings, Movies, Users;

-- 1. Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
-- Where Query
SELECT * FROM Movies WHERE release_year > 2010;


-- 2. Movies Table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(200),
    genre VARCHAR(50),
    release_year INT
);

-- 3. Ratings Table
CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- 4. WatchHistory Table
CREATE TABLE WatchHistory (
    history_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    watch_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- users
INSERT INTO Users (user_id, name, email) VALUES
(1, 'Ahmed Raza', 'ahmed.raza@example.pk'),
(2, 'Fatima Khan', 'fatima.khan@example.pk'),
(3, 'Hassan Ali', 'hassan.ali@example.pk'),
(4, 'Ayesha Siddiqui', 'ayesha.siddiqui@example.pk'),
(5, 'Usman Zafar', 'usman.zafar@example.pk'),
(6, 'Zainab Mirza', 'zainab.mirza@example.pk'),
(7, 'Bilal Saeed', 'bilal.saeed@example.pk'),
(8, 'Noor Bano', 'noor.bano@example.pk'),
(9, 'Danish Qureshi', 'danish.qureshi@example.pk'),
(10, 'Hira Iqbal', 'hira.iqbal@example.pk');


--  movies
INSERT INTO Movies (movie_id, title, genre, release_year) VALUES
(101, 'Inception', 'Sci-Fi', 2010),
(102, 'The Godfather', 'Crime', 1972),
(103, 'Titanic', 'Romance', 1997),
(104, 'Interstellar', 'Sci-Fi', 2014),
(105, 'The Matrix', 'Sci-Fi', 1999),
(106, 'Forrest Gump', 'Drama', 1994),
(107, 'Joker', 'Thriller', 2019),
(108, 'Avengers: Endgame', 'Action', 2019),
(109, 'The Dark Knight', 'Action', 2008),
(110, 'Parasite', 'Thriller', 2019);

-- ratings
INSERT INTO Ratings (rating_id, user_id, movie_id, rating) VALUES
(1, 1, 101, 9),
(2, 2, 105, 8),
(3, 3, 102, 7),
(4, 4, 106, 9),
(5, 5, 103, 10),
(6, 6, 107, 6),
(7, 7, 108, 8),
(8, 8, 104, 7),
(9, 9, 109, 9),
(10, 10, 110, 8);

-- watch history records
INSERT INTO WatchHistory (history_id, user_id, movie_id, watch_date) VALUES
(1, 1, 101, '2025-06-01'),
(2, 2, 105, '2025-06-02'),
(3, 3, 102, '2025-06-03'),
(4, 4, 106, '2025-06-04'),
(5, 5, 103, '2025-06-05'),
(6, 6, 107, '2025-06-06'),
(7, 7, 108, '2025-06-07'),
(8, 8, 104, '2025-06-08'),
(9, 9, 109, '2025-06-09'),
(10, 10, 110, '2025-06-10');

-- Directors Table
CREATE TABLE Directors (
    director_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

-- Data of Directors
INSERT INTO Directors (director_id, name, country) VALUES
(1, 'Christopher Nolan', 'UK'),
(2, 'Francis Ford Coppola', 'USA'),
(3, 'James Cameron', 'Canada'),
(4, 'Bong Joon-ho', 'South Korea');

-- Movie_Director Table
CREATE TABLE Movie_Directors (
    movie_id INT,
    director_id INT,
    PRIMARY KEY (movie_id, director_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (director_id) REFERENCES Directors(director_id)
);

-- Movie and Directors Data
INSERT INTO Movie_Directors (movie_id, director_id) VALUES
(101, 1), 
(104, 1),
(102, 2), 
(103, 3), 
(110, 4); 


 -- Actors Table
CREATE TABLE Actors (
    actor_id INT PRIMARY KEY,
    name VARCHAR(100),
    birth_year INT
);

-- Data Actors
INSERT INTO Actors (actor_id, name, birth_year) VALUES
(1, 'Leonardo DiCaprio', 1974),
(2, 'Marlon Brando', 1924),
(3, 'Heath Ledger', 1979),
(4, 'Robert Downey Jr.', 1965);

-- Movie_Actors Table
CREATE TABLE Movie_Actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors(actor_id)
);

-- Data Movie_Actors
INSERT INTO Movie_Actors (movie_id, actor_id) VALUES
(101, 1), 
(103, 1), 
(102, 2),
(109, 3), 
(108, 4);

-- Reviews Table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Data of Reviews
INSERT INTO Reviews (review_id, user_id, movie_id, review_text, review_date) VALUES
(1, 1, 101, 'Mind-blowing concept and execution!', '2025-06-01'),
(2, 2, 105, 'A true sci-fi classic.', '2025-06-02'),
(3, 3, 102, 'Legendary performance.', '2025-06-03');

-- Deletion in DB
DELETE FROM Reviews
WHERE review_id = 3;

DELETE FROM Ratings
WHERE user_id = 6;

DELETE FROM WatchHistory
WHERE movie_id = 105;

DELETE FROM Movies
WHERE movie_id = 105;

-- Update in DB
UPDATE Users
SET email = 'ayesha.updated@example.pk'
WHERE user_id = 4;

UPDATE Movies
SET genre = 'Classic Drama'
WHERE movie_id = 106;

-- selection in DB
SELECT * FROM Movies WHERE genre = 'Sci-Fi';
SELECT * FROM Users WHERE email LIKE '%@example.pk';
SELECT * FROM Movies WHERE release_year > 2010;

-- use of join
SELECT u.name, m.title, r.rating
FROM Ratings r
JOIN Users u ON r.user_id = u.user_id
JOIN Movies m ON r.movie_id = m.movie_id;

SELECT u.name, m.title, r.rating
FROM Users u
LEFT JOIN Ratings r ON u.user_id = r.user_id
LEFT JOIN Movies m ON r.movie_id = m.movie_id;

SELECT m.title, u.name, w.watch_date
FROM WatchHistory w
RIGHT JOIN Movies m ON w.movie_id = m.movie_id
LEFT JOIN Users u ON w.user_id = u.user_id;

-- use of having and aggartive function
SELECT genre, COUNT(*) AS total_movies
FROM Movies
GROUP BY genre;

SELECT user_id, COUNT(*) AS total_ratings
FROM Ratings
GROUP BY user_id
HAVING COUNT(*) >= 2;

SELECT movie_id, AVG(rating) AS average_rating
FROM Ratings
GROUP BY movie_id;

SELECT m.title, r.rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
ORDER BY r.rating DESC
LIMIT 1;

SELECT * FROM WatchHistory ORDER BY watch_date DESC LIMIT 3;

-- subquery in DB
SELECT name
FROM Users
WHERE user_id IN (
    SELECT user_id 
    FROM WatchHistory 
    GROUP BY user_id 
    HAVING COUNT(movie_id) > 1
);

SELECT title
FROM Movies
WHERE movie_id = (
    SELECT movie_id
    FROM Ratings
    GROUP BY movie_id
    ORDER BY AVG(rating) DESC
    LIMIT 1
);
 -- Count how many movies each director has directed
SELECT d.name AS director_name, COUNT(md.movie_id) AS total_movies
FROM Directors d
JOIN Movie_Directors md ON d.director_id = md.director_id
GROUP BY d.director_id, d.name;

-- Count how many movies each actor has acted in
SELECT a.name AS actor_name, COUNT(ma.movie_id) AS total_movies
FROM Actors a
JOIN Movie_Actors ma ON a.actor_id = ma.actor_id
GROUP BY a.actor_id, a.name;

-- Get users whose emails start with 'a'
SELECT * 
FROM Users
WHERE email LIKE 'a%@example.pk';

-- Find the average rating given by each user
SELECT u.name, AVG(r.rating) AS avg_user_rating
FROM Users u
JOIN Ratings r ON u.user_id = r.user_id
GROUP BY u.user_id, u.name;

-- Total movies watched per year
SELECT YEAR(watch_date) AS year, COUNT(*) AS total_watched
FROM WatchHistory
GROUP BY YEAR(watch_date);

-- Genres with more than 1 movie
SELECT genre, COUNT(*) AS genre_count
FROM Movies
GROUP BY genre
HAVING COUNT(*) > 1;

-- Total ratings per genre
SELECT m.genre, COUNT(r.rating_id) AS total_ratings
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.genre;

-- Users who gave the highest rating
SELECT u.name, r.rating
FROM Ratings r
JOIN Users u ON r.user_id = u.user_id
WHERE r.rating = 10;

-- Movie with maximum number of ratings
SELECT m.title, COUNT(r.rating_id) AS rating_count
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.movie_id, m.title
ORDER BY rating_count DESC
LIMIT 1;

