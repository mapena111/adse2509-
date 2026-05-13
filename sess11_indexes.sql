/* this seesion cover how to work with indexes/ indeces in SQL server.*/

--Switch to the customer database 
use Cust_db_adse2509

-- Demonstrate creating, modifying and deleting indexes 

--1. Create an Employee_details table 
if OBJECT_ID('Cust_Details') is null
	Create table Cust_Details
	(
		EmpID int not null primary key,
		AccNo nvarchar(18) not null
		AccName nvarchar(180) not null,
		Country nvarchar(70) not null
	);
else
	print('the ''Cust_Details'' table already exists and will not be recreated')

--2 insert rows into Cust_Details
Insert into dbo.Cust_Details
(AccNo, AccName, Country)
values
('CN001' ,'John Cena', 'Spain')
('CN020' ,'Smith Jones', 'Russia')
('CN01' ,'Albert Walker', 'Germany')
('CN021' ,'Rosa stines', 'Italy')

--get all the values store for Cust_Dtails table
select * from Cust_Details


--3. create a non-clustered index on the country field
create index ixCountry on Cust_Details(Country)

-- create a clustered index on the ProductID field of the Product_details
Create clustered index ixProductID on dbo.Product_details(ProductID)

-- create a non-clustered index on the city field in the 'Customer_Details'
create index ixCity on Cust_Details(City)

--add a primary key constraint to the CricketTeam table
alter table dbo.Cricketteam
add constraint PK_TeamID primary key clustered(TeamID)

--create a primary xml ndex on the CricketTeam table on the teaminfo column/field
create primary xmlindex PXML_Teaminfo
on dbo.cricketTeam(teaminfo)

--create a secondary index for value() => optimises value() method which is useful when extracting scalar values
create XML index SXML_TeamInfo_Value
on dbo.CricketTeam(Teaminfo)
using XML index PXML_Teaminfo
for value 

--create a secondary index for path() => optimises exists() method and path based lookup
create XML index SXML_TeamInfo_Path
on dbo.CricketTeam(Teaminfo)
using XML index PXML_Teaminfo
for Path 

--create a secondary index for Property() best used with typed xml columns (the teaminfor column is using the CrcketSchemaCollection Xsd)
create XML index SXML_TeamInfo_Property
on dbo.CricketTeam(Teaminfo)
using XML index PXML_Teaminfo
for Property 

--1. ceate a non-clustered index on the productname field in the Product_details table. crea 
create index ixproductname on Product_Details(productname)
