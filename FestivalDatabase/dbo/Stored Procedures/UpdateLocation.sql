
CREATE PROCEDURE [dbo].[UpdateLocation] @id int,  @contactId int, @locationName varchar(50)
AS
BEGIN
	update location set ContactId=case @contactId when 0 then NULL else @contactId end
	where Id=@id

	if @@ROWCOUNT=0
		raiserror('Location not found on server!', 11,1,'UpdateLocation')
END