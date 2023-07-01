# Tarea 9
## Distancia de levenshtein
La **Distancia de Levenshtein** mide la cantidad mínima de cambios requeridos ya sea eliminación, sustitución o inserción para transfoemar una cadena de caracteres en otra.


Esta dado por la ecuación:

$$
\begin{align}

&|lev_{a,b}(i-1,j)+1\\\
lev_{a,b}(i,j) = min\lbrace &|lev_{a,b}(i,j-1)+1\\
&|lev_{a,b}(i-1,j-1)+1_{(ai\neq bj)}
\end{align}
$$   

Para facilitar los cálculos, esto puede resolverse con matrices. 

La matriz se inicializa acomodando cada uno de los caracteres de las cadenas en los ejes y numerandolos. 

Por ejemplo las palabras "*gato*" y "*go*":

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 |         |         |         |         |
| ***o*** | 2 |         |         |         |         |

La matriz se resuelve de izquierda a derecha de froma descendiente y la distancia de levenshtein entre las dos cadenas estará dada por el numero que ocupe la ultima celda de la ultima fila.

Comenzando a resolver la matriz, en la primera celda se pondrá el minimo entre: 
- el número de arriba más uno ( $lev_{a,b}(i,j-1)+1$ ) 
- el número a la izquierda más uno ( $lev_{a,b}(i-1,j)+1$ ) y 
- el número en la diagonal al cuál se le sumará uno solo si los caractéres en i y j son diferentes, si son iguales se dejará como esta ( $ev_{a,b}(i-1,j-1)+1_{(ai\neq bj)}$ ).

Es así que en la primera celda del ejemplo se pone el mínimo entre 2 (arriba+1), 2 (izquiera+1) y 0 (diagonal):

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 | *0*     |         |         |         |
| ***o*** | 2 |         |         |         |         |

Para la siguiente celda se elige el mínimo entre 3 (arriba+1), 1 (izquierda+1, ya que el 0 pasa a ser la nueva izquierda) y 2 (diagonal+1, ya que "***g***" y "***a***" son diferentes):

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 | *0*     |*1*      |         |         |
| ***o*** | 2 |         |         |         |         |

La tercera celda se llena de la misma forma, el mínimo entre 4 (arriba+1), 2 (izquierda+1) y 3 (diagonal+1):

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 |*0*      |*1*      |*2*      |         |
| ***o*** | 2 |         |         |         |         |

La cuarta celda:

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 |*0*      |*1*      |*2*      |*3*      |
| ***o*** | 2 |         |         |         |         |

Las celdas de la segunda fila se llenan de forma similar solo considerando el hecho de que mis respuestas anteriores ahora son mi *arriba*.

Por ejemplo, la primera celda sería el mínimo entre 1(arriba+1), 3 (izquierda+1) y 2 (diagonal+1):

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 |*0*      |*1*      |*2*      |*3*      |
| ***o*** | 2 |*1*      |         |         |         |

Resolviendo las celdas faltantes:

|         |   |         |         |         |         |
|---------|---|---------|---------|---------|---------|
|         |   | ***g*** | ***a*** | ***t*** | ***o*** |
|         | 0 | 1       | 2       | 3       | 4       |
| ***g*** | 1 |*0*      |*1*      |*2*      |*3*      |
| ***o*** | 2 |*1*      |*1*      |*2*      |*2*      |

Como se mencionó, la disancia de levenshtein entre ambas cadenas está dada por la última celda de la última fila de la matriz. 

En este caso la distancia entre "*gato*" y "*go*" es igual a 2 la cuál hace referencia a la eliminación de los caracteres *a* y *t*.

### Programa en MySQL
Es posible crear un proceso almacenado que calcule la distancia de levenshtein entre dos cadenas dadas.

Para realizar este proceso se utilizaron diferentes funciones como:
- **LENGTH**: Devuelve un valor entero correspondiente al tamaño de una cadena de caracteres.

- **STRCMP**: Compara dos cadenas de caracteres y devuelve:
    - -1 si la cadena 1 es menor a la cadena 2.
    - 1 si la cadena 1 es mayor a la cadena 2.
    - 0 si ambas cadenas son iguales.

- **SUBSTRING**: Sustrae una subcadena de caracteres de una cadena iniciando a cualquier punto dado. La indicación es de la siguiente forma:

   *SUBSTRING( cadena, posición desde que inicia, cantidad de caracteres que sustrae)*

- **CONCAT**: Concatena dos cadenas de caracteres.

- **CAST**: Convierte un valor de cualquier tipo a un tipo específico de dato. Para el proceso se usó para convertir cadenas de caracteres al tipo SIGNED el cual es un tipo de valor entero.

En el proceso de creación de la 

## Hallazgos

La declaración IF solo puede existir dentro de los procedimientos almacenados.

La función MIN solo funciona para vectores o columnas en tablas.