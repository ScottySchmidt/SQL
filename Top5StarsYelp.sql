/*
Top 5 States With 5 Star Businesses, Yelp StrataSratch! 

Find the top 5 states with the most 5 star businesses.
Output the state name along with the number of 5-star businesses and order records by the number of 5-star businesses in descending order. 
In case there are ties in the number of businesses, return all the unique states. 
If two states have the same result, sort them in alphabetical order.
*/

--SQL Solution: 
with cte as(SELECT state, count(stars) as five_stars
FROM yelp_business
WHERE stars = 5
GROUP BY state
),

cte2 as(
SELECT state, five_stars,
RANK()OVER(ORDER BY five_stars DESC) as ranked
FROM cte
)
SELECT state, five_stars
FROM cte2
WHERE ranked <= 5
