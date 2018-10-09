CREATE PROCEDURE [dbo].[UpdateEntryDetails] @id int, @requiredpiece int, @requiredExtension char(1), @choicePiece nvarchar(50), 
	@choiceComposer nvarchar(50), @publisher nvarchar(20), @accompanist nvarchar(50), @notes nvarchar(50)
as

update entrydetails
	set requiredpiece=@requiredpiece, requiredextension=@requiredextension, choicepiece=@choicepiece,
	choicecomposer=@choicecomposer, publisher=@publisher, accompanist=@accompanist, notes=@notes
where id=@id

if @@rowcount=0
begin
	insert entrydetails (id, requiredpiece,requiredextension, choicepiece,choicecomposer,publisher,accompanist, notes)
	values (@id, @requiredpiece, @requiredextension,@choicepiece, @choicecomposer,@publisher, @accompanist, @notes)
end