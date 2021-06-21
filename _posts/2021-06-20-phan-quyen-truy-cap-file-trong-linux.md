---
layout: post
title: "Phân quyền truy cập file trong Linux"
---

### Khái niệm cơ bản về quyền đối với file trong Linux

Các hệ điều hành `Linux` thực sự là những hệ thống giống như Unix và các hệ thống giống như Unix tiếp cận quyền truy cập file như sau:

Mỗi file đều có chủ sở hữu (`owner`), xác định “user class” (lớp người dùng) của file. Mỗi file cũng có một nhóm (`group`), xác định “group class” (lớp nhóm) của file. Bất kỳ người dùng hệ thống nào không phải là chủ sở hữu và không thuộc cùng một nhóm đều được xác định là thuộc lớp khác (`others`).

Tất cả các file trên những hệ thống giống như Unix đều có quyền được gán cho cả ba lớp và chúng xác định hành động nào có thể được thực hiện bởi các lớp đã nói đối với file đã cho.

Ba hành động có sẵn trên một hệ thống giống như Unix là:

- `read` (đọc - khả năng mở và xem nội dung của file)
- `write` (ghi - khả năng mở và sửa đổi nội dung của file)
- `execute` (thực thi - khả năng chạy file như một chương trình thực thi)

Nói cách khác, các quyền của file xác định xem:

- Chủ sở hữu có thể đọc, viết và thực thi file không.
- Nhóm có thể đọc, viết và thực thi file.
- Bất cứ ai khác có thể đọc, viết và thực thi file không.
- Quyền truy cập file Linux có thể được hiển thị ở hai định dạng.

Định dạng đầu tiên được gọi là `symbolic notation` (ký hiệu tượng trưng), ​​là một chuỗi gồm 10 ký tự: Một ký tự đại diện cho loại file và 9 ký tự đại diện cho các quyền đọc (`r`), ghi (`w`) và thực thi (`x`) của file theo thứ tự chủ sở hữu, nhóm, và những người dùng khác. Nếu không được phép, biểu tượng dấu gạch ngang (`-`) sẽ được sử dụng.

Ví dụ:

