-- Cau 7 
select question_id from 
(
select count(*), question_id from answer group by question_id 
having count(*) >= 4
 ) bang_tam;

select question_id from 
( select count(*) as count_id, question_id from answer group by question_id 
) bang_tam
where count_id >= 4 
;


