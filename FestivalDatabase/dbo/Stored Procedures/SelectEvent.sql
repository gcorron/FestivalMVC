﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectEvent] @id int 
AS
BEGIN

	select id, location,openDate, closeDate,eventDate,instrument,status,classTypes,
		venue,notes
			from event
	where id=@id

	select a.instrument from instrument a inner join event b
		on a.id=b.instrument
	where b.id=@id


END