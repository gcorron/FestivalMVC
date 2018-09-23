	CREATE PROCEDURE [dbo].[SelectDataForLocation] @location int
	as

	set nocount on

	select a.Id, UserName, LastName,firstname, email, phone, available,instrument, b.Id as AssignedToLocation 
		from Contact a left outer join Location b
			on a.id=b.ContactId
	where a.ParentLocation=@location

	select LocationName, id,contactId
		from Location
	where ParentLocation=@location
		and LocationType>'A'
	order by LocationName