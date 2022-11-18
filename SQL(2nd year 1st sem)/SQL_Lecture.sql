/*In class activity
 SQL revision*/


/*Create the Emp table*/
Create table emp
(
   eid integer,
   ename varchar(50) not null,/*Employee name can not be null*/
   age integer,
   salary real,
   primary key(eid),  
)

ALTER TABLE emp add constraint chk_sal CHECK (salary>0)/*Employee’s salary should be greater than zero*/

/*Create the dept table*/
Create table dept
(
   did Varchar(10),
   budjet real,
   managerid integer,
   primary key(did),
)
/*Create the work table with the required foreign key constraints*/
Create table works/*Relationship*/
(
   eid integer,
   did varchar(10),
   pct_time integer,
   constraint works_pk primary key (eid,did),
   /*primary key of emp is foreign key of works*/
   constraint works_emp_fk foreign key(eid) references emp,
   /*primary key of dept is foreign key of works*/
   constraint works_depet_fk foreign key(did) references dept,
   

)

select *
from emp
/*insert values into every column in a row*/
insert into emp values(1000,'Ruwan',33,40000);

/*insert values into specific columns in a row*/
/*insert into  emp(eid,ename,age,salary) values (1000,'Ruwan',33,40000);*/

alter table emp drop column hireDate

Alter table emp add hireDate date default getdate()

select getdate()/*get current date*/

insert into  emp(eid,ename,age,salary) values (1000,'Ruwan',33,40000)
insert into emp(eid,ename,age,salary) values (1005,'Samadhi',26,50000)
insert into emp(eid,ename,age,salary) values (1001,'Bhagya',26,50000)
insert into emp(eid,ename,age,salary) values (1002,'Kavishka',26,1000000)
insert into emp(eid,ename,age,salary) values (1003,'Thisara',25,1000000)


update emp set age = 26
where eid = 1001

update emp set age = 26
where eid = 1002

update emp set age = 25
where eid = 1003

update emp set age = 29
where eid = 1001

select *
from emp

/*update value in a table*/
update emp set hireDate = '1-Jan-2010' 
where eid = 1000

/*Delete the row inserted in question 4*/
delete emp 
where eid = 1000

/*We cant do this before drop the constraint in table that has a replationship with this table*/
alter table emp 
drop column hireDate
/*drop the constraint*/
alter table emp drop constraint DF__emp__hireDate__2B3F6F97

/*we cant drop this table before drop the foreign key constraint of another table that has relationsship with this*/
drop table emp


select ename, salary
from emp;

select ename, salary 
from emp
order by salary desc

select ename, salary
from emp
where salary > 50000

select ename
from emp
where ename like 'S%'

select *
from emp

select * 
from dept

select *
from works

select d.did, e.ename 
from dept d, emp e
where d.managerid = e.eid

select e.ename, d.managerid
from emp e, works w, dept d
where e.salary > 75000 and e.eid = w.eid and w.eid = d.did

/*Using in operator*/
select e.ename
from emp e
where e.eid in (select managerid
from dept
where budjet > 90000)

/* Display the names of employees who are not assigned to any department yet*/
select e.ename
from emp e
where e.eid not in (select managerid
from dept)

/*Display the minimum and maximum salary of employees.*/
select max(salary) as 'maximum salary', min(salary) as 'Minimum salary'
from emp

/*Display the employees’ name and the total percentage he/she has worked in total.*/
select e.ename,  sum(w.pct_time) as 'Total'
from emp e, works w
where e.eid = w.eid
group by e.ename , e.eid

select *
from dept

select *
from works

/*Display the department id and the number of employees in each department*/
select d.did, count(e.eid) 'No of employees'
from emp e, dept d 
where e.eid = d.managerid
group by d.did

/*Display the names of the employee who work more than 6 pct_time.*/

select e.ename
from emp e, works w
where e.eid = w.eid  and  w.pct_time > 6


insert into dept(did, budjet, managerid) values ('d1005',5000,1002)
/*maximum budjet og the all the total budjets*/
select managerid, max(budjet) as 'Max Budjet'
from dept
group by managerid
having  sum(budjet) >= All (select SUM(budjet)
from dept 
group by managerid)





