CREATE PROCEDURE [dbo].[ReportTeacherEntrySummary] @ev int
AS

	--header
	select eventdate,d.instrument, venue
	from event a
		inner join instrument d on a.Instrument=d.Id
	where a.Id=@ev

	-- body
	select firstname + ' ' + lastname as teachername, count(status) as total, dbo.EntryStatus(status) as EntryStatus
	from entry a
		inner join contact b on a.Teacher=b.id
	where a.event=@ev
	group by lastname,firstname,status
	order by lastname,firstname,EntryStatus