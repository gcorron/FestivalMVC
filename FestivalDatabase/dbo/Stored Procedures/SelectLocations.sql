
CREATE PROCEDURE SelectLocations @currentId int, @goingUp bit 
AS
BEGIN
	if @goingUp=1
		select @currentId=parentlocation
			from location where id=@currentId

	select a.id, LocationName,isnull(FirstName + ' ' + LastName,'< Not Assigned >') as ContactName,LocationType
	from location a left outer join contact b
		on a.ContactId=b.id
	where a.id=@currentId

	select a.id, LocationName,isnull(FirstName + ' ' + LastName,'< Not Assigned >') as ContactName,LocationType
	from location a left outer join contact b
		on a.ContactId=b.id
	where a.parentlocation=@currentId
END