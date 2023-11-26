CREATE TRIGGER TRIGGER_Bid_Insert
ON Bid
INSTEAD OF INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted) > 0
    BEGIN
        IF (SELECT MAX(BidPrice) FROM Bid WHERE AuctionID IN (SELECT AuctionID FROM inserted)) >= (SELECT MIN(BidPrice) FROM inserted)
        BEGIN
            ROLLBACK;
        END
        ELSE
        BEGIN
            INSERT INTO Bid (AuctionID, BidPrice, BidTimestamp)
            SELECT AuctionID, BidPrice, BidTimestamp FROM inserted;
        END
    END
END;