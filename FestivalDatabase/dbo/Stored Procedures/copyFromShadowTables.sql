CREATE PROCEDURE [dbo].[copyFromShadowTables]
AS
-- copy fresh data from shadow tables into regular tables
set rowcount 0
exec sys.sp_MSforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

delete aspnetuserroles
insert aspnetuserroles select * from __aspnetuserroles

delete aspnetusers
insert aspnetusers select * from __aspnetusers

delete audition
insert audition select * from __audition

delete contact
SET IDENTITY_INSERT contact ON
insert contact(id,username,lastname,firstname,email,phone,parentlocation,available,instrument) select * from __contact
SET IDENTITY_INSERT contact OFF

delete entry
SET IDENTITY_INSERT entry ON
insert entry(id,event,teacher,student,classtype,classabbr,status) select * from __entry
SET IDENTITY_INSERT entry OFF

delete entrydetails
insert entrydetails select * from __entrydetails

delete event
SET IDENTITY_INSERT event ON
insert event(id,location,opendate,closedate,eventdate,instrument,status,venue,notes,classtypes) select * from __event
SET IDENTITY_INSERT event OFF

delete history
insert history select * from __history

delete judge
SET IDENTITY_INSERT judge ON
insert judge(id,event,name) select * from __judge
SET IDENTITY_INSERT judge OFF

delete location
SET IDENTITY_INSERT location ON
insert location(id,parentlocation,locationtype,locationname,contactid) select * from __location
SET IDENTITY_INSERT location OFF

delete schedule
SET IDENTITY_INSERT schedule ON
insert schedule(id,judge,starttime,minutes,classtype,prefhighlow) select * from __schedule
SET IDENTITY_INSERT schedule OFF

delete student
SET IDENTITY_INSERT student ON
insert student(id,instrument,teacher,birthdate,phone,lastname,firstname) select * from __student
SET IDENTITY_INSERT student OFF

delete teacherevent
insert teacherevent select * from __teacherevent

exec sys.sp_MSforeachtable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"