-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[AwardCup]
(
	-- Add the parameters for the function here
	@awardpoints tinyint, @accumulatedpoints tinyint
)
RETURNS tinyint
AS
BEGIN

declare @threshA tinyint=30
declare @threshB tinyint=20
declare @threshC tinyint=10
declare @newtotal tinyint=@awardpoints+@accumulatedpoints
declare @adjustedAccum tinyint=@accumulatedpoints+1 --if they are right on the threshhold, then they won last time!

	if @threshC between @adjustedAccum and @newtotal
			return 1

	if @threshB between @adjustedAccum and @newtotal
			return 2

	if @threshA between @adjustedAccum and @newtotal
			return 3

	return 0

END