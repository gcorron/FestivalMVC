
CREATE PROCEDURE TransferStudent @id int, @teacher int
AS
BEGIN
	update student set teacher=@teacher
	where id=@id
END