--=========================================================
--- Create Database & Enable Encryption
--=========================================================

USE MASTER;
GO

-- Drop database if it exists
IF EXISTS (SELECT NAME FROM SYS.DATABASES WHERE NAME = N'BIDDING_SYSTEM')
BEGIN
    ALTER DATABASE BIDDING_SYSTEM SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BIDDING_SYSTEM;
END
GO

-- Create database
CREATE DATABASE BIDDING_SYSTEM;
GO

IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE symmetric_key_id = 101)
BEGIN
    -- Create a master key if it doesn't exist
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SuperStrongPass123';
    PRINT 'Master key created successfully.';
END
ELSE
BEGIN
    PRINT 'Master key already exists.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'BiddingSystemTDECert')
BEGIN
    -- Create a certificate for TDE
    CREATE CERTIFICATE BiddingSystemTDECert WITH SUBJECT = 'TDE Certificate For Bidding System';
    PRINT 'Certificate created successfully.';
END
ELSE
BEGIN
    PRINT 'Certificate already exists.';
END
GO

-- Enable TDE on the database
USE BIDDING_SYSTEM;
GO

IF NOT EXISTS (SELECT * FROM sys.dm_database_encryption_keys WHERE database_id = DB_ID() AND encryption_state = 3)
BEGIN
    -- Create a database encryption key (DEK) using the certificate
    CREATE DATABASE ENCRYPTION KEY
    WITH ALGORITHM = AES_256
    ENCRYPTION BY SERVER CERTIFICATE BiddingSystemTDECert;
    PRINT 'Database encryption key created successfully.';
END
ELSE
BEGIN
    PRINT 'Database encryption key already exists or the database is not encrypted.';
END
GO

-- Enable TDE on the database
ALTER DATABASE BIDDING_SYSTEM SET ENCRYPTION ON;
GO


--=========================================================
--- Create Tables
--=========================================================

-- Create table User
CREATE TABLE [User]
(
  UserID INT NOT NULL IDENTITY(1,1),
  User_FirstName VARCHAR(255) NOT NULL,
  User_LastName VARCHAR(255) NOT NULL,
  UserEmail VARCHAR(255) NOT NULL UNIQUE,
  -- Add UNIQUE constraint for UserEmail
  UserPassword VARBINARY(255) NOT NULL,
  Gender VARCHAR(255) NOT NULL,
  DateofBirth DATE NOT NULL,
  UserType VARCHAR(255) NOT NULL,
  User_FullName VARCHAR(255),
  Age INT,
  CONSTRAINT User_PK PRIMARY KEY (UserID)
);


-- Create table Buyer
CREATE TABLE Buyer
(
  BuyerID INT NOT NULL,
  CONSTRAINT Buyer_PK PRIMARY KEY (BuyerID),
  CONSTRAINT Buyer_FK FOREIGN KEY (BuyerID) REFERENCES [User](UserID)
);

-- Create table Seller
CREATE TABLE Seller
(
  SellerID INT NOT NULL,
  SellerRating INT NOT NULL,
  SellerPaymentInfo VARCHAR(255) NOT NULL,
  CONSTRAINT Seller_PK PRIMARY KEY (SellerID),
  CONSTRAINT Seller_FK FOREIGN KEY (SellerID) REFERENCES [User](UserID)
);

-- Create table Chat
CREATE TABLE Chat
(
  ChatID INT NOT NULL IDENTITY(1,1),
  BuyerID INT NOT NULL,
  SellerID INT NOT NULL,
  Message VARCHAR(MAX) NOT NULL,
  Timestamp DATETIME NOT NULL,
  PRIMARY KEY (ChatID),
  CONSTRAINT Chat_FK1 FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
  CONSTRAINT Chat_FK2 FOREIGN KEY (SellerID) REFERENCES Seller(SellerID)
);

