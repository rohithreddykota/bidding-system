
USE BIDDING_SYSTEM;

INSERT INTO [Admin]
  (
  AdminName,
  AdminEmail,
  AdminPassword,
  AdminRole
  )
VALUES
  ('Neil', 'neil@facbook.com', 'password', 'Super'),
  ('John', 'john@gmail.com', '123456', 'Regular'),
  ('Emma', 'emma@yahoo.com', 'qwerty', 'Regular'),
  ('Sarah', 'sarah@hotmail.com', 'abc123', 'Super'),
  ('Michael', 'michael@gmail.com', 'password123', 'Regular'),
  ('Emily', 'emily@gmail.com', 'ilovecoding', 'Super'),
  ('David', 'david@yahoo.com', 'securepassword', 'Regular'),
  ('Olivia', 'olivia@hotmail.com', 'mypassword', 'Super'),
  ('James', 'james@gmail.com', 'password123', 'Regular'),
  ('Sophia', 'sophia@yahoo.com', 'letmein', 'Super');

INSERT INTO AdItemCategory
  (
  CategoryName
  )
VALUES
  ('Electronics'),
  ('Clothing'),
  ('Furniture'),
  ('Books'),
  ('Toys'),
  ('Sports'),
  ('Automotive'),
  ('Other');


INSERT INTO AdStatus
  (
  AdStatusName
  )
VALUES
  ('Active'),
  ('Inactive'),
  ('Sold'),
  ('Deleted');

INSERT INTO BidStatus
  (
  BidStatusName
  )
VALUES
  --bid states
  ('Valid'),
  ('Won'),
  ('Cancelled'),
  ('Deleted');

INSERT INTO [User]
  (
  User_FirstName,
  User_LastName,
  UserEmail,
  UserPassword,
  Gender,
  DateofBirth,
  UserType,
  User_FullName,
  Age
  )
VALUES
  ('John', 'Doe', 'john.doe@example.com', 'password123', 'Male', '1990-01-15', 'Regular', 'John Doe', 32),
('Jane', 'Smith', 'jane.smith@example.com', 'pass456', 'Female', '1985-08-22', 'Admin', 'Jane Smith', 37),
('Bob', 'Johnson', 'bob.johnson@example.com', 'securePwd', 'Male', '1995-03-10', 'Regular', 'Bob Johnson', 27),
('Alice', 'Williams', 'alice.williams@example.com', 'p@ssw0rd', 'Female', '1992-11-05', 'Regular', 'Alice Williams', 30),
('Michael', 'Miller', 'michael.miller@example.com', 'secret123', 'Male', '1988-07-18', 'Regular', 'Michael Miller', 34),
('Emily', 'Taylor', 'emily.taylor@example.com', 'securePwd123', 'Female', '1983-04-30', 'Admin', 'Emily Taylor', 39),
('Daniel', 'Brown', 'daniel.brown@example.com', 'brownPass', 'Male', '1998-09-12', 'Regular', 'Daniel Brown', 24),
('Olivia', 'Jones', 'olivia.jones@example.com', 'passOlivia', 'Female', '1994-06-25', 'Regular', 'Olivia Jones', 28),
('William', 'Davis', 'william.davis@example.com', 'davisPwd', 'Male', '1996-02-08', 'Regular', 'William Davis', 26),
('Sophia', 'Clark', 'sophia.clark@example.com', 'passSophia', 'Female', '1991-12-03', 'Regular', 'Sophia Clark', 31);


INSERT INTO Seller
  (
  SellerID,
  SellerRating,
  SellerPaymentInfo
  )
VALUES
  (1, 5, 'Paypal'),
  (2, 4, 'Paypal'),
  (3, 3, 'Paypal'),
  (4, 2, 'Paypal'),
  (5, 1, 'Paypal'),
  (6, 5, 'Paypal'),
  (7, 4, 'Paypal'),
  (8, 3, 'Paypal'),
  (9, 2, 'Paypal'),
  (10, 1, 'Paypal');


INSERT INTO Buyer
  (
  BuyerID
  )
VALUES
  (1),
  (2),
  (3),
  (4),
  (5),
  (6),
  (7),
  (8),
  (9),
  (10);

INSERT INTO AdItem
  (
  AdminID,
  CategoryID,
  SellerID,
  AdStatusID,
  Title,
  AdDescription
  )
