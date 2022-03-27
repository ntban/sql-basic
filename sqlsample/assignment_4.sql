-- Cau 11 
-- cau 11 
select d.department_name as ten_phong_ban, p.position_name as ten_chuc_vu
, count(*) as so_luong
 from account a 
join department d on a.department_id = d.department_id 
join position p on a.position_id = p.position_id 
group by a.department_id, a.position_id
order by d.department_name asc, p.position_name asc;