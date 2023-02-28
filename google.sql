/*
https://sqlpad.io/questions/83/top-search_query-in-us-and-uk-on-new-years-day/
Top search_query in US and UK on new year's day.
Medium Search Engine SQL
This problem was rather simple.
*/

SELECT country, query
FROM search
WHERE country IN ('US', 'UK')
AND DATE = '2021-01-01'
GROUP BY country, query
ORDER BY count(DISTINCT user_id) DESC
LIMIT 2
