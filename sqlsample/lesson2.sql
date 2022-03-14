create table class(
	class_id tinyint primary key,
    class_name varchar(50)
);
create table student(
	student_id tinyint primary key,
    email varchar(50) unique key,
    create_date datetime default now(),
    gender enum('female', 'male'),
    age tinyint not null check(age >=18),
    class_id tinyint not null,
    foreign key (class_id) references class(class_id)
);



















create table table1(
id bigint primary key,
gender enum('female','male', 'unknown')
);


create table hocvien(
stt tinyint primary key,
student_code char(8),
birthdate date,
email varchar(50)
);

CREATE TABLE table2 (
    column1 TINYINT primary key,
    column2 SMALLINT,
    column3 MEDIUMINT,
    column4 INT,
    column5 BIGINT,
    number1 FLOAT,
    number2 DOUBLE,
    string1 CHAR(10),
    string2 VARCHAR(50),
    date1 DATE,
    time1 TIME,
    datetime1 DATETIME,
    enum1 ENUM('1', '2')
);









create database database1;
drop database database1;
drop database if exists database1;
create database if not exists database2;
drop database database2;

drop table if exists table1;



create table sinhvien(
id int primary key, 
age tinyint not null,
email varchar(50)
);


create table sinhvien2(
id int primary key, 
age tinyint not null,
email varchar(50) unique key
);