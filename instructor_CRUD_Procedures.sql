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

--Proc to get instructor by id
CREATE PROCEDURE GetInstructor ( @insID INT)
AS 
BEGIN TRY 
	BEGIN TRANSACTION
		SELECT fname + ' ' + lname as 'Instructor fullname'
		FROM [user]
		WHERE u_id = @insID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--GetInstructor 22


--Proc to get all instructors names
CREATE PROCEDURE GetAllInstructors
AS
BEGIN TRY
	BEGIN TRANSACTION
		SELECT fname + ' ' + lname as 'Instructor fullname'
		FROM [user]
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--GetAllInstructors

--Proc to Delete an instructor from instructor tableS after deleting from users table
CREATE PROCEDURE DeleteInstructor ( @insID INT)
AS
BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM [user] 
		WHERE u_id = @insID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--