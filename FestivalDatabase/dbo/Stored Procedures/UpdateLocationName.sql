
CREATE PROCEDURE [dbo].[UpdateLocationName] @id int, @parentlocation int, @locationName varchar(50)
AS
BEGIN
	declare @locationType char(1)
	
	if @id=0
	BEGIN
		select @locationType=locationType
			from location
		where id=@parentlocation

		if @locationType is null
			RAISERROR('Location not found!',11,1,'InsertLocation')

		set @locationType=case @locationType when 'A' then 'B' when 'B' then 'C' when 'C' then 'D' when 'D' then 'E' else '?' end
		if @locationType='?'
			RAISERROR('Invalid location type!',11,1,'InsertLocation')

		insert location (locationName,locationType,ParentLocation)
			values(@locationName,@LocationType,@parentLocation)

		set @id = SCOPE_IDENTITY()
	END
	else
	BEGIN

		update location set LocationName=@locationName
			where Id=@id

		if @@ROWCOUNT=0
			raiserror('Location not found on server!', 11,1,'UpdateLocation')
	END

	select a.id, LocationName,isnull(FirstName + ' ' + LastName,'< Not Assigned >') as ContactName,LocationType
	from location a left outer join contact b
		on a.ContactId=b.id
	where a.id=@id

	

END