
CREATE PROCEDURE UpdateEventCompleted @ev int
AS
BEGIN
	update event set status='D'
	where id=@ev
END