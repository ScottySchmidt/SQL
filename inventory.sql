/*
https://sqlpad.io/questions/42/films-that-are-in-stock-vs-not-in-stock/

Write a query to return the number of films that we have inventory vs no inventory.
A film can have multiple inventory ids
Each film dvd copy has a unique inventory ids

To solve this problem one must:
1. Use a LEFT join from films to inventory so every film has an inventory.
This is the most challenging part of the problem.
2. COUNT how many items are not in stock versus in stock.
3. Union the data together.
*/


with no_invo as (select f.film_id, f.title
  from film f
  left join inventory i on f.film_id = i.film_id 
 where i.inventory_id is null
	),
	
 invo as (select f.film_id, f.title
  from film f
  left join inventory i on f.film_id = i.film_id 
 where i.inventory_id is NOT null
		   )
		   
		   
SELECT 'in stock' as in_stock, COUNT(*)
FROM invo
UNION 
SELECT 'not in stock' as in_stock, COUNT(*)
FROM no_invo
