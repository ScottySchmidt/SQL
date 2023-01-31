/*
3-Topping [McKinsey SQL Interview Question]
https://datalemur.com/questions/pizzas-topping-cost

consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. 
Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.
Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.
Be careful with the spacing (or lack of) between each ingredient
Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.

This problem is considered HARD. It becomes easier once one realizes to use a CROSS JOIN.
Also, one must use a < sign when comparing names. Otherwise, the names will not sort in alphabetical order
*/

WITH combos as (SELECT p1.topping_name as name1,
p2.topping_name as name2,
p3.topping_name as name3,
p1.ingredient_cost as cost1, 
p2.ingredient_cost as cost2, 
p3.ingredient_cost as cost3
FROM pizza_toppings p1
INNER JOIN pizza_toppings p2
ON p1.topping_name<p2.topping_name
INNER JOIN pizza_toppings p3
ON p2.topping_name<p3.topping_name
)

SELECT concat(name1, ',', name2, ',', name3) as pizza,
(cost1+cost2+cost3) as total_cost 
FROM combos
ORDER BY total_cost DESC, pizza
;
