-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectDataForChairLocation] @location int
AS
BEGIN


set nocount off

-- everything needed for first three steps

	select id, userName, lastName,firstName, email, phone, available,instrument 
	from Contact
	where ParentLocation=@location and Available=1

	select id, openDate, closeDate,eventDate,instrument,status from event
	where location=@location and status<>'H' --history, previous years events

	select event,teacher from teacherevent -- this table is purged - no history kept, just for enrollment phase
	where location=@location







END