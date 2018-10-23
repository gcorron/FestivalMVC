CREATE procedure [dbo].[ReportStudentStats] @location int
as
-- recursive table expression to find all districts downline from given location
;WITH ctelocation AS
(
    SELECT @location as id
    UNION ALL
    SELECT location.id
    FROM location inner join ctelocation
		on parentlocation=ctelocation.id
		where location.locationtype<='E'
)
SELECT q.locationname as region, p.locationname as area, l.locationname as district,
	(select count(*) from entry where event=e.id and status='C') as entries
FROM ctelocation c inner join location l
	on c.id=l.id
inner join location p
	on l.ParentLocation=p.id
inner join location q
	on p.ParentLocation=q.id
inner join event e 
	on e.Location=l.id
where l.LocationType='E'
order by region,area,district