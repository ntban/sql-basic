set @my_int = 1;
select @my_int ;
SET GLOBAL log_bin_trust_function_creators = 1;
show global variables where variable_name = 'log_bin_trust_function_creators' ;


create table account_history(
	id int primary key auto_increment,
    account_id int,
    action_name varchar(50),
    action_time datetime default now()
);
-- ví dụ: tạo trigger sau khi insert vào account thành công thì sẽ lưu lịch sử đã insert được vào bảng account_history
delimiter $$
create trigger account_history_insert 
after insert on `account` for each row 
begin 
	-- lưu lịch sử đã insert được vào bảng account_history
    insert into account_history(account_id, action_name) values (new.account_id, 'insert');
end $$
delimiter ;
insert into `account`(account_id, username, fullname) values (1020, 'ntba', 'an nguyen');

-- ví dụ: tạo trigger sau khi update vào account thành công thì sẽ lưu lịch sử đã update được vào bảng account_history
delimiter $$
create trigger account_history_update
after update on `account` for each row 
begin 
    insert into account_history(account_id, action_name) values (old.account_id, 'update');
end $$
delimiter ;
update `account` set username = 'anh.tranduc123' where account_id=1000;

-- ví dụ: tạo trigger sau khi delete account thành công thì sẽ lưu lịch sử đã delete được vào bảng account_history
delimiter $$
create trigger account_history_delete
after delete on `account` for each row 
begin 
    insert into account_history(account_id, action_name) values (old.account_id, 'delete');
end $$
delimiter ;
delete from `account` where account_id = 1020;

-- xem lại trigger đã tạo 
show triggers;

-- ví dụ: xóa question_id = 10000
delimiter $$ 
create trigger delete_question
before delete on question for each row
	begin 
		delete from exam_question where question_id = old.question_id;
	end $$
delimiter ;
delete from question where question_id = 10000;

-- question 3 : 
delimiter $$
create trigger max_5account_to_group 
before insert on group_account for each row
	begin
		declare so_luong int;
		select count(*) into so_luong from group_account 
		where group_id = new.group_id;
        if so_luong >= 5 then
			signal sqlstate '50000' set message_text = 'Đã đủ 5 user. không thể thêm nữa';
        end if;
	end $$
delimiter ;

insert into group_account (group_account_id, group_id, account_id) values (10, 203, 1014); -- lỗi
insert into group_account (group_account_id, group_id, account_id) values (10, 200, 1014);

select * from account where account_id > 1010;


create index account_salary_index on `account` (salary);

select * from account where salary >= 20000000;

select a.username, 
case when p.position_name is null then 'Không thuộc chức vụ nào'
else p.position_name 
end 
as pos_name
from account a left join position p on a.position_id = p.position_id ;

select username, salary,
case 
	when salary is null then 'Chưa có lương'
	when salary <= 10000000 then 'Lương cơ bản'
    when salary <= 30000000 then 'Lương cấp cao'
    else 'Lương chủ tịch'
end 
as phan_loai_luong
from account ;