	CREATE PROCEDURE [dbo].[SelectDataForLocation] @location int
	as

	set nocount on

	select Id, UserName, LastName,firstname, email, phone, available,instrument 
		from Contact
	where ParentLocation=@location

	select LocationName, id,contactId
		from Location
	where ParentLocation=@location
		and LocationType>'A'
	order by LocationName