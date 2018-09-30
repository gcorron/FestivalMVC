
CREATE PROCEDURE RemoveStudentFromTeacher @id int
AS
BEGIN
	update student set teacher=NULL
	where id=@id
END