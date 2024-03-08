use examV1

--Assign_Exam_To_Student
-- student exam  , exam-questions  ==> table in use
-- input ==> exam id, student id 

alter proc AssignExamToStudent
    @examid int,
    @studentid int
as
begin
    begin transaction;

    begin try
        -- Insert into std_exam table
        insert into std_exam (std_id, ex_id, q_id, std_answer)
        select @studentid, @examid, q.q_id, null
        from ex_question q
        where q.ex_id = @examid;

        commit transaction;
    end try
    begin catch
        rollback transaction;
        
        throw;
    end catch;
end;


EXEC AssignExamToStudent @examid = 1, @studentid = 8;


-- Exam Correction
-- input ==> exam_id, studentName 
-- output ==> grade

ALTER PROCEDURE ExamCorrection
    @exam_id INT,
    @std_id INT
AS
BEGIN
    DECLARE @TotalScore INT = 0;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Calculate total score
        SELECT @TotalScore = SUM(q.score)
        FROM std_exam se
        INNER JOIN ex_question eq ON se.q_id = eq.q_id
        INNER JOIN question q ON eq.q_id = q.q_id
        WHERE se.ex_id = 1
        AND se.std_id = 8
		AND se.std_answer= q.answer;


        -- Update student_course with total score as grade
        UPDATE student_course
        SET grade = @TotalScore
        WHERE s_id = @std_id
        AND crs_id = (SELECT crs_id FROM exam WHERE ex_id = @exam_id);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- If an error occurs, rollback the transaction
        ROLLBACK TRANSACTION;
        
        -- Optionally, raise an error or log the error message
        THROW;
    END CATCH;
END;

EXEC ExamCorrection @exam_id = 1, @std_id = 8;

