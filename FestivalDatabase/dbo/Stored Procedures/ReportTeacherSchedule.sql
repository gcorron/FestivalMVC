CREATE PROCEDURE [dbo].[ReportTeacherSchedule] @ev int, @teacher int
AS

	--header
	select firstname + ' ' + lastname as teachername, eventdate,d.instrument, venue
	from TeacherEvent a
		inner join contact b on a.Teacher=b.id
		inner join event c on a.Event=c.Id
		inner join instrument d on c.Instrument=d.Id
	where a.Event=@ev and a.Teacher=@teacher

	-- body
	select firstname + ' ' + lastname as studentname, d.AuditionTime, typename, classabbr
	from entry a
		inner join student b on a.student=b.id
		inner join EventClassType c on a.classtype=c.classtype
		inner join audition d on a.id=d.id
	where event=@ev and a.teacher=@teacher
	order by typename,auditiontime