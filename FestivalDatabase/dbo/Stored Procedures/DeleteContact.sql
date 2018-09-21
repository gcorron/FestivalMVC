
CREATE PROCEDURE DeleteContact @id int
AS
BEGIN

-- constraints will throw an error if contact should not be deleted
	delete contact
	where id=@id
END