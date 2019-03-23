---
layout: post
title: Bash Ubuntu on Windows 10
---

Sau hàng loạt tin đồn thì hôm nay Microsoft đã chính thức phát hành cập nhật Anniversary Update – hay còn gọi là RedStone 1, đến với người dùng Windows 10. Theo tuyên bố trong hội nghị BUILD 2016 vừa qua, Anniversary Update sẽ mang đến cho người dùng Windows 10 hàng loạt các thay đổi về tính năng và cải tiến rất đáng quan tâm.

### 1. Cài đặt Bash Ubuntu trên Windows

1. Bật chế độ Developer Mode: Settings > Update & Security > For Developers > Check the Developer Mode radio button:

![1-DevMode.png](/uploads/8849e585-18b5-487d-929d-50c5b084942a.png)

2. Trong menu start, mở “Turn Windows Features on or off”:

![2-features.png](/uploads/1d546e9c-84d3-45ec-8705-69de720f5778.png)

3. Tìm và check box “Windows Subsystem for Linux (Beta)” feature:

![3-WSL.png](/uploads/099ca25c-a90e-43ea-9e53-b2eeb85af14e.png)

4. Okay và reboot (required)

5. Sau khi khởi động lại, mở PowerShell/command prompt và gõ `bash`, chấp nhận Canonical's license để tải Ubuntu Image:

![4-ubuntu.png](/uploads/0ad31d6c-8519-4cf4-96d7-5be9abbd1d56.png)

6. Vậy là giờ ta có 1 máy 2 trong 1…

### 2. Ubuntu trong Windows

Cái Ubuntu mừ chúng mềnh vừa cài ấy! Nó nằm ở đây này:

`C:\Users\%USERPROFILE%\AppData\Local\lxss\rootfs`

Thư mục của root user thì nằm tại:

`C:\Users\%USERPROFILE%\AppData\Local\lxss\root`

Và thư mục của các users khác thì nằm tại:

`C:\Users\%USERPROFILE%\AppData\Local\lxss\home`

### 3. Windows trong Ubuntu

This PC chính là thư mục mnt

```sh
$ cd /mnt
```

![Capture.PNG](/uploads/7b17a84d-0f83-40ac-87f6-7078873be2ec.png)

### 4. Sử dụng

- Cách 1: Mở PowerShell/command prompt gõ:

```sh
$ bash
```

![Capture1.PNG](/uploads/eb5f47a2-fe54-48bb-b144-4dbc563dd419.png)

- Cách 2: Open Ubuntu bash from start

![Untitled.png](/uploads/9f02c7c2-3e08-446a-8321-ac96a5529c70.png)

### 5. Thử chạy 1 project

Tạo file: index.js ở đâu đó tùy. !!! Lưu ý. Tạo bằng editor của Windows, và mở folder gì gì vẫn bằng Windows bình thường nhé.

Nội dung file index.js (mình đặt ở Desktop windows)

```JavaScript
const http = require('http');
http.createServer((req, res) => {
    res.end('Everything can be Awesome :">');
}).listen(1234);
```

Thay vì sử dụng môi trường Windows để chạy project của bạn.
Bạn có thể chạy nó trong môi trường Linux:

`node index.js`

Sau đó mở trình duyệt lên và gõ: http://localhost:1234

Đây là 1 tính năng mình rất thích và chắc chắn là câu trả lời cho một số luận điểm về Windows như:

Đừng hỏi sao máy mình cài cái này ko dc… cái kia báo lỗi node gyp rebuild error v.v.., vì mình dùng win, đừng khóc (đọc tới đây hãy cộng số giờ phí phạm ngồi google làm sao cài xx trên win)

Hhi vọng, tình yêu của Windows và Linux sẽ tốt đẹp hơn nữa :x
Windows đng trở nên mạnh mẽ hơn bao giờ hết :)

Nguồn: https://blogs.msdn.microsoft.com/commandline/2016/04/06/bash-on-ubuntu-on-windows-download-now-3/

----
