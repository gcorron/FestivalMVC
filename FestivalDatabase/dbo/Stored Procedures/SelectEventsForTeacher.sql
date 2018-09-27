CREATE PROCEDURE SelectEventsForTeacher @parentLocation int, @currentTime smalldatetime
AS
BEGIN
	select id, openDate, closeDate,eventDate,instrument,status,
		venue,notes
			from event
	where location=@parentLocation
		and (
		(status='A' and closeDate>@currentTime)
		 or status='B')


	select id, instrument from instrument


	select * from location
	where id=@parentlocation

  END