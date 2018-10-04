-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEntry] @event int, @teacher int, @student int
	, @classtype char(1), @classabbr varchar(10), @classtype2 char(1), @classabbr2 varchar(10)
AS
BEGIN
	declare @currentStatus char(1), @currentTeacher int, @id int
	declare @count int=0
	
	while @count<2
	BEGIN
		if @classType<>'-'
		BEGIN
	
			select @currentStatus=isnull(status,'-'), @id=id,@currentTeacher=teacher
			from entry
			where event=@event and @student=student and classtype=@classtype

			if @id is null
			BEGIN
				if not (@classAbbr is null)
				BEGIN
					insert entry (event,teacher,student,classtype,classabbr,status)
						values(@event,@teacher,@student,@classtype,@classabbr,'-')
				END
			END
			else
			BEGIN
				if @currentTeacher<>@teacher
					RAISERROR('Student is already registered under another teacher for this event!',11,1,'UpdateEntry')
				if @currentStatus<>'-'
					RAISERROR('Cannot change registration after payment!',11,1,'UpdateEntry')
				if @classabbr is null
				BEGIN
					delete entry
					where id=@id
				END
				else
				BEGIN
					update entry
						set classabbr=@classabbr
					where id=@id
				END
			END
			set @classType=@classType2
			set @classAbbr=@classAbbr2
			set @count=@count+1
		END
	END
	-- return the new registered data ready for sending back to client
   declare @status char(1), @status2 char(1)
   
   select @classabbr=ClassAbbr, @status=isnull(status,'-')
   from entry
   where event=@event and student=@student and classtype=@classtype

   select @classabbr2=ClassAbbr,@status2=isnull(status,'-')
   from entry
   where event=@event and student=@student and classtype=@classtype2

	select @event as Event, @teacher as Teacher, @student as Student
	, @classtype as ClassType, @classabbr as ClassAbbr, @classtype2 as ClassType2, @classabbr2 as ClassAbbr2,
	isnull(@status,'-') as Status, isnull(@status2,'-') as Status2
END