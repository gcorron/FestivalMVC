
CREATE PROCEDURE [dbo].[UpdateJudge] @id int, @event int, @name nvarchar(50)
AS
BEGIN
	if @id=0
	BEGIN
		insert judge (event,name) values(@event,@name)
	END
	else if @id<0
	BEGIN
		if exists(Select * from audition a inner join schedule b on a.schedule=b.id where b.Judge=judge)
			RAISERROR('This judge has been assigned to entries and cannot be deleted.',11,1,'UpdateJudge')
		delete judge where id=-@id

	END
	else
	BEGIN
		update judge set name=@name
		where id=@id
	END
	select Id, Event, Name  -- return all judges for the event
	from judge
	where event=@event
	order by Name
END