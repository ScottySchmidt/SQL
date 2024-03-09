/*
Netflix StrataScratch: Find the genre of the person with the most number of oscar winnings

Find the genre of the person with the most number of oscar winnings.
If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. 
Use the names as keys when joining the tables.
*/ 

--My SQL SOLUTION:
WITH oscars AS (
    SELECT ni.top_genre, COUNT(ni.top_genre) AS genre_count
    FROM oscar_nominees o
    INNER JOIN nominee_information ni ON o.nominee = ni.name
    WHERE o.winner = true
    GROUP BY ni.top_genre
)
SELECT top_genre 
FROM oscars
ORDER BY genre_count DESC, top_genre ASC
LIMIT 1;
