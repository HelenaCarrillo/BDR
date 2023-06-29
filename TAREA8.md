# TAREA 8
## Join y Right Join
Para facilitar la consulta de estadísticas de los campiones por tipo de clase y estilo de juego se hizo una vita llamada _championsstats_ con el código:

    DROP VIEW IF EXISTS championsstats;

    CREATE VIEW championsstats AS
	    SELECT * FROM champion_def AS iz
	    JOIN champion_m_stats AS de
	    ON iz.name_champ = de.champ_name;

Esto también puede realizarse con RIGHT JOIN:

    DROP VIEW IF EXISTS championsstats;

    CREATE VIEW championsstats AS
	    SELECT * FROM champion_def AS iz
	    RIGHT JOIN champion_m_stats AS de
	    ON iz.name_champ = de.champ_name;

Al usar un RIGHT JOIN se asegura que solo aquellos que tengan datos estadisticos en *champ_m_stats* entrarán a la vista.

Una vez realizado esta vista se pueden realizar consultas para el análisis de las clases y tipos de juego como por ejemplo:

- El número de kills por clase:
    ````
    SELECT class, round(sum(kills)) AS total_kills FROM championsstats 
	    GROUP BY class ORDER BY total_kills DESC;
- El número de kills por clase y estilo de juego:
    ````
    SELECT class, playstyle, round(sum(kills)) AS total_kills FROM championsstats 
	GROUP BY class, playstyle ORDER BY total_kills DESC;
- Lo mismo para el número de victorias:
    ````
    SELECT class, round(sum(win)) AS total_wins FROM championsstats 
	    GROUP BY class ORDER BY total_wins DESC;

    SELECT class, playstyle, round(sum(win)) AS total_wins FROM championsstats 
	    GROUP BY class, playstyle ORDER BY total_wins DESC;
- Etcétera.

---

## Trigger, Left Join y Subconsulta

Se intetó crear una vista con la indicación:

    DROP VIEW IF EXISTS jugadores;

    CREATE VIEW jugadores AS
	    SELECT * FROM player_stats AS s
	    LEFT JOIN player_def AS d 
        ON s.player_name = d.player_name;

Sin embargo se registró un error ya que ambas columnas tienen el mismo nombre por lo que se modificaron los nombres de la tabla *player_def*:

    ALTER TABLE player_def RENAME COLUMN player_name TO player_name_d;
    ALTER TABLE player_def RENAME COLUMN wins TO wins_d;
    ALTER TABLE player_def RENAME COLUMN loses TO loses_d;
    ALTER TABLE player_def RENAME COLUMN win_rate TO win_rate_d;

Una vez cambiados los nombre se puede realizar con exito el LEFT JOIN:

    CREATE VIEW jugadores AS
		SELECT * FROM player_stats AS s
	 	LEFT JOIN player_def AS d ON s.player_name = d.player_name_d;

Una vez comprobado que no existen problemas al momento de crear vistas con este tipo JOIN se procede a crear una nueva consulta que me permita actualizar la tabla *player_def*.

Para esto se verifica primero el resultado para la consulta:

    SELECT player_name,
		COUNT(DISTINCT season) AS sseason,
		SUM(wins) AS swins,
		SUM(games_played) AS sgames_played,
		SUM(loses) AS sloses FROM player_stats GROUP BY player_name;

Esta consulta devuelve un resumen de las estadísticas de cada jugador. En escencia esta es la información encontrada en *player_def*.

Al comprobar que la consulta funciona se utiliza para crear una vista que una ambas tablas:

    DROP VIEW IF EXISTS jugadores;

    CREATE VIEW jugadores AS
	    SELECT * FROM (
	     SELECT player_name,
		    COUNT(DISTINCT season) AS sseason,
		    SUM(wins) AS swins,
		    SUM(games_played) AS sgames_played,
		    SUM(loses) AS sloses 
            FROM player_stats GROUP BY player_name
        ) AS s
	    LEFT JOIN player_def AS d ON s.player_name = d.player_name_d;

La vista jugadores cuenta con información resumida de los jugadores desde dos origenes: la almacenada en *player_def* y la que se obtiene directo de *player_stats*.

Considerando que al momento de actualizar la base de datos se hará desde *player_stats* se crea un TRIGGER que me permita actualizar *player_def* a través de la vista *jugadores*.

    DELIMITER //

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
    //

    DELIMITER ;


## Hallazgos

Al momento de crear la vista _championsstats_ se encontraron irregularidades con los nombres de algunos de los registros en *class* y *playstyle* de la tabla *champ_def*. 

Se corrigieron con el siguiente código:

    UPDATE champion_def SET class = 'Controller' WHERE class = 'Controllerer';

    UPDATE champion_def SET class = 'Mage' WHERE class = 'Mage Artillery';

    UPDATE champion_def SET class = 'Controller' WHERE class= 'Support';

Por otra parte, en la creación de TRIGGERS la aclaración de DELIMITER solo es necesaria si se ejecuta desde consola o si se ejecuta el script completo.

FInalmente, las sentencias de BEGIN ... END se pueden usar para comenzar una serie de instrucciones dentro de un TRIGGER.