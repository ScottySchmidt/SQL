/*
https://sqlpad.io/questions/49/top-3-money-making-movie-categories/
Top 3 money making movie categories

This problem requires joining six large tables together which is a large amount.
Using a simple INNER JOIN on the primary key IDS should match all the tables correctly.

Using a LIMIT 3 at the end creates a memory error more research needed.
Therefore, a window function row_number is one solution to make the solution faster:
https://community.snowflake.com/s/article/Out-of-memory-error-caused-by-LIMIT-and-or-OFFSET-clause
Using a row_number also creates a memory error but this is the correct solution as well.
*/

SELECT c.name,  
row_number() OVER (PARTITION BY c.name ORDER BY p.amount DESC ) as rn
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN inventory i
ON fc.film_id=i.film_id
INNER JOIN rental r
ON r.inventory_id=i.inventory_id
INNER JOIN payment p
ON p.customer_id=r.customer_id



SELECT c.name,  sum(p.amount)
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN inventory i
ON fc.film_id=i.film_id
INNER JOIN rental r
ON r.inventory_id=i.inventory_id
INNER JOIN payment p
ON p.customer_id=r.customer_id
GROUP BY c.name
ORDER BY sum(p.amount) DESC



