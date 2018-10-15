CREATE PROCEDURE [dbo].[RollupEvents] @testing bit
as
BEGIN
declare @eventid int, @eventdate smalldatetime

declare mycsr cursor for
select id,eventdate from event
where status='D'
and datediff(d,eventdate,getdate())>36 -- allow 6 weeks past event date until rollup, unless testing

open mycsr
fetch next from mycsr into @eventid, @eventdate

while @@FETCH_STATUS=0
BEGIN

	;with cte_history as (
		select
			e.student, e.classtype, @eventid as event,
			(select eventdate from event where id=@eventid) as eventdate, e.classabbr,
			a.awardrating,
			case a.awardrating when 'S' then 4 when 'E' then 3 when 'G' then 2 when 'F' then 1 else 0 end as awardpoints,
			isnull(h.consecutivesuperior,0) as consecutivesuperior,isnull(h.accumulatedpoints,0) as accumulatedpoints,
			DENSE_RANK() over (partition by h.student,h.classtype order by case when accumulatedpoints is not null then eventdate end desc) as rn
		from entry e inner join audition a
			on e.id=a.id
		left outer join history h
			on e.student=h.student and e.classtype=h.classtype
		where e.Event=@eventid
	)
	insert history (student,classtype,event,eventdate,classabbr,awardrating,awardpoints,consecutivesuperior,accumulatedpoints)
		select student,classtype,event,eventdate,classabbr,awardrating,awardpoints
		,consecutivesuperior+case when awardrating='S' then 1 else 0 end
		,accumulatedpoints+awardpoints
		 from cte_history
		where rn=1
	update event
		set status='H'
	where id=@eventid
	
fetch next from mycsr into @eventid, @eventdate
END
deallocate mycsr

if @testing=1 
	return

--now purge entrydetails, audition, entry, and judge for all events with status 'H'
declare mycsr cursor for
select id from event
	where status='H'
open mycsr
fetch next from mycsr into @eventid
while @@FETCH_STATUS=0
BEGIN
	delete entrydetails
	where id in (select id from entry where event=@eventid)

	delete audition
	where id in (select id from entry where event=@eventid)

	delete entry
	where event=@eventid

	delete judge
	where event=@eventid
	
fetch next from mycsr into @eventid
END
deallocate mycsr
END