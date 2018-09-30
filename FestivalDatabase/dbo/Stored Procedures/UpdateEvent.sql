CREATE PROCEDURE [dbo].[UpdateEvent] @id int, @location int, @openDate smalldatetime, @closeDate smalldatetime, @eventDate smalldatetime
	, @instrument char(1), @status char(1), @venue nvarchar(50), @notes varchar(256),@classTypes varchar(5)
as
BEGIN
	set @venue=isnull(@venue,'')
	set @notes=isnull(@notes,'')

	if @id=0
	BEGIN
		insert Event (location, opendate, closedate, eventdate, instrument, status, venue, notes,classTypes)
			values(@location,@opendate, @closedate, @eventdate, @instrument, @status, @venue, @notes,@classTypes)
		set @id=SCOPE_IDENTITY()
	END
	else
	BEGIN
		update Event
			set opendate=@opendate, closedate=@closedate, eventdate=@eventdate, instrument=@instrument,
			 status=@status, venue=@venue, notes=@notes, classTypes=@classTypes -- do not update location
		where id=@id
	END

	select @id as id

END