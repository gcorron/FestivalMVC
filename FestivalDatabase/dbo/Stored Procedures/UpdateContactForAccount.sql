-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateContactForAccount] @id int, @firstname nvarchar(50), @lastname nvarchar(50), @email nvarchar(50), @phone nvarchar(50)
	AS
BEGIN
	declare @username nvarchar(10)
	declare @message varchar(50)

	select @username=username
	from contact
	where id=@id

	if @username is null
	BEGIN
		RAISERROR('Missing row in table contact!',11,1,'UpdateContactForAccount') 
	END

	BEGIN TRANSACTION
		update contact
			set email=@email, phone=@phone, firstname=@firstname, lastname=@lastname
		where id=@id
		update aspnetusers
			set email=@email, phonenumber=@phone
		where username=@username

	COMMIT TRANSACTION
END