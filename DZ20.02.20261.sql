CREATE DATABASE AcademySubqueries;
GO
USE AcademySubqueries;
GO

-- =========================
-- FACULTIES
-- =========================
CREATE TABLE Faculties(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- DEPARTMENTS
-- =========================
CREATE TABLE Departments(
    Id INT IDENTITY PRIMARY KEY,
    Building INT NOT NULL CHECK(Building BETWEEN 1 AND 5),
    Financing MONEY NOT NULL DEFAULT 0 CHECK(Financing >= 0),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    FacultyId INT NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

-- =========================
-- GROUPS
-- =========================
CREATE TABLE Groups(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(10) NOT NULL UNIQUE,
    Year INT NOT NULL CHECK(Year BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

-- =========================
-- STUDENTS
-- =========================
CREATE TABLE Students(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    Rating INT NOT NULL CHECK(Rating BETWEEN 0 AND 5)
);

-- =========================
-- GROUPS-STUDENTS
-- =========================
CREATE TABLE GroupsStudents(
    Id INT IDENTITY PRIMARY KEY,
    GroupId INT NOT NULL,
    StudentId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (StudentId) REFERENCES Students(Id)
);

-- =========================
-- TEACHERS
-- =========================
CREATE TABLE Teachers(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    Salary MONEY NOT NULL CHECK(Salary > 0),
    IsProfessor BIT NOT NULL DEFAULT 0
);

-- =========================
-- SUBJECTS
-- =========================
CREATE TABLE Subjects(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

-- =========================
-- LECTURES
-- =========================
CREATE TABLE Lectures(
    Id INT IDENTITY PRIMARY KEY,
    Date DATE NOT NULL,
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

-- =========================
-- GROUPS-LECTURES
-- =========================
CREATE TABLE GroupsLectures(
    Id INT IDENTITY PRIMARY KEY,
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);

-- =========================
-- CURATORS
-- =========================
CREATE TABLE Curators(
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL
);

-- =========================
-- GROUPS-CURATORS
-- =========================
CREATE TABLE GroupsCurators(
    Id INT IDENTITY PRIMARY KEY,
    CuratorId INT NOT NULL,
    GroupId INT NOT NULL,
    FOREIGN KEY (CuratorId) REFERENCES Curators(Id),
    FOREIGN KEY (GroupId) REFERENCES Groups(Id)
);

-- =========================
-- TEST DATA
-- =========================
INSERT INTO Faculties VALUES ('Computer Science'), ('Software Engineering');

INSERT INTO Departments(Building,Financing,Name,FacultyId) VALUES
(1,120000,'Software Development',1),
(2,80000,'Cyber Security',1),
(3,150000,'AI Systems',2);

INSERT INTO Groups(Name,Year,DepartmentId) VALUES
('D221',5,1),
('D222',5,1),
('C101',1,2);

INSERT INTO Students(Name,Surname,Rating) VALUES
('Ivan','Petrov',5),
('Oleg','Ivanov',4),
('Anna','Shevchenko',3),
('Maria','Bondar',5);

INSERT INTO GroupsStudents(GroupId,StudentId) VALUES
(1,1),(1,2),(2,3),(3,4);

INSERT INTO Teachers(Name,Surname,Salary,IsProfessor) VALUES
('Dave','McQueen',2000,1),
('Jack','Underhill',1800,0),
('John','Smith',1500,1);

INSERT INTO Subjects VALUES ('Databases'),('AI'),('Networks');

INSERT INTO Lectures(Date,SubjectId,TeacherId) VALUES
('2025-01-10',1,1),
('2025-01-11',1,1),
('2025-01-12',2,2),
('2025-01-13',3,3);

INSERT INTO GroupsLectures(GroupId,LectureId) VALUES
(1,1),(1,2),(2,3),(3,4);

INSERT INTO Curators VALUES ('Alex','Brown'),('Tom','White');

INSERT INTO GroupsCurators VALUES
(1,1),(2,1),(2,2);



SELECT * FROM GroupsCurators;
SELECT * FROM Curators;
SELECT * FROM GroupsLectures;
SELECT * FROM Lectures;
SELECT * FROM Subjects;
SELECT * FROM Teachers;
SELECT * FROM GroupsStudents;
SELECT * FROM Students;
SELECT * FROM Groups; 
SELECT * FROM Departments;  
SELECT * FROM Faculties;
