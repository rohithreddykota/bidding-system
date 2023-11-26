Use BIDDING_SYSTEM

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
