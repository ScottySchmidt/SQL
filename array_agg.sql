/* https://www.codewars.com/kata/5818bde9559ff58bd90004a2/train/sql
This is the second hardest SQL problem on CodeWars. PostSQL

Given the the schema presented below find two actors who cast together the most and list titles of only those movies they were casting together.
Order the result set alphabetically by the movie title.


Self join the film_actor id to find same movie_id with different person.
If discovered, actor1 and actor 2 are JOINED at end to find their name which is sent to the select statemnent.
array_agg must be used to find all the film_ids. This is needed to find the title_id in the select statement.
------------------
*/

SELECT
concat(a1.first_name, ' ', a1.last_name) as second_actor,
concat(a2.first_name, ' ', a2.last_name) as first_actor,
f.title
FROM (
SELECT 
  t1.actor_id as actor1,
  t2.actor_id as actor2,
  array_agg(t1.film_id) as films_id,
  COUNT(t1.film_id) as casts
  
  FROM film_actor t1
  JOIN film_actor t2
  ON t1.film_id=t2.film_id
  AND t1.actor_id>t2.actor_id
  JOIN film f
  ON t1.film_id=f.film_id
  GROUP BY  t1.actor_id, t2.actor_id
  ORDER BY casts DESC
  LIMIT 1
  ) s
  
JOIN actor a1 ON a1.actor_id=s.actor1
JOIN actor a2 ON a2.actor_id=s.actor2
JOIN film f ON f.film_id=any(s.films_id)
