# https://datalemur.com/questions/top-fans-rank
# Spotify SQL Interview Question

# Original solution need to make code more clean
# DENSE RANK does not require a PARTITION 

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
