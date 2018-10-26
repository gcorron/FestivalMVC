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

	select a.id,a.parentlocation,a.locationtype,b.locationname + ': ' + a.locationname as locationname,a.contactid
		from location a inner join location b
			on a.ParentLocation=b.id
	where a.id=@location


END