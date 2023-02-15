/* 
Inventory 
https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true

in progress
---------
*/ 

SELECT w.id, w.code, w.coins_needed, w.power
FROM wands w
JOIN wands_property wp
ON w.code=wp.code
WHERE wp.is_evil=0
ORDER BY w.power, wp.age
;
