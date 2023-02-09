Average Post Hiatus (Part 1) [Facebook SQL Interview Question]
https://datalemur.com/questions/sql-average-post-hiatus-1

Given a table of Facebook posts, for each user who posted at least twice in 2021,
write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021.
Output the user and number of the days between each user's first and last post.

This is considered an easy problem but useful to know how to extract first/last date 
---------------------------------

SELECT user_id, 
EXTRACT(day FROM max(post_date) - min(post_date))
FROM posts
WHERE EXTRACT(year from post_date)=2021
GROUP BY user_id
HAVING count(post_id)>1
;