-- Create table Block
CREATE TABLE Block
(
  BlockID INT NOT NULL IDENTITY(1,1),
  BuyerID INT NOT NULL,
  SellerID INT NOT NULL,
  BlockTimestamp DATETIME NOT NULL,
  Reason VARCHAR(255) NOT NULL CONSTRAINT Reason_CHK CHECK (Reason IN ('Inappropriate', 'Spam', 'Other')),
  CONSTRAINT Block_PK PRIMARY KEY (BlockID),
  CONSTRAINT Block_FK1 FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
  CONSTRAINT Block_FK2 FOREIGN KEY (SellerID) REFERENCES Seller(SellerID)
);

-- Create table Admin
CREATE TABLE Admin
(
  AdminID INT NOT NULL IDENTITY(1,1),
  AdminName VARCHAR(255) NOT NULL,
  AdminEmail VARCHAR(255) NOT NULL UNIQUE,
  -- Add UNIQUE constraint for AdminEmail
  AdminPassword VARBINARY(255) NOT NULL,
  AdminRole VARCHAR(255) NOT NULL CONSTRAINT AdminRole_CHK CHECK (AdminRole IN ('Super', 'Regular'))
    CONSTRAINT Admin_PK PRIMARY KEY (AdminID)
);

-- Create table AdItemCategory
CREATE TABLE AdItemCategory
(
  CategoryID INT NOT NULL IDENTITY(1,1),
  CategoryName VARCHAR(255) NOT NULL,
  CONSTRAINT AdItemCategory_PK PRIMARY KEY (CategoryID)
);

-- Create table AdStatus
CREATE TABLE AdStatus
(
  AdStatusID INT NOT NULL IDENTITY(1,1),
  AdStatusName VARCHAR(255) NOT NULL,
  CONSTRAINT AdStatus_PK PRIMARY KEY (AdStatusID)
);

-- Create table AdItem
CREATE TABLE AdItem
(
  AdItemID INT NOT NULL IDENTITY(1,1),
  AdminID INT NOT NULL,
  CategoryID INT NOT NULL,
  SellerID INT NOT NULL,
  AdStatusID INT NOT NULL,
  Title VARCHAR(255) NOT NULL,
  AdDescription VARCHAR(255) NOT NULL,
  CONSTRAINT AdItem_PK PRIMARY KEY (AdItemID),
  CONSTRAINT AdItem_FK1 FOREIGN KEY (AdminID) REFERENCES Admin(AdminID),
  CONSTRAINT AdItem_FK2 FOREIGN KEY (CategoryID) REFERENCES AdItemCategory(CategoryID),
  CONSTRAINT AdItem_FK3 FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
  CONSTRAINT AdItem_FK4 FOREIGN KEY (AdStatusID) REFERENCES [AdStatus](AdStatusID)
);

-- Create table Feedback
CREATE TABLE Feedback
(
  FeedbackID INT NOT NULL IDENTITY(1,1),
  BuyerID INT NOT NULL,
  AdItemID INT NOT NULL,
  Comments VARCHAR(255) NOT NULL,
  FeedbackRating INT NOT NULL CONSTRAINT FeedbackRating_CHK CHECK (FeedbackRating IN (1, 2, 3, 4, 5)),
  PRIMARY KEY (FeedbackID),
  FOREIGN KEY (BuyerID) REFERENCES [Buyer](BuyerID),
  FOREIGN KEY (AdItemID) REFERENCES AdItem(AdItemID)
);


-- Create table Auction
CREATE TABLE Auction
(
  AuctionID INT NOT NULL IDENTITY(1,1),
  AdItemID INT NOT NULL,
  Title VARCHAR(255) NOT NULL,
  AuctionDescription VARCHAR(255) NOT NULL,
  BasePrice DECIMAL(10,2) NOT NULL,
  BuyNowPrice DECIMAL(10,2) NOT NULL,
  StartDate DATETIME NOT NULL,
  EndDate DATETIME NOT NULL,
  [Status] VARCHAR(25) CHECK ([Status] IN ('Active', 'Inactive')),
  CONSTRAINT Auction_PK PRIMARY KEY (AuctionID),
  CONSTRAINT Auction_FK FOREIGN KEY (AdItemID) REFERENCES AdItem(AdItemID)
);


