CREATE PROCEDURE [dbo].[SelectEventsForTeacher] @parentLocation int, @currentTime smalldatetime
AS
BEGIN
	select id, location, openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where location=@parentLocation

	select id, instrument from instrument


	select id,parentlocation,locationtype,locationname,contactid from location
	where id=@parentlocation

  END