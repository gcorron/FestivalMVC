-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectEventsForDistrict] @location int
AS
BEGIN


set nocount off


	select id, location, openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where location=@location and status<>'H' --history, previous years events
	order by eventDate

	select id, instrument from instrument

	select * from location
	where id=@location

END