CREATE procedure [dbo].[SelectScheduleSetupData] @ev int
as

-- this query returns a summary of unscheduled entries grouped and sorted by classtype and audition minutes
-- it allows the chair to allocate more judging time as needed

select coalesce(c.typeName,'Total Unscheduled Minutes') classTypeDesc,
	sum(a.auditionminutes) totalminutes,
	count(a.auditionminutes) as number
from eventclass a inner join entry b
on a.classabbr=b.classabbr
inner join eventclasstype c on a.classtype=c.classtype
where b.event=@ev and b.id not in (select id from audition)
group by c.typeName
with rollup;


-- summary of currently scheduled entries
select lastname,firstname,phone,classabbr,b.classtype,isnull(name,'- - -') as judgeName,auditiontime
	from entry b left outer join audition a
	on a.id=b.id
		inner join student c
		on b.Student=c.id
		left outer join schedule d
		on a.Schedule=d.Id
		left outer join judge e
		on d.Judge=e.id
	where b.Event=@ev
	order by auditiontime

exec SelectJudgeScheduleForEvent @ev