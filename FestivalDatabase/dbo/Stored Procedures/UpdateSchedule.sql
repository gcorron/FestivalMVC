CREATE PROCEDURE [dbo].[UpdateSchedule] @id int, @judge int, @startTime smalldatetime, @minutes smallint, @classType char(1), @prefHighLow char(1)
	
AS
BEGIN
	update schedule set judge=@judge, starttime=@starttime, minutes=@minutes, classtype=@classtype, prefHighLow=@prefHighLow
	where id=@id
	
	if @@rowcount=0
		insert schedule(judge,starttime,minutes,classtype,prefHighLow)
		values(@judge,@starttime,@minutes,@classtype,@prefHighLow)

	declare @ev int
	select @ev=event
	from judge
	where id=@judge

		exec SelectJudgeScheduleForEvent @ev
END