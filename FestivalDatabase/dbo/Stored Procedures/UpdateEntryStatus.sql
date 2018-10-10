CREATE PROCEDURE UpdateEntryStatus @id int, @status char, @notes varchar(50)
AS
BEGIN
	update entry
	set status=@status
	where id=@id

	update entrydetails
	set notes=@notes
	where id=@id
END