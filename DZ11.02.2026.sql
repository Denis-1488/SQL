CREATE DATABASE University;
GO

USE University;
GO

-------------------------------------------

CREATE TABLE Groups
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,

    Name NVARCHAR(10) NOT NULL
        UNIQUE
        CHECK (Name <> ''),

    Rating INT NOT NULL
        CHECK (Rating BETWEEN 0 AND 5),

    [Year] INT NOT NULL
        CHECK ([Year] BETWEEN 1 AND 5)
);
------------------------------------------------

CREATE TABLE Departments
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,

    Financing MONEY NOT NULL
        DEFAULT (0)
        CHECK (Financing >= 0),

    Name NVARCHAR(100) NOT NULL
        UNIQUE
        CHECK (Name <> '')
);

---------------------------------------------------

CREATE TABLE Faculties
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,

    Name NVARCHAR(100) NOT NULL
        UNIQUE
        CHECK (Name <> '')
);
-----------------------------------------------------

CREATE TABLE Teachers
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,

    EmploymentDate DATE NOT NULL
        CHECK (EmploymentDate >= '1990-01-01'),

    Name NVARCHAR(MAX) NOT NULL
        CHECK (Name <> ''),

    Premium MONEY NOT NULL
        DEFAULT (0)
        CHECK (Premium >= 0),

    Salary MONEY NOT NULL
        CHECK (Salary > 0),

    Surname NVARCHAR(MAX) NOT NULL
        CHECK (Surname <> '')
);
--------------------------------
Go

INSERT INTO Faculties (Name)
VALUES ('Computer Science'),
       ('Economics');

INSERT INTO Departments (Name, Financing)
VALUES ('Programming', 50000),
       ('Mathematics', 30000);

INSERT INTO Groups (Name, Rating, [Year])
VALUES ('CS101', 4, 1),
       ('CS202', 5, 2);

INSERT INTO Teachers (Name, Surname, EmploymentDate, Salary)
VALUES ('Ivan', 'Petrov', '2005-03-12', 1500),
       ('Anna', 'Ivanova', '2010-06-01', 2000);

GO

SELECT * FROM Faculties;
SELECT * FROM Departments;
SELECT * FROM Groups;
SELECT * FROM Teachers;