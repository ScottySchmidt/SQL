#These two problems were considered 'mediun' level but were both easy. 
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



/*
CodeWars Daily
find the entries whose name equals "trained"
group them by the day the activity happened (the date part of the created_at timestamp) and their description's
the 2 aforementioned fields should be returned together with the number of grouped entries in a column called count
the result should also be sorted by day
*/
with cte as(SELECT
id, date(created_at) as day, description, name
FROM events
WHERE name='trained'
)

SELECT day, description, count(id) as count 
FROM cte
GROUP BY day, description
ORDER BY day, description
