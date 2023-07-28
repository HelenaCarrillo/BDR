## FUNCIONES DE CADENAS DE CARACTERES EN MYSQL

SET @c1 = "Hola";
SET @c2 = "Barbie";

SELECT LCASE(@c1); -- Convierte todas a minuscula
SELECT LOWER(@c2);

SELECT UCASE(@c1); -- Convierte todas a mayuscula
SELECT UPPER(@c2);

SELECT CONCAT(@c1,@c2); -- Concatena cadenas
SELECT CONCAT(@c1,',',@c2);

SELECT CONCAT_WS(',',@c1,@c2); -- Concatena cadenas con un separador
SELECT CONCAT_ws(',',@c1,@c2,2);

SELECT LEFT(@c1,2); -- Devuelve el numero de caracteres especificados más a la izquierda de la cadena, los primeros
SELECT RIGHT(@c1,2); -- Devuelve el numero de caracteres especificados más a la derecha de la cadena, los últimos


SELECT LPAD(@c1,5,'!'); -- Convierte la cadena al tamaño de caracteres deseado rellenando con un caracter especificado a la izquierda
SELECT LPAD(@c1,6,'*'); --     LPAD(cadena original, tamaño deseado, caracter de relleno)

SELECT RPAD(@c1,5,'!'); -- Convierte la cadena al tamaño de caracteres deseado rellenando con un caracter especificado a la derecha
SELECT RPAD(@c1,6,'*'); --     RPAD(cadena original, tamaño deseado, caracter de relleno)


SELECT LTRIM('                       Hola') AS H; -- Quita espacios a la izquierda
SELECT RTRIM('Hola                       ') AS H; -- Quita espacios a la derecha
SELECT TRIM('           Hola             ') AS H; -- Quita espacios a izquierda y derecha

SELECT TRIM(LEADING '@'FROM '@@@@@Hola@@@@');   -- Remueve todas las repeticiones de la subacdena indicada de la cadena original. A la izquierda si se usa LEADING.
SELECT TRIM(TRAILING '@' FROM '@@@@@Hola@@@@'); --    A la derecha si se usa TRAILING.
SELECT TRIM(BOTH '@' FROM '@@@@@Hola@@@@');     --    A ambos lados si se usa 'BOTH'



SELECT CHAR_LENGTH(@c1);  -- Devuelve el número de caracteres de una cadena
SELECT CHARACTER_LENGTH(@c1); 

SELECT LENGTH('Páris');       -- Devuelve el tamaño de una cadena en bytes
SELECT CHAR_LENGTH('Páris');
SELECT OCTET_LENGTH('Páris'); -- Devuelve el tamaño de una cadena en bytes

SELECT BIT_LENGTH('Páris');   -- Devuelve el tamaño de una cadena en bits


SELECT LOCATE('Bar','Hola Barbie Barbie'); -- Devuelve la posición inicial de la subcadena buscada ->  LOCATE(cadena a buscar, cadena donde busca)
SELECT POSITION('Bar' IN 'Hola Barbie'); -- Devuelve la posición inicial de la subcadena buscada -> POSITION(cadena abuscar IN cadena donde busca)
SELECT INSTR('Hola Barbie Barbie', 'Bar'); -- Devuelve la posición inicial de la subcadena buscada ->  INSTR(cadena donde busca, cadena a buscar)


SELECT ELT(2, 'Árbol', 'Abeja', 'Agua'); -- Devuelve la cadena en la posición especificada -> ELT(no. de cadena buscada, cadenas separadas por ,)

SELECT FIELD('Abeja', 'Árbol', 'Abeja', 'Agua'); -- Devuelve la posición de la cadena en el conjunto -> FIELD(cadena buscada, cadenas separadas por ,)

SELECT FIND_IN_SET('Abeja', 'Árbol,Abeja,Agua'); -- Devuelve la posición de la cadena en la lista -> FIND_IN_SET(cadena buscada, lista de cadenas separadas por ,)



SELECT REVERSE(@c1); -- Devuelve una cadena con los caracteres de la cadena original en reversa

SELECT REPLACE('Elemental', 'e','*'); -- Reemplaza por una subcadena nueva todas las veces que aparezca la subcadena a reemplazar indicada.
SELECT REPLACE('papa', 'pa', '*/');   --    REPLACE(cadena original, subcadena a reemplazar, subcadena que reemplaza)

