CREATE PROCEDURE dbo.usp_MakeFamilyPurchase (@FamilySurName NVARCHAR(255))
AS
BEGIN
    -- 5.2.1
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - ISNULL((SELECT SUM(Value) FROM dbo.Basket WHERE ID_Family = Family.ID), 0)
    WHERE SurName = @FamilySurName;

    -- 5.2.2
    IF @@ROWCOUNT = 0
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(255);
        SET @ErrorMessage = 'Семьи с фамилией ' + @FamilySurName + ' не существует.';
        THROW 50000, @ErrorMessage, 1;
    END;
END;
