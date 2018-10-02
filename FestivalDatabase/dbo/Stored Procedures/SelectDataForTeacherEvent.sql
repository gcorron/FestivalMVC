CREATE PROCEDURE [dbo].[SelectDataForTeacherEvent] @teacher int, @ev int
as
BEGIN

	
	select id,birthdate,phone,lastname,FirstName
	from student
		where teacher=@teacher


	select isnull(a.student,b.student) as Student, isnull(a.classtype,b.classtype) as ClassType, isnull(a.classabbr,'') as LastClassAbbr,
		isnull(awardRating,0) as LastAwardRating,isnull(consecutivesuperior,0) as ConsecutiveSuperior,
		 isnull(accumulatedpoints,0) as AccumulatedPoints, isnull(b.ClassAbbr,'') as ClassAbbr, isnull(b.Status,'-') as Status
	from history a full outer join entry b
	on a.student=b.student and a.ClassType=b.ClassType
	inner join student c on a.student=c.id or b.student=c.id
	where c.teacher=@teacher

	exec SelectEvent @ev

	
declare @classtypes varchar(10)
select @classtypes=classtypes from event where id=@ev

	select classtype, classabbr, auditionMinutes
	from eventclass
	where active=1 and CHARINDEX(classtype,@classtypes)>0
	order by classtype, AuditionMinutes,classabbr



END