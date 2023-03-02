/*
Calculate Running Total 
Second Hardest Difficulity from Codewars.com
Given a posts table that contains a created_at timestamp column write a query that returns date (without time component), 
a number of posts for a given date and a running (cumulative) total number of posts up until a given date. 
The resulting set should be ordered chronologically by date.

This problem is easy once you read an article on running total:
http://www.silota.com/docs/recipes/sql-running-total.html

One must convert the totals into an INT as SQL sometimes defaults to scientific notation. 
*/


with cte as( SELECT date(created_at) as date, count(title) as count, 
sum(count(title)) over (order by date(created_at)) as total
FROM posts
GROUP BY date
ORDER BY date
)

SELECT date, count, cast(total as int) as total
FROM cte
