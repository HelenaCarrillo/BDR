# TAREA 5

Para esta tarea se tomó la decisión de cambiar la base de datos. La nueva base de datos a utilizar se obtuvo de la combinación de las bases de datos presentes en los siguientes links:
 * [Link 1](https://www.kaggle.com/datasets/pedrocsar/league-of-legends-worlds-20112022-stats)
 * [Link 2](https://www.kaggle.com/datasets/barthetur/league-of-legends-champions-items-stats)

Debido a que la base de datos tiene dos orígenes distintos para unirla era necesario homogenizar algunos de los datos. Entre ellos el nombre de los campeones ya que estos fungirían después como la llave primaria y foránea de algunas tablas. Para realizar lo anterior se quitó de los nombres el carácter " ___'___ ". Por ejemplo, de Bel'Veth se pasó a BelVeth.

También se cambió la manera en que se tenían registrados los valores nulos. Una parte de las tablas solo tenían celdas vacías mientras que la otra parte se identificaban como _'None'_. Teniendo en cuenta el formato de sql se optó por que todos se manejaran como _null_.

Algunas de las tablas corresponden a registros de partidas a lo largo de 12 años por lo que algunos de los nombres que se buscaba usar como llaves primarias se repetían a lo largo de las tablas.

Para solucionar esto se crearon tablas de definición o tablas de resumen donde se listaran de manera única cada nombre así como un resumen de sus estadísticas totales. En estas tablas se establecieron las llaves primarias y se usaron como llaves foráneas en las que se detallaban los datos a través de los años.

Una vez que ya se habían trabajado los datos se procedió a importar la información a la base en sql. Para esto se usó el método de inserción de código visto en clase. 

Para generar los archivos de código se usó Visual Studio y Excel.

Uno de los problemas que se encontraron durante este proceso fue el manejo de los valores tipo fecha en sql ya que en la base se encontraba con formato _dd/mm/aaaa_ mientras que para una inserción en código se necesitaba el formato _'aaaa-mm-dd'_. Esto se solucionó con la ayuda de el cambio de formato de Excel y manejando momentáneamente las fechas como texto.

Una vez generados los archivos de inserción se procedió a usar la consola para importar los datos a la base con el comando:
           
    mysql -u root -p lol_stats < "archivo_de_incerción.sql"
    

## Autoevaluación
Creo que me merezco un 10 ya que me esforcé por solucionar los problemas conforme se presentaban y complementé mi falta de conocimiento en sql con investigación y uso de conocimientos previos de otros programas. 
