-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SelectContactForAccount @userName nvarchar(10)
AS
BEGIN
	select Id, LastName,firstname, email, phone 
		from Contact
	where UserName=@userName
END