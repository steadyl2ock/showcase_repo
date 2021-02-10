SELECT
    table_1.team_name,
    table_2.total_player_cost/table_1.avg_pl_ppg AS total_team_value
FROM
    (SELECT
        tt.team_name,
        SUM(player_cost) AS total_player_cost
    FROM teamtable AS tt
    JOIN teamtoplayer AS tp
        ON tt.team_id = tp.team_id
    JOIN playertable as pt
        ON tp.player_id = pt.player_id
    GROUP BY tt.team_name) AS table_2,
     (SELECT
        team_name,
        SUM(avg_pl_ppg) AS avg_pl_ppg
    FROM teamtable AS tt
    JOIN teamtoplayer AS tp
        ON tt.team_id = tp.team_id
    JOIN playertable AS pt
        ON tp.player_id = pt.player_id
     GROUP BY tt.team_name) AS table_1
GROUP BY table_1.team_name
;



SELECT
     first_name,
     last_name,
     COUNT(rating) AS count,
     IFNULL(MIN(rating), 0) AS min,
     IFNULL(MAX(rating), 0) AS max,
     ROUND(IFNULL(AVG(rating), 0) , 2) AS avg,
     CASE 
         WHEN COUNT(rating) >= 10 THEN 'POWER USER'
         WHEN COUNT(rating) > 0 THEN 'ACTIVE'
         ELSE 'INACTIVE'
     END AS 'STATUS'
 FROM reviewers
 LEFT JOIN reviews
     ON reviewers.id = reviews.reviewer_id
 GROUP BY reviewers.id
 ;
 
 
 
 SELECT
    photos.id AS id,
    COUNT(photo_id) AS likes,
    username
FROM photos
RIGHT JOIN likes
    ON photos.id = likes.photo_id
RIGHT JOIN users
    ON photos.user_id = users.id
GROUP BY
    id
ORDER BY
    likes DESC
LIMIT 3
;



SELECT
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS reviewers
FROM series
INNER JOIN reviews
    ON series.id = reviews.series_id
INNER JOIN reviewers
    ON reviewers.id = reviews.reviewer_id
ORDER BY title
;
