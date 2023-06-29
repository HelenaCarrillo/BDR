# TAREA 8
## Right Join
Para facilitar la consulta de estadísticas de los campiones por tipo de clase y estilo de juego se hizo una vita llamada _championsstats_ con el código

    DROP VIEW IF EXISTS championsstats;

    CREATE VIEW championsstats AS
	    SELECT * FROM champion_def AS iz
	    RIGHT JOIN champion_m_stats AS de
	    ON iz.name_champ = de.champ_name;

Al usar un Right Join se asegura que solo aquellos que tengan datos estadisticos esntrarán a la vista.

Una vez realizado esta vista se pueden realizar consultas para el análisis de las clases y tipos de juego como por ejemplo:

El número de kills por clase:

    SELECT class, round(sum(kills)) AS total_kills FROM championsstats 
	    GROUP BY class ORDER BY total_kills DESC;

El número de kills por clase y estilo de juego:

    SELECT class, playstyle, round(sum(kills)) AS total_kills FROM championsstats 
	GROUP BY class, playstyle ORDER BY total_kills DESC;

Lo mismo para el número de victorias:

    SELECT class, round(sum(win)) AS total_wins FROM championsstats 
	    GROUP BY class ORDER BY total_wins DESC;

    SELECT class, playstyle, round(sum(win)) AS total_wins FROM championsstats 
	    GROUP BY class, playstyle ORDER BY total_wins DESC;

## Left Join

## Join

## Subconsulta

## Trigger

Se intetó crear una vista con la indicación:

    DROP VIEW IF EXISTS jugadores;

    CREATE VIEW jugadores AS
	    SELECT * FROM player_stats AS s
	    LEFT JOIN player_def AS d 
        ON s.player_name = d.player_name;

Sin embargo se registró un error ya que ambas columnas tienen el mismo nombre por lo que se modificaron los nombres de la tabla *player_def*:

