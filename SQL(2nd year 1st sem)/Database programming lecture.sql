Create view emp_info 
as
select d.did, d.budjet, e.ename
from dept d, emp e
where d.managerid = e.eid

select *
from dept

select *
from works



select *
from emp

select *
from emp_info
where budjet > 60000


update emp_info set budjet = 100000
where did = 'd1002'

CREATE VIEW emp_info_2(EID, Name, Salary, Work_pct)
as
select e.eid, e.ename, e.salary, sum(w.pct_time)
from emp e, works w
where w.eid = e.eid
group by e.eid, e.ename, e.salary

select *
from emp_info_2

declare @eid int
set @eid = 1002
select *
from emp
where eid = @eid

declare @emid int
set @emid = 1002
declare @sal real
select @sal = salary 
from emp
where eid = @emid
if @sal>50000
begin
   print 'Inside the if condition'
   print 'Salary is grater than 50000'
end
else
   print 'Salary is less than or equal to 50000'

declare @count int
while @count <= 100
Begin
   insert into emp values(@count, CONCAT('ename',@count))
   set @count = @count + 1
ENd



create function getEmpCount(@did varchar(15)) returns int
as 
begin
declare @cnt int
select @cnt=count(*)
from works
where did = @did

return @cnt
end

declare @c int
exec @c = getEmpCount 'Thisara'
print @c

create function getEmpInfo(@eid int) returns int
as 
begin 
declare @tot int
select @tot=SUM(pct_time)
from works
where eid = @eid
return @tot
end

declare @t int
exec @t = getEmpInfo 1002
print @t
drop procedure getManagerSalary
create procedure getManagerSalary(@did varchar(15)output,@name varchar(20) output, @salary real output)
as 
begin

select @name = e.ename , @salary = e.salary
from emp e, dept d
where e.eid = d.managerid and d.did = @did

end

declare @n varchar(20)
declare @s real
exec getManagerSalary 'd1003', @n output, @s output
print @n
print @s

select *
from dept

/* trigger test is automatically execute the ensert, update, delete to emp table*/
create trigger test
on emp
for insert, update, delete
as
begin

end

select *
from works

update works set pct_time = 60 
where eid = 1001

update works set pct_time = 80
where eid = 1002

update works set pct_time = 100 
where eid = 1005

select *
from works

select * 
from dept

select *
from emp

update dept set did='Academic'
where managerid = 1005

ALTER TABLE works drop constraint works_depet_fk

update dept set did='Academic'
where managerid = 1006
update dept set did='Admin'
where managerid = 1006
update dept set did='ITSD'
where managerid = 1009
update dept set did='Finance'
where managerid = 1001
update dept set did='ITSD'
where managerid = 1002
 

 update works set did='Finance'
where eid = 1001
update works set did='Admin'
where eid = 1002
update works set did='Academic'
where eid = 1005

delete dept
where did = 'd1002'
delete dept
where did = 'd1005'

ALTER TABLE works ADD constraint works_depet_fk foreign key(did) references dept

insert into works values (1002, 'ITSD',20)
insert into works values (1001, 'Admin',30)

/*create trigger ensure that employee doesn't work more than 100% */
create trigger check_pct_time
on works
for insert, update
as
begin
declare @tot int
declare @eid int
select @eid=eid from inserted/*by using the eid we can check the total percentage time of that employee*/
select @tot=sum(pct_time)
from works
where eid = @eid

if(@tot>100)
begin
  print 'Can not work more than 100'
  rollback transaction
end
end

update works set pct_time = 20
where eid = 1001

update works set pct_time = 80
where eid = 1001

insert into works values (1001,'ITSD',50)
insert into works values (1005,'ITSD',50)

create trigger check_emp_sal
on emp
for insert, update
as 
begin
declare @esal int /*variable to get employee salary*/
declare @msal int /*variable to get manager salary*/
declare @dno int
select @esal=salary, @dno=eid  from inserted
select @msal=e.salary
from emp e, dept d
where d.did = @dno and d.managerid = e.eid
if(@esal>@msal)
begin
   print 'Employee salary can not exceed manager salary'
   rollback transaction
end
end  



