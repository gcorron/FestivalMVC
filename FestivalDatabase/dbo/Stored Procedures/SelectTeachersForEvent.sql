-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectTeachersForEvent] @id int
AS
BEGIN


set nocount on

	declare @location int
	declare @instrument char(1)

	select @location=location, @instrument=instrument
		from event
	where id=@id
	
	select id, userName, lastName,firstName, email, phone  -- since we know all of them are available, re-use that field to indicate whether they are in the event
			,case b.teacher when null then 0 else 1 end as available
			,instrument 
		from Contact a left outer join teacherevent b
		on a.id=b.teacher and @id=b.event
	where ParentLocation=@location
		and a.Available=1
		and instrument=@instrument
	order by lastName,FirstName

	select id,name
		from judge
	where event=@id



END