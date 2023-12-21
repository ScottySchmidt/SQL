/* Days At Number One, Hard (in my opinion Medium) Spotify SQL: https://platform.stratascratch.com/coding/10173-days-at-number-one?code_type=5
Find the number of days a US track has stayed in the 1st position for both the US and worldwide rankings on the same day. 
Output the track name and the number of days in the 1st position. Order your output alphabetically by track name.
If the region 'US' appears in dataset, it should be included in the worldwide ranking.
/*

--Create tracks table that finds songs with same day and trackname:
with tracks_table as (select usa.trackname, usa.date
FROM spotify_daily_rankings_2017_us as usa
JOIN spotify_worldwide_daily_song_ranking as world
ON usa.trackname = world.trackname
AND usa.date = world.date
WHERE world.region= 'US')

-- Perform a count by trackname:
SELECT trackname, count(trackname) as track
FROM tracks_table 
GROUP BY trackname
ORDER BY trackname
