/*
Subqueries master from Codewars:

Use proficient at string manipulation (and perhaps that you can use extensively subqueries).
You will use people table but will focus solely on the name column:

Greyson Tate Lebsack Jr.
Elmore Clementina O'Conner

Note: Don't forget to remove spaces around names in your result.
Note: Due to multicultural context, if full name has more than 3 words, consider the last 2 as first_lastname and second_lastname, all other names belonging to name.

Explanation: 
1. Most people have three names. However, a title makes a forth name. 
2. Use SPLIT_PART to get the name into four strings. The forth name is only a potential.
3. If a name only have three names then the case statements are normal.
4. However, if four names then the first two names go into the first column.
*/

with names as(
SELECT 
split_part(name, ' ', 1) as name,
split_part(name, ' ', 2) as first_lastname,
split_part(name, ' ', 3) as second_lastname,
split_part(name, ' ', 4) as forth
FROM people
)

SELECT 
(CASE WHEN forth ='' THEN name 
ELSE concat(name, ' ', first_lastname) END) as name,
(CASE WHEN forth ='' THEN first_lastname 
ELSE  second_lastname END) as first_lastname,
(CASE WHEN forth ='' THEN  second_lastname
ELSE forth  END) as second_lastname
 
FROM names
