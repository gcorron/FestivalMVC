-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION AwardPoints 
(
	@rating char(1)
)
RETURNS tinyint
AS
BEGIN
	return case @rating when 'S' then 4 when 'E' then 3 when 'G' then 2 when 'F' then 1 else 0 end

END