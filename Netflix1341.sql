/* 
Netflix 1341. Movie Rating  https://leetcode.com/problems/movie-rating/

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

Input: 
Movies table:
+-------------+--------------+
| movie_id    |  title       |
+-------------+--------------+
| 1           | Avengers     |
| 2           | Frozen 2     |
| 3           | Joker        |
+-------------+--------------+
Users table:
+-------------+--------------+
| user_id     |  name        |
+-------------+--------------+
| 1           | Daniel       |
| 2           | Monica       |
| 3           | Maria        |
| 4           | James        |
+-------------+--------------+
MovieRating table:
+-------------+--------------+--------------+-------------+
| movie_id    | user_id      | rating       | created_at  |
+-------------+--------------+--------------+-------------+
| 1           | 1            | 3            | 2020-01-12  |
| 1           | 2            | 4            | 2020-02-11  |
| 1           | 3            | 2            | 2020-02-12  |
| 1           | 4            | 1            | 2020-01-01  |
| 2           | 1            | 5            | 2020-02-17  | 
| 2           | 2            | 2            | 2020-02-01  | 
| 2           | 3            | 2            | 2020-03-01  |
| 3           | 1            | 3            | 2020-02-22  | 
| 3           | 2            | 4            | 2020-02-25  | 
+-------------+--------------+--------------+-------------+

Output: 
+--------------+
| results      |
+--------------+
| Daniel       |
| Frozen 2     |
+--------------+
Explanation: 
Daniel and Monica have rated 3 movies ("Avengers", "Frozen 2" and "Joker") but Daniel is smaller lexicographically.
Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.
*/

-- Final Accepted Solution beats 22% runtime: 
with netflix as(SELECT m.movie_id, m.title, rating.rating, u.user_id, u.name, 
year(rating.created_at) as yr, month(rating.created_at) as mth
FROM MovieRating rating
JOIN movies m
ON m.movie_id = rating.movie_id
JOIN users u
ON u.user_id = rating.user_id
),

max_user as (SELECT user_id, name, count(movie_id) as movie_count
FROM netflix
GROUP BY user_id, name
ORDER BY count(movie_id) DESC, name, CHAR_LENGTH(name)
LIMIT 1
),

max_rating as ( SELECT title, avg(rating) as avg_rating
FROM netflix 
WHERE yr=2020 and mth=2
GROUP BY title
ORDER BY avg(rating) DESC, title, CHAR_LENGTH(title) 
LIMIT 1
)

SELECT name as results FROM max_user 
UNION
SELECT title FROM max_rating



--Currently passes 10 / 17 testcases passed:
with netflix as(SELECT m.movie_id, m.title, mr.rating, u.user_id, u.name
FROM MovieRating mr
JOIN movies m
ON m.movie_id = mr.movie_id
JOIN users u
ON u.user_id = mr.user_id
WHERE year(mr.created_at) = 2020 
AND month(mr.created_at) = 2
),

max_user as (SELECT user_id, name, count(movie_id) as movie_count
FROM netflix
GROUP BY user_id, name
ORDER BY count(movie_id) DESC, name, CHAR_LENGTH(name)
LIMIT 1
),

max_rating as ( SELECT title, avg(rating) as avg_rating
FROM netflix 
GROUP BY movie_id
ORDER BY avg(rating) DESC, title, CHAR_LENGTH(title) 
LIMIT 1
)

SELECT name as results FROM max_user
UNION
SELECT title FROM max_rating
