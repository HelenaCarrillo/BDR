# TAREA 1

## BASE DE DATOS ELEGIDA
La base de datos a utilizar es la llamada **International Chess Statistics 2022**.

La base de datos cuenta con dos archivos csv: *Complete_Players_Database.csv* y *International_Chess_Stats.csv*.

El archivo *Complete_Players_Database.csv* tiene los datos de todos los jugadores del mundo que tienen un rating mayor a 1000. Este archivo cuenta con 7 columnas:
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

El archivo *International_Chess_Stats.csv* contiene la información estadística de todos los países que tienen jugadores de ajedrez. Este archivo contiene 15 columnas:
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

## SGBD
