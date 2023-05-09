# TAREA 1

## BASE DE DATOS ELEGIDA
La base de datos a utilizar es la llamada **International Chess Statistics 2022** a la cual se puede acceder en la siguiente [liga](https://www.kaggle.com/datasets/deepcontractor/international-chess-statistics-2022).

La base de datos cuenta con dos archivos .csv: *"Complete_Players_Database.csv"* y *"International_Chess_Stats.csv"*.

El archivo *"Complete_Players_Database.csv"* tiene los datos de todos los jugadores del mundo que tienen un rating mayor a 1000. Este archivo cuenta con 7 columnas:
- __Country Rank:__ _[Texto]._ El lugar que el jugador tiene en su respectivo país. 
- __Name:__ _[Texto]._ El nombre del jugador. 
- __Title:__ _[Texto]._ Hace referencia al título que el jugador posee. Los titulos que se enlistan en la base son:
    + FM (FIDE Master)
    + WFM (Woman FIDE Master)
    + IM (International Master)
    + WIM (Woman International Master)
    + GM (Grandmaster)
    + WGM (Woman Grandmaster)
    + unranked/unrated
- __Country:__ _[Texto]._ País del jugador. 
- __FIDE:__ _[Entero]._ Puntuación según la FIDE (Federación Internacional de Ajedrez).
- __Age:__ _[Entero]._ Edad del jugador.
- __K-Factor:__ _[Entero]._ Este muestra el número máximo de puntos de que un jugador puede ganar o perder en una partida. La FIDE usa k-factors de 10, 20 y 40.

El archivo *"International_Chess_Stats.csv"* contiene la información estadística de todos los países que tienen jugadores de ajedrez. Este archivo contiene 15 columnas:
- __[columna sin titulo]:__ _[Entero]._ Este es un índice que va de 0 a 189.
- __#:__ _[Entero]._ Rank del país. Va de 1 a 190.
- __Country:__ _[Texto]._ Nombre del país.
- __Flag:__ Esta columna esta vacía. Se presume estaba destinada a almacenar una imagen de la bandera del país.
- __Num Players:__ _[Entero]._ Número de jugadores con los que cuenta el país.
- __Women:__ _[Entero]._ Número de jugadoras mujeres en el país.
- __% of Women:__ _[Reales]._ Porcentaje de jugadores que son mujeres en el país.
- __FIDE Average:__ _[Reales]._ Promedio del puntaje FIDE de los jugadores del país.
- __GMs:__ _[Entero]._ Número de jugadores con titulo Grandmaster en el país.
- __IMs:__ _[Entero]._ Número de jugadores con titulo International Master en el país.
- __FMs:__ _[Entero]._ Número de jugadores con titulo FIDE Master en el país.
- __WGMs:__ _[Entero]._ Número de jugadores con titulo Woman Grandmaster en el país.
- __WIMs:__ _[Entero]._ Número de jugadores con titulo Woman International Master en el país.
- __WFMs:__ _[Entero]._ Número de jugadores con titulo Woman FIDE Master en el país.
- __Age Avg:__ _[Reales]._ Edad promedio de los jugadores.
-----
-----
## SISTEMA GESTOR DE BASE DE DATOS (SGBD)
Un Sistema Gestor de Base de Datos es un software que permite a un usuario mediante una interfaz interactuar con bases de datos. 

Entre los SGBD más usados se encuentran MySQL, Oracle ans SQL Server. 

Para este curso he elegido utilizar MySQL ya que es gratuito y es el sistema que se utilizará durante clases lo que creo que facilitará mi entendimiento al ser principiante en el uso de SQL.

MySQL es un software de código abierto propiedad de Oracle. 

Entre otras de las ventajas que tiene el uso de MySQL se encuentra el hecho de que es fácil de instalar, rápido, escalable y compatible con una gran variedad de sistemas operativos. 

-----
-----
### __REFERENCIAS__
- International Chess Federation. (s.f.). _ABOUT FIDE_. FIDE. https://fide.com/fide/about-fide
- Chess.com. (s.f.). _Chess Titles_. Chess.com. https://www.chess.com/terms/chess-titles
- Chess Armory. (25 de mayo de 2019). _CHESS RATINGS EXPLAINED_. Chess Armory. https://chessarmory.com/blogs/chess-blog/chess-ratings-explained
- PowerData. (09 de mayo de 2019). _¿Qué es un gestor de datos y para qué sirve?_. PowerData. https://blog.powerdata.es/el-valor-de-la-gestion-de-datos/que-es-un-gestor-de-datos-y-para-que-sirve
- Canal Fredy Geek (5 de agosto del 2020). _SQL, SGBD, Servidores de Bases de Datos y lo mas importante, la información_. [Video]. Youtube. https://www.youtube.com/watch?v=-xeqMyQaqWs
- Darias Pérez, S. (09 de septiembre de 2021). _Gestor de Base de Datos: Qué es, funcionalidades y ejemplos_. Intelequia. https://intelequia.com/blog/post/gestor-de-base-de-datos-qu%C3%A9-es-funcionalidades-y-ejemplos
- Código SQL. (s.f.). _Ventajas y Desventajas de Mysql_. Código SQL. https://codigosql.top/ventajas-y-desventajas-de-mysql/
- TecnoMagazine. (s.f.). _MySQL_. TecnoMagazine. https://tecnomagazine.net/mysql/