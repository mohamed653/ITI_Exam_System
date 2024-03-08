create type exam_questions_ids as table(
q_id int
)


-- generate random exam
alter proc generate_exam @crs_id int, @exam_date date, @duration time(0)
as
begin
begin try 
	begin transaction
	declare @tfCount int= (select COUNT(q_id) from question where type='TF'); 
	declare @MCQCount int= (select COUNT(q_id) from question where type='MCQ');
	declare @total_score int;

	exec mcq_tf_count @MCQCount output, @tfCount output;

	create table questions_table (
        q_id INT,
        score INT
    );

    insert into questions_table (q_id, score)
    select top (@MCQCount) q_id, score
    from question
    where crs_id = @crs_id AND type = 'MCQ'
    order by NEWID();

    insert into questions_table (q_id, score)
    select top (@tfCount) q_id, score
    from question
    where crs_id = @crs_id AND type = 'TF'
    order by NEWID();
	
	set @total_score = (select sum(score) from questions_table);

	declare @examQuestions exam_questions_ids;
	insert into @examQuestions select q_id from questions_table;

	exec insert_new_exam @duration, @exam_date, @total_score, @crs_id, @examQuestions;

	DROP TABLE questions_table;
	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch

end

--questions types random count
create proc mcq_tf_count @mcq int output, @tf int output
as
begin 
	if @mcq >= 5 and @tf >= 5
	begin
		set @mcq = 5;
		set @tf = 5;
	end

	else if @mcq >= 5 and @tf < 5
		set @mcq = (SELECT MIN(val) FROM (VALUES (@mcq), (10 - @tf)) AS AllValues(val));

	else if @mcq < 5 and @tf > 5
		set @tf = (SELECT MIN(val) FROM (VALUES (10 - @mcq), (@tf)) AS AllValues(val));
end

-- exam model answer
alter proc get_exam_answers @exam_id int
as
begin
begin try
	begin transaction
	select q.q_id, answer
	from exam e
	join exam_question eq on e.ex_id = eq.ex_id
	join question q on eq.q_id = q.q_id
	where e.ex_id = @exam_id;
	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch

end

exec generate_exam 1, '2024-03-07', '02:00:00'
exec get_exam_answers 5;

--save exam
alter proc insert_new_exam @duration time(0), @exam_date date, @total_score int, @crs_id int, @questionsTable exam_questions_ids readonly
as
begin
begin try
	begin transaction

	declare @examId int;
	insert into exam
	values(@duration, @exam_date, @total_score, @crs_id);
	set @examId = SCOPE_IDENTITY();

	insert into exam_question
	select @examId, q_id
	from @questionsTable;

	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end	

--delete exam
alter proc delete_exam @exam_id int
as
begin
begin try
	begin transaction

	delete from exam_question
	where ex_id = @exam_id

	delete from exam
	where ex_id = @exam_id

	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
	select 'error happened';
end catch
end	

--update exam
create proc modify_exam 
@exam_id int,
@duration time(0),
@exam_date date,
@total_score int,
@crs_id int,
@questionsTable exam_questions_ids readonly
as
begin
begin try
	begin transaction

	update exam
	set duration = @duration,
		date = @exam_date,
		total_score = @total_score,
		crs_id = @crs_id
	where ex_id = @exam_id;

	delete from exam_question
	where ex_id = @exam_id;

	insert into exam_question
	select @exam_id, q_id
	from @questionsTable;

	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end	

--get exam
create proc get_exam @exam_id int
as
begin
begin try
	begin transaction

	select * 
	from exam
	where ex_id = @exam_id

	select * 
	from exam_question eq
	join question q
	on eq.q_id = q.q_id
	where ex_id = @exam_id

	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end	

--generate_exam 1, '2024-03-06', '01:30:00'
--get_exam 7
--delete_exam 7
--get_question_with_choices 23
--delete_question 23