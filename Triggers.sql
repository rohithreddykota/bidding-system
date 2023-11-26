Use BIDDING_SYSTEM
Go

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


--Prevents the addition of new auction for an aditem if an existing auction for the auctionitem is active and the inserting startdate is greater than enddate

CREATE TRIGGER TRIGGER_PreventDuplicateAuction
ON Auction
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check for active existing auction for each AdItem in the inserted rows
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN AdItem a ON i.AdItemID = a.AdItemID
        INNER JOIN Auction existingAuction ON a.AdItemID = existingAuction.AdItemID
        WHERE existingAuction.EndDate > i.StartDate
    )
    BEGIN
        ROLLBACK;
    END
    -- Check that the inserting EndDate is greater than StartDate
    ELSE IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE EndDate <= StartDate
    )
    BEGIN
        ROLLBACK;
    END
    ELSE
    BEGIN
        -- Insert the new auction
        INSERT INTO Auction (AdItemID, Title, AuctionDescription, BasePrice, StartDate, EndDate)
        SELECT AdItemID, Title, AuctionDescription, BasePrice, StartDate, EndDate FROM inserted;
    END
END;


-- update auction status to inactive if enddate reached or adstatus is inactive, sold, deleted

CREATE TRIGGER TRIGGER_UpdateAuctionStatus_Auction
ON Auction
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if EndDate is reached or AdStatusID is changed to 2, 3, or 4
    UPDATE a
    SET [Status] = 'Inactive'
    FROM Auction a
    INNER JOIN AdItem i ON a.AdItemID = i.AdItemID
    INNER JOIN inserted ins ON a.AdItemID = ins.AdItemID
    WHERE ins.EndDate <= GETDATE() OR i.AdStatusID IN (2, 3, 4);
END;
