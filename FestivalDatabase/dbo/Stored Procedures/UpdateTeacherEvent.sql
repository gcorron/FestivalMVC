
CREATE PROCEDURE UpdateTeacherEvent @teacher int, @ev int, @participate bit 
AS
BEGIN

	declare @exists char(1)='N'

	if exists(select * from teacherevent where teacher=@teacher and event=@ev)
		set @exists='Y'


	if @participate=1
	BEGIN
		if @exists='N'
			insert teacherevent (teacher, event) values (@teacher,@ev)
	END
	else
	BEGIN
		if @exists='Y'
			delete teacherevent where teacher=@teacher and event=@ev
	END
END