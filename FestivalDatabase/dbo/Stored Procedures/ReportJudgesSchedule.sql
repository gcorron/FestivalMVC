CREATE PROCEDURE [dbo].[ReportJudgesSchedule] @ev int
AS

	--header
	select eventdate,d.instrument, venue
	from event a
		inner join instrument d on a.Instrument=d.Id
	where a.Id=@ev

	-- body
	select firstname + ' ' + lastname as studentname, d.AuditionTime, typename, classabbr, name as judgename
	from entry a
		inner join student b on a.student=b.id
		inner join EventClassType c on a.classtype=c.classtype
		inner join audition d on a.id=d.id
		inner join schedule e on d.Schedule=e.id
		inner join judge f on e.Judge=f.Id
	where a.event=@ev
	order by judgename,auditiontime