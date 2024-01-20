/* 
YouTube Solution: https://www.youtube.com/watch?v=lBuUzWqP61Y
Algorithm Performance, Hard SQL

Meta/Facebook is developing a search algorithm that will allow users to search through their post history. 
You have been assigned to evaluate the performance of this algorithm.
We have a table with the user's search term, search result positions, and whether or not the user clicked on the search result.

Write a query that assigns ratings to the searches in the following way:
•	If the search was not clicked for any term, assign the search with rating=1
•	If the search was clicked but the top position of clicked terms was outside the top 3 positions, assign the search a rating=2
•	If the search was clicked and the top position of a clicked term was in the top 3 positions, assign the search a rating=3

As a search ID can contain more than one search term, select the highest rating for that search ID. 
Output the search ID and its highest rating.

Example: The search_id 1 was clicked (clicked = 1) and its position is outside of the top 3 positions (search_results_position = 5), therefore its rating is 2.
*/

with cte  as (SELECT search_id, 
case WHEN clicked = 0 THEN 1
WHEN clicked = 1 AND search_results_position > 3 THEN 2
WHEN clicked = 1 AND search_results_position <= 3 THEN 3
END as rating
FROM fb_search_events
)

SELECT search_id, max(rating) as best_rating
FROM cte
GROUP BY search_id
