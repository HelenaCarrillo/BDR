USE lol_stats;

SHOW TABLES;

-- buscar nulls
SELECT * FROM champion_def;
SELECT * FROM champion_def WHERE name_champ IS NULL;
SELECT * FROM champion_def WHERE title_champ IS NULL;
SELECT * FROM champion_def WHERE class IS NULL;
SELECT * FROM champion_def WHERE playstyle IS NULL;
SELECT * FROM champion_def WHERE date_release IS NULL;
SELECT * FROM champion_def WHERE last_change IS NULL;
SELECT * FROM champion_def WHERE blue_essence_price IS NULL;
SELECT * FROM champion_def WHERE rp_price IS NULL;
SELECT * FROM champion_def WHERE resource IS NULL; -- NULL
SELECT * FROM champion_def WHERE HP IS NULL;
SELECT * FROM champion_def WHERE HP_inc IS NULL;
SELECT * FROM champion_def WHERE HP_lvl18 IS NULL;
SELECT * FROM champion_def WHERE HP5 IS NULL;
SELECT * FROM champion_def WHERE HP5_inc IS NULL;
SELECT * FROM champion_def WHERE HP5_lvl18 IS NULL;
SELECT * FROM champion_def WHERE MP IS NULL;
SELECT * FROM champion_def WHERE MP_inc IS NULL;
SELECT * FROM champion_def WHERE MP_lvl18 IS NULL;
SELECT * FROM champion_def WHERE MP5 IS NULL;
SELECT * FROM champion_def WHERE MP5_inc IS NULL;
SELECT * FROM champion_def WHERE MP5_lvl18 IS NULL;
SELECT * FROM champion_def WHERE AD IS NULL;
SELECT * FROM champion_def WHERE AD_inc IS NULL;
SELECT * FROM champion_def WHERE AD_lvl18 IS NULL;
SELECT * FROM champion_def WHERE AS_stat IS NULL;
SELECT * FROM champion_def WHERE AS_inc IS NULL;
SELECT * FROM champion_def WHERE AS_lvl18 IS NULL;
SELECT * FROM champion_def WHERE AR IS NULL;
SELECT * FROM champion_def WHERE AR_inc IS NULL;
SELECT * FROM champion_def WHERE AR_lvl18 IS NULL;
SELECT * FROM champion_def WHERE MR IS NULL;
SELECT * FROM champion_def WHERE MR_inc IS NULL;
SELECT * FROM champion_def WHERE MR_lvl18 IS NULL;
SELECT * FROM champion_def WHERE MS IS NULL;
SELECT * FROM champion_def WHERE MS_lvl18 IS NULL;
SELECT * FROM champion_def WHERE range_stat IS NULL;
SELECT * FROM champion_def WHERE range_lvl18 IS NULL;

-- prueba de cambio de null por una cadena creando una columna copia
ALTER TABLE champion_def ADD pruebaa VARCHAR(20) AFTER resource;
UPDATE champion_def SET pruebaa = resource;
UPDATE champion_def SET pruebaa = 'Resourceless' WHERE pruebaa IS NULL;
ALTER TABLE champion_def DROP COLUMN pruebaa;

-- nulls de champion_m_stats
SELECT * FROM champion_m_stats;
SELECT * FROM champion_m_stats WHERE played_games = 0;

SET @nom = (SELECT champ_name FROM champion_m_stats WHERE played_games = 0 LIMIT 32,1);
SET @ssn = (SELECT season FROM champion_m_stats WHERE played_games = 0 LIMIT 32,1);
SET @evt= (SELECT event FROM champion_m_stats WHERE played_games = 0 LIMIT 32,1);
SELECT @nom, @ssn;

-- ver datos con información
SELECT * FROM match_stats WHERE 
(pick_1_blue_team = @nom AND season = @ssn) OR 
(pick_2_blue_team = @nom AND season = @ssn) OR
(pick_3_blue_team = @nom AND season = @ssn) OR
(pick_4_blue_team = @nom AND season = @ssn) OR
(pick_5_blue_team = @nom AND season = @ssn) OR
(pick_1_red_team = @nom AND season = @ssn) OR
(pick_2_red_team = @nom AND season = @ssn) OR
(pick_3_red_team = @nom AND season = @ssn) OR
(pick_4_red_team = @nom AND season = @ssn) OR
(pick_5_red_team = @nom AND season = @ssn)
;

-- games played
SELECT COUNT(season) FROM match_stats WHERE
(pick_1_blue_team = @nom AND season = @ssn) OR 
(pick_2_blue_team = @nom AND season = @ssn) OR
(pick_3_blue_team = @nom AND season = @ssn) OR
(pick_4_blue_team = @nom AND season = @ssn) OR
(pick_5_blue_team = @nom AND season = @ssn) OR
(pick_1_red_team = @nom AND season = @ssn) OR
(pick_2_red_team = @nom AND season = @ssn) OR
(pick_3_red_team = @nom AND season = @ssn) OR
(pick_4_red_team = @nom AND season = @ssn) OR
(pick_5_red_team = @nom AND season = @ssn)
;

