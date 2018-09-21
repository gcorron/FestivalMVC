CREATE PROCEDURE [dbo].[UpdateContact]
	@id int, @userName nvarchar(10), @lastName nvarchar(50), @firstName nvarchar(50),
	 @email nvarchar(50), @phone nvarchar(50), @parentLocation int, @available bit, @instrument char(1)
		
AS
	declare @locationType char(1)
	declare @role nvarchar(128)
	declare @userId nvarchar(128)

	if @id=0
	BEGIN

		select @userId=Id from aspnetusers
		where @userName=userName
		if @userId is null
		BEGIN
			raiserror('Person not found on server!', 11,1,'UpdateContact')
		END

		select @locationtype=locationtype
		from location
		where id=@parentlocation

		if @locationtype is null
		BEGIN
			raiserror('Parent location not found on server!', 11,1,'UpdateContact')
		END
		set @role=case @locationType when 'A' then '1' when 'B' then '1' when 'C' then '1' when 'D' then '2' when 'E' then '3' end
		if @role is null
		BEGIN
			raiserror('Parent location type is not valid!', 11,1,'UpdateContact')
		END

		BEGIN Transaction
		insert Contact (userName, lastName, firstName,email,phone,parentLocation,available, instrument)
			values(@userName,@lastName,@firstName,@email,@phone,@parentLocation,@available,@instrument)
		
		set @id=SCOPE_IDENTITY()
		
		-- add to asp role based on the parent location type
		insert aspnetuserroles(userId, RoleId) values(@userId,@role)

		commit transaction
		
		select @id as Id
	END
	
	else
	
	BEGIN
		declare @existingusername nvarchar(128), @existingemail nvarchar(50)


		select @existingusername=username, @existingemail=email
			from contact
		where id=@id
			if @@ROWCOUNT=0
				raiserror('Person not found on server!', 11,1,'UpdateContact')

		 
		begin transaction

			update Contact
				set LastName=@lastName, FirstName=@firstName, Email=@email,
					Phone=@phone, Available=@available, Instrument=@instrument
				where Id=@id
			
			if @existingemail<>@email
			BEGIN
				update aspnetusers
					set email=@email
				where username=@existingusername
			END
		commit transaction

		select  @id as Id
	END