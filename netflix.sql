/*
Find the genre of the person with the most number of oscar winnings:
https://platform.stratascratch.com/coding/10171-find-the-genre-of-the-person-with-the-most-number-of-oscar-winnings?code_type=5

If there are more than one person with the same number of oscar wins, 
return the first one in alphabetic order based on their name. 
Use the names as keys when joining the tables.
*/

--SQL Server and mySQL:
with netflix as (SELECT oscar.category as genre, 
oscar.nominee as full_name, 
count(oscar.id) as number_oscars
FROM oscar_nominees AS oscar
LEFT JOIN nominee_information AS person 
ON oscar.nominee = person.name
WHERE winner = 'TRUE' 
GROUP BY oscar.category, oscar.nominee
)

SELECT full_name, genre, number_oscars
FROM netflix
ORDER BY number_oscars DESC, full_name
;
