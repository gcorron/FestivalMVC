
CREATE PROCEDURE SelectDataForGeneratingSchedule @ev int
AS
BEGIN
select a.id, classtype,prefhighlow,
 starttime, starttime as auditiontime, minutes as minutesremain
from schedule a inner join judge b
on a.judge=b.id
where b.event=@ev

select id,a.classtype,auditionminutes, 0 as schedule, null as auditionTime
from entry a inner join eventclass b
on a.classabbr=b.classabbr
where a.event=@ev

--also clear out the auditions, they will be recreated
delete a from audition a inner join entry b
on a.id=b.id
where b.event=@ev

END