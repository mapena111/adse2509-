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
create index ixproductname on dbo.Product_Details(ProductName);

--modify/alter the name of the ixProdName non-clustered index to 'IX_ProductName'
exex sp_rename N'dbo.product_details.ixProdname', N'IX_ProductName', N'Index';

--modify/alter the IX_ProductName' non-clustered index to disable it
alter index IX_ProductNme on dbo.Producct_details Disable;

--modify/alter the IX_ProductName' non-clustered index to disable it
alter index IX_ProductNme on dbo.Producct_details rebuild;

--remove/delete the iX_productName non-clustered index if it exists 
drop index if exists IX_ProductName on dbo.Product _details;

--create a table with computed values then index the computed column field 
if OBJECT_ID('tblCalcArea') is null
	create table tblCalcArea 
	(
		length decimal(10,2)
		breadth decimal(10,2)
		area as length*breadth-- => computed column given by length multiplied by width

else
	 print the table tblCalcArea table already existsand will not be recreated

--add records into the table tblCalcArea table
insert into tblCalcArea(length, breadth)
values 
(34,10)
(20,200)
(33.4,12)
(12,7)

--check whether the records were inseerted successully
select* from tblCalcArea

--create an index on the area computed column
create index ixArea on dbo.tblCalcArea(Areaa);

--the above index will be used in a querry to get shapes with an area less than 400
select*
from tblCalcArea
where Area<400

--create a unique index on the 'Emp_Cellular' phone table for the personid column
create unique index ixPersonID on dbo.emp_cellularphone (PersonID);

--create a filtered index for products sold for 4000or more on the product_details table 
create index ixExpensiveProduct on dbo.Product_Details(rate)
where rate >= 4000;

--use the above index to get products costing 4000 or more
select ProductID, ProductName [Product Name], Rate, coalasce(Description) [Descriptoon] --use coalesce to remove nulls from the resulttest
from Product_details where Rate >= 4000;

--1. Create an Employee's Table
Create Table Employee
(
	EmpID int not null primary key,
	EmpName nvarchar(100) not null,
	Salary int not null,
	Address nvarchar(200) not null
);
 
--2. Insert employee records
Insert into dbo.Employee
values
(1,'Derek', 12000, 'Houston'),
(2,'David', 25000, 'Texas'),
(3,'Alan', 22000, 'New York'),
(4,'Matthew', 22000, 'Las Vegas'),
(5,'Joseph', 28000, 'Chicago');
 
--3. Confirm entry of records into the Employee's Table
Select * from Employee;
 
--4. Declare a cursor on the Employee's Table
set nocount on
declare @id int, @name nvarchar(100), @salary int
--A cursor is declared by defining sql statements that return a resultset
declare curEmp Cursor
static for 
Select EmpID, EmpName, Salary from employee
--A cursor is opened and populated by executing the statement(s) 
--defined in the cursor
open curEmp
--Execute the statements below if the emp cursor contains rows
if @@CURSOR_ROWS > 0
	begin
		--Rows are fetched from the cursor one by one or in a block
		--for data manipulation
		Fetch next from curEmp into @id, @name, @salary
		while @@FETCH_STATUS = 0
		begin
			print 'ID: ' + convert(nvarchar(20),@id) + char(13) +
			'Name: ' + @name + char(13) +
			'Salary: ' + convert(nvarchar(20),@salary) + char(13)--> used for line break
			Fetch next from curEmp into @id, @name, @salary
		End
	End
--Close the cursor explicitly
Close curEmp
--Delete the cursor definition and release all the system resources associated
--with the cursor
deallocate curEmp
set nocount off

