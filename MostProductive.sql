/*
HARD SQLpad problem
The most productive actors by category 
https://sqlpad.io/questions/74/the-most-productive-actors-by-category/

in process..
*/


SELECT cat.category_id, fa.actor_id, count(fa.film_id) as movie_num
FROM film_actor fa
INNER JOIN film_category cat
ON fa.film_id=cat.film_id
GROUP BY fa.actor_id, cat.category_id
ORDER BY cat.category_id, count(fa.film_id) DESC

