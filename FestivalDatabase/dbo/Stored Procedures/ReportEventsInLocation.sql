create procedure ReportEventsInLocation @location int
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
SELECT q.locationname as region, p.locationname as area, l.locationname as district
	, isnull(convert(varchar(20),eventdate,101 ),'') as eventdate
	, isnull(i.instrument,'') as instrument,case isnull(e.status,'N') when 'N' then '< No events >' when 'D' then 'Complete' else '' end as complete,
	(select count(*) from entry where event=e.id) as entries
FROM ctelocation c inner join location l
	on c.id=l.id
inner join location p
	on l.ParentLocation=p.id
inner join location q
	on p.ParentLocation=q.id
left outer join event e 
	on e.Location=l.id
left outer join instrument i
	on e.Instrument=i.Id
where l.LocationType='E'
order by region,area,district