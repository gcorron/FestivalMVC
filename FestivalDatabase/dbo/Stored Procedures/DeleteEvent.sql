
CREATE PROCEDURE DeleteEvent @id int
AS
BEGIN
	-- see if there are any entries yet for this event!
	if exists(select * from entry where event=@id)
		RAISERROR('Cannot delete event that already has entries!',11,1,'DeleteEvent') 
	
	delete event where id=@id
	if @@ROWCOUNT=0
		RAISERROR('No event found to be deleted!',11,1,'DeleteEvent') 

END