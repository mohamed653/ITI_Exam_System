-- questions CRUD
create type choices_ids as table(
ch_id int
)

declare @test_choices choices_ids;
insert into @test_choices
select ch_id from choice
WHERE ch_id >= 29 and ch_id <= 31
exec add_question 'to access the parent method in the inherited class but not in main what should be the type of the accessor?', 'MCQ', 31, 2, 1, @test_choices;

--add question
alter proc add_question @q_text varchar(200), @type varchar(10), @answer int, @score int, @crs_id int, @choices choices_ids readonly
as
begin
begin try
	begin transaction

	insert into question
	values (@q_text, @type, @answer, @score, @crs_id)
	declare @q_id int = scope_identity()

	insert into questions_choices
	select @q_id, ch_id
	from @choices

	commit;
end try

begin catch
	IF @@TRANCOUNT > 0
		rollback;
end catch
end


--update question 
create proc update_question @q_id int, @q_text varchar(200), @type varchar(10), @answer int, @score int, @crs_id int, @choices choices_ids readonly
as
begin
begin try
	begin transaction

	update question
	set q_text = @q_text,
		type = @type,
		answer = @answer,
		score = @score,
		crs_id = @crs_id
	where q_id = @q_id;

	delete from questions_choices
	where q_id = @q_id;

	insert into questions_choices
	select @q_id, ch_id
	from @choices

	commit;
end try

begin catch
	IF @@TRANCOUNT > 0
		rollback;
end catch
end


--delete question
create proc delete_question @q_id int
as
begin

begin try
	begin transaction

	delete from questions_choices
	where q_id = @q_id

	delete from question
	where q_id = @q_id

	commit
end try

begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end

--get question
create proc get_question_with_choices 
@q_id int
as
begin

begin try
	begin transaction

	select *
	from question
	where q_id = @q_id;

	select c.*
	from questions_choices qc
	join choice c
	on qc.ch_id = c.ch_id
	where qc.q_id = @q_id;

	commit 
end try

begin catch
	if @@trancount > 0
		rollback;
end catch
end

--exec get_question_with_choices 3


