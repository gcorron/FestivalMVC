CREATE PROCEDURE SelectLocation @id int
AS
BEGIN
	select a.UserName, a.Id as UserId, a.Email, a.PhoneNumber,
		b.Id as LocationId, b.LocationName, b.LastName,b.FirstName,b.LocationType as AdminRole
	from AspNetUsers a inner join location b
		on a.Id=b.UserId
	where b.id=@id
END