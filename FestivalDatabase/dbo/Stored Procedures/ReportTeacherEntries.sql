
-- =============================================
CREATE PROCEDURE [dbo].[ReportTeacherEntries] @ev int, @teacher int 
AS
BEGIN

	--header
	select firstname + ' ' + lastname as teachername, eventdate,d.instrument, venue
	from TeacherEvent a
		inner join contact b on a.Teacher=b.id
		inner join event c on a.Event=c.Id
		inner join instrument d on c.Instrument=d.Id
	where a.Event=@ev and a.Teacher=@teacher

	-- body
	select firstname + ' ' + lastname as studentname, typename, classabbr
	from entry a
		inner join student b on a.student=b.id
		inner join EventClassType c on a.classtype=c.classtype
	where event=@ev and a.teacher=@teacher and a.status <> '-'
	order by typename,lastname,firstname 


END