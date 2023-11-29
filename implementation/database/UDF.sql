Use BIDDING_SYSTEM
go

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
