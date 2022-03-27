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

SQL : count, min, max, sum, avg 

variable (biến) : giá trị có thể thay đổi 
parameter : tham số của hàm, có thể là input hoặc output 


-- bài 6 
Viết 1 store cho phép người dùng nhập vào 1 chuỗi -- => in varchar_input varchar 
và trả về group có tên  -- => bảng group, group_name 
chứa chuỗi của người dùng nhập vào  group_name like concat('%', varchar_input, '%') -- '%CLB%'

 hoặc trả về user có username chứa -- bảng account, username 
 chuỗi của người dùng nhập vào  username like concat('%', varchar_input, '%')
 
 hoặc or

