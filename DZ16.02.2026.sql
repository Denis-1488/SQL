CREATE DATABASE AcademyFull;
GO
USE AcademyFull;
GO

------------------------Divisions---------------------------------------
CREATE TABLE Divisions
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> ''),
    Head NVARCHAR(100) NOT NULL CHECK(Head <> '')
);
GO

----------------------Units----------------------------
CREATE TABLE Units
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> ''),
    Budget MONEY NOT NULL DEFAULT 0 CHECK(Budget >= 0),
    DivisionId INT NOT NULL,
    FOREIGN KEY (DivisionId) REFERENCES Divisions(Id)
);
GO


-----------------------------Teams----------------------------------------
CREATE TABLE Teams
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK(Name <> ''),
    Score INT NOT NULL CHECK(Score BETWEEN 0 AND 5),
    [Level] INT NOT NULL CHECK([Level] BETWEEN 1 AND 5),
    UnitId INT NOT NULL,
    FOREIGN KEY (UnitId) REFERENCES Units(Id)
);
GO

----------------------------------Mentors--------------------------------------------------
CREATE TABLE Mentors
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(MAX) NOT NULL CHECK(FirstName <> ''),
    LastName NVARCHAR(MAX) NOT NULL CHECK(LastName <> '')
);
GO


---------------------------Instructors-------------------------------------------
CREATE TABLE Instructors
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL CHECK(FirstName <> ''),
    LastName NVARCHAR(100) NOT NULL CHECK(LastName <> ''),
    HireDate DATE NOT NULL CHECK(HireDate >= '1990-01-01'),
    Salary MONEY NOT NULL CHECK(Salary > 0),
    Bonus MONEY NOT NULL DEFAULT 0 CHECK(Bonus >= 0),
    Role NVARCHAR(50) NOT NULL CHECK(Role <> ''),
    IsSenior BIT NOT NULL,
    IsJunior BIT NOT NULL
);
GO

----------------------------------Courses--------------------------------------------------
CREATE TABLE Courses
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK(Name <> '')
);
GO

----------------------------------Sessions--------------------------------------------------
CREATE TABLE Sessions
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Room NVARCHAR(MAX) NOT NULL CHECK(Room <> ''),
    CourseId INT NOT NULL,
    TrainerId INT NOT NULL,
    FOREIGN KEY (CourseId) REFERENCES Courses(Id),
    FOREIGN KEY (TrainerId) REFERENCES Trainers(Id)
);
GO

----------------------------------TeamMentors--------------------------------------------------
CREATE TABLE TeamMentors
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    MentorId INT NOT NULL,
    TeamId INT NOT NULL,
    FOREIGN KEY (MentorId) REFERENCES Mentors(Id),
    FOREIGN KEY (TeamId) REFERENCES Teams(Id)
);
GO

-------------------------------TeamSessions-----------------------------------------------------
CREATE TABLE TeamSessions
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    TeamId INT NOT NULL,
    SessionId INT NOT NULL,
    FOREIGN KEY (TeamId) REFERENCES Teams(Id),
    FOREIGN KEY (SessionId) REFERENCES Sessions(Id)
);
GO

------------------------------------------------------------------------------------
INSERT INTO Divisions (Name, Head) VALUES
('Digital Technologies', 'Michael Brown'),
('Business Management', 'Sarah Johnson');

INSERT INTO Units (Name, Budget, DivisionId) VALUES
('Web Engineering', 35000, 1),
('Data Analytics', 20000, 1),
('Corporate Finance', 25000, 2);

INSERT INTO Teams (Name, Score, [Level], UnitId) VALUES
('DT101', 4, 1, 1),
('DT202', 5, 2, 1),
('DA301', 3, 3, 2),
('BF401', 2, 4, 3);

INSERT INTO Instructors
(FirstName, LastName, HireDate, Salary, Bonus, Role, IsSenior, IsJunior)
VALUES
('Alex', 'Kovalenko', '1999-04-15', 1300, 250, 'Senior Trainer', 1, 0),
('Olena', 'Shevchenko', '2007-08-21', 950, 180, 'Junior Trainer', 0, 1),
('Dmytro', 'Bondarenko', '2012-11-05', 850, 120, 'Junior Trainer', 0, 1),
('Iryna', 'Melnyk', '1996-02-18', 1600, 420, 'Senior Trainer', 1, 0);


GO
---------------------------------------------------

SELECT * FROM Divisions;
SELECT * FROM Units;
SELECT * FROM Teams;
SELECT * FROM Instructors;

