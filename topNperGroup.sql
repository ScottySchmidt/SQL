*/ Using Window Functions To Get Top N per Group
Code Wars SQL
/* 

with cte as ( SELECT c.id as category_id, c.category, p.title, p.views, p.id as post_id, 
row_number() OVER( PARTITION BY c.id ORDER BY p.views, p.id DESC )as rn
FROM categories c
JOIN posts p
ON c.id=p.category_id
 )
 
 SELECT category_id, category, title, views, post_id
 FROM cte
 WHERE rn<3
 ORDER BY category, views DESC
