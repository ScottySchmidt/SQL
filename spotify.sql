/*
Spotify: https://platform.stratascratch.com/coding/10173-days-at-number-one?code_type=5

Find the number of days a US track has stayed in the 1st position for both the US and worldwide rankings on the same day.
Output the track name and the number of days in the 1st position. 
Order your output alphabetically by track name.
If the region 'US' appears in dataset, it should be included in the worldwide ranking.
*/

--SQL Server:
select usa.trackname, usa.date
FROM spotify_daily_rankings_2017_us as usa
JOIN spotify_worldwide_daily_song_ranking as world
ON usa.trackname = world.trackname
AND usa.date = world.date
WHERE world.region= 'US'
ORDER BY usa.trackname
