# https://www.hackerrank.com/challenges/placements/problem
# This problem is difficult until one creates the two temp tables below:
# p is temp table of person salary
# f is temp table of freinds salary
# join two tables by original id

SELECT students.name 
FROM friends
JOIN packages p on friends.id=p.id
JOIN packages f on friends.friend_id=f.id
JOIN students on friends.id=students.id
WHERE f.salary>p.salary
order by f.salary 
;
