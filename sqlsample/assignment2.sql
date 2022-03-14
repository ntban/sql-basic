
create database if not exists db_assignment12;  
use db_assignment12;

CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
drop table if exists `position` ;
CREATE TABLE if not exists  `position` (
    position_id INT PRIMARY KEY,
    position_name ENUM('Dev', 'Test', 'PM', 'Scrum Master')
);

create table `account`(
	account_id int primary key,
	email varchar(50) unique key,
    fullname varchar(50) not null,
    department_id int,
    position_id int,
    create_date datetime default now(),
    age int,
    foreign key (department_id) references department(department_id) ,
    foreign key (position_id) references `position`(position_id),
    check (age >= 18)
);

CREATE TABLE `position1` (
    position_id INT PRIMARY KEY auto_increment,
    position_name ENUM('Dev', 'Test', 'PM', 'Scrum Master')
);
