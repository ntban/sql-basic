create view account_full_info as 
select a.*, p.position_name, d.department_name from account a 
join department d on a.department_id = d.department_id
join position p on a.position_id = p.position_id
;

create view account_less_info as 
select username, fullname, email from account
;
alter view account_less_info as 
select account_id, username, fullname, email, create_date from account
;
create view account_info as 
select * from account
;
drop view account_info;

with cte_account as (
select a.*, p.position_name, d.department_name from account a 
join department d on a.department_id = d.department_id
join position p on a.position_id = p.position_id
)
select * from cte_account where position_name ='Dev'
union all 
select * from cte_account where department_name = 'Sale'
;

with max_length as (
select max(length(username)) as maxlen from account 
)
select * from account where length(username) = (select maxlen from max_length)
;