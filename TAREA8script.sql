USE lol_stats;

SHOW tables;

--- Crear JOINS
DROP VIEW IF EXISTS championsstats;
CREATE VIEW championsstats AS
	SELECT * FROM champion_def AS iz
	JOIN champion_m_stats AS de
	ON iz.name_champ = de.champ_name;


--- RIGHT Joins ensures ONLY champs WITH stats FROM MATCH will appear
DROP VIEW IF EXISTS championsstats;
CREATE VIEW championsstats AS
	SELECT * FROM champion_def AS iz
	RIGHT JOIN champion_m_stats AS de
	ON iz.name_champ = de.champ_name;

--- consultas posibles 
SELECT class, round(sum(kills)) AS total_kills FROM championsstats 
	GROUP BY class ORDER BY total_kills DESC;

SELECT class, playstyle, round(sum(kills)) AS total_kills FROM championsstats 
	GROUP BY class, playstyle ORDER BY total_kills DESC;

SELECT class, round(sum(win)) AS total_wins FROM championsstats 
	GROUP BY class ORDER BY total_wins DESC;

SELECT class, playstyle, round(sum(win)) AS total_wins FROM championsstats 
	GROUP BY class, playstyle ORDER BY total_wins DESC;




---- TRIGGER, LEFT JOIN y subconsulta

--- primer intento de vistas y LEFT JOIN

DROP VIEW IF EXISTS jugadores;
CREATE VIEW jugadores AS
		SELECT * FROM player_stats AS s
	 	LEFT JOIN player_def AS d ON s.player_name = d.player_name_d;
	 
	 
--- cambio de nombres para solucionar errores de mismo nombre
ALTER TABLE player_def RENAME COLUMN player_name TO player_name_d;
ALTER TABLE player_def RENAME COLUMN wins TO wins_d;
ALTER TABLE player_def RENAME COLUMN loses TO loses_d;
ALTER TABLE player_def RENAME COLUMN win_rate TO win_rate_d;

	 

--- Subconsulta para obtener sumatorias de stats e ingresar en jugadores 
SELECT player_name,
		COUNT(DISTINCT season) AS sseason,
		SUM(wins) AS swins,
		SUM(games_played) AS sgames_played,
		SUM(loses) AS sloses FROM player_stats GROUP BY player_name;
	 
	 
	 
	 -- CREA jugadores
DROP VIEW IF EXISTS jugadores;

CREATE VIEW jugadores AS
	SELECT * FROM (
	 SELECT player_name,
		COUNT(DISTINCT season) AS sseason,
		SUM(wins) AS swins,
		SUM(games_played) AS sgames_played,
		SUM(loses) AS sloses FROM player_stats GROUP BY player_name) AS s
	 LEFT JOIN player_def AS d ON s.player_name = d.player_name_d;
	 

SELECT * FROM jugadores;

-- CREAR TRIGGER
DROP TRIGGER IF EXISTS actualizar_players_def;

-- DELIMITER //
CREATE TRIGGER actualizar_players_def AFTER INSERT ON player_stats
FOR EACH ROW
 BEGIN
	UPDATE jugadores
		SET jugadores.seasons_played = jugadores.sseasons WHERE jugadores.sseason > jugadores.seasons_played;
	UPDATE jugadores
		SET jugadores.wins_d = jugadores.swins WHERE jugadores.swins > jugadores.wins_d;
	UPDATE jugadores
		SET jugadores.played_match = jugadores.sgames_played WHERE jugadores.sgames_played > jugadores.played_match;
	UPDATE jugadores
		SET jugadores.loses_d = jugadores.sloses WHERE jugadores.sloses > jugadores.loses_d;
	UPDATE jugadores 
		SET win_rate_d = jugadores.swins / jugadores.sgames_played;
	END;
-- //
-- DELIMITER ;

/* PRUEBAS PARA SUBCONSULTA
	
-- SELECT * FROM jugadores;

SELECT player_name, COUNT(DISTINCT season) FROM jugadores GROUP BY player_name; -- temporadas jugadas
SELECT player_name, SUM(wins) FROM jugadores GROUP BY player_name; -- wins
SELECT player_name, SUM(games_played) FROM jugadores GROUP BY player_name; -- juego jugados
SELECT player_name, SUM(loses) FROM jugadores GROUP BY player_name;

SELECT player_name, AVG(played_match), SUM(games_played) FROM jugadores GROUP BY player_name; -- juego jugados */






/* CORRECCIONES ENCONTRADAS AL MOMETO DE TRABAJAR LOS DATOS
 
--- Correcciones encontradas al realizar joins en champion_m_stats y champion_def

UPDATE champion_def SET class = 'Controller' WHERE class = 'Controllerer';

UPDATE champion_def SET class = 'Mage' WHERE class = 'Mage Artillery';

UPDATE champion_def SET class = 'Controller' WHERE class= 'Support';
*/

