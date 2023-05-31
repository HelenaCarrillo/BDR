DROP DATABASE IF EXISTS chess_2022;

CREATE DATABASE chess_2022;

USE chess_2022;

CREATE TABLE country(
id INT AUTO_INCREMENT PRIMARY KEY,
ranking INT,
name CHAR(20),
num_players INT,
num_women INT,
perc_women FLOAT(5,2),
fide_avg INT,
gms INT,
ims INT,
fms INT,
wgms INT,
wims INT,
wfms INT,
age_avg INT
);

CREATE TABLE players(
id INT AUTO_INCREMENT PRIMARY KEY,
id_country INT REFERENCES country(id), -- hace referencia al id del pais
country_rank INT,
name CHAR(80),
title CHAR(8),
country CHAR(20),
fide FLOAT(7,2),
age INT,
kfactor INT
);

INSERT INTO country (ranking, name, num_players, num_women, perc_women, fide_avg, gms, ims, fms, wgms, wims, wfms, age_avg) VALUES
(1, 'Russia', 34497, 5734, 16.62, 1666, 236, 522, 1177, 50, 101, 409, 34),
(2, 'India', 32735, 3581, 10.94, 1275, 64, 114, 83, 9, 41, 42, 27),
(3, 'Germany', 26577, 1751, 6.59, 1841, 94, 273, 861, 18, 40, 69, 49),
(4, 'Spain', 25009, 1430, 5.72, 1429, 55, 134, 365, 2, 14, 37, 42),
(5, 'France', 23784, 2143, 9.01, 1580, 50, 117, 234, 4, 18, 21, 41),
(6, 'Poland', 10596, 1537, 14.51, 1622, 45, 105, 172, 9, 30, 39, 37),
(7, 'Italy', 10256, 604, 5.89, 1621, 16, 45, 161, 0, 1, 13, 44),
(8, 'Iran', 9597, 973, 10.14, 1386, 14, 23, 55, 4, 4, 15, 29),
(9, 'Turkey', 8230, 919, 11.17, 1424, 12, 25, 72, 2, 4, 16, 27),
(10, 'Czech Republic', 8008, 497, 6.21, 1752, 35, 81, 159, 8, 15, 18, 45),
(11, 'United States', 6547, 485, 7.41, 1887, 95, 155, 352, 12, 31, 46, 39),
(12, 'Hungary', 6413, 588, 9.17, 1720, 52, 114, 232, 9, 18, 28, 44),
(13, 'Greece', 5706, 762, 13.35, 1414, 14, 29, 74, 3, 6, 9, 32),
(14, 'Brazil', 5367, 625, 11.65, 1667, 14, 31, 108, 0, 9, 11, 37),
(15, 'Serbia', 5212, 435, 8.35, 1858, 52, 120, 328, 15, 21, 32, 49),
(16, 'Romania', 4520, 625, 13.83, 1585, 21, 71, 108, 8, 12, 33, 35),
(17, 'Ukraine', 4502, 625, 13.88, 1844, 89, 199, 187, 20, 33, 34, 37),
(18, 'Netherlands', 4347, 253, 5.82, 1886, 36, 100, 181, 4, 14, 10, 49),
(19, 'Argentina', 4277, 210, 4.91, 1627, 22, 76, 128, 1, 13, 16, 39),
(20, 'Denmark', 4091, 77, 1.88, 1733, 12, 43, 68, 0, 3, 8, 55)
;

INSERT INTO players (id_country, country_rank, name, title, country, fide, age, kfactor) VALUES
(1, 1, 'Nepomniachtchi, Ian', 'GM', 'Russia', 2773, 32, 10),
(1, 2, 'Grischuk, Alexander', 'GM', 'Russia', 2764, 39, 10),
(1, 3, 'Karjakin, Sergey', 'GM', 'Russia', 2747.5, 32, 10),
(1, 4, 'Vitiugov, Nikita', 'GM', 'Russia', 2736, 35, 10),
(1, 5, 'Esipenko, Andrey', 'GM', 'Russia', 2724, 20, 10),
(1, 6, 'Andreikin, Dmitry', 'GM', 'Russia', 2724, 32, 10),
(1, 7, 'Dubov, Daniil', 'GM', 'Russia', 2711.4, 26, 10),
(1, 8, 'Tomashevsky, Evgeny', 'GM', 'Russia', 2708, 35, 10),
(1, 9, 'Fedoseev, Vladimir', 'GM', 'Russia', 2704, 27, 10),
(1, 10, 'Alekseenko, Kirill', 'GM', 'Russia', 2702, 25, 10),
(1, 11, 'Artemiev, Vladislav', 'GM', 'Russia', 2700, 24, 10),
(1, 12, 'Sarana, Alexey', 'GM', 'Russia', 2685, 22, 10),
(1, 13, 'Svidler, Peter', 'GM', 'Russia', 2683, 46, 10),
(1, 14, 'Predke, Alexandr', 'GM', 'Russia', 2682, 28, 10),
(1, 15, 'Jakovenko, Dmitry', 'GM', 'Russia', 2682, 39, 10),
(1, 16, 'Oparin, Grigoriy', 'GM', 'Russia', 2681, 25, 10),
(1, 17, 'Sjugirov, Sanan', 'GM', 'Russia', 2680, 29, 10),
(1, 18, 'Matlakov, Maxim', 'GM', 'Russia', 2674, 31, 10),
(1, 19, 'Najer, Evgeniy', 'GM', 'Russia', 2661, 45, 10),
(1, 20, 'Inarkiev, Ernesto', 'GM', 'Russia', 2659, 37, 10)
;
