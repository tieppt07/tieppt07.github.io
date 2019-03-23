---
layout: post
title: Linux - Hệ điều hành nên dùng để lập trình
---

### I. Linux là gì?
Linux là hệ điều hành máy tính dựa trên Unix được phát triển và phân phối qua mô hình phần mềm tự do mã nguồn mở. Thành phần cơ bản tạo nên Linux đó là nhân linux, một nhân hệ điều hành ra đời bản đầu tiên vào tháng 8 năm 1991 bởi Linus Torvalds. Nhiều người gọi Linux là GNU/Linux, lý do là bản thân linux chỉ là phần nhân hệ điều hành. Rất nhiều phần mềm, ứng dụng khác như hệ thống đồ họa, trình biên dịch, soạn thảo, các công cụ phát triển cũng cần được gắn vào nhân để tạo nên một HĐH hoàn chỉnh. Hầu hết những phần mềm này được phát triển bởi cộng đồng GNU.

Những người sử dụng giao tiếp với kernel thông qua một chương trình mà được biết như là shell. Shell là một bộ biên dịch dòng lệnh, nó biên dịch các lệnh được nhập bởi người sử dụng và chuyển đổi chúng thành một ngôn ngữ mà kernel có thể hiểu.

- Unix/Linux được phát triển lần đầu tiên bởi một nhóm các nhân viên AT&T tại phòng thí nghiệm Bell Labs, gồm có Ken Thompson, Dennis Ritchie, Douglas Mclloy và Joe Ossanna.

- Có rất nhiều phiên bản Unix khác nhau trên thị trường. Solaris Unix, AIX, HP Unix và BSD là một số ví dụ. Linux cũng là một phiên bản của Unix mà là miễn phí.

- Nhiều người có thể sử dụng một máy tính Unix cùng một lúc; vì thế Unix được gọi là hệ thống đa người dùng.

- Một người sử dụng có thể chạy nhiều chương trình cùng một lúc; vì thế Unix được gọi là đa nhiệm.

### II. Lí do nên sử dụng Linux

1. Miễn phí
    Linux là 1 HĐH mã nguồn mở miễn phí. Bạn không tốn bất cứ một chi phí nào cho bản quyền hay việc sử dụng nó cả.

2. Cài đặt nhanh
    Khi cài đặt xong Linux, đã có đầy đủ driver và các phần mềm cơ bản như Office, E-mail Client... mà không cần phải cài đặt thủ công những driver và phần mềm còn thiếu như Windows.

3. Tính bảo mật cao
    Việc quản lý quyền người dùng chặt chẽ từ nhân hệ thống, cùng với việc lượng người dùng ít hơn windows khiến số hacker tấn công vào Linux cũng ít hơn dẫn đến việc bị virus tấn công cũng giảm thiểu.

4. Hoạt động ổn định với hiệu năng không thay đổi theo thời gian
    - Linux miễn phí, mã nguồn mở nên không cần crack như Windows, vì vậy hệ thống không bị mất ổn định do crack.
    - Linux quản lý quyền người dùng rất chặt chẽ nên sẽ không có chuyện một phần mềm tự khởi động mà không được sự cho phép của bạn.
    - Linux không có Registry nên không bị lỗi Registry như Windows
    - Virus làm mất ổn định hệ thống – Phần mềm diệt Virus nặng nề, chạy âm ỉ làm chậm hệ thống. Linux hầu như không có Virus nên không cần Phần mềm diệt Virus.
    - Không như Windows, Linux hỗ trợ phần cứng (Driver cho phần cứng) từ nhân hệ thống. Do đó, nó hôex trợ rất tốt cho các thiết bị có phần cứng lỗi thời.

5. Hỗ trợ tốt cho lập trình viên - quản trị mạng
    Hệ thống Linux hoạt động ổn định, hiệu năng cao nên hỗ trợ nhiều tốt cho công việc, đặc biệt là đối với những công việc đòi hỏi tính ổn định hệ thống cao như công việc của quản trị mạng hay lập trình viên.

6. Sự hỗ trợ kỹ thuật tích cực
     Trong quá khứ, doanh nghiệp thường mượn lý do thiếu sự hỗ trợ về mặt kỹ thuật để gắn bó với Windows. Tuy nhiên, vào lúc này, sự bành trướng và phổ dụng của mã nguồn mở đã khiến các hãng sản xuất, ứng dụng và dịch vụ nền Linux thay đổi. Ví dụ, 3 cây đại thụ trong lĩnh vực cung cấp HĐH Linux như Red Hat, Novell và Canonical hiện cung cấp dịch vụ hỗ trợ kỹ thuật 24x7 trong cả năm đối với mọi dịch vụ.

### III. Một số câu lệnh cơ bản thường dùng

- `<câu lệnh> --help`:  xem thông tin trợ giúp và các tùy chỉnh của câu lệnh.
- `whatis <tên câu lệnh>`: hiển thị mô tả về câu lệnh.
- `ls`: liệt kê nội dung (file và thư mục) trong thư mục hiện hành.
- `mkdir <tên thư mục mới>`:  tạo một thư mục mới.
- `pwd`: in ra đường dẫn đầy đủ đến thư mục hiện hành.
- `cd <thư mục>`: chuyển một thư mục thành thư mục hiện hành cho phiên làm việc hiện tại.
- `rmdir <thư mục>`: xóa một thư mục.
- `cp <file nguồn> <file đích>`: sao chép file từ vị trí nguồn đến vị trí đích.
- `mv <nguồn> <đích>`: di chuyển một file hoặc thư mục từ vị trí này sang vị trí khác.
- `cat <tên file>`: đọc và in ra nội dung của file ra màn hình terminal.
- `grep <chuỗi> <tên file>`: tìm kiếm nội dung của file theo chuỗi cung cấp.
- `find <thư mục> -name <tên file>`: tìm kiếm file trong  <thư mục>  theo  <tên file>.
- `unzip <file-nén.zip>`: giải nén một file nén (.zip).
- `man <tên câu lệnh>`: hiển thị trang hướng dẫn cho câu lệnh.
- `exit`: thoát khỏi phiên làm việc.
- `who`: hiển thị danh sách các tài khoản đang đăng nhập vào hệ thống.
- `su <tên tài khoản>`: chuyển sang đăng nhập bằng một tài khoản khác.
- `uname`: hiển thị ra một số thông tin hệ thống như tên kernel, tên host, bộ xử lý, ...
- `free`: xem thông tin về bộ nhớ: bộ nhớ đã sử dụng, bộ nhớ còn trống trên hệ thống
- `ps`: hiển thị thông tin về các tiến trình đang chạy.
- `shutdown`: lệnh tắt máy tính. Có thể dùng  shutdown -r  để khởi động lại máy tính.

----
