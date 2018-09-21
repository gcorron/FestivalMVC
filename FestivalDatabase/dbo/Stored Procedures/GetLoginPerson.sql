CREATE PROCEDURE [dbo].[GetLoginPerson] @userName nvarchar(256)
AS
BEGIN

-- used for the currently logged in user only
-- selects by ASP identity userName, not Id, for simplicity

	select b.LastName, b.FirstName, b.Instrument,
		c.id as ParentLocationId,c.locationName as ParentLocationName,
		d.id as LocationId, d.LocationName,
		case c.LocationType when 'E' then 'T' else isnull(d.LocationType,'-') end as RoleType
	from AspNetUsers a inner join contact b
		on a.UserName=b.UserName
		left outer join location c on b.ParentLocation=c.id
		left outer join location d
		on d.contactid=b.id
		
	where a.UserName=@userName

	
END