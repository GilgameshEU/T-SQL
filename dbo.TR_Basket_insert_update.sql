CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    -- 6.1
    UPDATE b
    SET DiscountValue = Value * 0.05
    FROM dbo.Basket b
    JOIN (
        SELECT ID_SKU
        FROM inserted
        GROUP BY ID_SKU
        HAVING COUNT(*) >= 2
    ) i ON b.ID_SKU = i.ID_SKU;

    UPDATE b
    SET DiscountValue = 0
    FROM dbo.Basket b
    JOIN (
        SELECT ID_SKU
        FROM inserted
        GROUP BY ID_SKU
        HAVING COUNT(*) < 2
    ) i ON b.ID_SKU = i.ID_SKU;
END;
