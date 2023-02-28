/*
https://sqlpad.io/questions/49/top-3-money-making-movie-categories/
Top 3 money making movie categories

This problem requires joining six large tables together which is a large amount.
The difficult part becomes knowing when to use LEFT or INNER JOIN.
Using a SUM(P.AMOUNT) order by at the end gets a memory error.
*/

SELECT c.name, c.category_id, fc.film_id, i.store_id, p.amount
FROM category c
LEFT JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN inventory i
ON fc.film_id=i.film_id
LEFT JOIN rental r
ON r.inventory_id=i.inventory_id
LEFT JOIN payment p
ON p.customer_id=r.customer_id
