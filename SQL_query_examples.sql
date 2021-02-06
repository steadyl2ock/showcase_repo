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
GROUP BY table_1.team_name;
