use demo;


---- Creating Department Table-----
create table Department(
DeptID int primary key,
DeptName varchar(50));

---- Creating Employee Table ----
create table Employee(
EmpID int primary key,
EmpName varchar(100),
Salary decimal(10,2),
DeptID int,
ManagerID int,
DateOfJoining date);

---- Inserting values in Department Table ----
insert into Department values(1,'HR'),(2,'FINANCE'),(3,'IT'),(4,'Customer Support');

---- Inserting values in Employee Table ----
insert into Employee values 
(101,'Raj',7000.45,3,null,'2024-01-15'),
(102,'Rajiv',35000,2,101,'2025-01-15'),
(103,'Rajesh',40000,3,101,'2021-01-15'),
(104,'Rajini',50000,3,102,'2022-01-15'),
(105,'Rani',70000,1,null,'2020-01-15'),
(106,'kishore',79000,5,null,'2019-01-15');

select * from Department;


select * from Employee;

---- Implementing built-in scalar function ----

select EmpName, Len(EmpName) as NameLength from Employee;

select EmpName,round(Salary,-1) as RoundedSalary from Employee;

---- Positive value round to decimal place (Round(123.456,2) -> 123.46) ----
---- Negative value round to power of 10 the left(Round(12345,2) -> 12300) ----


select GETDATE() as CurrentDate;


---- Aggregate Functions ----

select COUNT(*) as TotalEmployees from Employee;

select AVG(Salary) as AverageSalary from Employee;

select MAX(Salary) as MaxSalary from Employee;

---- JOINS ---- 

---- 1. Inner Join ---- (returns only matching rows from both tables)
		--- combines the column from multiple tables based on matching criteia
select E.EmpName, D.DeptName
from Employee E
Inner Join Department D on E.DeptID = D.DeptID;


---- 2. Left Join ----  (Returns all rows from the left table and matched rows from the right)

select E.EmpName,D.DeptName
from Employee E
Left Join Department D on E.DeptID = D.DeptID;



---- 3. Right Join ---- ( Returns all rows from the right table and matched rows from the left)

Select E.EmpName, D.DeptName
from Employee E
Right Join Department D on E.DeptID = D.DeptID;



---- 4. Full Join ---- (returns all rows where there is a match in one of the table)
select E.EmpName , D.DeptName
from Employee E
full outer join Department D on E.DeptID = D.DeptID; 



---- 5. Self Join ---- ( a table is joined with itself, of the using aliases)

select E1.EmpName as Employee , E2.EmpName as Manager
from Employee E1
Left Join Employee E2 on E1.ManagerID = E2.EmpID;

--- Here we are returning to Employee  -> Manager mapping

---- 6. Cross Join ---- ( returns the cartsian product of two table (All possible combinations)

select EmpName, DeptName from Employee cross join Department;

---- Set Operators : ----
---- union ---- (retrives both the tables data)
			---- (combines rows from two SELECT queries, & they must  have the same number of columns , same data type)

SELECT DeptName AS Name FROM Department
UNION
SELECT EmpName FROM Employee;

select EmpName from Employee
union
select DeptName from Department;



---- intersect ---- (Same set of values will be retrived)
				---- ( both SELECT statements used with INTERSECT must have the same number of columns ,  same data type)
SELECT DeptID FROM Employee
INTERSECT                   ----- It shows matching values only
SELECT DeptID FROM Department;


SELECT DeptName AS Name FROM Department
INTERSECT
SELECT EmpName AS Name FROM Employee;



---- Minus ----- (displays the data individually)
				-- (it gives the difference between two SELECT queries.)

SELECT DeptID FROM Department
MINUS 
SELECT DeptID FROM Employee;

SELECT DeptID FROM Department
Except  -- it shows all value which are not assigned  (not working)
SELECT DeptID FROM Employee;



create procedure DisplayDepartments
as
Begin
select * from Department;
end;

execute DisplayDepartments;



---- lets create a stored procedure for getting employee details

create procedure GetEmployeeDetails
@EmpID int, @EmpName varchar(100) output
as
begin
select @EmpName = EmpName from Employee where EmpID = @EmpID;

End;


declare @Name varchar(100);
execute GetEmployeeDetails 103, @EmpName = @Name output;
print @Name;

--- update employee details

alter procedure UpdateEmployeeDetails
@EmpID int, @NewSalary decimal(10,2) output
as
begin
update Employee
set salary = @NewSalary 
where EmpID= @EmpID;
select * from Employee
end;
execute UpdateEmployeeDetails @EmpID = 103, @NewSalary = 90000;

--- check salary


create procedure CheckSalary
@EmpID int 
as
begin
declare @Salary decimal(10,2)
select @Salary = Salary from Employee where EmpID = @EmpID;
if @Salary> 55000
print 'High Earner'
else
print 'Low Earner';
end

execute CheckSalary @EmpID=103;