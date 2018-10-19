CREATE PROCEDURE SelectReports @role char(1)
AS
BEGIN
	select Id,Description, Name, Params
	from report
	where role=@role
END