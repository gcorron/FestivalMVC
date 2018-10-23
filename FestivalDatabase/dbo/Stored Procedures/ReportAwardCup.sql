-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE ReportAwardCup @location int
AS
BEGIN

select locationName from location
where id=@location


	;with cteHistory as(
	select student, classtype, classabbr, awardrating, consecutivesuperior, accumulatedpoints
	,ROW_NUMBER() over(partition by student,classtype order by eventdate desc) as rn
	from history
	 a inner join student b on a.student=b.id)


select v.EventDate,i.instrument,firstname + ' ' + lastname as studentname, c.TypeName,a.awardrating,dbo.awardpoints(a.awardrating) as awardpoints,
 h.AccumulatedPoints, dbo.awardcup(dbo.awardpoints(a.awardrating),h.AccumulatedPoints) as cup

from entry e inner join student s
on e.student=s.id
inner join audition a on e.id=a.id
inner join event v on e.event=v.id
inner join cteHistory h on e.student=h.student and e.ClassType=h.classtype
inner join instrument i on v.Instrument=i.Id
inner join EventClassType c on e.ClassType=c.ClassType
where v.location=@location and v.status='D' and h.rn=1
and dbo.awardcup(dbo.awardpoints(a.awardrating),h.AccumulatedPoints)>0
order by cup desc, lastname, firstname
END