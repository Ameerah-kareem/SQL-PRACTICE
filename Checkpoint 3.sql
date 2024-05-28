create database checkpoint3
go 

use checkpoint3
go 

--Entity relational model to relational model 
--link(https://docs.google.com/document/d/1w3FN1yKZLeyXZW3A2Y5In8qvsSPmNaSX9HMBYLC5F1U/edit?usp=sharing)
go 

create table wine(
NumW INT PRIMARY KEY, 
category varchar(80),
year varchar(50),
Degree varchar (80)
);
go 

create table producer(
NumP INT PRIMARY KEY, 
First_Name varchar(80),
Last_Name varchar(80),
Region varchar(80)
);
go 

create table harvest(
NumW INT,
NumP INT, 
Quantity INT
);
go 

alter table harvest
add constraint for_key FOREIGN KEY(NumW) REFERENCES wine(NumW);
go 

alter table harvest
add constraint for_key2 FOREIGN KEY(NumP) REFERENCES producer(NumP);
go 

INSERT INTO wine(NumW, category, year,Degree) VALUES (1, 'Red', 2020, 13.5),
(2, 'White', 2019, 12.5),
(3, 'Rosé', 2021, 11.5),
(4, 'Sparkling', 2018, 12.0),
(5, 'Dessert', 2017, 15.0),
(6, 'Fortified', 2016, 18.0),
(7, 'Red', 2022, 14.0),
(8, 'White', 2023, 13.0),
(9, 'Rosé', 2020, 12.0),
(10, 'Sparkling', 2019, 11.5),
(11, 'Dessert', 2018, 14.5),
(12, 'Fortified', 2017, 17.5),
(13, 'Red', 2021, 13.0),
(14, 'White', 2022, 12.5),
(15, 'Rosé', 2023, 11.0)
;
go  
select * from wine

ALTER TABLE wine
ALTER COLUMN year INT;


INSERT INTO producer(NumP, First_Name, Last_Name, Region) values (1, 'John', 'Doe', 'Napa Valley'),
(2, 'Jane', 'Smith', 'Sonoma County'),
(3, 'Bob', 'Johnson', 'Paso Robles'),
(4, 'Alice', 'Williams', 'Santa Barbara'),
(5, 'Charlie', 'Brown', 'Monterey'),
(6, 'Emma', 'Jones', 'Lodi'),
(7, 'Oliver', 'Miller', 'Temecula Valley'),
(8, 'Sophia', 'Davis', 'Central Coast'),
(9, 'Jack', 'Garcia', 'Livermore Valley'),
(10, 'Ava', 'Rodriguez', 'Sierra Foothills'),
(11, 'Liam', 'Wilson', 'Mendocino County'),
(12, 'Mia', 'Martinez', 'Lake County'),
(13, 'Noah', 'Taylor', 'Amador County'),
(14, 'Isabella', 'Anderson', 'El Dorado County'),
(15, 'Ethan', 'Thomas', 'North Coast')
;
go 
select * from producer
go 

INSERT INTO harvest(NumW, NumP, Quantity) values (1, 1, 1000),
(2, 2, 1500),
(3, 3, 2000),
(4, 4, 2500),
(5, 5, 3000),
(6, 6, 3500),
(7, 7, 4000),
(8, 8, 4500),
(9, 9, 5000),
(10, 10, 5500),
(11, 11, 6000),
(12, 12, 6500),
(13, 13, 7000),
(14, 14, 7500),
(15, 15, 8000)
;
go
select * from harvest

--Give the list the producers.
select NumP,Last_name , first_name from producer;
go 
select* from producer

--Give the list of producers sorted by name.
select last_name, first_name from producer
group by Last_Name, First_Name
order by First_Name asc
;

UPDATE producer
SET Region = 'sousse'
WHERE NumP =1
;

UPDATE producer
SET Region = 'sousse'
WHERE NumP =12
;
go 

--Give the list the producers of Sousse
select NumP, last_name, first_name, region from producer
where region = 'sousse'
;
GO 

--Calculate the total quantity of wine produced having the number 12
SELECT SUM(Quantity) AS TotalQuantity
FROM harvest
WHERE NumW = 12;
GO 

--Calculate the quantity of wine produced by category
Select category, SUM(Quantity) as quantity 
from wine
join harvest on 
wine.NumW = harvest.NumW
group by category
;
go 

--Which producers in the Sousse region have harvested at least one wine in quantities greater than 300 liters? We want the names and first names of the producers, sorted in alphabetical order.
select last_name , first_name , quantity 
from producer
join harvest on producer.NumP = harvest.NumP
where region = 'sousse' and Quantity > 300
order by First_Name, Last_Name asc 
;

--List the wine numbers that have a degree greater than 12 and that have been produced by producer number 24.
Select wine.NumW from wine
join harvest on 
wine.NumW = harvest.NumW
join producer on 
producer.NumP = harvest.NumP
where Degree > 12 and producer.NumP = 24
;
go 