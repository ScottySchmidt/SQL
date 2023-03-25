/*
Spotify SQL https://datalemur.com/questions/top-fans-rank

Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".
Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.
For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

Assumptions:
If two artists' songs have the same number of appearances, the artists should have the same rank.
The rank number should be continuous (1, 2, 2, 3, 4, 5) and not skipped (1, 2, 2, 4, 5).

My Notes:  
1. DENSE RANK will sort order by a tie (unless row_number or rank), and will rank by  continuous (1, 2, 2, 3, 4, 5).
  a. Dense Rank does not require a PARTITION BY
*/

--Second solution more easy for beginners:
with spotify as (SELECT a.artist_name
FROM songs s
INNER JOIN artists a
USING (artist_id)
INNER JOIN global_song_rank g
ON g.song_id = s.song_id
WHERE g.rank<11
),

spotify2 as (SELECT artist_name, 
dense_rank() OVER(ORDER BY count(artist_name) DESC) as artist_rank
FROM spotify
GROUP BY artist_name
)

SELECT artist_name, artist_rank
FROM spotify2
WHERE artist_rank < 6
;


--Original solution need to make code more clean
with t1 AS (
SELECT 
  songs.artist_id,
  artists.artist_name,
  COUNT(songs.song_id) AS song_count,
  DENSE_RANK() OVER (
  ORDER BY COUNT(songs.song_id) DESC) artist_rank
FROM songs
INNER JOIN global_song_rank AS ranking
  ON songs.song_id = ranking.song_id
  LEFT JOIN artists
  ON artists.artist_id=songs.artist_id
WHERE ranking.rank <= 10
GROUP BY songs.artist_id, artists.artist_name
)

SELECT artist_name, artist_rank FROM t1
ORDER BY artist_rank, artist_name
LIMIT 6
