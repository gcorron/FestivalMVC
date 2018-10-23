-- =============================================
-- Author:		Greg C.
-- Create date: 10/23/2018
-- Description:	Decode status
-- =============================================
CREATE FUNCTION EntryStatus(@status char(1))
RETURNS varchar(20)
AS
BEGIN
	-- Add the T-SQL statements to compute the return value here
	return case @status
		when '-' then 'Unpaid'
		when 'P' then 'Paid'
		when 'S' then 'Submitted'
		when 'A' then 'Approved'
		when '?' then 'Rejected'
		when 'R' then 'Resubmitted'
		when 'C' then 'Complete'
		else '???' end
END