CREATE PROCEDURE copyToShadowTables
AS

-- copy into shadow tables

set rowcount 0

drop table if exists __aspnetusers;
select * into __aspnetusers from aspnetusers;

drop table if exists __audition;
select * into __audition from audition;

drop table if exists __contact;
select * into __contact from contact;

drop table if exists __entry;
select * into __entry from entry;

drop table if exists __entrydetails;
select * into __entrydetails from entrydetails;

drop table if exists __event;
select * into __event from event;

drop table if exists __entry;
select * into __entry from entry;

drop table if exists __history;
select * into __history from history;

drop table if exists __judge;
select * into __judge from judge;

drop table if exists __location;
select * into __location from location;

drop table if exists __schedule;
select * into __schedule from schedule;

drop table if exists __student;
select * into __student from student;

drop table if exists __teacherevent;
select * into __teacherevent from teacherevent;