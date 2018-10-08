
CREATE PROCEDURE SelectPiecesForClassAbbr @classAbbr varchar(10)
AS
BEGIN
	select Id,Composition,Composer,Extension
	from piece
	where classAbbr=@classAbbr
END