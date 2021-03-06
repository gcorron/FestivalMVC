﻿CREATE PROCEDURE [dbo].[SelectDataForTeacherEvent] @teacher int, @ev int
as
BEGIN


	select id,birthdate,phone,lastname,FirstName
	from student
		where teacher=@teacher

	;with cteHistory as(
	select student, classtype, classabbr, awardrating, consecutivesuperior, accumulatedpoints
	,ROW_NUMBER() over(partition by student,classtype order by eventdate desc) as rn
	from history
	 a inner join student b on a.student=b.id
	where teacher=@teacher)
	
	select student,classtype,classabbr,awardrating,consecutivesuperior,accumulatedpoints
	from cteHistory where rn=1

	select student,classtype, classabbr,status
	from entry
	where teacher=@teacher and event=@ev

	exec SelectEvent @ev

	declare @classtypes varchar(10)
	select @classtypes=classtypes from event where id=@ev

	select classtype, classabbr, auditionMinutes
	from eventclass
	where active=1 and CHARINDEX(classtype,@classtypes)>0
	order by classtype, AuditionMinutes,classabbr



END