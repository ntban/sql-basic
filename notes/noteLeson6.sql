PL/SQL 
function hàm /procedure thủ tục  
1. input 
2. thao tác lệnh để từ input -> output
3. output 
ví dụ 
hàm tính tổng a + b = c 
1. input a, b : a = 1, b = 2
2. thao tác lệnh để từ input -> output : 1 + 2 = 3 
3. output : c = 3


variable (biến) : giá trị có thể thay đổi 
parameter : tham số của hàm, có thể là input hoặc output 

SQL : count, min, max, sum, avg -- function mysql đã viết sẵn

-- bài 6 
Viết 1 store cho phép người dùng nhập vào 1 chuỗi -- => in varchar_input varchar 
và trả về group có tên  -- => bảng group, group_name 
chứa chuỗi của người dùng nhập vào  group_name like concat('%', varchar_input, '%') -- '%CLB%'

 hoặc trả về user có username chứa -- bảng account, username 
 chuỗi của người dùng nhập vào  username like concat('%', varchar_input, '%')
 
 hoặc or

-- bài 7 
create procedure insert_developer(in fullname_input varchar(50), in email_input varchar(50)) ;
Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email
-- input : fullname_input, email_input 'abc@gmail.com'
 và 
 trong store sẽ tự động gán:
username sẽ giống email nhưng bỏ phần @..mail đi
-- từ email bỏ phần sau dấu @ và dùng làm username 
-- username_input = 'abc'
positionID: sẽ có default là developer
-- positionID_input : tìm positionID trong bảng position mà có position name = 'Dev' 
departmentID: sẽ được cho vào 1 phòng chờ
-- set null 
 Sau đó in ra kết quả tạo thành công
-- tạo thành công => insert vào bảng account với thông tin
--  fullname_input, email_input, username_input, positionID_input , departmentID=null
-- in ra 
select * from account where fullname = fullname_input and email = email_input ;


-- bài 8 
Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice -- in type_input enum('Essay','Multiple-Choice') 
 để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất -- question 
 
 select * from question q join type_question tq ... where tq.type_name = type_input 
 and length (q.content) = -- max length 
 
 -- bài 11 
 Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng  -- dùng bảng account và department 
 nhập vào tên phòng ban -- in deptname_input varchar
 và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc -- set null cho cái departmentId 
 
 update account set departmentId = null where departmentId in ( select departmentId from department where departmentName = deptname_input);
 delete department where departmentName = deptname_input;
 
 
 -- bài 12 
 tháng || số câu hỏi 
 1			10
 2			20 
 3			30 
 
 -- bài 13 
 tháng || số câu hỏi 
 3/2022			10
 2/2022			20 
 1/2012			30 
 12/2021 		không có câu hổi nào 
 