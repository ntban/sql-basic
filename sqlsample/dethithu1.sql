/*
Ta có 1 database để quản lý điểm của học sinh như dưới (trường có dấu gạch chân là
PrimaryKey)
 Student(ID,Name,Age,Gender)
 Subject(ID, Name)
 StudentSubject(StudentID,SubjectID,Mark,Date)
*/
-- Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 3 bản ghi vào table
create database if not exists student_mark_db;
use student_mark_db;
create table student(
	id int primary key auto_increment,
    `name` varchar(50),
    age int,
    gender enum('0', '1')
);
create table `subject`(
	id int primary key auto_increment,
    `name` varchar(50)
);
create table student_subject(
	student_id int,
    subject_id int,
    mark float,
    `date` date default (date(now())),
    primary key(student_id, subject_id),
    foreign key(student_id) references student(id),
    foreign key(subject_id) references `subject`(id)
);
insert into student(`name`, age, gender) values ('Chi', 18, '1'), ('Hanh', 22, '1'), ('Trung', 20, '0'), ('Phuc', 21, '0'), ('Tien', 21, null);
insert into `subject`(`name`) values ('SQL'), ('Java'), ('Javascript'), ('Android');
insert into student_subject(student_id, subject_id, mark) values (1, 1, 9.1), (1, 2, 8.3 ), (2, 1, 7.1), (2, 2, 9.3), (2, 3, null);
insert into student_subject(student_id, subject_id, mark) values (1, 3, 9.2), (3, 3, 7.2), (3, 2, null);

-- 2. Viết lệnh để
-- a) Lấy tất cả các môn học không có bất kì điểm nào
select s.* from `subject` s left join student_subject ss on s.id = ss.subject_id where ss.subject_id is null ;

-- b) Lấy danh sách các môn học có ít nhất 2 điểm
select s.*, count(*) as quantity from  `subject` s join student_subject ss on s.id = ss.subject_id
group by ss.subject_id having count(*) >= 2 ; 

/*
3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
Student ID,Subject ID, Student Name, Student Age, Student Gender,
Subject Name, Mark, Date
(Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
'Unknow' thay thế cho null)
*/
create view student_info as 
select 
	stu.id,
    ss.subject_id,
    stu.`name` as student_name,
    stu.age as student_age,
    case when stu.gender = '0' then 'Male'
    when stu.gender = '1' then 'Female'
    else 'Unknow' end as student_gender,
    ss.mark,
    ss.`date`
from student stu 
left join student_subject ss on stu.id = ss.student_id
left join `subject` sub on sub.id = ss.subject_id ;

/*
4.b) Tạo trigger cho table StudentSubject có tên là StudentDeleteID:
Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
cột StudentID của table StudentSubject cũng bị xóa theo
*/
delimiter $$
create trigger StudentDeleteID before delete on student for each row
begin
	delete from student_subject where student_id = old.id;  
end $$
delimiter ;
delete from student where id = 4;

/*
5. Viết 1 store procedure (có parameters: student name) sẽ xóa tất cả các
thông tin liên quan tới học sinh có cùng tên như parameter
Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
các học sinh
*/
delimiter $$
create procedure delete_student_by_name(in student_name varchar(50)) 
begin 
	if student_name != '*' then
		delete from student_subject where student_id in (select id from student where `name` = student_name) ;
		delete from student where `name` = student_name;
	end if ;
    if student_name = '*' then
		delete from student_subject;
		delete from student;
    end if;
end $$
delimiter ;
SET SQL_SAFE_UPDATES = 0;
call delete_student_by_name('Hoa');
call delete_student_by_name('*');

/*
4. Không sử dụng On Update Cascade & On Delete Cascade
a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
Khi thay đổi data của cột ID của table Subject, thì giá trị tương
ứng với cột SubjectID của table StudentSubject cũng thay đổi
theo
*/
-- 4)a cách 1: dùng mẹo
insert into `subject`(id) values (-1);

drop trigger if exists SubjectUpdateID1;

delimiter $$
create trigger SubjectUpdateID1 before update on `subject` for each row
begin
	update student_subject set subject_id = -1 where subject_id = old.id;  
end $$
delimiter ;

drop trigger if exists SubjectUpdateID2;
delimiter $$
create trigger SubjectUpdateID2 after update on `subject` for each row
begin
	update student_subject set subject_id = new.id where subject_id = -1; 
end $$
delimiter ;

update `subject` set id = 100000 where id = 1;

