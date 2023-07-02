# Tarea 9
## Distancia de levenshtein
La **Distancia de Levenshtein** mide la cantidad mínima de cambios requeridos ya sea eliminación, sustitución o inserción para transfoemar una cadena de caracteres en otra.

Esta dado por la ecuación:

$$` \begin{align}

&|lev_{a,b}(i-1,j)+1\\\
lev_{a,b}(i,j) = min\lbrace &|lev_{a,b}(i,j-1)+1\\
&|lev_{a,b}(i-1,j-1)+1_{(ai\neq bj)}

\end{align} `$$  

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
- el número en la diagonal al cuál se le sumará uno solo si los caractéres en i y j son diferentes, si son iguales se dejará como esta ($lev_{a,b}(i-1,j-1)+1_{(ai\neq bj)}$ ).

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

En el proceso de creación del proceso se intentó utilizar también la función MIN() sin embargo esta no funciona para valores en variables por lo que se optó por crear una función que devolviera el menor de tres números.

La función fue titulada *min3n*:
````
DROP FUNCTION IF EXISTS min3n;

DELIMITER //

CREATE FUNCTION min3n(
	n1 INTEGER,
	n2 INTEGER,
	n3 INTEGER
  )
  RETURNS INTEGER DETERMINISTIC
  BEGIN 
	  IF n1<n2 AND n1<n3 THEN
	  	RETURN n1;
	  END IF;
	  
	  IF n2<n1 AND n2<n3 THEN
	  	RETURN n2;
	  END IF;
	 
	 IF n3<n2 AND n3<n1 THEN
	  	RETURN n3;
	  END IF;
	 
	 IF n1=n2 AND n1<n3 THEN
	  	RETURN n1;
	  END IF;
	  
	  IF n3=n1 AND n3<n2 THEN
	  	RETURN n3;
	  END IF;
	 
	 IF n3=n2 AND n3<n1 THEN
	  	RETURN n3;
	  END IF;
	 
	  IF n3=n2 AND n3=n1 THEN
	  	RETURN n3;
	  END IF;
	 
   END; 
   //

DELIMITER ;
````

Una vez creada la función se crea el proceso:

````
DROP PROCEDURE IF EXISTS distancia;

DELIMITER //
CREATE PROCEDURE distancia(
	IN p1 VARCHAR(50),
	IN p2 VARCHAR(50),
	OUT dist INT 
   )
 BEGIN
   	SET @l1=LENGTH(p1);
   	SET @l2=LENGTH(p2);
    SET @i=1;
    SET @j=1;
    SET @filaanterior='';
    SET @fila='';
    SET @diagonal=0;
    SET @arriba=0;
    SET @lado=0;
   
    etiqueta1: WHILE @j <= @l2 DO
     BEGIN
    	etiqueta2: WHILE @i<= @l1 DO
    	 BEGIN
    		IF @i= 1 AND @j=1 THEN
    		 BEGIN 
	    		 SET @arriba = @i+1;
	    		 SET @lado = @j+1;
	    		 IF STRCMP(SUBSTRING(p1,@i,1),SUBSTRING(p2,@j,1))=0 THEN
	    		 	SET @diagonal=0;
	    		 ELSE
	    		 	SET @diagonal=1;
	    		 END IF;
	    		 
	    		 SET @aux= min3n(@diagonal,@lado,@arriba);
	    		 SET @fila = CONCAT(@fila,@aux);
	    		 SET @lado = @aux;
    		 END;
    		
    		ELSEIF @j=1 AND @i>1 THEN
    		 BEGIN 
	    		SET @arriba= @i+1;
	    		SET @lado= @lado+1;
	    		IF STRCMP(SUBSTRING(p1,@i,1),SUBSTRING(p2,@j,1))=0 THEN
	    		 	SET @diagonal=@i-1;
	    		 ELSE
	    		 	SET @diagonal=@i;
	    		 END IF;
	    		
	    	 	 SET @aux= min3n(@diagonal,@lado,@arriba);
	    		 SET @fila = CONCAT(@fila,@aux);
	    		 SET @lado = @aux;
	    	 END;
	    	
	    	ELSEIF @i=1 AND @j>1 THEN 
	    	 BEGIN
		    	SET @lado = @j+1; 
		    	SET @arriba= CAST(SUBSTRING(@filaanterior,@i,1) AS SIGNED)+1;
		    	IF STRCMP(SUBSTRING(p1,@i,1),SUBSTRING(p2,@j,1))=0 THEN
	    		 	SET @diagonal=@j-1;
	    		 ELSE
	    		 	SET @diagonal=@j;
	    		 END IF;
		    	 
	    		 SET @aux= min3n(@diagonal,@lado,@arriba);
	    		 SET @fila = CONCAT(@fila,@aux);
	    		 SET @lado = @aux;
		     END;
	    	
	    	ELSE 
	    	 BEGIN
		    	 SET @lado= @lado+1;
		    	 SET @arriba=CAST(SUBSTRING(@filaanterior,@i,1) AS SIGNED)+1;
		    	 IF STRCMP(SUBSTRING(p1,@i,1),SUBSTRING(p2,@j,1))=0 THEN
	    		 	SET @diagonal=CAST(SUBSTRING(@filaanterior,@i-1,1) AS SIGNED);
	    		 ELSE
	    		 	SET @diagonal=CAST(SUBSTRING(@filaanterior,@i-1,1) AS SIGNED)+1;
	    		 END IF;
	    		
	    		 SET @aux= min3n(@diagonal,@lado,@arriba);
	    		 SET @fila = CONCAT(@fila,@aux);
	    		 SET @lado = @aux;
		     END;
    		
    		
    		END IF;
    	 
    	 SET @i = @i+1;
    	
    	 END;
    	
    	END WHILE etiqueta2;
    
    	SET @i = 1;
    	SET @j = @j+1;
    	SET @filaanterior = @fila;
    	SET @fila = '';
     END;
    END WHILE etiqueta1;
    SET dist = @aux;
  END;
   
