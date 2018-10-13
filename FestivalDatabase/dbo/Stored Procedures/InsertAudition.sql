create procedure InsertAudition @id int, @schedule int, @auditiontime smalldatetime
	AS
	insert audition (id,schedule,auditiontime, awardrating)
		values(@id,@schedule,@auditiontime, '-');