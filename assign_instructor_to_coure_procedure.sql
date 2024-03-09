--Proc to assign instructor to course

ALTER PROCEDURE AssignInstructorToCourse ( @insID INT, @crsID INT)
AS
BEGIN TRY
	BEGIN TRANSACTION
		IF NOT EXISTS (
			SELECT 1
			FROM instructor_course
			WHERE ins_id = @insID AND crs_id = @crsID
		)
		BEGIN
			INSERT INTO instructor_course (ins_id, crs_id)
			VALUES (@insID, @crsID)
		END
		ELSE
		BEGIN
			SELECT 'Instructor is already assigned to this course' as 'Error Message'
		END
	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH

--AssignInstructorToCourse 10,1