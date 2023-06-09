# TAREA 6
Para esta tarea se usó la base de datos ***lol_stats*** que consta de las tablas:
- champion_def
- champion_m_stats
- match_stats 
- player_def
- player_stats
- team_stats

## Conteo de frecuencias
Se eligió calcular la frecuencia de cada estilo de juego de los campiones listados en la tabla *champion_def*.

Para esto se usó la siguiente instrucción para mostrarlos ordenados de forma descendente conforme a su frecuencia:

        SELECT playstyle, COUNT(playstyle) AS frequency FROM champion_def GROUP BY playstyle ORDER BY COUNT(playstyle) DESC;

Dicha instrucción nos arroja el siguiente resultado:
```
+------------+-----------+
| playstyle  | frequency |
+------------+-----------+
| Marksman   |        23 |
| Assassin   |        17 |
| Burst      |        16 |
| Specialist |        15 |
| Diver      |        15 |
| Juggernaut |        14 |
| Skirmisher |        14 |
| Vanguard   |        13 |
| Battlemage |        11 |
| Enchanter  |         8 |
| Catcher    |         7 |
| Warden     |         6 |
| Artillery  |         4 |
+------------+-----------+
```

| playstyle  | frequency |
|------------|----------:|
| Marksman   |        23 |
| Assassin   |        17 |
| Burst      |        16 |
| Specialist |        15 |
| Diver      |        15 |
| Juggernaut |        14 |
| Skirmisher |        14 |
| Vanguard   |        13 |
| Battlemage |        11 |
| Enchanter  |         8 |
| Catcher    |         7 |
| Warden     |         6 |
| Artillery  |         4 |


## Media

## Cuantil distinto a la media

## Moda

Hallazgos, dificultades, soluciones encontradas en línea. ETC. 