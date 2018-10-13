CREATE procedure [dbo].[SelectScheduleSetupData] @ev int
as

-- this query returns a summary of unscheduled entries grouped and sorted by classtype and audition minutes
-- it allows the chair to allocate more judging time as needed

select coalesce(c.typeName,'Grand Total') classTypeDesc, coalesce(convert(varchar(10),a.auditionminutes),'Total') auditionMinutes, sum(a.auditionminutes) totalminutes, count(a.auditionminutes) as number
from eventclass a inner join entry b
on a.classabbr=b.classabbr
inner join eventclasstype c on a.classtype=c.classtype
where b.event=@ev and b.id not in (select id from audition)
group by c.typeName,a.auditionminutes
with rollup;

exec SelectJudgeScheduleForEvent @ev