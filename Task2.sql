CREATE DATABASE Electronics;

USE Electronics;

CREATE TABLE Brands (
    Id INT identity PRIMARY KEY,
    Name NVARCHAR(100)
);


CREATE TABLE Laptops (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    Price INT,
    BrandId INT,
    FOREIGN KEY (BrandId) REFERENCES Brands(Id)
);


CREATE TABLE Phones (
    Id INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100),
    Price INT,
    BrandId INT,
    FOREIGN KEY (BrandId) REFERENCES Brands(Id)
);


INSERT INTO Brands (Name) VALUES
('Apple'),
('Samsung'),
('mi'),
('Asus'),
('Sony');


INSERT INTO Laptops (Name, Price, BrandId) VALUES
('Laptop1', 3000, 1),
('Laptop2', 2500, 1),
('Laptop3', 1200, 4),
('Laptop4', 1800, 4),
('Laptop5', 2800, 5),
('Laptop6', 5000, 1);


INSERT INTO Phones (Name, Price, BrandId) VALUES
('Phone1', 1000, 2),
('Phone2', 1500, 1),
('Phone3', 800, 3),
('Phone4', 2000, 5),
('Phone5', 1200, 2);


SELECT Laptops.Name, Brands.Name as BrandName, Laptops.Price FROM Laptops
JOIN Brands ON Laptops.BrandId = Brands.Id;


SELECT Phones.Name, Brands.Name as BrandName, Phones.Price FROM Phones
JOIN Brands ON Phones.BrandId = Brands.Id;


SELECT * FROM Laptops JOIN Brands ON Laptops.BrandId = Brands.Id
WHERE CHARINDEX('s', Brands.Name) > 0;


SELECT * FROM Laptops
WHERE Price >= 2000;


SELECT * FROM Phones
WHERE Price >= 1000;


SELECT Brands.Name as BrandName, COUNT(Laptops.Id) as LaptopCount FROM Brands
LEFT JOIN Laptops ON Brands.Id = Laptops.BrandId
GROUP BY Brands.Id, Brands.Name;


SELECT Brands.Name as BrandName, COUNT(Phones.Id) as PhoneCount FROM Brands
LEFT JOIN Phones ON Brands.Id = Phones.BrandId
GROUP BY Brands.Id, Brands.Name;


SELECT Id, Name, Price, BrandId FROM Laptops
UNION ALL
SELECT Id, Name, Price, BrandId FROM Phones;


SELECT Laptops.Id, Laptops.Name, Laptops.Price, Laptops.BrandId, Brands.Name as BrandName FROM Laptops
JOIN Brands ON Laptops.BrandId = Brands.Id
UNION ALL
SELECT Phones.Id, Phones.Name, Phones.Price, Phones.BrandId, Brands.Name as BrandName FROM Phones
JOIN Brands ON Phones.BrandId = Brands.Id;


SELECT Laptops.Id, Laptops.Name, Laptops.Price, Laptops.BrandId, Brands.Name as BrandName FROM Laptops
JOIN Brands ON Laptops.BrandId = Brands.Id WHERE Laptops.Price > 1000
UNION ALL
SELECT Phones.Id, Phones.Name, Phones.Price, Phones.BrandId, Brands.Name as BrandName FROM Phones
JOIN Brands ON Phones.BrandId = Brands.Id WHERE Phones.Price > 1000;
