---
layout: post
title: Sử dụng chế độ giả lập di động trên Chrome
---

Lập trình Website đã và đang trở nên phức tạp. Ngoài việc kiểm thử tính năng trên hàng tá trình duyệ, website của bạn cần được đánh giá thật kỹ lưỡng trên cả một loạt thiết bị đa dạng, từ di động đến máy tính với những hệ điều hành, độ phân giải, khích thước màn hình và tốc độ xử lý khác nhau. Trong những trường hợp cực đoan, thời gian cho test có thể lâu bằng thời gian phát triển ban đầu. 
Rất may mắn, các trình duyệt hiện đại ngày nay đều đã cung cấp công cụ giả lập di động. Trong bài viết này chúng ta sẽ tìm hiểu về chế độ giả lập di động trên Chrome.

### Chrome Developer Tools
Truy cập vào trang web bạn muốn test và mở Developer Tools (Menu > Tools > Developer Tools, Cmd+Opt+I trên Mac hoặc F12 / Ctrl+Shift+I trên Windows và Linux).
Bạn giờ đây đã có thể kích hoạt giả lập bằng cách click vào icon Toggle device toolbar ở góc trái trên cùng:
![](https://images.viblo.asia/8b239d1b-0e5c-4ed5-96fa-d90a7489c970.png)

Bộ giả lập thiết bị sẽ hiện lên:
![](https://images.viblo.asia/b7bb4507-6901-4354-a2e3-03b6da1b49f7.png)

##### Giả lập cảm ứng
Di chuyển con trỏ chuột lên thiết bị để biến thành trỏ ‘chạm’ tròn. Thay đổi này sẽ phản ứng với các e0vent JavaScript dạng chạm như touchstart, touchmove và touchend. Event riêng cho cuột và hiệu ứng CSS sẽ không xảy ra.

Giữ phím Shift sau đó click và di chuyển con chuột để mô phỏng pinch zooming.

##### Mobile Emulator Device Toolbar
Bạn cũng rất nên dành chút thời gian làm quen với toolbar và menu phía trên cửa sổ trên mobile emulator:
![](https://images.viblo.asia/c610f9a4-a918-4991-bd81-90bb7243f2c7.png)

Các mục điều khiển mặc định gồm:
* kiểu thiết bị (hoặc đơn giản là Responsive)
* độ phân giải hiện tại
* tỷ lệ (màn hình có thể được phóng to hoặc thu nhỏ để khớp với ô giả lập hơn)
* nút chuyển đổi portrait/landscape.
   
Menu 3 chấm cho phép bạn ẩn/hiện 1 số các điều khiển khác:
* khung thiết bị (hình ảnh minh họa của thiết bị)
* thước pixel
* tỷ lệ pixel của thiết bị (như 2.0 có các màn hình Retina được giả lập)
* điều tiết mạng (giới hạn băng thông và test hiệu năng trên các kết nối chậm hơn)
* tùy chọn cuối cùng cho phép bạn chụp screenshot kèm theo khung thiết bị nếu được hiển thị.
![](https://images.viblo.asia/6f0a8239-f2ed-47c6-9b3e-925f44f5eb0f.png)

##### Thanh CSS Media Query
Thanh bên dưới toolbar hiển thị một loạt kích thước di động, tablet và các thiết bị khác thường thấy. Mục này click được khi Responsive được chọn làm thiết bị cho độ rộng đó.

Lựa chọn Show media queries từ menu ba chấm để xem được bản tóm tắt theo màu của tất cả media query được set trong CSS.
![](https://images.viblo.asia/fc911abb-ffd3-46dc-8942-6b07ae47b2e3.png)

* BLUE – các query tập trung vào maximum width
* GREEN – các query tập trung vào widths trong một khoảng nhất định
* ORANGE – các query tập trung vào một độ rộng nhất định
Bạn có thể click bất kỳ thanh nào để thiết đặt màn hình giả lập về độ rộng đó.

##### Lựa chọn thiết bị cần giả lập
Dropdown menu ở phía bên trái bạn lựa chọn một thiết bị. Bạn cũng sẽ được cung cấp một loạt preset cho smartphone và tablet, điển hình như iPhones, iPads, Nexus tablets, Samsung Galaxy,…
![](https://images.viblo.asia/6235fa24-891e-426f-a9ab-0f302f6b0211.png)
Bạn có thể mở hoặc tắt thiết bị hoặc tự nhập kích thước thiết bị thông qua:

* tên
* phân nhóm như “Mobile” hoặc “Tablet”
* độ phân giải của thiết bị
* và tỷ lệ pixel (ví dụ như 2 cho màn hình iPhone Retina – mật độ pixel cao gấp đôi độ phân giải của view port được report).

![](https://images.viblo.asia/2c08459a-7ae6-4732-9c29-ecb6bd20897e.png)
Một cửa sổ mới sẽ xuất hiện cho phép bạn xác định:

* Kinh-vĩ độ hiện tại hoặc lựa chọn một thành phố lớn nào đó từ dropdown. Bạn cũng có thể lựa chọn Location unavailable để giả lập phản ứng của ứng dụng khi thiết bị không thu được tín hiệu GPS.
* Về tính năng xoay. Bạn có thể xoay theo các preset có sẵn hoặc xoay thiết bị bằng cách click và kéo.


##### Remote Real Device Debugging
Cuối cùng, Chrome cũng đã cho phép bạn kết nối một thiết bị Android thật thông qua USB remote device debugging. Lựa chọn More tools -> Remote devices trong menu ba chấm chính của Developer Tools. Kiểm tra xem mục Discover USB devices đã được đánh dấu hay chưa, sau đó kết nối điện thoại/tablet và làm theo hướng dẫn.

Chrome còn cho phép bạn set up port forwarding, để bạn có thể chuyển hướng đến địa chỉ web trên local server của thiết bị. Ô preview của Chrome hiển thị hình ảnh đồng bộ của màn hình thiết bị và bạn có thể tương tác đồng thời qua thiệt bị hoặc bản thân Chrome.

Để test Progressive Web Apps ở chế độ offline, bạn có thể sử dụng một loạt tính năng tuyệt vời của developer tools, kể cả tab Application. Chú ý rằng, không giống ứng dụng thật có yêu cầu HTTPS, Chrome cho phép PWAs chạy từ localhost thông qua kết nối HTTP.