-- choice CRUDs

-- create choice 
alter proc add_choice @choice_text varchar(100)
as
begin
begin try
	begin transaction
	insert into choice
	values(@choice_text);
	commit
end try
begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end

--update choice
alter proc update_choice @choice_id int, @new_text varchar(100)
as
begin
begin try
	begin transaction
	update choice
	set text = @new_text
	where ch_id = @choice_id
	commit
end try
begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end

--read choice
alter proc get_choice @choice_id int
as
begin
begin try
	begin transaction
	select *
	from choice
	where ch_id = @choice_id
	commit
end try
begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end

--delete choice
alter proc delete_choice @choice_id int
as
begin
begin try
	begin transaction
	delete
	from choice
	where ch_id = @choice_id
	commit
end try
begin catch
	if @@TRANCOUNT > 0
		rollback;
end catch
end 

--exec add_choice 'a and c'
--exec update_choice 47, 'a and b'
--exec get_choice 47
--exec delete_choice 47