-- Create table Alert
CREATE TABLE Alert
(
  AlertID INT NOT NULL IDENTITY(1,1),
  BuyerID INT NOT NULL,
  SellerID INT NOT NULL,
  AuctionID INT NOT NULL,
  AlertMessage VARCHAR(255) NOT NULL,
  AlertTimestamp DATETIME NOT NULL,
  AlertType VARCHAR(255) NOT NULL CONSTRAINT AlertType_CHK CHECK (AlertType IN ('Bid', 'Buy', 'Sell')),
  -- todo: verify the values
  CONSTRAINT Alert_PK PRIMARY KEY (AlertID),
  CONSTRAINT Alert_FK1 FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
  CONSTRAINT Alert_FK2 FOREIGN KEY (SellerID) REFERENCES Seller(SellerID),
  CONSTRAINT Alert_FK3 FOREIGN KEY (AuctionID) REFERENCES Auction(AuctionID)
);

-- Create table WatchList
CREATE TABLE WatchList
(
  WatchListID INT NOT NULL IDENTITY(1,1),
  BuyerID INT NOT NULL UNIQUE,
  WatchListName VARCHAR(255) NOT NULL,
  WatchListDescription VARCHAR(255) NOT NULL,
  WatchListTimestamp DATETIME NOT NULL,
  CONSTRAINT WatchList_PK PRIMARY KEY (WatchListID),
  CONSTRAINT WatchList_FK1 FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID)
);


-- Create table AdItemWatchList
CREATE TABLE AdItemWatchList
(
  AdItemID INT NOT NULL,
  WatchListID INT NOT NULL,
  EventType VARCHAR(255) NOT NULL CONSTRAINT AdItemWatchListEventType_CHK CHECK (EventType IN ('Active', 'Inactive', 'Sold')),
  EventTimestamp DATETIME NOT NULL,
  CONSTRAINT AdItemWatchList_PK PRIMARY KEY (AdItemID, WatchListID),
  CONSTRAINT AdItemWatchList_FK1 FOREIGN KEY (AdItemID) REFERENCES AdItem(AdItemID),
  CONSTRAINT AdItemWatchList_FK2 FOREIGN KEY (WatchListID) REFERENCES WatchList(WatchListID)
);

-- Create table Bid
CREATE TABLE Bid
(
  BidID INT NOT NULL IDENTITY(1,1),
  AuctionID INT NOT NULL,
  BidPrice DECIMAL(10,2) NOT NULL,
  BidTimestamp DATETIME NOT NULL,
  CONSTRAINT Bid_PK PRIMARY KEY (BidID),
  CONSTRAINT Bid_FK1 FOREIGN KEY (AuctionID) REFERENCES Auction(AuctionID),
);


-- Create table BidStatus
CREATE TABLE BidStatus
(
  BidStatusID INT NOT NULL IDENTITY(1,1),
  BidStatusName VARCHAR(255) NOT NULL,
  CONSTRAINT BidStatus_PK PRIMARY KEY (BidStatusID)
)


-- Create table BidLog

CREATE TABLE BidLog
(
  BidLogID INT NOT NULL IDENTITY(1,1),
  BidID INT NOT NULL,
  BuyerID INT NOT NULL,
  BidStatusID INT NOT NULL,
  BidPrice DECIMAL(10,2) NOT NULL,
  BidTimestamp DATETIME NOT NULL,
  CONSTRAINT BidLog_PK PRIMARY KEY (BidLogID),
  CONSTRAINT BidLog_FK1 FOREIGN KEY (BidID) REFERENCES Bid(BidID),
  CONSTRAINT BidLog_FK2 FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
  CONSTRAINT BidLog_FK3 FOREIGN KEY (BidStatusID) REFERENCES BidStatus(BidStatusID)
);

--=========================================================
--- Non Cluster Indexes
--=========================================================

Use BIDDING_SYSTEM;

-- Nonclustered index for BuyerID in Chat table
CREATE NONCLUSTERED INDEX IX_BuyerID_Chat
ON Chat (BuyerID);

