/*
HARD SQLpad problem
The most productive actors by category 
https://sqlpad.io/questions/74/the-most-productive-actors-by-category/

Using max in (fa.film_id) is just a way to use an agg within a groupnby later to not throw an error.
*/

with categories as (SELECT cat.category_id, 
max(fa.actor_id) as actor_id,
count(fa.film_id) as movie_num,
rank() over(PARTITION BY cat.category_id ORDER BY count(fa.film_id) DESC) as rn
FROM film_actor fa
INNER JOIN film_category cat
ON fa.film_id=cat.film_id
GROUP BY cat.category_id, fa.actor_id
ORDER BY cat.category_id
)

SELECT category_id, actor_id, movie_num
FROM categories
WHERE rn=1
ORDER BY category_id



