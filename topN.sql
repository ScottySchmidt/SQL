/* 
Using LATERAL JOIN To Get Top N per Group
https://www.codewars.com/kata/5820176255c3d23f360000a9/train/sql
-------------------------
*/

with cte as(
SELECT  min(p.category_id) as category_id, 
  min(c.category) as category, 
  min(p.title) as title, 
  sum(p.views) as views,
  min(c.id) as post_id,
  row_number() OVER(PARTITION BY c.category ORDER BY sum(p.views) DESC) as rn
FROM categories c
JOIN posts p
ON c.id=p.id
GROUP BY p.category_id
 )
 
 SELECT category_id, title, views, post_id
 FROM cte
 WHERE rn<3
 ORDER BY category, views DESC, post_id