-- Nonclustered index for SellerID in Chat table
CREATE NONCLUSTERED INDEX IX_SellerID_Chat
ON Chat (SellerID);

-- Nonclustered index for BuyerID in Block table
CREATE NONCLUSTERED INDEX IX_BuyerID_Block
ON Block (BuyerID);

-- Nonclustered index for SellerID in Block table
CREATE NONCLUSTERED INDEX IX_SellerID_Block
ON Block (SellerID);

-- Nonclustered index for BuyerID in Alert table
CREATE NONCLUSTERED INDEX IX_BuyerID_Alert
ON Alert (BuyerID);

-- Nonclustered index for SellerID in Alert table
CREATE NONCLUSTERED INDEX IX_SellerID_Alert
ON Alert (SellerID);

-- Nonclustered index for AuctionID in Alert table
CREATE NONCLUSTERED INDEX IX_AuctionID_Alert
ON Alert (AuctionID);

-- Nonclustered index for BuyerID in AdItemWatchList table
CREATE NONCLUSTERED INDEX IX_BuyerID_AdItemWatchList
ON AdItemWatchList (BuyerID);

-- Nonclustered index for SellerID in AdItemWatchList table
CREATE NONCLUSTERED INDEX IX_SellerID_AdItemWatchList
ON AdItemWatchList (SellerID);

-- Nonclustered index for AuctionID in AdItemWatchList table
CREATE NONCLUSTERED INDEX IX_AuctionID_AdItemWatchList
ON AdItemWatchList (AuctionID);

-- Nonclustered index for AuctionID in Auction table
CREATE NONCLUSTERED INDEX IX_AuctionID_Auction
ON Auction (AdItemID);

-- Nonclustered index for BuyerID in BidLog table
CREATE NONCLUSTERED INDEX IX_BuyerID_BidLog
ON BidLog (BuyerID);

-- Nonclustered index for BidID in BidLog table
CREATE NONCLUSTERED INDEX IX_BidID_BidLog
ON BidLog (BidID);

-- Nonclustered index for BidStatusID in BidLog table
CREATE NONCLUSTERED INDEX IX_BidStatusID_BidLog
ON BidLog (BidStatusID);


--=========================================================
--- Stored Procedures
--=========================================================

-- Stored procedures

USE BIDDING_SYSTEM;

-- Stored procedure for Inserting new User
CREATE PROCEDURE InsertNewUser
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @UserEmail VARCHAR(255),
    @UserPassword VARCHAR(255),
    @Gender VARCHAR(255),
    @DateOfBirth DATE,
    @UserType VARCHAR(255)
    
AS
BEGIN
    -- Check if the user with the given email already exists
    IF EXISTS (SELECT 1 FROM [User] WHERE UserEmail = @UserEmail)
    BEGIN
        RETURN;
    END

    -- Insert the new user
    INSERT INTO [User] (User_FirstName, User_LastName, UserEmail, UserPassword, Gender, DateofBirth, UserType, User_FullName, Age)
    VALUES (@FirstName, @LastName, @UserEmail, @UserPassword, @Gender, @DateOfBirth, @UserType, [dbo].GetFullName(@FirstName, @LastName),[dbo].CalculateAge(@DateOfBirth));

END;
 

EXEC [dbo].InsertNewUser
    @FirstName = 'John',
    @LastName = 'Doe',
    @UserEmail = 'john.doe@example.com',
    @UserPassword = 'hashed_password',
    @Gender = 'Male',
    @DateOfBirth = '1990-01-01',
    @UserType = 'Regular';

-- Stored procedure for Updating a User
CREATE PROCEDURE UpdateUser
    @UserID INT,
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @UserEmail VARCHAR(255),
    @UserPassword VARCHAR(255),
    @Gender VARCHAR(255),
    @DateOfBirth DATE,
    @UserType VARCHAR(255)
    
