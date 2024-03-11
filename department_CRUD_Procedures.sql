--Proc to get one department
ALTER PROCEDURE GetDepartment ( @deptID INT )
AS
BEGIN TRY
	BEGIN TRANSACTION
		SELECT name as 'deptName'
		FROM department 
		WHERE dept_id = @deptID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--GetDepartment 7


--Proc to get all departments names
GO
CREATE PROCEDURE GetAllDepartment
AS
BEGIN TRY
	BEGIN TRANSACTION
		SELECT name as 'deptName'
		FROM department
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--GetAllDepartment


--Proc to delete deprtment
GO
ALTER PROCEDURE DeleteDepartment ( @deptID INT )
AS 
BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM department
		WHERE dept_id = @deptID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

--DeleteDepartment 8


--Proc to update department info 
CREATE PROCEDURE UpdateDepartmentInfo ( @deptID INT, @newName VARCHAR(20) )
AS
BEGIN TRY
	BEGIN TRANSACTION 
		UPDATE department
		SET name = @newName
		WHERE dept_id = @deptID
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--UpdateDepartmentInfo 3, 'ML'


--Add new Department
GO
CREATE PROCEDURE AddDepartment ( @deptName VARCHAR(20) )
AS
BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO department (name)
		VALUES ( @deptName )
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

AddDepartment 'Java'