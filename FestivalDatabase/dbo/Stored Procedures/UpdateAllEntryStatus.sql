CREATE PROCEDURE UpdateAllEntryStatus @ev int, @teacher int, @status char(1)
AS

Update entry
set status=@status
where event=@ev and teacher=@teacher and status<>@status