SELECT REPEAT(@c1, 3); -- Repite la cadena un numero dado de veces

SELECT SPACE(3); -- Devuelve una cadena con el numero dado de espacios
SELECT LENGTH(SPACE(3));


SELECT INSERT(@c1,2,1,'*'); -- Inserta una subcadena en la cadena original iniciando en la posición indicada y reemplazando un numero de caracteres indicado
SELECT INSERT(@c1,2,3,'/'); --    INSERT(cadena original, posición inicial, caracteres a reemplazar, subcadena a insertar)
SELECT INSERT(@c1,3,0,'-');



SELECT MID('Hola.Hola', 3, 5); -- Substrae de la cadena un numero indicado de caracteres iniciando en la posición indicada -> MID(cadena, posicion inicial, caracteres a substraer)
SELECT MID('Hola.Hola', 3);    --   Si NO se indica el número de caracteres a substraer se toma el resto de la cadena
SELECT MID('Hola.Hola' FROM 3);
SELECT MID('Hola.Hola' FROM 3 FOR 5);

SELECT SUBSTRING('Hola.Hola', 3, 5);          -- Substrae de la cadena un numero indicado de caracteres iniciando en la posición indicada
SELECT SUBSTRING('Hola.Hola', 3);             --        SUBSTRING(cadena, posicion inicial, caracteres a substraer)
SELECT SUBSTRING('Hola.Hola' FROM 3 FOR 5);
SELECT SUBSTRING('Hola.Hola' FROM 3);         --   Si NO se indica el número de caracteres a substraer se toma el resto de la cadena

SELECT SUBSTR('Hola.Hola', 3, 5);          -- Substrae de la cadena un numero indicado de caracteres iniciando en la posición indicada
SELECT SUBSTR('Hola.Hola', 3);             --        SUBSTR(cadena, posicion inicial, caracteres a substraer)
SELECT SUBSTR('Hola.Hola' FROM 3 FOR 5);
SELECT SUBSTR('Hola.Hola' FROM 3);         --   Si NO se indica el número de caracteres a substraer se toma el resto de la cadena

SELECT MID('Hola.Hola', -3, 2);  -- Si se usa un negativo se toma el número indicado de caracteres iniciando desde la posión indicada usando como referencia el FINAL de la cadena
SELECT MID('Hola.Hola', -3);     -- Si NO se indica el número de caracteres a substraer se toma el resto de la caden
SELECT MID('Hola.Hola', -6);
SELECT MID('Hola.Hola', -6,4);

SELECT SUBSTRING('Hola.Hola', -2);
SELECT SUBSTRING('Hola.Hola', -3, 2);

SELECT SUBSTR('Hola.Hola', -3);
SELECT SUBSTR('Hola.Hola', -3, 2);


SELECT SUBSTRING_INDEX('Enero.Febrero.Marzo.Abril', '.', 2); -- Devuelve una subcadena con los caracteres presentes ANTES de que se repita un numero dado de veces una subcadena
SELECT SUBSTRING_INDEX('Enero.Febrero.Marzo.Abril', '.',-2); --   SUBSTRING(cadena, sucadena que delimita, numero de repeticiones)
SELECT SUBSTRING_INDEX('Enero.Febrero.Marzo.Abril', '.', 3); -- Si se usa un número positivo cuenta las repeticiones desde el inicio de la cadena
SELECT SUBSTRING_INDEX('Enero.Febrero.Marzo.Abril', '.',-3); -- Si se usa un número negativo cuenta las repeticiones desde el FINAL de la cadena



SELECT FORMAT(12345678.91011, 2); -- Devuelve en forma de cadena el número dado con formato tipo ###,###,###.### con el número de decimales deseado


SELECT STRCMP('Hola', 'hola');     -- Compara 2 cadenas de caracteres. Insensible a mayusculas.
SELECT STRCMP('texto1', 'texto2'); --   devuelve 1 si la primera cadena es mayor a la segunda, -1 si la segunda es mayor a la primera y 0 si son iguales
SELECT STRCMP('texto1', 'texto0');

SELECT ASCII('0');  -- Devuelve el valor númerico en la tabla ASCII del primer caracter
SELECT ASCII('1');
SELECT ASCII('2');


