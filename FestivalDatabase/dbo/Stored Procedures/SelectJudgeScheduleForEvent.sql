CREATE PROCEDURE [dbo].[SelectJudgeScheduleForEvent] @ev int
AS

-- returns all the time blocks allocated for the judges in this event
select a.id,judge,starttime,minutes,prefhighlow,classtype
from schedule a inner join judge b
on a.judge=b.id
where b.event=@ev
order by starttime,judge

--returns judges for this event
select id,[name]
from judge
where event=@ev