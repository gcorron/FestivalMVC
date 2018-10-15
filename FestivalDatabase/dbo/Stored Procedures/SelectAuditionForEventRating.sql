CREATE PROCEDURE [dbo].[SelectAuditionForEventRating] @ev int
AS
BEGIN
	select a.id, firstname + ' ' + lastname as StudentName, classtype,classabbr, awardrating
	from audition a inner join entry b
		on a.id=b.id
		inner join student c
		on b.Student=c.id
	where b.Event=@ev
	order by classtype,lastname,firstname


END