AS
BEGIN
    -- Check if the user with the given email already exists (excluding the current user)
    IF EXISTS (SELECT 1 FROM [User] WHERE UserEmail = @UserEmail AND UserID <> @UserID)
    BEGIN
        RETURN;
    END
    -- Update the user information
    UPDATE [User]
    SET
        User_FirstName = @FirstName,
        User_LastName = @LastName,
        UserEmail = @UserEmail,
        UserPassword = @UserPassword,
        Gender = @Gender,
        DateofBirth = @DateOfBirth,
        UserType = @UserType,
        User_FullName = [dbo].GetFullName(@FirstName,@LastName),
        Age = [dbo].CalculateAge(@DateOfBirth)
    WHERE UserID = @UserID;

END;

-- Stored procedure for Insert AdItem
CREATE PROCEDURE InsertAdItem
  @AdminID INT,
  @CategoryID INT,
  @SellerID INT,
  @AdStatusID INT,
  @Title VARCHAR(255),
  @AdDescription VARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;
  INSERT INTO AdItem (AdminID, CategoryID, SellerID, AdStatusID, Title, AdDescription)
  VALUES (@AdminID, @CategoryID, @SellerID, @AdStatusID, @Title, @AdDescription);
END;

EXEC InsertAdItem
  @AdminID = 1,            
  @CategoryID = 2,         
  @SellerID = 3,           
  @AdStatusID = 4,         
  @Title = 'New AdItem',  
  @AdDescription = 'Description';  

-- Stored procedure for displaying the buyers list who bought for the same category 
  CREATE PROCEDURE GetBuyersByCategory
  @CategoryName VARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;

  SELECT DISTINCT B.BuyerID, U.User_FullName, U.UserEmail
  FROM Buyer B
  INNER JOIN AdItem AI ON B.BuyerID = AI.SellerID
  INNER JOIN AdItemCategory AC ON AI.CategoryID = AC.CategoryID
  INNER JOIN [User] U ON B.BuyerID = U.UserID
  WHERE AC.CategoryName = @CategoryName;
END;

EXEC GetBuyersByCategory
  @CategoryName = 'Clothing';


-- Stored procedure for deleting a chat

CREATE PROCEDURE DeleteChat
  @ChatID INT
AS
BEGIN
  SET NOCOUNT ON;
  DELETE FROM Chat
  WHERE ChatID = @ChatID;
  end;

  EXEC DeleteChat
  @ChatID = 1;


-- Stored procedure for deleting a chat

CREATE PROCEDURE DeleteFeedback
  @FeedbackID INT
AS
BEGIN
  SET NOCOUNT ON;
  DELETE FROM Feedback
  WHERE FeedbackID = @FeedbackID;
END;

EXEC DeleteFeedback
  @FeedbackID = 3;


--=========================================================
--- Create Triggers
--=========================================================

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


-- Prevents the addition of new auction for an aditem if an existing auction for the auctionitem is active and the inserting startdate is greater than enddate
-- Note: This must throw error
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
    -- Check if BuyNowPrice is greater than BasePrice
    IF EXISTS (SELECT *
               FROM inserted
               WHERE BuyNowPrice <= BasePrice)
    BEGIN
        RAISERROR ('BuyNowPrice must be greater than BasePrice in Auction table.', 16, 1);
        ROLLBACK TRANSACTION;
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


--=========================================================
--- UDFs
--=========================================================

Use BIDDING_SYSTEM
GO

-- Create a UDF to concatenate User_FirstName and User_LastName
CREATE FUNCTION GetFullName
(
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255)
)
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @FullName VARCHAR(255);
    SET @FullName = @FirstName + ' ' + @LastName;
    RETURN @FullName;
END;


