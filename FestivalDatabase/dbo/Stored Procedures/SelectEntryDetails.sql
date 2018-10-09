
CREATE PROCEDURE [dbo].[SelectEntryDetails] @ev int, @teacher int
AS
BEGIN

DECLARE @entries TABLE(
    Id int NOT NULL,
    Student int NOT NULL,
	ClassType char(1) NOT NULL,
	ClassAbbr varchar(10) NOT NULL,
	Status char(1) NOT NULL
);

INSERT INTO @entries (Id, Student, ClassType, ClassAbbr,Status)
select id, student,classtype,classabbr,status
from Entry
where event=@ev and teacher=@teacher and status<>'-'

declare @classtypes varchar(5)
select @classtypes=classtypes
from event
where id=@ev

select distinct a.id,a.firstname,a.lastname from student a inner join @entries b
on a.id=b.student 


select classtype,typename,requireschoicepiece,RequiresAccomp
from eventclasstype
where charindex(classtype,@classtypes)>0

select * from @entries

select a.id, requiredPiece,RequiredExtension, ChoicePiece,ChoiceComposer,Publisher,Accompanist, Notes
from EntryDetails a inner join @entries b on a.id=b.id

select c.id, d.Composer + ' :' + c.Composition as RequiredDescription
from EntryDetails a inner join @entries b on a.id=b.id
 left outer join Piece c
 on a.RequiredPiece=c.Id
 left outer join Composer d
 on c.Composer=d.Id

exec SelectEvent @ev



END