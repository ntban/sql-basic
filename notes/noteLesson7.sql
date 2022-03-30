trigger đi cùng table 
ví dụ: 
- kiểm soát data nhập vào 
học sinh tháng 3 điểm = 1, tháng 4 điểm = 10 => vô lý, không cho phép người dùng chỉnh sửa từ 1 điểm lên 10 điểm => tạo trigger 
- kiểm tra lỗi dữ liệu 
sinh viên tuổi >= 18, < 50 thì mới cho nhập (hơi giống check) 
- kiểm tra điều kiện ràng buộc phức tạp 
có bảng class có ngày nhập học là lớn hơn ngày hiện tại thì chỉ nhận 50 học sinh 
bảng student: sinh viên mới vào mà tăng sĩ số lớp lên 51 => không cho nhập 

trigger đi kèm insert | update | delete trong bảng 
có thể xảy ra before | after trước sự kiện
ví dụ: 
before insert -> chạy sự kiện trước khi insert, nếu không chạy sự kiện thành công thì không cho phép insert
after insert -> chạy sự kiện sau khi insert, nếu insert thành công thì mới chạy sự kiện 

ví dụ: tạo trigger sau khi insert vào account thành công thì sẽ lưu lịch sử đã insert được vào bảng account_history

Question 3: -- Cấu hình 1 group có nhiều nhất là 5 user
yêu cầu đề: nếu khi thêm vào bảng group_account 1 ông group đã có số lượng account = 5 rồi thì sẽ không cho thêm 
=> cần dùng before insert để kiểm tra số lượng trước khi insert 
nếu số lượng kiểm tra là 5 rồi => không cho insert 
nếu < 5 => cho insert 

index -- chỉ mục : giống như mục lục của cuốn sách 
index sẽ giúp cho việc tìm kiếm dữ liệu nhanh hơn => tức là câu select 
insert, update, delete sẽ có thể bị chậm hơn vì phải sắp xếp lại  
-- index 1 cột 
bài 1 
bài 2
bài 3 
..

-- index 2 cột 
chương 1 : 
	bài 1 
	bài 2
	bài 3
chương 2 : 
	bài 4 
	bài 5 
