
CREATE PROCEDURE [dbo].[DeleteSchedule] @id int
AS
BEGIN
	declare @ev int



	select @ev=event
	from judge a inner join schedule b
	on a.id=b.judge
	where b.id=@id

	delete schedule where id=@id

	exec SelectJudgeScheduleForEvent @ev

END