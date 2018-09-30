CREATE procedure [dbo].[UpdateStudent] @id int, @instrument char(1), @teacher int, @birthdate smalldatetime,
	@phone varchar(20), @lastname nvarchar(50),@firstname nvarchar(50)
as

if @Id=0
BEGIN
	insert student (instrument, teacher, birthdate,phone,lastname,firstname)
		values(@instrument, @teacher, @birthdate, @phone, @lastname,@firstname)
	set @id=SCOPE_IDENTITY()
END
else
BEGIN
	update student
		set teacher=@teacher, birthdate=@birthdate, phone=@phone, lastname=@lastname, firstname=@firstname
	where id=@id
END
select @id as Id