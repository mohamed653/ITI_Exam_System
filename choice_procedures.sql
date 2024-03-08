-- choice CRUDs

-- create choice 
create proc add_choice @choice_text varchar(100)
as
begin
	insert into choice
	values(@choice_text);
end

--update choice
create proc update_choice @choice_id int, @new_text varchar(100)
as
begin
	update choice
	set text = @new_text
	where ch_id = @choice_id
end

--read choice
create proc get_choice @choice_id int
as
begin
	select *
	from choice
	where ch_id = @choice_id
end

--delete choice
create proc delete_choice @choice_id int
as
begin
	delete
	from choice
	where ch_id = @choice_id
end 

--exec add_choice 'a and c'
--exec update_choice 47, 'a and b'
--exec get_choice 47
--exec delete_choice 47