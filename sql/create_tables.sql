CREATE DATABASE netflix_challenge ;
USE netflix_challenge ;

CREATE TABLE users (
user_id INT PRIMARY KEY,
signup_date DATE,
country VARCHAR(150),
plan_type VARCHAR(100)
);

CREATE TABLE content(
content_id INT PRIMARY KEY,
title VARCHAR(100),
genre VARCHAR(50),
content_type VARCHAR(100),
release_year INT
);

CREATE TABLE watch_history (
watch_id INT PRIMARY KEY,
user_id INT,
content_id INT,
watch_date DATE,
minutes_watched INT,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY(content_id) REFERENCES content(content_id)
);