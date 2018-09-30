-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE UpdateEntry @event int, @teacher int, @student int, @classtype char(1), @classabbr varchar(10)
AS
BEGIN
	declare @currentStatus char(1), @currentTeacher int, @id int

	select @currentStatus=status, @id=id,@currentTeacher=teacher
	from entry
	where event=@event and @student=student and classtype=@classtype

	if @id is null
	BEGIN
		insert entry (event,teacher,student,classtype,classabbr,status)
			values(@event,@teacher,@student,@classtype,@classabbr,'R')
	END
	else
	BEGIN
		if @currentTeacher<>@teacher
			RAISERROR('Student is already registered under another teacher',11,1,'UpdateEntry')
		if @currentStatus<>'R'
			RAISERROR('Cannot change registration after payment',11,1,'UpdateEntry')
		if @classabbr='DELETE'
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


END