/*
You’re given a table of rental property searches by users. 
The table consists of search results and outputs host information for searchers. 
Find the minimum, average, maximum rental prices for each host’s popularity rating. 
The host’s popularity rating is defined as below:
0 reviews: New
1 to 5 reviews: Rising
6 to 15 reviews: Trending Up
16 to 40 reviews: Popular
more than 40 reviews: Hot

Tip: The id column in the table refers to the search ID. 
You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.

Output host popularity rating and their minimum, average and maximum rental prices.
--------------------------
To solve this we need to:
1. Use distinct because 'create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.'
2. Use case statements to create the pop_rating column
*/



with cte as(select distinct price, room_type, host_since, zipcode,number_of_reviews,
CASE 
WHEN number_of_reviews = 0 THEN 'New'
WHEN number_of_reviews >= 1 AND number_of_reviews < 6 THEN 'Rising'
WHEN number_of_reviews >= 6 AND number_of_reviews <= 15 THEN 'Trending Up'
WHEN number_of_reviews >= 16 AND number_of_reviews <= 40 THEN 'Popular'
WHEN number_of_reviews > 40 THEN 'Hot'
ELSE 'ERROR'
END as pop_rating
FROM airbnb_host_searches 
)
SELECT pop_rating, 
min(price) as min_p,
avg(price) as avg_p,
max(price) as max_p
FROM cte 
GROUP BY pop_rating
