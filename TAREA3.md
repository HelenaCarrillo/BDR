# TAREA 3
## Relaciones

Player(**ID**,Name, Country_Rank, Title, Country_Name, FIDE, Age, K-Factor, ID_Country)

Country(**ID**, Rank, Name, Flag, Num_Players, Women, Perc_of_Women, FIDE_Average, GMs, FMs, IMs, WGMs, WFMs, WIMs, Age_Avg)

## Diagrama
```mermaid
erDiagram
PLAYER}|--||COUNTRY:belongs
PLAYER{
    entero ID PK "[0,inf)"
    text(50) Name
    entero Country_Rank "[1,inf)"
    text(50) Title
    text(50) Country_Name
    entero FIDE "[0,inf)"
    entero Age "[0,inf)"
    entero K-Factor "[0,inf)"
    entero ID_Country FK "[0,inf)"

}
    
COUNTRY {
    entero ID PK "[0,inf)"
    entero Rank "[1,190]" 
    text(50) Name
    image Flag 
    entero Num_Players "[0,inf)"
    entero Women "[0,inf)"
    real Perc_of_Women "[0,inf)"
    real FIDE_Average "[0,inf)"
    entero GMs "[0,inf)"
    entero FMs "[0,inf)"
    entero IMs "[0,inf)"
    entero WGMs "[0,inf)"
    entero WFMs "[0,inf)"
    entero WIMs "[0,inf)"
    real Age_Avg "[0,inf)"
} 
```

## Operaciones
1. Proyección de los paises que tienen jugadorez de ajedréz registrados en FIDE:

        Country[Name]
     $\prod_{Name}$(Country)


2. Proyección de países con jugadores menores de edad:

        Player[Age<18][Country_Name]
     $\prod_{CountryName}$ ($\sigma_{Age<18}$(Player))
     
        
3. Proyección de paises con jugadoras mujeres

        Country[Women>0][Name]
    $\prod_{Name}$ ($\sigma_{Women>0}$(Country))

4. Proyección del Top 10 ranking de países

        Country[Rank<=10][Name]
    $\prod_{Name}$ ($\sigma_{Rank<=10}$(Country))