
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
  UserName,
  UserEmail,
  UserPassword,
  Gender,
  UserType
  )
VALUES
  ('Alice', 'alice@gmail.com', 'password123', 'Female', 'Regular'),
  ('Bob', 'bob@yahoo.com', 'qwerty', 'Male', 'Regular'),
  ('Charlie', 'charlie@hotmail.com', 'abc123', 'Male', 'Regular'),
  ('Diana', 'diana@gmail.com', 'letmein', 'Female', 'Regular'),
  ('Ethan', 'ethan@yahoo.com', 'securepassword', 'Male', 'Regular'),
  ('Fiona', 'fiona@hotmail.com', 'mypassword', 'Female', 'Regular'),
  ('George', 'george@gmail.com', 'password123', 'Male', 'Regular'),
  ('Hannah', 'hannah@yahoo.com', 'ilovecoding', 'Female', 'Regular'),
  ('Ian', 'ian@hotmail.com', 'abc123', 'Male', 'Regular'),
  ('Julia', 'julia@gmail.com', 'letmein', 'Female', 'Regular');


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
  (1, 1, 1, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 2, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 3, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 4, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 5, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 6, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 7, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 8, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 9, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue'),
  (1, 1, 10, 1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue');

INSERT INTO Auction
  (
  AdItemID,
  Title,
  AuctionDescription,
  BasePrice,
  StartDate,
  EndDate
  )
VALUES
  (1, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (2, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (3, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (4, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (5, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (6, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (7, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00'),
  (8, 'Apple iPhone 12 Pro Max', 'Apple iPhone 12 Pro Max 128GB Pacific Blue', 1000.00, '2021-04-01 00:00:00', '2021-04-30 00:00:00');

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
