/*
https://sqlpad.io/questions/49/top-3-money-making-movie-categories/
Top 3 money making movie categories

This problem requires joining six large tables together which is a large amount.
The difficult part becomes knowing when to use LEFT or INNER JOIN.
Using a LIMIT 3 at the end creates a memory error more research needed.
*/

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
