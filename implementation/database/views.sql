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
    JOIN Seller S ON AI.SellerID = S.SellerID
  WHERE
    A.StartDate <= GETDATE() AND A.EndDate >= GETDATE();

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
