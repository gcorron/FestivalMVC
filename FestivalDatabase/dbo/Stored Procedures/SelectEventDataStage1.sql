-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectEventDataStage1] @event int
AS
BEGIN


set nocount off

	declare @location int
	declare @instrument int

	select @location=location, @instrument=instrument
		from event
	where id=@event

	select id, userName, lastName,firstName, email, phone, available,instrument 
		from Contact
	where ParentLocation=@location
		and Available=1
		and instrument=@instrument


END