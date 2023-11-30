CREATE TRIGGER CheckBuyNowPrice
ON Auction
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if BuyNowPrice is greater than BasePrice
    IF EXISTS (SELECT *
               FROM inserted
               WHERE BuyNowPrice <= BasePrice)
    BEGIN
        RAISERROR ('BuyNowPrice must be greater than BasePrice in Auction table.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