-- wins
SELECT COUNT(season) FROM match_stats WHERE
(pick_1_blue_team = @nom AND season = @ssn AND winner = blue_team) OR 
(pick_2_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_3_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_4_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_5_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_1_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_2_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_3_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_4_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_5_red_team = @nom AND season = @ssn AND winner = red_team)
;

-- win ratio
SELECT (SELECT COUNT(season) FROM match_stats WHERE
(pick_1_blue_team = @nom AND season = @ssn AND winner = blue_team) OR 
(pick_2_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_3_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_4_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_5_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_1_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_2_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_3_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_4_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_5_red_team = @nom AND season = @ssn AND winner = red_team))/(SELECT COUNT(season) FROM match_stats WHERE
(pick_1_blue_team = @nom AND season = @ssn) OR 
(pick_2_blue_team = @nom AND season = @ssn) OR
(pick_3_blue_team = @nom AND season = @ssn) OR
(pick_4_blue_team = @nom AND season = @ssn) OR
(pick_5_blue_team = @nom AND season = @ssn) OR
(pick_1_red_team = @nom AND season = @ssn) OR
(pick_2_red_team = @nom AND season = @ssn) OR
(pick_3_red_team = @nom AND season = @ssn) OR
(pick_4_red_team = @nom AND season = @ssn) OR
(pick_5_red_team = @nom AND season = @ssn)) AS win_ratio;

-- loses
SELECT (SELECT COUNT(season) FROM match_stats WHERE
(pick_1_blue_team = @nom AND season = @ssn) OR 
(pick_2_blue_team = @nom AND season = @ssn) OR
(pick_3_blue_team = @nom AND season = @ssn) OR
(pick_4_blue_team = @nom AND season = @ssn) OR
(pick_5_blue_team = @nom AND season = @ssn) OR
(pick_1_red_team = @nom AND season = @ssn) OR
(pick_2_red_team = @nom AND season = @ssn) OR
(pick_3_red_team = @nom AND season = @ssn) OR
(pick_4_red_team = @nom AND season = @ssn) OR
(pick_5_red_team = @nom AND season = @ssn))-(SELECT COUNT(season) FROM match_stats WHERE
(pick_1_blue_team = @nom AND season = @ssn AND winner = blue_team) OR 
(pick_2_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_3_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_4_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_5_blue_team = @nom AND season = @ssn AND winner = blue_team) OR
(pick_1_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_2_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_3_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_4_red_team = @nom AND season = @ssn AND winner = red_team) OR
(pick_5_red_team = @nom AND season = @ssn AND winner = red_team)) AS loses;






SET @nom = (SELECT champ_name FROM champion_m_stats WHERE played_games = 0 LIMIT 27,1);
SET @ssn = (SELECT season FROM champion_m_stats WHERE played_games = 0 LIMIT 27,1);
SELECT @nom, @ssn;

-- ver datos con información erronea flag
SELECT IF(((SELECT COUNT(*) FROM match_stats WHERE 
(pick_1_blue_team = @nom AND season = @ssn) OR 
(pick_2_blue_team = @nom AND season = @ssn) OR
(pick_3_blue_team = @nom AND season = @ssn) OR
(pick_4_blue_team = @nom AND season = @ssn) OR
(pick_5_blue_team = @nom AND season = @ssn) OR
(pick_1_red_team = @nom AND season = @ssn) OR
(pick_2_red_team = @nom AND season = @ssn) OR
(pick_3_red_team = @nom AND season = @ssn) OR
(pick_4_red_team = @nom AND season = @ssn) OR
(pick_5_red_team = @nom AND season = @ssn))!= 0),


"YES"
, 
"NO"
) AS aplica
;

-- crear columnas prueba para cambios
ALTER TABLE champion_m_stats ADD prueba_played float AFTER played_games;
UPDATE champion_m_stats SET prueba_played = played_games;

ALTER TABLE champion_m_stats ADD prueba_win float AFTER win;
UPDATE champion_m_stats SET prueba_win = champion_m_stats.win;

ALTER TABLE champion_m_stats ADD prueba_lose float AFTER lose;
UPDATE champion_m_stats SET prueba_lose = lose;

ALTER TABLE champion_m_stats ADD prueba_win_rate float AFTER win_rate;
UPDATE champion_m_stats SET prueba_win_rate = win_rate;

SELECT * FROM champion_m_stats WHERE champ_name = @nom AND season= @ssn;
-- ver datos con información erronea flag
UPDATE champion_m_stats
SET prueba_played = 45 
WHERE champ_name = @nom AND season= @ssn AND played_games=0;

UPDATE champion_m_stats
SET prueba_win = 40 
WHERE champ_name = @nom AND season= @ssn;

UPDATE champion_m_stats
SET prueba_lose = prueba_played - prueba_win
WHERE champ_name = @nom AND season= @ssn;

UPDATE champion_m_stats
SET prueba_win_rate = prueba_win / prueba_played 
WHERE champ_name = @nom AND season= @ssn;
