select count(*), d.department_id, d.department_name from department d 
join account a on d.department_id = a.department_id
group by d.department_id, d.department_name
having count(*) >= 3
;

