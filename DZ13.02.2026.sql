CREATE DATABASE шарага;
GO

USE шарага;
GO


-----------------------------------------------------------------------------------

CREATE TABLE FacultiesNew
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> ''),
    Dean NVARCHAR(100) NOT NULL CHECK (Dean <> '')
);

-----------------------------------------------------------------------------------
CREATE TABLE DepartmentsNew
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> ''),
    Financing MONEY NOT NULL DEFAULT 0 CHECK (Financing >= 0),
    FacultyId INT NOT NULL
);

-----------------------------------------------------------------------------------
CREATE TABLE GroupsNew
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK (Name <> ''),
    Rating INT NOT NULL CHECK (Rating BETWEEN 0 AND 5),
    [Year] INT NOT NULL CHECK ([Year] BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL
);

-----------------------------------------------------------------------------------
CREATE TABLE TeachersNew
(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL CHECK (Name <> ''),
    Surname NVARCHAR(100) NOT NULL CHECK (Surname <> ''),
    EmploymentDate DATE NOT NULL CHECK (EmploymentDate >= '1990-01-01'),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Position NVARCHAR(100) NOT NULL CHECK (Position <> ''),
    IsProfessor BIT NOT NULL DEFAULT 0,
    IsAssistant BIT NOT NULL DEFAULT 0
);


----------------------------------------------------------------------
ALTER TABLE DepartmentsNew
ADD CONSTRAINT FK_DepartmentsNew_FacultiesNew
FOREIGN KEY (FacultyId) REFERENCES FacultiesNew(Id);

ALTER TABLE GroupsNew
ADD CONSTRAINT FK_GroupsNew_DepartmentsNew
FOREIGN KEY (DepartmentId) REFERENCES DepartmentsNew(Id);


-----------------------------------------------------------------------
INSERT INTO FacultiesNew (Name, Dean) VALUES
('Computer Science', 'Robert Martin'),
('Economics', 'John Smith');

INSERT INTO DepartmentsNew (Name, Financing, FacultyId) VALUES
('Software Development', 30000, 1),
('Information Systems', 15000, 1),
('Finance', 20000, 2);

INSERT INTO GroupsNew (Name, Rating, [Year], DepartmentId) VALUES
('CS101', 4, 1, 1),
('CS202', 5, 2, 1),
('IS301', 3, 3, 2),
('FN401', 2, 4, 3);

INSERT INTO TeachersNew
(Name, Surname, EmploymentDate, Salary, Premium, Position, IsProfessor, IsAssistant)
VALUES
('Ivan', 'Petrov', '1998-03-12', 1200, 300, 'Professor', 1, 0),
('Anna', 'Ivanova', '2005-06-01', 900, 200, 'Assistant', 0, 1),
('Oleg', 'Sidorov', '2010-09-15', 800, 150, 'Assistant', 0, 1),
('Maria', 'Smirnova', '1995-01-10', 1500, 400, 'Professor', 1, 0);

---------------------------------------------------------------------------

SELECT * FROM FacultiesNew;
SELECT * FROM DepartmentsNew;
SELECT * FROM GroupsNew;
SELECT * FROM TeachersNew;