--Problem 1 Create Database
CREATE DATABASE Minions

--Problem 2 Create Tables
USE Minions

CREATE TABLE Minions (
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50),
	Age INT
	);

CREATE TABLE Towns (
	Id INT PRIMARY KEY,
	[Name] VARCHAR(50)
	)

--Problem 3 Alter Minions Table
ALTER TABLE Minions
ADD TownId INT;

ALTER TABLE Minions
ADD CONSTRAINT FK_MinionTown
FOREIGN KEY (TownId) REFERENCES Towns(Id);

--Problem 4 Insert Records in Both Tables
INSERT INTO Towns(Id, [Name])
VALUES
	(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna');

INSERT INTO Minions (Id, [Name], Age, TownId)
VALUES
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2);

--Problem 5 Truncate Table Minions
TRUNCATE TABLE Minions;

--Problem 6 Drop All Tables
DROP TABLE Minions;
DROP TABLE Towns;

DROP TABLE People;

--Problem 7 Create Table People
CREATE TABLE People(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX),
	Height DECIMAL(3,2),
	[Weight] DECIMAL(5,2),
	Gender CHAR(1) NOT NULL,
	CONSTRAINT check_gender
	CHECK (Gender = 'm' OR Gender = 'f'),
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX)
	);

INSERT INTO People
VALUES
	('Ivan', NULL, 1.89, 88.2, 'm', '2000-11-11', 'Hi! I''m Ivan!'),
	('Peter', NULL, 1.89, 88.2, 'm', '1990-11-11', 'Hi! I''m Peter!'),
	('Goshka', NULL, 1.89, 88.2, 'f', '2000-11-11', 'Hi! I''m Goshka!'),
	('Petko', NULL, 1.89, 88.2, 'm', '2000-11-11', 'Hi! I''m Petko!'),
	('Simeon', NULL, 1.89, 88.2, 'm', '2000-11-11', 'Hi! I''m Simeon!');

--Problem 8 Create table users
CREATE TABLE Users(
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	LastLoginTime DATETIME,
	IsDeleted BIT);

INSERT INTO Users
VALUES
	('Misho', 12345, NULL, NULL, 0),
	('Peter', 12345, NULL, '2012-06-18T10:34:09', 1),
	('Goshka', 12345, NULL, '2012-06-18T10:34:09', 0),
	('Simeon', 12345, NULL, '2012-06-18T10:34:09', 0),
	('Misho', 12345, NULL, NULL, 0);

--Problem 9 Change primary key
DECLARE @PkConstraintName NVARCHAR(128);
SELECT @PkConstraintName =  name
FROM sys.key_constraints
WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = N'Users';

EXEC('ALTER TABLE Users
DROP CONSTRAINT ' + @PkConstraintName);

ALTER TABLE Users
ADD PRIMARY KEY (Id, Username);

--Problem 10 Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT password_lenght
CHECK (LEN([Password]) >= 5);

--Problem 11 Set default value of a field
ALTER TABLE Users
ADD CONSTRAINT df_lastlogintime
DEFAULT GETDATE() FOR LastLoginTime;

INSERT INTO Users (Username, [Password], ProfilePicture, IsDeleted)
VALUES
	('Lubo', '123321', NULL, 1);

--Problem 12 Set Unique Field
DECLARE @PkConstraintName NVARCHAR(128);
SELECT @PkConstraintName =  name
FROM sys.key_constraints
WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = N'Users';

EXEC('ALTER TABLE Users
DROP CONSTRAINT ' + @PkConstraintName);

DECLARE @UniqueConstraintName NVARCHAR(128);
SELECT @UniqueConstraintName = name
FROM sys.key_constraints
WHERE type = 'UQ' AND OBJECT_NAME(parent_object_id) = N'Users';

EXEC('ALTER TABLE Users
DROP CONSTRAINT ' + @UniqueConstraintName);

ALTER TABLE Users
ADD PRIMARY KEY (ID),
UNIQUE (Username),
CONSTRAINT username_len CHECK (LEN(Username) >= 3);

--Problem 13 Movies database
CREATE DATABASE Movies;

USE Movies;

CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR(30) NOT NULL,
	CONSTRAINT director_name_lenght
	CHECK (LEN(DirectorName) >= 3),
	Notes NVARCHAR(MAX)
	);

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
	);

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(MAX)
	);

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(30) NOT NULL,
	DirectorId INT NOT NULL,
	FOREIGN KEY (DirectorId) REFERENCES Directors(Id),
	CopyrightYear SMALLINT NOT NULL,
	Lenght SMALLINT NOT NULL,
	GenreId INT NOT NULL,
	FOREIGN KEY (GenreId) REFERENCES Genres(Id),
	CategoryId INT NOT NULL,
	FOREIGN KEY (CategorYId) REFERENCES Categories(Id),
	Rating DECIMAL(4,2),
	Notes NVARCHAR(MAX))

