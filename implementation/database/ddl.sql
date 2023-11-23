
-- Create database
IF EXISTS (SELECT NAME
FROM SYS.DATABASES
WHERE NAME = N'BIDDING_SYSTEM')
  DROP DATABASE BIDDING_SYSTEM
GO
CREATE DATABASE BIDDING_SYSTEM
GO
USE BIDDING_SYSTEM
GO

-- Create table User
CREATE TABLE [User]
(
  UserID INT NOT NULL IDENTITY(1,1),
  -- Use IDENTITY instead of AUTO_INCREMENT for SQL Server
  UserName VARCHAR(255) NOT NULL,
  UserEmail VARCHAR(255) NOT NULL UNIQUE,
  -- Add UNIQUE constraint for UserEmail
  UserPassword VARCHAR(255) NOT NULL,
  -- todo: encrypt password
  Gender VARCHAR(255) NOT NULL,
  UserType VARCHAR(255) NOT NULL,
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
  AdminPassword VARCHAR(255) NOT NULL,
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
  StartDate DATETIME NOT NULL,
  EndDate DATETIME NOT NULL,
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
  BuyerID INT NOT NULL,
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
CREATE TABLE BidStatus (
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
  BidTimestamp DATETIME NOT NULL,
  CONSTRAINT BidLog_PK PRIMARY KEY (BidLogID),
  CONSTRAINT BidLog_FK1 FOREIGN KEY (BidID) REFERENCES Bid(BidID),
  CONSTRAINT BidLog_FK2 FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID),
  CONSTRAINT BidLog_FK3 FOREIGN KEY (BidStatusID) REFERENCES BidStatus(BidStatusID)
);

