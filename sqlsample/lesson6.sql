/** Procedure*/
-- Ví dụ 1: lấy ra output là department_name từ input là department_id 
delimiter $$ 
create procedure get_dept_name (in dept_id int, out dept_name varchar(50))
	begin 
		select department_name into dept_name from department where department_id = dept_id ; 
	end $$
delimiter ;

set @dept_name = '0';
select @dept_name;
call get_dept_name(2, @dept_name);
select @dept_name;

-- Ví dụ 2: hiển thị thông tin về câu hỏi từ input là email và username của account; 
delimiter $$
create procedure get_question_from_account_info(in email_input varchar(50), in username_input varchar(30))
	begin
		select q.* from account a join question q on a.account_id = q.creator_id 
		where email = email_input and username = username_input;
	end $$
delimiter ;
call get_question_from_account_info('ducanht1108@gmail.com', 'anh.tranduc');

-- Ví dụ 3: lấy ra output về câu hỏi: question_id, contentt từ input là email và username của account;  
delimiter $$
create procedure get_questionid_content_from_account_info(in email_input varchar(50), in username_input varchar(30), out question_id_output int, out content_output varchar(1000))
	begin
		select q.question_id, q.content into question_id_output, content_output
        from account a join question q on a.account_id = q.creator_id 
		where email = email_input and username = username_input;
	end $$
delimiter ;
set @question_id_output = 0;
set @content_output = 'content_output';
select @question_id_output, @content_output;
call get_questionid_content_from_account_info('ducanht1108@gmail.com', 'anh.tranduc', @question_id_output, @content_output);
select @question_id_output, @content_output;

-- ví dụ 4: chỉ hiển thị thông tin username và fullname liền nhau của account khi đã biết input là account_id 
select concat('Nguyễn', ' ', 'An', ' ', '1994') as my_name;
-- drop procedure if exists get_username_fullname_by_accountId;
delimiter $$
create procedure get_username_fullname_by_accountId(in accountId_input int)
	begin
		declare info_name varchar(134);
		select concat(username, ' || ', fullname) into info_name from account where account_id = accountId_input ;
        select info_name;
	end $$
delimiter ;
call get_username_fullname_by_accountId(1003);

-- hàm lấy ra tháng
select month('2022-03-27') as m;
-- hàm lấy ra năm
select year('2022-03-27') as y;
-- hàm lấy ra tháng hiện tại
select month(date(now())) as m;
select now() as y;
select date(now()) as y;

-- ví dụ 5: update account có lương cao nhất về departmentId = 7
-- hàm tìm ra id có lương cao nhất (vì trong mysql k cho phép select cùng 1 bảng trong khi update chính bảng đó)
delimiter $$
create function max_salary_id() returns int 
	begin
		declare id int;
		select account_id into id from `account` where salary = (select max(salary) from `account`);
        return id;
	end $$
delimiter ;
-- procedure : update account có lương cao nhất về departmentId = 7
drop procedure if exists update_max_salary_to_department;
delimiter $$
create procedure update_max_salary_to_department (in dept_id int) 
	begin 
		update `account` set department_id = dept_id where account_id = max_salary_id();
    end $$ 
delimiter ;
call update_max_salary_to_department(7);
SET SQL_SAFE_UPDATES = 0;
-- update `account` set department_id = 7 where account_id = max_salary_id(); 


/** ----------------------------------------------------- */
SET GLOBAL log_bin_trust_function_creators = 1;
/** Function */

alter table `account` add salary float;
update  `account` set salary = 10000000 where account_id between 1000 and 1013;
update  `account` set salary = 8000000 where account_id = 1014;

-- ví dụ 1: tính lương trung bình của nhân viên 
delimiter $$
create function avg_account_salary() returns float 
	begin
		declare avg_salary float;
		select avg(salary) into avg_salary from `account`;
        return avg_salary;
	end $$
delimiter ;
select avg_account_salary();

-- ví dụ 2: tạo hàm tính tổng a + b = c
-- drop function if exists my_sum_func;
delimiter $$
create function my_sum_func(a int, b int) returns int 
	begin
		declare c int;
		select a + b into c;
        return c;
	end $$
delimiter ;
-- ví dụ 2: sử dụng hàm tính tổng a + b = c
create table student(
	id int primary key,
    math float,
    english float
);
insert into student values (1, 10, 8), (2, 9, 7); 
select *, my_sum_func(math, english) from student;
update student set math = my_sum_func(math, english) where id = 1;


/** ----------------------------------------------------- */
/** Optional JOIN */ 
delete from `group` where creator_id in (select account_id from `account` where department_id = 8); 
delete from `account` where department_id = 8;
delete from department where department_id = 8;

update `account` set department_id = null where department_id = 7;
update department set department_id = 700  where department_id = 7;
update `account` set department_id = 700 where account_id = 1001;

create table class(
	id int primary key,
    `name` varchar(50)
);
create table student(
	id int primary key,
    `name` varchar(50),
    class_id int,
    foreign key (class_id) references class(id) on update set null on delete set null
    -- on update set null on delete set null
);

/**Bai tap assignment*/
-- bai 4 
delimiter $$
create procedure max_typeid_question (out typeid_output int)
	begin 
		select type_id into typeid_output from question q group by type_id
		having count(*) = (select count(*) as so_luong from question group by type_id order by so_luong desc limit 1 ) ;
	end $$
delimiter ;

set @typeid_output = 0;
call max_typeid_question(@typeid_output);
select @typeid_output;
-- Question 5 
select * from type_question where type_id = @typeid_output;

/*
-- bài 6 
Viết 1 store cho phép người dùng nhập vào 1 chuỗi -- => in varchar_input varchar 
và trả về group có tên  -- => bảng group, group_name 
chứa chuỗi của người dùng nhập vào  group_name like concat('%', varchar_input, '%') -- '%CLB%'
 
 hoặc UNION 
 
 hoặc trả về user có username chứa -- bảng account, username 
 chuỗi của người dùng nhập vào  username like concat('%', varchar_input, '%')
*/
select group_name from `group` where group_name like '%CLB%';
select group_name from `group` where group_name like concat('%', 'CLB', '%');
select group_name from `group` where group_name like '%CLB%'
union
select username from `account` where username like '%CLB%';
-- Question6
delimiter $$
create procedure find_groupname_username (in `name` varchar(50))
	begin 
		select group_name from `group` where group_name like concat('%',  `name`, '%')
		union
		select username from `account` where username like concat('%',  `name`, '%');
	end $$
delimiter ;



