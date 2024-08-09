select * from worker;
select  *from bonus;
select * from title;

select  upper(first_name) from worker;   #'Upper case'
select distinct(department) from worker #unique department
select substring(first_name,1,3),first_name from worker;  #first 3 character
select  locate('a',first_name,2) as 'Name' from worker where first_name='Amitabh' #position of a
select distinct(department), length(department) from worker #distince & length
select * from worker order by first_name asc, department desc  #asc,desc
select * from worker where first_name in ('Vipul', 'satish') #firstname in vipul and satish
select * from worker  where first_name like '%a%'  #firstname contain a
select * from worker where first_name like '%h' and length(first_name)=6 #firstname contain six character and end with chr h
select * from worker where salary between 100000 and 500000 #salary between 100000 and 500000
select * from worker where date_format(joining_date,'%y%m')='1402' #date of join in feb 2014
select count(department) as 'No of Dept' from worker where department='admin' #count of Admin department
select count(worker_id) as 'No of workers' ,department from worker group by department order by count(worker_id) desc  #count of workers in each dept
select concat(w.first_name, ' ', w.last_name)  as 'Name' from worker w 
 join title t on w.worker_id =t.worker_ref_id where t.worker_title='Manager'
 with dp as (select worker_title, row_number() over(partition by worker_title  ) as rowcnt from   title)
 select distinct(worker_title) from dp where rowcnt > 1
 select  concat(w.first_name, '', w.last_name) as 'Name', b.bonus_amount
 from worker w join  bonus b on w.worker_id= b.worker_ref_id
 select  concat(w.first_name, '', w.last_name) as 'Name', w.worker_id
 from worker w where w.worker_id not in (select worker_ref_id from bonus)
select  *from worker order by salary desc limit 1,2
with dp as (select first_name,salary, dense_rank() over( order by salary desc  ) as highsalary from   worker)
#select dp.first_name from dp where dp.salary in (select salary from dp group by salary having count(highsalary) > 1)  #people have the same salary
 #2nd highest without using TOP or LIMIT
select  * from dp where highsalary=2
select  * from worker order by worker_id asc limit 1; #display 1 record
select  * from worker order by worker_id desc limit 1 #display last record
select  * from worker order by worker_id desc limit 5  #display last 5 records
 
 #with dp1 as(select worker_id, dense_rank() over(order by worker_id) as rownum from worker)
 #select worker_id,count(rownum) as rr from dp1 group by worker_id having rr  = count(rownum))
  
  #earn the highest salary
  with dp as (select first_name,salary, dense_rank() over( order by salary desc  ) as highsalary from   worker)
select * from dp order by highsalary desc limit 1

# highest salary in each group 
  with dp2 as (select max(salary) as 'salary',department from worker group by department)
 select w.first_name,w.department from worker w join dp2 on w.salary=dp2.salary and w.department=dp2.department # where salary in (select salary from dp2) and department in (select department from dp2)


select * from worker
#total salaries paid for each of them
select sum(salary) as 'Total salary', department from worker group by department
#more than 3 people in worker table
with dp4 as (select  count(worker_id) as cnt, department  from worker group by department having cnt >3)
select w.first_name from worker w join dp4 on w.department=dp4.department
