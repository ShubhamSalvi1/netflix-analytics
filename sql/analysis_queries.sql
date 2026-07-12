-- task 1: Show first 10 rows from users table
SELECT * FROM  users
LIMIT 10;

-- task 2: Count total number of users

SELECT COUNT(user_id)  FROM users;

-- task 3: 
 SELECT COUNT(*) FROM watch_history;
 
 -- task 4: filtering, count users from Ireland
 SELECT * FROM users
 WHERE country = 'Ireland';
 
 SELECT * FROM users
 WHERE plan_type = 'Premium'; 
 
SELECT * FROM users
WHERE plan_type = 'Premium' AND country = 'Ireland';

SELECT * FROM users 
WHERE country = 'Ireland' OR 'Germany';

-- task: Count total minutes watched across all users
SELECT SUM(minutes_watched) FROM watch_history;

-- SELECT genre, SUM(minutes_watched)
-- FROM watch_history
-- JOIN content
-- ON  watch_history.content_id = content.content_id
-- GROUP BY genre;
-- task : Find total minutes watched BY genre
-- SELECT c.genre, SUM(w.minutes_watched) AS total_minutes
-- FROM watch_history w
-- JOIN content c 
-- ON w.content_id = c.content_id
-- GROUP BY c.genre;

-- task: Find the top 10 most watched titles by total minutes watched
SELECT c.title, SUM(w.minutes_watched) AS total_minutes
FROM watch_history w
JOIN content c
ON w.content_id = c.content_id
GROUP BY c.title
ORDER BY total_minutes DESC
LIMIT 10;

-- task : total mintues watched per user
SELECT user_id, SUM(minutes_watched) AS total_minutes
FROM watch_history
GROUP BY user_id
ORDER BY total_minutes DESC
LIMIT 10;

-- task : avg watch time by plan_type
SELECT u.plan_type, AVG(w.minutes_watched) AS avg_time
FROM watch_history w
JOIN users u 
ON w.user_id = u.user_id
GROUP BY u.plan_type;

-- task: Find TOTAL watch time AND AVERAGE watch time by plan_type
SELECT u.plan_type, 
AVG(w.minutes_watched) AS avg_time,
SUM(w.minutes_watched) AS total_minutes
FROM watch_history w
JOIN users u 
ON w.user_id = u.user_id
GROUP BY u.plan_type;
