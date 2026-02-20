CREATE DATABASE Academiﬂ;
GO

USE Academiﬂ;
GO

-- =========================
-- Faculties
-- =========================
CREATE TABLE Faculties
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> '')
);
GO

-- =========================
-- Departments
-- =========================
CREATE TABLE Departments
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Financing MONEY NOT NULL DEFAULT 0 CHECK(Financing >= 0),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> ''),
    FacultyId INT NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);
GO

-- =========================
-- Groups
-- =========================
CREATE TABLE Groups
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK(Name <> ''),
    Year INT NOT NULL CHECK(Year BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);
GO

-- =========================
-- Teachers
-- =========================
CREATE TABLE Teachers
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(MAX) NOT NULL CHECK(Name <> ''),
    Surname NVARCHAR(MAX) NOT NULL CHECK(Surname <> ''),
    Salary MONEY NOT NULL CHECK(Salary > 0)
);
GO

-- =========================
-- Subjects
-- =========================
CREATE TABLE Subjects
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> '')
);
GO

-- =========================
-- Lectures
-- =========================
CREATE TABLE Lectures
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    DayOfWeek INT NOT NULL CHECK(DayOfWeek BETWEEN 1 AND 7),
    LectureRoom NVARCHAR(MAX) NOT NULL CHECK(LectureRoom <> ''),
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);
GO

-- =========================
-- GroupsLectures
-- =========================
CREATE TABLE GroupsLectures
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);
GO
------------------------------------------------------------------


-- Faculties
INSERT INTO Faculties (Name)
VALUES ('Computer Science'), ('Software Engineering');

-- Departments
INSERT INTO Departments (Name, Financing, FacultyId)
VALUES 
('Software Development', 50000, 1),
('Information Systems', 40000, 1);

-- Groups
INSERT INTO Groups (Name, Year, DepartmentId)
VALUES
('SD101', 1, 1),
('SD201', 2, 1),
('IS101', 1, 2);

-- Teachers
INSERT INTO Teachers (Name, Surname, Salary)
VALUES
('Dave', 'McQueen', 1500),
('Jack', 'Underhill', 1700),
('Emma', 'Stone', 1400);

-- Subjects
INSERT INTO Subjects (Name)
VALUES
('C#'), ('Databases'), ('Algorithms');

-- Lectures
INSERT INTO Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId)
VALUES
(1, 'D201', 1, 1),
(2, 'D202', 2, 2),
(3, 'D201', 3, 1),
(4, 'D203', 2, 3);

-- GroupsLectures
INSERT INTO GroupsLectures (GroupId, LectureId)
VALUES
(1,1),
(1,2),
(2,3),
(3,4);
GO

SELECT * FROM Faculties;
SELECT * FROM Departments;
SELECT * FROM Groups;
SELECT * FROM Teachers;
SELECT * FROM Subjects;
SELECT * FROM Lectures;
SELECT * FROM GroupsLectures;

