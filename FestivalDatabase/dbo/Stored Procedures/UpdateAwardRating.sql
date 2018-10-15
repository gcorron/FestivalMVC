
CREATE PROCEDURE UpdateAwardRating @id int, @awardRating char(1)
as

update audition set awardrating=@awardrating
where id=@id

update entry set status='C'
where id=@id