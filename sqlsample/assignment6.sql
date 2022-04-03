drop procedure if exists delete_exam ;
delimiter $$
create procedure delete_exam(in id int) 
	begin
		delete from exam_question where exam_id = id;
        delete from exam where exam_id = id;
    end $$
delimiter ;

drop procedure if exists delete_exam_3yearsago ;
delimiter $$
create procedure delete_exam_3yearsago()
	begin
		declare count_examquestion int ;
        declare count_exam int ;
        
        declare i int default 1;
        declare j int default 0;
        declare temp_id int;
        
        select count(*) into count_examquestion from exam_question eq join exam e on eq.exam_id = e.exam_id where e.create_date <= date_sub(now(), interval 3 year) ;
        select count(*) into count_exam from exam where create_date <= date_sub(now(), interval 3 year) ;
        
        drop table if exists temp_exam;
        create table temp_exam (id int primary key) ;
        insert into temp_exam select exam_id from exam where create_date <= date_sub(now(), interval 3 year) ;
        
        while (i <= count_exam) do
			select id into temp_id from temp_exam order by id limit j, 1;
            call delete_exam(temp_id);
            set j = i;
			set i = i + 1;
        end while;
        
        drop table if exists temp_exam;
        
        select count_examquestion + count_exam;
    end $$
delimiter ;

-- Q12 
select question_id, month(create_date), count(*) as quantity from question where year(create_date) = year(now())
group by month(create_date);

-- Q13
with cte_number_question as (
	select month(create_date) as m, year(create_date) as y, count(*) as quantity from question 
    where create_date >= date_sub(now(), interval 5 month)
	group by y, m 
),
cte_month as (
	select month(date_sub(now(), interval 5 month)) as m, year(date_sub(now(), interval 5 month)) as y
    union all
    select month(date_sub(now(), interval 4 month)) as m, year(date_sub(now(), interval 4 month)) as y
    union all
    select month(date_sub(now(), interval 3 month)) as m, year(date_sub(now(), interval 3 month)) as y
    union all
    select month(date_sub(now(), interval 2 month)) as m, year(date_sub(now(), interval 2 month)) as y
    union all
    select month(date_sub(now(), interval 1 month)) as m, year(date_sub(now(), interval 1 month)) as y
    union all
    select month(now()) as m, year(now()) as y
)
select cm.*,
case when cnq.m is null then 'không có câu hỏi nào trong tháng' 
else cnq.quantity end as quantity
from cte_month cm left join cte_number_question cnq on cm.y = cnq.y and cm.m = cnq.m
order by cm.y, cm.m
;
