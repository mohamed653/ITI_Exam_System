--OmarAbdallah

--Proc to add new user generally used in inserting instructors and students
ALTER PROCEDURE InsertUser ( @userName VARCHAR(20), @password VARCHAR(50), @role VARCHAR(20), @fname NVARCHAR(50), @lname NVARCHAR(50), @userID INT OUTPUT ) 
AS
BEGIN TRY
	BEGIN TRANSACTION

	INSERT INTO [user] (username, password, role, fname, lname)
	VALUES (@userName, @password, @role, @fname, @lname)

	SET @userID = SCOPE_IDENTITY()

	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--InsertUser 'omarabdallah', 'omar123', 'instructor', 'Omar', 'Abdallah'*/
--InsertUser 'ahmedelsharkawy', 'ahmed12345', 'student', 'Ahmed', 'Elsharkawy'

--Proc to add instructor using InsertUser Proc 
GO
ALTER PROCEDURE InsertInstructor 
(   
    @userName VARCHAR(20),
    @password VARCHAR(50),
    @role VARCHAR(20),
    @fname NVARCHAR(50),
    @lname NVARCHAR(50),
	@hire_date DATE,
    @dept_id INT
)
AS
BEGIN TRY
	BEGIN TRANSACTION
		DECLARE @insID INT

		EXEC InsertUser @userName, @password, @role, @fname, @lname, @insID OUTPUT

		INSERT INTO instructor VALUES ( @insID, @hire_date, @dept_id )

		COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

--InsertInstructor 'insUsername', '0123456', 'instructor', 'Kareem', 'Waleed', '4-4-2013', 3

