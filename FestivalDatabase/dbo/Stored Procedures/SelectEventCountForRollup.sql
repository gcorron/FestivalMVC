CREATE procedure SelectEventCountForRollup
as

select count(*) as number from event
where datediff(d,eventdate,getdate())>36 -- allow 6 weeks after event for any corrections
and status='D'