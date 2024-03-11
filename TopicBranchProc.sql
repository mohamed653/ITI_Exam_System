/****** Object:  StoredProcedure [dbo].[DeleteTopic]    Script Date: 11/3/2024 10:08:04 PM ******/


create proc [dbo].[DeleteTopic] @crs_id int,@topic varchar(20)
as 
begin
delete from topic where crs_id=@crs_id and topic_name=@topic
end 
GO

/****** Object:  StoredProcedure [dbo].[DeleteTopicsByCourseId]    Script Date: 11/3/2024 10:08:18 PM ******/


create proc [dbo].[DeleteTopicsByCourseId] @crs_id int
as 
begin
delete from topic where crs_id=@crs_id
end 
GO

/****** Object:  StoredProcedure [dbo].[GetAllBranches]    Script Date: 11/3/2024 10:08:38 PM ******/


create proc [dbo].[GetAllBranches]
as 
begin 
select name from branch
end 
GO

/****** Object:  StoredProcedure [dbo].[GetAllTopics]    Script Date: 11/3/2024 10:09:10 PM ******/


create proc [dbo].[GetAllTopics]
as 
begin 
select topic_name
from topic
end 
GO

/****** Object:  StoredProcedure [dbo].[GetBranchById]    Script Date: 11/3/2024 10:09:29 PM ******/


create proc [dbo].[GetBranchById] @id int 
as 
begin 
select name from branch
where branch_id=@id
end 
GO

/****** Object:  StoredProcedure [dbo].[GetTopicById]    Script Date: 11/3/2024 10:10:08 PM ******/


create proc [dbo].[GetTopicById] @id int 
as 
begin 
select topic_name
from topic
where crs_id=@id
end
GO

/****** Object:  StoredProcedure [dbo].[InsertBranch]    Script Date: 11/3/2024 10:10:25 PM ******/


create proc [dbo].[InsertBranch] @name varchar(20) ,@loc varchar(20)
as 
begin
insert into branch (name,location)
values (@name,@loc)
end 
GO

/****** Object:  StoredProcedure [dbo].[InsertTopic]    Script Date: 11/3/2024 10:10:43 PM ******/


create proc [dbo].[InsertTopic] @crs_id int, @topic varchar(20)
as 
begin
insert into topic (crs_id,topic_name)
values (@crs_id,@topic)
end
GO

/****** Object:  StoredProcedure [dbo].[UpdateBranch]    Script Date: 11/3/2024 10:11:06 PM ******/


create proc [dbo].[UpdateBranch] @id int ,@name varchar(20),@loc varchar(20)
as
begin
update branch 
set name=@name ,location=@loc
where branch_id=@id
end 
GO

/****** Object:  StoredProcedure [dbo].[UpdateTopic]    Script Date: 11/3/2024 10:11:27 PM ******/


create proc [dbo].[UpdateTopic] @crs_id int ,@old_topic varchar(20),@new_topic varchar(20)
as 
begin 
update topic set topic_name=@new_topic
where crs_id=@crs_id and topic_name=@old_topic
end
GO

