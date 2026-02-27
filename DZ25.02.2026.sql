CREATE DATABASE SportShop;
GO

USE SportShop;
GO

/* ===============================
   СПІВРОБІТНИКИ МАГАЗИНУ
   =============================== */
CREATE TABLE Shop_Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    HireDate DATE NOT NULL,
    Gender NVARCHAR(10),
    Salary DECIMAL(10,2) NOT NULL
);
GO

/* ===============================
   АРХІВ СПІВРОБІТНИКІВ
   =============================== */
CREATE TABLE Shop_EmployeesArchive (
    ArchiveID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    FullName NVARCHAR(100),
    Position NVARCHAR(50),
    HireDate DATE,
    Gender NVARCHAR(10),
    Salary DECIMAL(10,2),
    DismissalDate DATETIME DEFAULT GETDATE()
);
GO

/* ===============================
   КЛІЄНТИ
   =============================== */
CREATE TABLE Shop_Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    Gender NVARCHAR(10),
    DiscountPercent INT DEFAULT 0,
    IsSubscribed BIT DEFAULT 0
);
GO

/* ===============================
   ТОВАРИ
   =============================== */
CREATE TABLE Shop_Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    ProductType NVARCHAR(50),
    Quantity INT DEFAULT 0,
    CostPrice DECIMAL(10,2),
    Manufacturer NVARCHAR(100),
    SalePrice DECIMAL(10,2)
);
GO

/* ===============================
   ПРОДАЖІ
   =============================== */
CREATE TABLE Shop_Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerID INT NULL,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(10,2) NOT NULL,
    SaleDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_ShopSales_Product
        FOREIGN KEY (ProductID)
        REFERENCES Shop_Products(ProductID),

    CONSTRAINT FK_ShopSales_Employee
        FOREIGN KEY (EmployeeID)
        REFERENCES Shop_Employees(EmployeeID),

    CONSTRAINT FK_ShopSales_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Shop_Customers(CustomerID)
);
GO

CREATE TRIGGER trg_Shop_ArchiveDeletedEmployee
ON Shop_Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO Shop_EmployeesArchive (
        EmployeeID,
        FullName,
        Position,
        HireDate,
        Gender,
        Salary
    )
    SELECT 
        d.EmployeeID,
        d.FullName,
        d.Position,
        d.HireDate,
        d.Gender,
        d.Salary
    FROM deleted d;
END;
GO


/* ===============================
   даные
   =============================== */

INSERT INTO Shop_Employees (FullName, Position, HireDate, Gender, Salary)
VALUES 
('Іван Петренко', 'Продавець', '2022-05-10', 'Чоловік', 15000),
('Олена Коваль', 'Касир', '2023-02-15', 'Жінка', 14000);

INSERT INTO Shop_Customers (FullName, Email, Phone, Gender, DiscountPercent, IsSubscribed)
VALUES
('Андрій Сидоренко', 'andriy@gmail.com', '0991112233', 'Чоловік', 5, 1),
('Марія Іванова', 'maria@gmail.com', '0982223344', 'Жінка', 10, 0);

INSERT INTO Shop_Products (ProductName, ProductType, Quantity, CostPrice, Manufacturer, SalePrice)
VALUES
('Кросівки Nike Air', 'Взуття', 20, 2000, 'Nike', 3500),
('Футболка Adidas', 'Одяг', 50, 500, 'Adidas', 1200);

INSERT INTO Shop_Sales (ProductID, EmployeeID, CustomerID, Quantity, SalePrice)
VALUES
(1, 1, 1, 1, 3500),
(2, 2, 2, 2, 1200);
GO

-- Звільнення співробітника
DELETE FROM Employees WHERE EmployeeID = 1;

-- Перевірка архіву
SELECT * FROM Shop_Employees;
SELECT * FROM Shop_EmployeesArchive;
SELECT * FROM Shop_Customers;
SELECT * FROM Shop_Products;
SELECT * FROM Shop_Sales;

GO
