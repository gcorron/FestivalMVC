-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateEntry] @event int, @teacher int, @student int, @classtype char(1), @classabbr varchar(10)
AS
BEGIN
	declare @status char(1),@id int

	select @id=id, @status=status
	from entry
	where event=@event and student=@student and classtype=@classtype
	if @id is null
		set @id=0

	if @id<>0 and @status<>'-'
			RAISERROR('Entry cannot be changed: already processed.',11,1,'UpdateEntry')

	if @classabbr is null
	BEGIN
		if @id=0
			RAISERROR('No entry found to delete.',11,1,'UpdateEntry')
		delete entry
		where event=@event and student=@student and status='-'
	END
	else if @id=0
	BEGIN
		insert entry(event,teacher,student,classtype,classabbr,status)
			values(@event,@teacher,@student,@classtype,@classabbr,'-')
	END
	else
	BEGIN
		update entry
			set classabbr=@classabbr
		where id=@id
	END
	select @event as event, @teacher as teacher, @student as Student, @classtype as ClassType, @classabbr as ClassAbbr

END