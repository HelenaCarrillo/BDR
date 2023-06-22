# TAREA 7

Para esta tarea se usó la base de datos ***lol_stats*** que consta de las tablas:
- champion_def
- champion_m_stats
- match_stats 
- player_def
- player_stats
- team_stats

Se comenzó por analizar los valores NULL de cada una de las tablas.

---

## team_stats
No se encontraron valores NULL.

---

## player_def
No se encontraron valores NULL.

----
 
## champion_def
 De esta tabla se encoontró que se tenían nulos en la columna _resource_ con la instrucción:

    SELECT * FROM champion_def WHERE resource IS NULL;

En este caso un valor NULL significa que el campeón es del tipo _Resourceless_.

Se contempló cambiar estos datos con la instrucción:

    UPDATE champion_def SET resource = 'Resourceless' WHERE resource IS NULL;

Sin embargo se considera que para futuras modificaciones es más facil el manejarlo como NULL.

Sin embargo para realizar el ejercicio se creo una columna llamada _pruebaa_ y se copió el contenido de la columna _resource_ para después realizar el cambio en ella para finalmente eliminarla:

    ALTER TABLE champion_def ADD pruebaa VARCHAR(20) AFTER resource;

    UPDATE champion_def SET pruebaa = resource;

    UPDATE champion_def SET pruebaa = 'Resourceless' WHERE pruebaa IS NULL;

    ALTER TABLE champion_def DROP COLUMN pruebaa;

---

## player_stats
Se encontraron valores nulos durante las orimeras temporadas en las columnas:
- damage
- damage/min
- kill_participation
- kill_share
- gold_share

Esta falta de datos puede deberse a que no se registraban estas estadisticas durante las primeras temporadas ya que faltan para todos los registros de las mismas.

Se decidió que se debe mantener de esta manera.

------------

## champion_m_stats
Se encontraron valores NULL en todas las columnas, sin embargo en muchas ocasiones esto se debe a que no se tienen datos ya que el campeón no fue escogido durante esa temporada. Estos registros se pueden ver con:

    SELECT * FROM champion_m_stats WHERE played_games = 0;

Para comprobar que efectivamente no hay datos para estos registros se probaron con algunos casos:



- champion_m_stats
- match_stats 


