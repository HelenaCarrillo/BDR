# TAREA 6
Para esta tarea se usó la base de datos ***lol_stats*** que consta de las tablas:
- champion_def
- champion_m_stats
- match_stats 
- player_def
- player_stats
- team_stats

---
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

-------
## Media
Para poner en practica el cálculo de la media se utilizó también la tabla *champion_def* y se calculó la media de los precios en blue essence y rp de todos los campeones usando la siguiente instrucción:

        SELECT AVG(blue_essence_price) AS 'Precio promedio blue essence' , AVG(rp_price) AS 'Precio promedio rp' FROM champion_def;

El resultado obtenido es el siguiente:

```
+------------------------------+--------------------+
| Precio promedio blue essence | Precio promedio rp |
+------------------------------+--------------------+
|                    4038.0368 |           794.8773 |
+------------------------------+--------------------+
```


| Precio promedio blue essence | Precio promedio rp |
|:-----------------------------|:-------------------|
|                    4038.0368 |           794.8773 |


También se calcularon estas mismas medias para cada uno de los estilos de juego con la siguinete instrucción:

        SELECT playstyle,  AVG(blue_essence_price) AS 'blue essence', AVG(rp_price) AS 'rp_price' FROM champion_def GROUP BY playstyle ORDER BY AVG(blue_essence_price) DESC;

El resultado fue el siguiente:

````
+------------+--------------+----------+
| playstyle  | blue essence | rp_price |
+------------+--------------+----------+
| Skirmisher |    4853.5714 | 847.8571 |
| Artillery  |    4800.0000 | 880.0000 |
| Assassin   |    4650.0000 | 869.4118 |
| Marksman   |    4506.5217 | 830.6522 |
| Catcher    |    4500.0000 | 852.1429 |
| Battlemage |    4227.2727 | 816.3636 |
| Diver      |    4160.0000 | 813.3333 |
| Burst      |    4153.1250 | 811.5625 |
| Enchanter  |    3562.5000 | 741.2500 |
| Vanguard   |    3507.6923 | 749.2308 |
| Juggernaut |    3182.1429 | 716.0714 |
| Warden     |    3050.0000 | 659.1667 |
| Specialist |    2970.0000 | 700.6667 |
+------------+--------------+----------+
````


| playstyle  | blue essence | rp_price |
|------------|--------------|----------|
| Skirmisher |    4853.5714 | 847.8571 |
| Artillery  |    4800.0000 | 880.0000 |
| Assassin   |    4650.0000 | 869.4118 |
| Marksman   |    4506.5217 | 830.6522 |
| Catcher    |    4500.0000 | 852.1429 |
| Battlemage |    4227.2727 | 816.3636 |
| Diver      |    4160.0000 | 813.3333 |
| Burst      |    4153.1250 | 811.5625 |
| Enchanter  |    3562.5000 | 741.2500 |
| Vanguard   |    3507.6923 | 749.2308 |
| Juggernaut |    3182.1429 | 716.0714 |
| Warden     |    3050.0000 | 659.1667 |
| Specialist |    2970.0000 | 700.6667 |

---

## Cuantil distinto a la media
Para calular un cuantil


## Moda

Hallazgos, dificultades, soluciones encontradas en línea. ETC. 