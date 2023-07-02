
-- CREAR FUNCION PARA OBTENER EL MENOR DE 3 NÚMEROS

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
	 -- //
DELIMITER ;




-- CREACION DE PROCEDIMIENTO PARA MEDIR DISTANCIA
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

--- PRUEBA DE FUNCIONAMEINTO
SET @resultado=3;
SET @pal1= 'catyy';
SET @pal2= 'pot';
CALL distancia(@pal1, @pal2, @resultado);
SELECT @resultado;


/*PRUEBAS

SELECT STRCMP('hola', 'hpla');

SET @p1 = '1234';
SET @n = 3;
SELECT CAST(@n AS char);
SET @l= CONCAT(@p1,@n);
SELECT CAST(@l AS SIGNED);
SELECT @l / 5;

SELECT STRCMP(SUBSTRING('12345678',@n,1),SUBSTRING('12345678',@n,1));

SET @prueb=CAST(SUBSTRING(@p1,@n-1,1) AS SIGNED)+1;
SELECT @prueb;

SET @prueb = min3n(5,3,@n);

SET @h = 0;

DROP PROCEDURE IF EXISTS whileproof;
CREATE PROCEDURE whileproof(
	INOUT h INTEGER)
BEGIN
 etiqueta4: WHILE h <=8 DO
  BEGIN
	IF h<1 THEN SET h= h+1;
	ELSE IF h= 1 THEN SET h=h+2;
	ELSE SET h=h+3;
     END IF;
    SET @j = h+2;
  END;
 END WHILE etiqueta4;
END;



*/
