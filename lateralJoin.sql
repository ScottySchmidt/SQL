/* 
Using LATERAL JOIN To Get Top N per Group
https://www.codewars.com/kata/5820176255c3d23f360000a9/train/sql

Same problem two times. 
The firt time solve the problem using a window function.
The second time use a left Lateral join.
-------------------------
*/

with cte as ( SELECT c.id as category_id, c.category, p.title, p.views, p.id as post_id, 
row_number() OVER( PARTITION BY c.id ORDER BY p.views DESC, p.id )as rn
FROM categories c
JOIN posts p
ON c.id=p.category_id
 )
 
 SELECT category_id, category, title, views, post_id
 FROM cte
 WHERE rn<3 
 ORDER BY category, views DESC
