/*
-- create and use database
*/
create database testing_system__assignment_1;
use testing_system__assignment_1;

/*
-- create tables
*/
create table department(
	department_id int primary key,
    department_name varchar(50)
);
create table `position`(
	position_id int primary key,
    position_name enum('Dev', 'Test', 'Scrum Master', 'PM')
);
create table `account`(
	account_id int primary key,
    email varchar(50) unique key,
    username varchar(30) not null,
    fullname varchar(100) not null,
    department_id int,
    position_id int,
    create_date date default (date(now())),
    foreign key (department_id) references department(department_id),
    foreign key (position_id) references `position`(position_id)
);
create table `group`(
	group_id int primary key,
    group_name varchar(50),
    creator_id int,
    create_date date default (date(now())),
    foreign key (creator_id) references `account`(account_id)
);
create table group_account(
	group_account int primary key,
	group_id int,
    account_id int,
    join_date date default (date(now())),
    foreign key (group_id) references `group`(group_id),
    foreign key (account_id) references `account`(account_id)
);
create table type_question(
	type_id int primary key auto_increment,
    type_name enum('Essay', 'Multiple-Choice')
);
create table category_question(
	category_id int primary key auto_increment,
    category_name varchar(50)
);
create table question(
	question_id int primary key auto_increment,
    content varchar(1000) not null,
    category_id int,
    type_id int,
    creator_id int,
    create_date date default (date(now())),
    foreign key (category_id) references category_question(category_id),
    foreign key (type_id) references type_question(type_id),
    foreign key (creator_id) references `account`(account_id)
);
create table answer(
	answer_id int primary key auto_increment,
    content varchar(1000) not null,
    question_id int,
    is_correct boolean,
    foreign key (question_id) references question(question_id)
);
create table exam(
	exam_id int primary key auto_increment,
    `code` varchar(20) not null,
    title varchar(50),
    category_id int,
    duration time,
    creator_id int,
    create_date date default (date(now())),
    foreign key (category_id) references category_question(category_id),
    foreign key (creator_id) references `account`(account_id)
);
create table exam_question(
	exam_question_id int primary key,
    exam_id int,
    question_id int,
    foreign key (exam_id) references exam(exam_id),
    foreign key (question_id) references question(question_id)
);

/*
-- create data for tables
*/
insert into department(department_id, department_name) values
	(1, 'Sale'),
    (2, 'IT'),
    (3, 'HR'),
    (4, 'Marketing')
;
insert into `position`(position_id, position_name) values
	(100, 'Dev'),
    (101, 'Test'),
    (102, 'Scrum Master'),
    (103, 'PM')
;
insert into `account`(account_id, email, username, fullname, department_id, position_id) values 
	(1000, 'ducanht1108@gmail.com', 'anh.tranduc', 'Trần Đức Anh', 1, 100),
    (1001, 'manhtu.cau@gmail.com', 'tu.hamanh', 'Hà Mạnh Tú', 1, 101),
    (1002, 'nguyencaohieu.15.06.1996@gmail.com','hieu.nguyencao','Nguyễn Cao Hiếu', 1, 102),
    (1003, 'chuongst99@gmail.com','chuong.nguyen','Nguyễn Chương', 1, 103),
    (1004, 'nguyenquytruong04@gmail.com','truong.nguyenquy','Nguyễn Quý Trường', 2, 100),
    (1005, 'minhthuan1612@gmail.com','thuan.leminh','Lê Minh Thuận', 2, 101),
    (1006, 'namplc6789@gmail.com','nam.tranvan','Trần Văn Nam', 2, 102),
    (1007, 'nguyenduc8696@gmail.com','duc.nguyenhuu','Nguyễn Hữu Đức', 2, 103),
    (1008, 'ngohoangminh12111996official@gmail.com','minh.ngohoang','Ngô Hoàng Minh', 3, 100),
    (1009, 'nguyennhi2521998@gmail.com','nhi.nguyenthiphuong','Nguyễn Thị Phương Nhi', 3, 101),
    (1010, 'quynhziumy@gmail.com','quynh.nguyenthinhu','Nguyễn Thị Như Quỳnh', 3, 102),
    (1011, 'tuannhdinhtrong1@gmail.com','anh.dinhtrongtuan','Đinh Trọng Tuấn Anh', 4, 103),
    (1012, 'thanhbuiduc1939@gmail.com','thanh.buiduc','Bùi Đức Thành', 4, 100),
    (1013, 'dangvodich@gmail.com','dang.nguyenhai','Nguyễn Hải Đăng', 4, 101),
	(1014, 'duongvandao@gmail.com','dao.duongvan','Dương Văn Đào', 4, 102),
    (1015, 'duongqua@gmail.com','qua.duong','Dương Quá', 3, 103),
    (1016, 'dangngocbao@gmail.com','bao.dangngoc','Đặng Ngọc Bảo', 1, 100)
;
insert into `group`(group_id, group_name, creator_id, create_date) values
	(200, 'CLB Bóng đá', 1000, '2019-12-19'),
    (201, 'CLB Liên minh Huyền thoại', 1001, '2019-12-20'),
    (202, 'CLB Freefire', 1002, '2022-03-16'),
    (203, 'CLB Tin học', 1003, '2018-01-27'),
    (204, 'CLB Tiếng Anh', 1004, '2020-01-01'),
    (205, 'CLB Tiếng Nhật', 1005, '2021-02-05'),
    (206, 'HR Team', 1006, '2017-01-27'),
    (207, 'IT Team', 1007, '2019-04-04'),
    (208, 'Sale Team', 1008, '2020-05-18'),
    (209, 'Marketing Team', 1009, '2021-08-09'),
    (210, 'Dev Team', 1010, '2021-06-07')
;
insert into question(question_id, content) values
	(10000, 'câu hỏi: not null nghĩa là gì'),
    (10001, 'câu hỏi: primary key có được phép nhập null không'),
    (10002, 'Đặc điểm nào dưới đây đúng với primary key'),
    (10003, 'Đặc điểm nào dưới đây đúng với unique key')
;
insert into answer values
	(20000, 'Không được phép bỏ trống data', 10000, true),
    (20001, 'Được phép bỏ trống data', 10000, false),
    (20002, 'Không được', 10001, true),
    (20003, 'Được', 10001, false),
    (20004, 'Được phép null và được phép trùng nhau', 10002, false),
    (20005, 'Được phép null và không được phép trùng nhau', 10002, false),
    (20006, 'Không được phép null và được phép trùng nhau', 10002, false),
    (20007, 'Không được phép null và không được phép trùng nhau', 10002, true),
    (20008, 'Được phép null và được phép trùng nhau', 10003, false),
    (20009, 'Được phép null và không được phép trùng nhau', 10003, true),
    (20010, 'Không được phép null và được phép trùng nhau', 10003, false),
    (20011, 'Không được phép null và không được phép trùng nhau', 10003, false)
;

insert into exam(`code`, duration, create_date) values 
	('VA000374', '01:00:00', '2019-12-19') ,
    ('VA000481', '01:00:00', '2019-04-04') ,
    ('VA000545', '01:00:01', '2017-01-27') ,
    ('VA000775', '00:59:59', '2020-05-18') 
;
