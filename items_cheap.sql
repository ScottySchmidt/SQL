/* 
Inventory 
https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true

Determining the minimum number of money needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power.
If more than one wand has same power, sort the result in order of descending age.
---------
*/ 

with items as (SElECT w.id, wp.age, w.coins_needed, w.power, 
rank() OVER(PARTITION BY wp.age ORDER BY w.coins_needed ASC) rn
FROM wands w
JOIN wands_property wp
ON w.code=wp.code
WHERE wp.is_evil=0)

SELECT id, age, coins_needed, power
FROM items
WHERE rn=1
ORDER BY power DESC, age DESC
;
