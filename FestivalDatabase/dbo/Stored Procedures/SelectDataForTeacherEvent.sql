CREATE PROCEDURE [dbo].[SelectDataForTeacherEvent] @teacher int, @ev int
as
BEGIN

	
	select id,birthdate,phone,lastname,FirstName
	from student
		where teacher=@teacher

	select a.classtype as LastClassType, a.classabbr as LastClassAbbr,
		awardRating,consecutivesuperior, accumulatedpoints,
		b.ClassType, b.ClassAbbr
	from history a full outer join entry b
	on a.Student=b.Student and a.ClassAbbr=b.ClassAbbr
	where b.Event=@ev and b.Teacher=@teacher

	exec SelectEvent @ev
END