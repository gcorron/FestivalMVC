CREATE PROCEDURE [dbo].[SelectEventsForTeacher] @parentLocation int, @currentTime smalldatetime
AS
BEGIN
	select id, location, openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where location=@parentLocation

	select id, instrument from instrument


	select * from location
	where id=@parentlocation

  END