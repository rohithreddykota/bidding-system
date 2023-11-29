Use BIDDING_SYSTEM
Go

-- bidprice should be greater than previous bid and less than or equal to buynowprice
CREATE TRIGGER TRIGGER_Bid_Insert
ON Bid
INSTEAD OF INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM inserted) > 0
    BEGIN
        IF (
            (SELECT MAX(BidPrice) FROM Bid WHERE AuctionID IN (SELECT AuctionID FROM inserted)) >= (SELECT MIN(BidPrice) FROM inserted)
            OR
            (SELECT MIN(BidPrice) FROM inserted) <= (SELECT BuyNowPrice FROM Auction WHERE AuctionID IN (SELECT AuctionID FROM inserted))
        )
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

ALTER TRIGGER TRIGGER_PreventDuplicateAuction
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
        WHERE existingAuction.[status] = 'Active'
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


-- Create trigger to check BuyNowPrice > BasePrice
CREATE TRIGGER CheckBuyNowPrice
ON Auction
AFTER INSERT, UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  IF (SELECT COUNT(*) FROM inserted WHERE BuyNowPrice < BasePrice) > 0
  BEGIN
    ROLLBACK;
  END
END;

-- if bidprice matches buynow price, bid will be won and auction ends immediately

CREATE TRIGGER TRIGGER_UpdateBidStatusAndAuction
ON Bid
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE BidLog
    SET BidStatusID = 2
    FROM BidLog bl
    INNER JOIN inserted i ON bl.BidID = i.BidID
    INNER JOIN Auction a ON i.AuctionID = a.AuctionID
    WHERE i.BidPrice = a.BuyNowPrice;

    UPDATE Auction
    SET Status = 'Inactive'
    FROM Auction a
    INNER JOIN inserted i ON a.AuctionID = i.AuctionID
    WHERE i.BidPrice = a.BuyNowPrice;
END;


-- if bid is won, aditem status changes to sold

CREATE TRIGGER TRIGGER_UpdateAdStatusOnBidWon
ON BidLog
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(BidStatusID)
    BEGIN
        UPDATE AdItem
        SET AdStatusID = 3
        FROM AdItem ai
		inner join Auction a on a.AdItemID = ai.AdItemID
		inner join Bid b on b.AuctionID = a.AuctionID
        INNER JOIN inserted i ON b.BidID = i.BidID
        WHERE i.BidStatusID = 2;
    END
END;



-- Create trigger to change BidStatusID when EndDate is passed for a specific AuctionID
CREATE TRIGGER TRIGGER_UpdateBidStatusOnEndDate
ON Auction
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the EndDate is updated to the current date or earlier
    IF UPDATE(EndDate) AND EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN deleted d ON i.AuctionID = d.AuctionID
        WHERE i.EndDate <= GETDATE() AND i.EndDate <> d.EndDate
    )
    BEGIN
        -- Update the BidStatusID to 2 for the bid with the highest bid price
        UPDATE BidLog
        SET BidStatusID = 2
        FROM BidLog bl
        INNER JOIN (
            SELECT TOP 1 b.BidID
            FROM Bid b
            WHERE b.AuctionID IN (SELECT AuctionID FROM inserted)
            ORDER BY b.BidPrice DESC
        ) AS highestBid ON bl.BidID = highestBid.BidID;
    END
END;
