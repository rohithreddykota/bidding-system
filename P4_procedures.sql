                                               //-- Stored procedures

                                   //-- Stored procedure for Inserting new User

CREATE PROCEDURE InsertNewUser
  @UserName VARCHAR(255),
  @UserEmail VARCHAR(255),
  @UserPassword VARCHAR(255),
  @Gender VARCHAR(255),
  @UserType VARCHAR(255),
  @IsBuyer BIT = 0,  
  @IsSeller BIT = 0  
AS
BEGIN
  SET NOCOUNT ON;
  INSERT INTO [User] (UserName, UserEmail, UserPassword, Gender, UserType)
  VALUES (@UserName, @UserEmail, @UserPassword, @Gender, @UserType);
  DECLARE @UserID INT;
  SET @UserID = SCOPE_IDENTITY();
  IF (@IsBuyer = 1)
  BEGIN
    INSERT INTO Buyer (BuyerID)
    VALUES (@UserID);
  END
  IF (@IsSeller = 1)
  BEGIN
    INSERT INTO Seller (SellerID)
    VALUES (@UserID);
  END
END;
 

EXEC InsertNewUser
  @UserName = 'John Doe',
  @UserEmail = 'john.doe@example.com',
  @UserPassword = 'password123',
  @Gender = 'Male',
  @UserType = 'Regular',
  @IsBuyer = 1;

                                     //-- Stored procedure for Updating a User

  CREATE PROCEDURE UpdateUser
  @UserID INT,
  @UserName VARCHAR(255),
  @UserEmail VARCHAR(255),
  @UserPassword VARCHAR(255),
  @Gender VARCHAR(255),
  @UserType VARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;
  UPDATE [User]
  SET UserName = @UserName,
      UserEmail = @UserEmail,
      UserPassword = @UserPassword,
      Gender = @Gender,
      UserType = @UserType
  WHERE UserID = @UserID;
END;


EXEC UpdateUser 
  @UserID = 1,  
  @UserName = 'shreya',
  @UserEmail = 'shreya@example.com',
  @UserPassword = 'thakur',
  @Gender = 'female',
  @UserType = 'Regular';

                                            //-- Stored procedure for Insert AdItem

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

                                  //-- Stored procedure for displaying the buyers list who bought for the same category 
  CREATE PROCEDURE GetBuyersByCategory
  @CategoryName VARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;

  SELECT DISTINCT B.BuyerID, U.UserName, U.UserEmail
  FROM Buyer B
  INNER JOIN AdItem AI ON B.BuyerID = AI.SellerID
  INNER JOIN AdItemCategory AC ON AI.CategoryID = AC.CategoryID
  INNER JOIN [User] U ON B.BuyerID = U.UserID
  WHERE AC.CategoryName = @CategoryName;
END;

EXEC GetBuyersByCategory
  @CategoryName = 'Clothing';


                                        //-- Stored procedure for deleting a chat

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


                                           //-- Stored procedure for deleting a chat

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

                                

                                 
								   




                                                                        //-- Views

					              //-- Views to display a list of active auctions
CREATE VIEW ActiveAuctionsView AS
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
JOIN Seller S ON AI.SellerID = S.SellerID
WHERE
    A.StartDate <= GETDATE() AND A.EndDate >= GETDATE();


                                            	//-- Views to display a list of highly rated sellers

CREATE VIEW HighRatedSellersView AS
SELECT
    S.SellerID,
    S.SellerRating,
    S.SellerPaymentInfo,
    U.UserName,
    U.UserEmail
FROM
    Seller S
JOIN [User] U ON S.SellerID = U.UserID
WHERE
    S.SellerRating > 4;

	                                           //-- Views to display a list of buyers watchlist 
                                           
                                           
	CREATE VIEW BuyerWatchlistView AS
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


                     
					                            //-- Views to display active users from user
												
CREATE VIEW ActiveUsersView AS
SELECT
    U.UserID,
    U.UserName,
    U.UserEmail,
    U.Gender,
    U.UserType
FROM
    [User] U
WHERE
    U.UserID IN (SELECT BuyerID FROM Buyer)
    OR U.UserID IN (SELECT SellerID FROM Seller);

	                                                