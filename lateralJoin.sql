/* 
Using LATERAL JOIN To Get Top N per Group
https://www.codewars.com/kata/5820176255c3d23f360000a9/train/sql
-------------------------
*/

with cte as(
SELECT  
  c.id as category_id, 
  c.category as category, 
  min(p.title) as title, 
  min(p.views) as views,
  min(p.id) as post_id,
  row_number() OVER(PARTITION BY c.id, c.category  ORDER BY  min(p.views)) as rn
FROM categories c
JOIN posts p
ON c.id=p.category_id
  GROUP BY c.id,   c.category 
 )
 
 SELECT category_id, category, title, views, post_id
 FROM cte
 WHERE rn<3
 ORDER BY category, views DESC, post_id