![Quyền đối với file trong Linux](https://images.viblo.asia/9aca144b-99e4-4d80-88f4-2568d8c7e9b2.png)


Định dạng thứ hai được gọi là `numeric notation` (ký hiệu số), là một chuỗi gồm ba chữ số, mỗi chữ số tương ứng với user, nhóm và các quyền khác. Mỗi chữ số có thể nằm trong khoảng từ 0 đến 7 và mỗi giá trị của chữ số có được bằng cách tính tổng các quyền của lớp:

- 0 có nghĩa là không có quyền nào được cho phép.
- +1 nếu lớp có thể thực thi file.
- +2 nếu lớp có thể ghi vào file.
- +4 nếu lớp có thể đọc file.

Nói cách khác, ý nghĩa của từng giá trị chữ số là:

- 0: Không được phép thực hiện bất kỳ quyền nào
- 1: Thực thi
- 2: Viết
- 3: Viết và thực thi
- 4: Đọc
- 5: Đọc và thực thi
- 6: Đọc và viết
- 7: Đọc, viết và thực thi

### Chmod là gì?

Trên các hệ thống giống như Unix, chmod là một lệnh cấp hệ thống, viết tắt của “change mode” và cho phép bạn thay đổi cài đặt quyền của file theo cách thủ công.

Đừng nhầm lẫn với chown. Đó là một lệnh cấp hệ thống khác trên những hệ thống giống như Unix, viết tắt của “change owner” và cho phép bạn gán quyền sở hữu một file cho người dùng khác, hoặc chgrp, viết tắt của “change group” và gán file cho một nhóm khác. Đây là những lệnh quan trọng cần biết, nhưng không được sử dụng phổ biến như chmod.

#### Chmod 644 có nghĩa là gì?

Việc đặt quyền của file thành 644 cho phép chủ sở hữu có thể truy cập và sửa đổi file theo cách họ muốn, trong khi mọi người dùng khác chỉ có thể truy cập mà không thể sửa đổi và không ai có thể thực thi file ngay cả chủ sở hữu. Đây là cài đặt lý tưởng cho những file có thể truy cập công khai vì nó duy trì cân bằng giữa sự linh hoạt và tính bảo mật.

#### Chmod 755 có nghĩa là gì?

Đặt quyền của file thành 755 về cơ bản giống như 644, ngoại trừ mọi người đều có quyền thực thi. Quyền này chủ yếu được sử dụng cho các thư mục có thể truy cập công khai, vì cần có quyền thực thi để thực hiện thay đổi đối với thư mục.

#### Chmod 555 có nghĩa là gì?

Việc đặt quyền của file thành 555 làm cho file không thể bị sửa đổi bởi bất kỳ ai, ngoại trừ superuser (siêu người dùng) của hệ thống. Quyền này không thường được sử dụng như 644, nhưng việc biết về nó vẫn rất quan trọng, vì cài đặt quyền chỉ đọc ngăn ngừa các thay đổi ngẫu nhiên và/hoặc giả mạo.

#### Chmod 777 có nghĩa là gì?

Đặt quyền truy cập file thành 777 cho phép mọi người có thể làm bất cứ điều gì họ muốn với file. Đây là một rủi ro bảo mật rất lớn, đặc biệt là trên các máy chủ web! Theo nghĩa đen, bất cứ ai cũng có thể truy cập file, sửa đổi theo cách họ muốn và thực thi nó trên hệ thống. Bạn có thể tưởng tượng thiệt hại tiềm tàng nếu một kẻ lừa đảo nhúng tay vào file này.

### Cách sử dụng Chmod trên Linux

Lệnh chmod có định dạng đơn giản:

```bash
chmod [permissions] [file]
```

Quyền có thể được cung cấp trong ký hiệu số, đây là định dạng tốt nhất để sử dụng khi bạn muốn gán quyền cụ thể cho tất cả các lớp:

```bash
chmod 644 example.txt
```

Quyền cũng có thể được cung cấp trong ký hiệu tượng trưng, ​​rất hữu ích khi bạn chỉ muốn sửa đổi các quyền của một lớp cụ thể. Ví dụ:

```bash
chmod u=rwx example.txt
chmod g=rw example.txt
chmod o=rw example.txt
```

Bạn có thể sửa đổi quyền cho nhiều lớp, chẳng hạn như ví dụ này cho chủ sở hữu quyền đọc/ghi/thực thi nhưng nhóm và các người dùng khác chỉ có quyền đọc/thực thi:

```bash
chmod u=rwx,g=rw,o=rw example.txt
```

Khi gán cùng một quyền cho nhiều lớp, bạn có thể kết hợp chúng:

```bash
chmod u=rwx,go=rw example.txt
```

Nhưng lợi ích của việc sử dụng ký hiệu tượng trưng sẽ được thấy rõ khi bạn chỉ muốn thêm hoặc xóa quyền cho một hành động cụ thể đối với một lớp.

Ví dụ, lệnh sau thêm quyền thực thi cho chủ sở hữu file:

```bash
chmod u+x example.txt
```

Và lệnh này loại bỏ quyền ghi và thực thi cho người dùng khác:

```bash
chmod o-wx example.txt
```

Cuối cùng, nếu bạn muốn áp dụng một nhóm quyền cụ thể cho tất cả các file và mục trong một thư mục cụ thể (nghĩa là một chmod đệ quy), hãy sử dụng tùy chọn -R và nhắm mục tiêu tới một thư mục:

```bash
chmod -R 755 example_directory
```

Mặc dù lệnh chmod thoạt nhìn có vẻ hơi kỳ lạ, nhưng nó thực sự khá đơn giản và hoàn toàn hợp lý. Nếu bạn hiểu những điều trên, về cơ bản bạn đã thành thạo chmod!

Nguồn:

- [quantrimang](https://quantrimang.com/phan-quyen-truy-cap-file-bang-lenh-chmod-59672)
- [ubuntu](https://help.ubuntu.com/community/FilePermissions)

---
