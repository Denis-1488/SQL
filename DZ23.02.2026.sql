CREATE DATABASE Academyii;
GO
USE Academyii;
GO

-- =========================
-- Faculties
-- =========================
CREATE TABLE Faculties
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> '')
);

-- =========================
-- Departments
-- =========================
CREATE TABLE Departments
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> ''),
    Financing MONEY NOT NULL DEFAULT 0 CHECK(Financing >= 0),
    FacultyId INT NOT NULL,
    FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

-- =========================
-- Groups
-- =========================
CREATE TABLE Groups
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK(Name <> ''),
    Year INT NOT NULL CHECK(Year BETWEEN 1 AND 5),
    DepartmentId INT NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

-- =========================
-- Teachers
-- =========================
CREATE TABLE Teachers
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL CHECK(Name <> ''),
    Surname NVARCHAR(100) NOT NULL CHECK(Surname <> ''),
    Salary MONEY NOT NULL CHECK(Salary > 0)
);

-- =========================
-- Subjects
-- =========================
CREATE TABLE Subjects
(
    Id INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> '')
);

-- =========================
-- Lectures
-- =========================
CREATE TABLE Lectures
(
    Id INT PRIMARY KEY IDENTITY,
    DayOfWeek INT NOT NULL CHECK(DayOfWeek BETWEEN 1 AND 7),
    LectureRoom NVARCHAR(50) NOT NULL CHECK(LectureRoom <> ''),
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

-- =========================
-- GroupsLectures
-- =========================
CREATE TABLE GroupsLectures
(
    Id INT PRIMARY KEY IDENTITY,
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);



-- ==================================================
INSERT INTO Faculties (Name) VALUES
('Computer Science'),
('Economics');

INSERT INTO Departments (Name, Financing, FacultyId) VALUES
('Software Development', 50000, 1),
('Information Systems', 30000, 1),
('Finance', 40000, 2);

INSERT INTO Groups (Name, Year, DepartmentId) VALUES
('P107', 1, 1),
('P208', 2, 1),
('IS301', 3, 2),
('F401', 4, 3);

INSERT INTO Teachers (Name, Surname, Salary) VALUES
('Dave', 'McQueen', 1200),
('Jack', 'Underhill', 1500),
('Samantha', 'Adams', 1300);

INSERT INTO Subjects (Name) VALUES
('Databases'),
('Programming'),
('Economics');

INSERT INTO Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) VALUES
(1, 'D201', 1, 1),
(2, 'D201', 2, 1),
(3, 'A101', 2, 2),
(4, 'B103', 1, 2),
(5, 'B103', 3, 3);

INSERT INTO GroupsLectures (GroupId, LectureId) VALUES
(1,1),
(1,2),
(2,3),
(3,4),
(4,5);


