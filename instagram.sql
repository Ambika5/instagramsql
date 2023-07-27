#1. Find the 5 oldest instagram users?

select username,created_at
from users
order by created_at
limit 5;

#Find the user who never posted on instagram?
select u.username 
from users as u
inner join photos as p 
on p.id = u.id
where p.image_url is null
order by u.username;

# 3.Identify the winner of the contest and provide details to the team?
select l.photo_id, u.username, count(l.user_id) as numlikes
from likes as l
inner join photos as p
on l.photo_id = p.id
inner join users as u
on p.user_id = u.id
group by l.photo_id, u.username
order by numlikes desc; 

# 4.What day of the week do most users register?
select date_format((created_at), '%d') as dated , count(username) as numusers
from users
group by 1
order by 2;

#5.how many times an average user post on instagram? 
WITH cte AS (
    SELECT u.username, COUNT(l.photo_id) AS numph
    FROM likes AS l
    INNER JOIN users AS u ON u.id = l.user_id
    GROUP BY u.username
)

SELECT cte.username, cte.numph AS likes
FROM cte
WHERE cte.numph = (SELECT COUNT(*) FROM photos 
WHERE cte.username = cte.username);
