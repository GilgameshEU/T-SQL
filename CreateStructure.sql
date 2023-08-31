-- 2.1
CREATE TABLE dbo.SKU (
    ID INT IDENTITY PRIMARY KEY,
    Code AS 's' + CAST(ID AS NVARCHAR(255)) UNIQUE,
    Name NVARCHAR(255)
);

-- 2.2
CREATE TABLE dbo.Family (
    ID INT IDENTITY PRIMARY KEY,
    SurName NVARCHAR(255),
    BudgetValue DECIMAL(18, 2)
);

-- 2.3
CREATE TABLE dbo.Basket (
    ID INT IDENTITY PRIMARY KEY,
    ID_SKU INT REFERENCES dbo.SKU(ID),
    ID_Family INT REFERENCES dbo.Family(ID),
    Quantity INT CHECK (Quantity >= 0),
    Value DECIMAL(18, 2) CHECK (Value >= 0),
    PurchaseDate DATETIME DEFAULT GETDATE(),
    DiscountValue DECIMAL(18, 2)
);
