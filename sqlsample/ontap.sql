create table `student`(
	id int primary key auto_increment,
    `name` varchar(50),
    gender enum('F','M','Unknown') default 'Unknown',
    country varchar(50) default 'Viet Nam',
    age int default 18,
    gpa float default 2.1,
    create_date date default (date(now())),
	check (age >=18)
);
insert into `student`(name) values ('Nguyen');
select * from student;

select * from account where account_id between 1000 and 1005;
select * from account where account_id =1001 or salary = 30000000 ;
select * from account where account_id not in (1000, 1001, 1003, 1008);
select * from account where email like 'manhtu.cau@gmail.com';
select count(1) from account where salary = 10000000 ;
select * from account limit 3;
select max(account_id), department_id from account group by department_id ;
select count(distinct(salary)) from account;
select max(account_id), department_id from account group by department_id ;
select count(*), department_id, position_id from account group by department_id, position_id 
having count(*) >= 2
;

select * from account order by department_id desc, position_id asc;
insert into department values (10, 'Ten gi cung duoc'), (11, 'Ten gi cung duoc');
update department set department_name = 'Hanh chinh' where department_id =11;
delete from department where department_id = 10;
-- xóa exam_id = 2
delete from exam_question where exam_id = 2;
delete from exam where exam_id = 2;

-- sửa exam_id = 1 thành 1000 
update exam_question set exam_id = null where exam_question_id = 2; 
update exam set exam_id = 1000 where exam_id = 1; 
update exam_question set exam_id = 1000 where exam_question_id = 2; 

delimiter $$
create trigger update_cascade_exam_question 
before update on `exam` for each row 
begin
	update exam_question set exam_id = new.exam_id where exam_id = old.exam_id;
end $$
delimiter ;
-- 
select * from class, student ;
select * from class cross join student ;

select * from account a cross join department d where a.department_id = d.department_id;
select * from account a inner join department d on a.department_id = d.department_id;