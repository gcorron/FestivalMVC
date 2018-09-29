CREATE PROCEDURE [dbo].[SelectDataForTeacherEvent] @teacher int, @ev int
as
BEGIN
	select id,birthdate,phone,lastname,FirstName from student
	where teacher=@teacher

	select student, classType, classAbbr,status
	from entry
	where teacher=@teacher and event=@ev

	exec SelectEvent @ev
END