INSERT INTO Directors
VALUES 
	('Ivan', 'He have a lot of rewards'),
	('Misho', NULL),
	('Pesho', '10 years of experience'),
	('Maria', NULL),
	('Nataliq', NULL);

INSERT INTO Categories
VALUES
	('Adults', 'These movies are for 18 years or older'),
	('Kids', 'These movies are recommended for kids'),
	('Best movies', 'These movies are the most watched'),
	('Oscar movies', 'These movies have won oscars'),
	('Funny movies', NULL);

INSERT INTO Genres
VALUES
	('Fantasy', NULL),
	('Drama', NULL),
	('Horror', 'Not recommended for kids'),
	('Action', 'Not recommended for younger than 16'),
	('Animation', 'Recommended for kids');

INSERT INTO Movies
VALUES
	('Fast & Furious', 2, 2001, 182, 4, 3, 8.24, NULL),
	('Interstellar', 1, 2014, 122, 1, 4, 10, 'One of the best movies'),
	('The lord of the rings', 4, 2001, 210, 1, 2, 9.24, NULL),
	('Garfield', 5, 2005, 95, 5, 2, 8.98, 'Good movie'),
	('Casper', 3, 1998, 80, 5, 2, 7.95, NULL)

--Problem 16 Create Softuni database
CREATE DATABASE SoftUni;

USE SoftUni;

CREATE TABLE Towns(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,);

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY,
	AddressText NVARCHAR(200) NOT NULL,
	TownId INT NOT NULL,
	FOREIGN KEY (TownId) REFERENCES Towns(Id));

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR (50) NOT NULL);

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(30),
	LastName NVARCHAR(30) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	DepartmentId INT NOT NULL,
	FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
	HireDate DATE NOT NULL,
	Salary DECIMAL(8,2) NOT NULL,
	AddressId INT NOT NULL,
	FOREIGN KEY (AddressId) REFERENCES Addresses(Id));

--Problem 18 Basic insert
INSERT INTO Towns
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO Departments
VALUES 
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance');

INSERT INTO Addresses
VALUES
	('av. Cherni vruh 100', 1),
	('av. Makedonia 190', 3),
	('av. Luben karavelov 13', 2),
	('sc. Izgrev bl. 397', 4);

INSERT INTO Employees
VALUES
	('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00, 2),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineering', 1, '2004-03-02', 4000.00, 2),
	('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25, 3),
	('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00, 5),
	('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88, 4);
 --Problem 19
 SELECT * FROM Towns;
 SELECT * FROM Departments;
 SELECT * FROM Employees;

 --Problem 20
 SELECT * FROM Towns
 ORDER BY [Name] ASC;

 SELECT * FROM Departments
 ORDER BY [Name] ASC;

 SELECT * FROM Employees
 ORDER BY Salary DESC;

 --Problem 21
 SELECT [Name] FROM Towns
 ORDER BY [Name] ASC;

 SELECT [Name] FROM Departments
 ORDER BY [Name] ASC;

 SELECT FirstName, LastName, JobTitle, Salary FROM Employees
 ORDER BY Salary DESC;

 --Problem 22
 UPDATE Employees
 SET Salary = Salary * 0.1 + Salary;

 SELECT Salary FROM Employees;
