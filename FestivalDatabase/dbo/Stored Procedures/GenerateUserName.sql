
CREATE PROCEDURE [dbo].[GenerateUserName] @seed varchar(10) 
AS
BEGIN
	declare @userName nvarchar(256)
	declare @suffix nvarchar(10)
	declare @suffixstart smallint
	declare @suffixnum int

	-- validate seed first
	if not (@seed not like '%[^A-Z]%')
	BEGIN
		RAISERROR('Argument not alphabetic',11,1,'GenerateUserName')
	END

	-- make it lower case
	set @seed=lower(@seed)

	-- find the maximum suffix int used with this seed
	set @suffixstart=LEN(@seed)+1
	
	select @userName=max(UserName) from AspNetUsers
	where UserName like @seed + '[0-9][0-9][0-9][0-9]'


	if @userName is null
	BEGIN
		select @seed + '1000' as ret
		return
	END

	set @suffix=substring(@userName,@suffixstart,4)

	set @suffixnum=CONVERT(int,@suffix)

	select @seed + CONVERT(varchar(10),@suffixnum) as UserName


END