VALUES
  -- Category 1
  (1, 1, 1, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 2, 1, 'Samsung Galaxy S21 Ultra', 'Samsung Galaxy S21 Ultra 256GB Phantom Black'),
  (1, 1, 3, 1, 'Google Pixel 5', 'Google Pixel 5 128GB Just Black'),
  (1, 1, 4, 1, 'OnePlus 9 Pro', 'OnePlus 9 Pro 256GB Morning Mist'),
  (1, 1, 5, 1, 'Xiaomi Mi 11', 'Xiaomi Mi 11 256GB Midnight Gray'),
  -- Category 2
  (1, 2, 6, 1, 'Sony PlayStation 5', 'Sony PlayStation 5 Console'),
  (1, 2, 7, 1, 'Microsoft Xbox Series X', 'Microsoft Xbox Series X Console'),
  (1, 2, 8, 1, 'Nintendo Switch', 'Nintendo Switch Console'),
  (1, 2, 9, 1, 'Sony PlayStation 4', 'Sony PlayStation 4 Console'),
  (1, 2, 10, 1, 'Microsoft Xbox One X', 'Microsoft Xbox One X Console'),
  -- Category 3
  (1, 3, 1, 1, 'Apple MacBook Pro', 'Apple MacBook Pro 13" M1 Chip 256GB'),
  (1, 3, 2, 1, 'Dell XPS 13', 'Dell XPS 13 9300 13.4" 512GB'),
  (1, 3, 3, 1, 'HP Spectre x360', 'HP Spectre x360 13.3" 512GB'),
  (1, 3, 4, 1, 'Lenovo ThinkPad X1 Carbon', 'Lenovo ThinkPad X1 Carbon 14" 1TB'),
  (1, 3, 5, 1, 'Asus ROG Zephyrus G14', 'Asus ROG Zephyrus G14 14" 1TB'),
  -- Category 4
  (1, 4, 6, 1, 'Canon EOS R5', 'Canon EOS R5 Mirrorless Camera'),
  (1, 4, 7, 1, 'Nikon Z7 II', 'Nikon Z7 II Mirrorless Camera'),
  (1, 4, 8, 1, 'Sony Alpha A7 III', 'Sony Alpha A7 III Mirrorless Camera'),
  (1, 4, 9, 1, 'Fujifilm X-T4', 'Fujifilm X-T4 Mirrorless Camera'),
  (1, 4, 10, 1, 'Panasonic Lumix GH5', 'Panasonic Lumix GH5 Mirrorless Camera');

INSERT INTO Auction
  (
  AdItemID,
  Title,
  AuctionDescription,
  BasePrice,
  BuyNowPrice,
  StartDate,
  EndDate,
  [status]
  )
VALUES
  (1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, 1200.00,'2021-11-10', '2021-11-17','Active'),
  (2, 'Samsung Galaxy S21 Ultra', 'Samsung Galaxy S21 Ultra 256GB Phantom Black', 900.00, 945.00, '2021-11-10', '2021-11-17','Active'),
  (3, 'Google Pixel 5', 'Google Pixel 5 128GB Just Black', 800.00, 850.00, '2021-11-10', '2021-11-17','Active'),
  (4, 'OnePlus 9 Pro', 'OnePlus 9 Pro 256GB Morning Mist', 700.00, 702.00, '2021-11-10', '2021-11-17','Active'),
  (5, 'Xiaomi Mi 11', 'Xiaomi Mi 11 256GB Midnight Gray', 600.00, 610.00, '2021-11-10', '2021-11-17','Active'),
  (6, 'Sony PlayStation 5', 'Sony PlayStation 5 Console', 500.00, 520.00, '2021-11-10', '2021-11-17','Active'),
  (7, 'Microsoft Xbox Series X', 'Microsoft Xbox Series X Console', 400.00, 410.00, '2021-11-10', '2021-11-17','Active'),
  (8, 'Nintendo Switch', 'Nintendo Switch Console', 300.00, 340.00,'2021-11-10', '2021-11-17','Active'),
  (9, 'Sony PlayStation 4', 'Sony PlayStation 4 Console', 200.00, 234.00,'2021-11-10', '2021-11-17','Active'),
  (10, 'Microsoft Xbox One X', 'Microsoft Xbox One X Console', 100.00, 115.00,'2021-11-10', '2021-11-17','Active');

INSERT INTO Feedback
  (
  BuyerID,
  AdItemID,
  Comments,
  FeedbackRating
  )
VALUES
  (1, 1, 'Good', 5),
  (2, 2, 'Good', 5),
  (3, 3, 'Good', 5),
  (4, 4, 'Good', 5),
  (5, 5, 'Good', 5),
  (6, 6, 'Good', 5),
  (7, 7, 'Good', 5),
  (8, 8, 'Good', 5),
  (9, 9, 'Good', 5),
  (10, 10, 'Good', 5);


INSERT INTO Bid
  (
  AuctionID,
  BidPrice,
  BidTimestamp
  )
  VALUES 
  (1, 1000.00, '2023-11-10'),
  (2, 900.00, '2023-11-10'),
  (3, 800.00, '2023-11-10'),
  (4, 700.00, '2023-11-10'),
  (5, 600.00, '2023-11-10'),
  (6, 500.00, '2023-11-10'),
  (7, 400.00, '2023-11-10'),
  (8, 300.00, '2023-11-10'),
  (9, 200.00, '2023-11-10'),
  (10, 100.00, '2023-11-10');


