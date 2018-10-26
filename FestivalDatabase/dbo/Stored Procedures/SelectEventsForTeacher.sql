CREATE PROCEDURE [dbo].[SelectEventsForTeacher] @parentLocation int, @currentTime smalldatetime
AS
BEGIN
	select id, location, openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where location=@parentLocation

	select id, instrument from instrument


	select a.id,a.parentlocation,a.locationtype,b.locationname + ': ' + a.locationname as locationname,a.contactid
		from location a inner join location b
			on a.ParentLocation=b.id
	where a.id=@parentlocation

  END