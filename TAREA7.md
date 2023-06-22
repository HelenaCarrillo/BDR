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


Esto da como resultado 52 registros.

Para comprobar que efectivamente no hay datos para estos registros se probaron todos los casos (números del 0 a 51) en la tabla de *match_stats*:

    SET @nom = (SELECT champ_name FROM champion_m_stats WHERE played_games = 0 LIMIT 0,1);

    SET @ssn = (SELECT season FROM champion_m_stats WHERE played_games = 0 LIMIT 0,1);

    SELECT @nom, @ssn;

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

Se encontró una serie de elementos que aparecían con 0 juegos en la temporada a pesar de tener registros en la tabla de *match_stats*:

- 19,1 Jax 8
- 20,1 Sivir 8
- 22,1 Drius 8
- 23,1 Pyke 8
- 24,1 Jax 9
- 25,1 Vayne 9
- 26,1 Pantheon 9
- 27,1 Braum 9
- 28,1 Jhin 9
- 30,1 Blitzcrank 10
- 31,1 LeBlanc 10
- 32,1 Lux 10
- 34,1 Quinn 10
- 35,1 VelKoz 10
- 36,1 Swain 10
- 38,1 Morgana 10
- 39,1 Kassadin 11
- 40,1 Yuumi 11
- 41,1 Ziggs 11

Se busca corregir los datos posibles que en esta ocasión solo es posible obtener la información correspondiente a las columnas:
- played_games
- win
- lose
- win_rate

Para evitar posible perdida de datos se realizaron primero columnas prueba de cada una:

    ALTER TABLE champion_m_stats ADD prueba_played float AFTER played_games;
    UPDATE champion_m_stats SET prueba_played = played_games;

    ALTER TABLE champion_m_stats ADD prueba_win float AFTER win;
    UPDATE champion_m_stats SET prueba_win = champion_m_stats.win;

    ALTER TABLE champion_m_stats ADD prueba_lose float AFTER lose;
    UPDATE champion_m_stats SET prueba_lose = lose;

    ALTER TABLE champion_m_stats ADD prueba_win_rate float AFTER win_rate;
    UPDATE champion_m_stats SET prueba_win_rate = win_rate;

After un análisis más detallado se descubrió que existen registros de un mismo champeón durante la misma temporada bajo dos tipos de eventos: _Play in_ y _Main_. 

Bajo esta misma condición se revisaron nuevamente si existen registros con matches registrados que no se ven reflejados en las estadicticas de *champ_m_stats*:

    SET @nom = (SELECT champ_name FROM champion_m_stats WHERE played_games = 0 LIMIT 51,1);

    SET @ssn = (SELECT season FROM champion_m_stats WHERE played_games = 0 LIMIT 51,1);

    SET @evt= (SELECT event FROM champion_m_stats WHERE played_games = 0 LIMIT 51,1);

    -- ver datos con información
    SELECT * FROM match_stats WHERE 
    (pick_1_blue_team = @nom AND season = @ssn AND event = @evt) OR 
    (pick_2_blue_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_3_blue_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_4_blue_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_5_blue_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_1_red_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_2_red_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_3_red_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_4_red_team = @nom AND season = @ssn AND event = @evt) OR
    (pick_5_red_team = @nom AND season = @ssn AND event = @evt)
    ;

Bajo esta misma condición no hay registros incorrectos por lo que se eliminan las columnas de prueba:

    ALTER TABLE champion_m_stats DROP COLUMN prueba_played;
    ALTER TABLE champion_m_stats DROP COLUMN prueba_win;
    ALTER TABLE champion_m_stats DROP COLUMN prueba_lose;
    ALTER TABLE champion_m_stats DROP COLUMN prueba_win_rate;


---

- match_stats 