-- Create a UDF to calculate Age
CREATE FUNCTION CalculateAge
(
    @DateOfBirth DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @Age INT;

    SET @Age = YEAR(@CurrentDate) - YEAR(@DateOfBirth) - 
        CASE
            WHEN MONTH(@CurrentDate) < MONTH(@DateOfBirth) OR 
                (MONTH(@CurrentDate) = MONTH(@DateOfBirth) AND DAY(@CurrentDate) < DAY(@DateOfBirth)) 
            THEN 1
            ELSE 0
        END;

    RETURN @Age;
END;


INSERT INTO [User] (User_FirstName,User_LastName,UserEmail,UserPassword,Gender,DateofBirth,UserType,User_FullName,Age) VALUES('John', 'Emily', 'john.emily@example.com', 'password123', 'Male', '1990-01-15', 'Regular', (select [dbo].GetFullName('John','Emily')), (select [dbo].calculateAge('1990-01-15') ) );


-- Create a UDF to calculate the average feedback rating for a seller
CREATE FUNCTION dbo.AverageFeedbackRatingForSeller
(
    @SellerID INT
)
RETURNS DECIMAL(3, 2)
AS
BEGIN
    DECLARE @AverageRating DECIMAL(3, 2);

    -- Calculate the average feedback rating for the specified seller
    SELECT @AverageRating = AVG(CONVERT(DECIMAL(3, 2), FeedbackRating))
    FROM Feedback
    WHERE AdItemID IN (SELECT AdItemID FROM AdItem WHERE SellerID = @SellerID);

    RETURN ISNULL(@AverageRating, 0); -- Return 0 if no feedback is available
END;

DECLARE @SellerID INT = 1; -- Replace with the actual SellerID
SELECT [dbo].AverageFeedbackRatingForSeller(@SellerID) AS AverageSellerRating;

--=========================================================
--- Create Views
--=========================================================

USE BIDDING_SYSTEM;

-- Create ActiveAuctionsView
CREATE VIEW ActiveAuctionsView
AS
  SELECT
    A.AuctionID,
    A.Title AS AuctionTitle,
    A.AuctionDescription,
    A.BasePrice,
    A.StartDate,
    A.EndDate,
    AI.Title AS AdItemTitle,
    AI.AdDescription,
    AI.SellerID,
    S.SellerRating
  FROM
    Auction A
    JOIN AdItem AI ON A.AdItemID = AI.AdItemID
    JOIN Seller S ON AI.SellerID = S.SellerID;

-- Create HighlyRatedSellersView
CREATE VIEW HighlyRatedSellersView
AS
  SELECT
    s.SellerID,
    u.User_FullName AS SellerName,
    s.SellerRating,
    s.SellerPaymentInfo
  FROM
    Seller s
    JOIN
    [User] u ON s.SellerID = u.UserID
  WHERE
    s.SellerRating >= 4;


-- Views to display a list of buyers watchlist                                            
CREATE VIEW BuyerWatchlistView
AS
  SELECT
    W.WatchListID,
    W.BuyerID,
    W.WatchListName,
    W.WatchListDescription,
    AWL.AdItemID,
    AWL.EventType,
    AWL.EventTimestamp,
    AI.Title AS AdItemTitle,
    AI.AdDescription,
    AI.CategoryID
  FROM
    WatchList W
    JOIN AdItemWatchList AWL ON W.WatchListID = AWL.WatchListID
    JOIN AdItem AI ON AWL.AdItemID = AI.AdItemID;


-- Views to display active users from user
CREATE VIEW ActiveUsersView
AS
  SELECT
    UserID,
    User_FirstName,
    User_LastName,
    UserEmail,
    Gender,
    DateofBirth,
    UserType,
    User_FullName,
    Age
  FROM
    [User]
  WHERE
    UserType = 'Regular';

-- Create view DetailedBidInfo
CREATE VIEW DetailedBidInfo AS
SELECT
    b.BidID,
    b.BidTimestamp,
    b.AuctionID,
    a.Title AS AuctionTitle,
    b.BidPrice,
    u.UserID,
    CONCAT(u.User_FirstName, ' ', u.User_LastName) AS UserName
FROM Bid b
JOIN Auction a ON b.AuctionID = a.AuctionID
JOIN BidLog bl ON b.BidID = bl.BidID
JOIN [User] u ON bl.BuyerID = u.UserID;

-- Create view to TotalBidsOverTime
CREATE VIEW TotalBidsOverTime AS
SELECT 
    CAST(b.BidTimestamp AS DATE) AS BidDate,
    COUNT(*) AS TotalBids
FROM Bid b
GROUP BY CAST(b.BidTimestamp AS DATE)
