/* 
Using LATERAL JOIN To Get Top N per Group
https://www.codewars.com/kata/5820176255c3d23f360000a9/train/sql

Given the schema presented below write a query, which uses a window function, that returns two most viewed posts for every category.

Order the result set by:

category name alphabetically
number of post views largest to lowest
post id lowest to largest
Note:

Some categories may have less than two or no posts at all.
Two or more posts within the category can be tied by (have the same) the number of views. 
Use post id as a tie breaker - a post with a lower id gets a higher rank.

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
