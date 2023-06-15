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
Para calular un cuantil se tienen que ordenar los datos de forma ascendente y obtener la posición buscada.

Por ejemplo para calcular el primer cuartil se obtiene el numero total de datos. Podemos calcularla con la siguinete intrucción:

        SELECT COUNT(blue_essence_price) FROM champion_def;

El resultado es:

````
+---------------------------+
| COUNT(blue_essence_price) |
+---------------------------+
|                       163 |
+---------------------------+
````
Al dividir esta cantidad entre 4 para calcular el numero de datos de cada cuartil obtenemos:

        SELECT ROUND((SELECT COUNT(blue_essence_price) FROM champion_def) / 4) AS 'first_quartile';

````
+----------------+
| first_quartile |
+----------------+
|             41 |
+----------------+
````
Ahora es posible obtener el numero que pertenece al primer cuartil si ordenamos los datos y pedimos que obtenga el numero en la posición obtenida:

        SELECT blue_essence_price AS 'first quartile' FROM champion_def ORDER BY blue_essence_price ASC LIMIT 40,1;

````
+----------------+
| first quartile |
+----------------+
|           3150 |
+----------------+
````


## Moda
Para obtener la moda se siguió primero un procedimiento parecido para imprimir las frecuencias cambiando la etiqueta de _frequency_ a _mode_ y limitando la selección al primer elemento:

        SELECT playstyle, COUNT(playstyle) AS mode FROM champion_def GROUP BY playstyle ORDER BY COUNT(playstyle) DESC LIMIT 1;

El resultado obtenido fue el siguiente:

````
+-----------+------+
| playstyle | mode |
+-----------+------+
| Marksman  |   23 |
+-----------+------+
````


| playstyle | mode |
|-----------|-----:|
| Marksman  |   23 |

Después se pensó en utilizar la función de agrupamiento MAX() para indicar que se seleccionara el maximo de las frecuencias.

El primer intento se hizo con la instrucción:

        SELECT playstyle, COUNT(playstyle) AS mode FROM champion_def GROUP BY playstyle HAVING MAX(COUNT(playstyle));

Sin embargo al ser MAX() y COUNT() ambas funciones de agregamiento anidarlas no es posible.

Una breve busqueda en internet reveló que una alternativa a la anidación de las funciones es la "anidación" de los SELECT. 

La logica detrás de la amidación es primero se crea una _tabla temporal_ de consulta con una instrucción (SELECT) parecida a la usada en la impresión de las frecuencias y después esta _tabla temporal_ se usa en lugar de las tablas originales de la base de datos para la otra instrucción (SELECT) donde se obtiene el valor máximo.

La instrucción utilizada es la siguiente:

        SELECT MAX(frequency) AS mode FROM (SELECT playstyle, COUNT(playstyle) FROM champion_def GROUP BY playstyle);

Lamentablemente esta instrucción también generó un error:

        ERROR 1248 (42000): Every derived table must have its own alias

Nuevamente, una busqueda en internet aclaró que la causa es que cada _subquery_ o _tabla temporal_ tiene que tener asignado un nombre. Esto es facilmente corregible usando la instrucción AS.

Al usarse la instrucción corregida:

        SELECT MAX(frequency) AS mode FROM (SELECT playstyle, COUNT(playstyle) FROM champion_def GROUP BY playstyle) as frecuencias;

Se obtuvo lo siguiente:
````
+------+
| mode |
+------+
|   23 |
+------+
````

Sin embargo lo que se busca es que también nos diga el estilo de juego correspondiente.

Se intentó utilizar la instrucción:

        SELECT playstyle, MAX(frequency) AS mode FROM (SELECT playstyle, COUNT(playstyle) FROM champion_def GROUP BY playstyle) as frecuencias;

Sin embargo se originó el siguiente error:

        ERROR 1140 (42000): In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'frecuencias.style'; this is incompatible with sql_mode=only_full_group_by

Se decidió cambiar el acercamiento al problema y se optó por combinar dos metodos previamente vistos. Se buscaría generar nuevamente una tabla de frecuencias y limitarla, sin embargo en lugar de ordenarla y mostrar el primer valor se mostraría solo el valor que represente la frecuencia máxima al igualarlo a los SELECT anteriores.

Finalmente, la instrucción a utilizar fue:

        SELECT playstyle, COUNT(playstyle) AS mode FROM champion_def GROUP BY playstyle HAVING mode = (SELECT MAX(frequency) AS mode FROM (SELECT playstyle, COUNT(playstyle) AS frequency FROM champion_def GROUP BY playstyle) AS frecuencias);

Y el resultado obtenido fue:

````
+-----------+------+
| playstyle | mode |
+-----------+------+
| Marksman  |   23 |
+-----------+------+
````

----
 