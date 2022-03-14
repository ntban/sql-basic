SELECT * FROM `account`;

SELECT account_id, email, fullname, age FROM `account`;

SELECT account_id FROM `account`;

SELECT * FROM `account` where age >=20  and fullname = 'name';

SELECT * FROM `account` where age >=20 or email = 'an2@gmail.com' or fullname = 'name';

SELECT * FROM `account` where  email = 'an2@gmail.com' ;
SELECT * FROM `account` where  email != 'an2@gmail.com' ;

SELECT * FROM `account` where age between 20 and 21;
SELECT * FROM `account` where age >= 20 and age <= 21;

SELECT * FROM `account` where fullname in ('a', 'name');
SELECT * FROM `account` where fullname ='a' or fullname='name';

SELECT * FROM `account` where fullname not in ('a', 'name');

SELECT * FROM `account` where position_id is not null;


SELECT * FROM `account` where fullname like '%a%'; 