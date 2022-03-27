SELECT * FROM testing_system__assignment_1.account;

with cte_count_account as (
	select count(*) as so_luong, account_id from group_account group by account_id
)
select * from account a 
join cte_count_account cca on a.account_id = cca.account_id
join (select so_luong from cte_count_account order by so_luong desc limit 1) cte2
on cca.so_luong = cte2.so_luong;

with cte_user_nguyen as (
	select account_id from `account` where fullname like 'Nguyễn%'
)
select q.* from question q join cte_user_nguyen ng on q.creator_id = ng.account_id
; 


