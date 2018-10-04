CREATE PROCEDURE UpdateEntryPaid @ev int, @teacher int, @totalAmt decimal(9,2)
AS
BEGIN



---- calculate the total --------

declare @count int, @amountDue decimal(9,2)
declare @message varchar(100)

set @amountDue=0

	select @count=count(*),@amountDue=sum(0.96*auditionMinutes + 10)
		from entry a inner join eventClass b
			on a.classabbr=b.classabbr
		where event=@ev and teacher=@teacher and status='-'

set @message='?'


if @totalAmt>0 and @totalAmt<>@amountDue
	set @message='Cannot process payment - calculated amount is ' + convert(varchar(10),abs(@totalAmt-@amountDue)) + ' different from original.'

if @count=0
	set @message='No entries are awaiting payment.'


if @totalAmt>0 and @message='?'
BEGIN
	update entry set status='P'
		where event=@ev and teacher=@teacher  and status='-'
	set @message='Thank you. Your payment has been processed.'
END

select @count as entries, @amountDue as amountDue, @message as message
	
END