//

DELIMITER ;
````
El proceso toma dos cadenas de caracteres *p1* y *p2* y devuelve la variable entera *dist*.

El programa usa dos ciclos WHILE, el primero manejado por *@j* para moverse entre las filas y el segundo manejado por *@i* para las columnas. 

Al entrar a ambos ciclos la primera condición por la que pregunta es el caso de que se encuentre en la primera celda de la primera columna y asigna los valores de *@arriba*, *@abajo* y *@diagonal* acorde a esto. Se usan la función SUBSTRING para extraer los caracteres correspondientes de cada cadena y se comparan con la función STRCMP para saber si se suma o no a la variable *@diagonal*.

Se usa función generada *min3n* para conseguir el mínimo de los tres números y se usa la función CONCAT para guardar el resultado en la variable de tipo cadena *@fila*. Posteriormente se asigna el valor a la variable *@lado* ya que este resultado es el que se tiene que considerar en la siguiente iteración.

La seguda condición es para el caso de estar en cualquier otra celda de la fila 1 y el procedimiento es parecido a la condición anterior.

El primero ciclo terminará usando solo estas dos condiciones la primera vez y al finalizar se incrementa *@j* y se reinicia *@i* a la vez que se guarda el resultado final de la variable *@fila* en la variable *@filaanterior* antes de vaciarse para almacenar nuevos resultados.

En la segunda iteración el procedimiento comenzará por la tercera condición la cuál es para el caso de estar en la primera celda de cualquier fila mayor a 1. 

Aqui se usa la función CAST para convertir el primer caracter de la variable *@filaanterior* a un número entero y poder sumarle uno ya que este es el nuevo valor correspondiente a *@arriba*. El resto del procedimiento es parecido a lo explicado anteriormente.

La última condición es para el caso de que se esté en cualquier celda diferente de la primera de cualquier fila mayor a 1. Aqui nuevamente se usa la función CAST para convertir el caracter de *@filaanterior* respectivo a *@arriba* a entero pero también se usa de forma similiar para obtener el caracter respectivo a *@diagonal*.

El procedimiento continuará usando la tercera y cuarta condición hasta que se hayan realizado todas las celdas de todas las filas.

Al suceder esto se da por finalizados ambos ciclos y se devuelve el resultado de la última celda de la última fila al asignarla a *dist*.

----
## Hallazgos
- La declaración IF solo puede existir dentro de los procedimientos almacenados.

- La función MIN() solo funciona para vectores o columnas en tablas.