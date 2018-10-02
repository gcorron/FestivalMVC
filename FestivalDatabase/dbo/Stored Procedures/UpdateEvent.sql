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
		declare @oldinstrument char(1), @oldclassTypes varchar(5)
		select @oldinstrument=instrument, @oldclassTypes=classTypes
		from event
		where id=@id

		if @oldinstrument is null
			RAISERROR('Event not found in system!',11,1,'UpdateEvent')
		
		if @oldinstrument <> @instrument
		BEGIN
			if exists(select * from teacherevent where event=@id)
				RAISERROR('Cannot change instrument when teachers are already signed up!',11,1,'UpdateEvent')
		END
		if charindex(@classtypes,@oldclasstypes,0)<0
		BEGIN
			if exists(select * from entry where event=@id)
				RAISERROR('Cannot remove a class type from the event after registration!',11,1,'UpdateEvent')
		END
				 

		update Event
			set opendate=@opendate, closedate=@closedate, eventdate=@eventdate, instrument=@instrument,
			 status=@status, venue=@venue, notes=@notes, classTypes=@classTypes -- do not update location
		where id=@id
	END

	select @id as id

END