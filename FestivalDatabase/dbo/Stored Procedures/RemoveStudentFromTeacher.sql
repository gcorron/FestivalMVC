
CREATE PROCEDURE [dbo].[RemoveStudentFromTeacher] @id int, @teacher int
AS
BEGIN
	update student set teacher=NULL
	where id=@id and teacher=@teacher

	if @@ROWCOUNT=0
		RAISERROR('Remove failed - system could not locate this student.',11,1,'RemoveStudentFromTeacher')
END