INSERT INTO BidLog
  (
    BidID,
    BuyerID,
    BidStatusID,
    BidTimestamp
  )
  VALUES 
  (1, 1, 1, '2023-11-10'),
  (2, 2, 1, '2023-11-10'),
  (3, 3, 1, '2023-11-10'),
  (4, 4, 1, '2023-11-10'),
  (5, 5, 1, '2023-11-10'),
  (6, 6, 1, '2023-11-10'),
  (7, 7, 1, '2023-11-10'),
  (8, 8, 1, '2023-11-10'),
  (9, 9, 1, '2023-11-10'),
  (10, 10, 1, '2023-11-10');


INSERT INTO WatchList
  (
    BuyerID,
    WatchListName,
    WatchListDescription,
    WatchListTimestamp
  )
  VALUES 
  (1, 'WatchList 1', 'WatchList 1 Description', '2023-11-10'),
  (2, 'WatchList 2', 'WatchList 2 Description', '2023-11-10'),
  (3, 'WatchList 3', 'WatchList 3 Description', '2023-11-10'),
  (4, 'WatchList 4', 'WatchList 4 Description', '2023-11-10'),
  (5, 'WatchList 5', 'WatchList 5 Description', '2023-11-10'),
  (6, 'WatchList 6', 'WatchList 6 Description', '2023-11-10'),
  (7, 'WatchList 7', 'WatchList 7 Description', '2023-11-10'),
  (8, 'WatchList 8', 'WatchList 8 Description', '2023-11-10'),
  (9, 'WatchList 9', 'WatchList 9 Description', '2023-11-10'),
  (10, 'WatchList 10', 'WatchList 10 Description', '2023-11-10');


INSERT INTO AdItemWatchList
  (
    AdItemID,
    WatchListID,
    EventType,
    EventTimestamp
  )
  VALUES
  (1, 1, 'Active', '2023-11-10'),
  (2, 2, 'Active', '2023-11-10'),
  (3, 3, 'Active', '2023-11-10'),
  (4, 4, 'Active', '2023-11-10'),
  (5, 5, 'Active', '2023-11-10'),
  (6, 6, 'Active', '2023-11-10'),
  (7, 7, 'Active', '2023-11-10'),
  (8, 8, 'Active', '2023-11-10'),
  (9, 9, 'Active', '2023-11-10'),
  (10, 10, 'Active', '2023-11-10');


INSERT INTO Alert
(
  BuyerID,
  SellerID,
  AuctionID,
  AlertMessage,
  AlertTimestamp,
  AlertType
)
VALUES
(1, 1, 1, 'Alert 1', '2023-11-10', 'Bid'),
(2, 2, 2, 'Alert 2', '2023-11-10', 'Bid'),
(3, 3, 3, 'Alert 3', '2023-11-10', 'Bid'),
(4, 4, 4, 'Alert 4', '2023-11-10', 'Bid'),
(5, 5, 5, 'Alert 5', '2023-11-10', 'Bid'),
(6, 6, 6, 'Alert 6', '2023-11-10', 'Bid'),
(7, 7, 7, 'Alert 7', '2023-11-10', 'Bid'),
(8, 8, 8, 'Alert 8', '2023-11-10', 'Bid'),
(9, 9, 9, 'Alert 9', '2023-11-10', 'Bid'),
(10, 10, 10, 'Alert 10', '2023-11-10', 'Bid');

INSERT INTO Chat
(
  BuyerID,
  SellerID,
  Message,
  [Timestamp]
)
VALUES
(1, 1, 'Hello, is the product available?', '2023-11-10'),
(2, 2, 'Hi, I am interested in buying the item.', '2023-11-10'),
(3, 3, 'Is the price negotiable?', '2023-11-10'),
(4, 4, 'Can you provide more details about the product?', '2023-11-10'),
(5, 5, 'What is the condition of the item?', '2023-11-10'),
(6, 6, 'I would like to place a bid.', '2023-11-10'),
(7, 7, 'Is there a warranty for the product?', '2023-11-10'),
(8, 8, 'Can I schedule a viewing of the item?', '2023-11-10'),
(9, 9, 'Are there any additional fees?', '2023-11-10'),
(10, 10, 'What is the payment method?', '2023-11-10');

INSERT INTO Block
(
  BuyerID,
  SellerID,
  BlockTimestamp,
  Reason
)
VALUES
(1, 1, '2023-11-10', 'Spam'),
(1, 2, '2023-11-10', 'Inappropriate'),
(2, 3, '2023-11-10', 'Other'),
(2, 4, '2023-11-10', 'Spam'),
(3, 5, '2023-11-10', 'Inappropriate'),
(3, 6, '2023-11-10', 'Spam'),
(4, 7, '2023-11-10', 'Inappropriate'),
(4, 8, '2023-11-10', 'Spam'),
(5, 9, '2023-11-10', 'Spam'),
(5, 10, '2023-11-10', 'Spam');

