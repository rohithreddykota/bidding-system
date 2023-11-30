-- Stored procedures

 use BIDDING_SYSTEM
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
                                     //-- Stored procedure for Updating a User

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

                                  //-- Stored procedure for displaying the buyers list who bought for the same category 
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

                                

                                 
								   




 	                                                