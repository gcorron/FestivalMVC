CREATE PROCEDURE UpdateStudentRegistration @student int, @teacher int, @ev int, @classtype char(1),
	@classAbbr varchar(10)
AS
BEGIN
	if @classabbr='DELETE'
	BEGIN
		delete entry
			where event=@ev and teacher=@teacher and student=@student	
				and classtype=@classtype and status='R'

	END
	update entry
		set classabbr=@classabbr
			where event=@ev and teacher=@teacher and student=@student	
				and classtype=@classtype and status='R'
	if @@ROWCOUNT=0
		insert entry(event,teacher,student,classtype,classabbr,status)
			values(@ev,@teacher,@student,@classtype,@classabbr,'R')

END