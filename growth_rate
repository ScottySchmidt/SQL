/*
https://www.codewars.com/kata/589e0837e10c4a1018000028/train/sql

Given a posts table that contains a created_at timestamp column write a query that returns a first date of the month, 
a number of posts created in a given month and a month-over-month growth rate.
The resulting set should be ordered chronologically by date.

Note:
percent growth rate can be negative
percent growth rate should be rounded to one digit after the decimal point and immediately followed by a percent symbol "%". 
*/

with cte as (SELECT DATE(created_at) as dt, 
EXTRACT(MONTH from created_at) as mth,
EXTRACT(year from created_at) as yr
FROM posts
),

cte2 as(SELECT min(dt) as date, 
count(dt) as count,
mth, yr
FROM cte 
GROUP BY yr, mth
ORDER BY yr, mth
),

cte3 as (SELECT date,
count,
lag(count,1) OVER() as prev,
mth,
yr
FROM cte2
),

cte4 as( SELECT date,
count,
prev,
round( (100*(count-prev)/prev), 1) as percent_growth
FROM cte3
)

SELECT date, count, percent_growth as percent_growth 
FROM cte4
;
