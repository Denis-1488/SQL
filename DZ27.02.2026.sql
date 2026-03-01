CREATE DATABASE BooksShop;
GO

USE BooksShop;
GO

/* =====================================
   AUTHORS
   ===================================== */
CREATE TABLE Authors (
    AuthorID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Discount DECIMAL(5,2) DEFAULT 0
);
GO

/* =====================================
   BOOKS
   ===================================== */
CREATE TABLE Books (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    AuthorID INT NOT NULL,

    CONSTRAINT FK_Books_Authors
        FOREIGN KEY (AuthorID)
        REFERENCES Authors(AuthorID)
);
GO

/* =====================================
   TRIGGER: зміна скидки автора
   ===================================== */
CREATE TRIGGER trg_UpdateBookPricesByAuthorDiscount
ON Authors
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE b
    SET b.Price = b.Price * (1 - i.Discount / 100.0)
    FROM Books b
    JOIN inserted i ON b.AuthorID = i.AuthorID
    JOIN deleted d ON d.AuthorID = i.AuthorID
    WHERE i.Discount <> d.Discount;
END;
GO

/* =====================================
   ТЕСТОВІ ДАНІ
   ===================================== */
INSERT INTO Authors (FullName, Discount)
VALUES
('Тарас Шевченко', 0),
('Леся Українка', 0),
('Іван Франко', 0),
('Михайло Коцюбинський', 0),
('Панас Мирний', 0);

INSERT INTO Books (Title, Price, AuthorID)
VALUES
('Кобзар', 200, 1),
('Гайдамаки', 180, 1),

('Лісова пісня', 220, 2),
('Кассандра', 210, 2),

('Захар Беркут', 250, 3),
('Мойсей', 240, 3),

('Тіні забутих предків', 230, 4),
('Fata Morgana', 215, 4),

('Хіба ревуть воли, як ясла повні?', 260, 5),
('Повія', 245, 5);
GO

/* =====================================
   ТЕСТ: зміна скидки
   ===================================== */
UPDATE Authors
SET Discount = 15
WHERE FullName = 'Іван Франко';

SELECT * FROM Books;
GO