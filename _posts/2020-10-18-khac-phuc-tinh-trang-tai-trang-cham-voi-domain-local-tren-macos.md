---
layout: post
title: Khắc phục tình trạng tải trang chậm với domain .local trên MacOS
---

Nguyên nhân và cách khắc phục tình trạng tên miền .local phản hồi rất chậm trên MacOS

### Vấn đề

Khi phát triển web, đôi khi chúng ta muốn sử dụng một tên miền local, vừa dễ nhớ, vừa tạo cảm hứng cho project chúng ta đang làm, thay vì sử dụng localhost với port khô khan. Ví dụ như khi mình chạy blog của mình ở local để phục vụ việc dev, mình đặt là `tiepxdev.local`.

Để sử dụng custom local domain, khá đơn giản, chỉ cần sửa file `/etc/hosts`, trỏ custom domain về loop IP là xong.

```zsh
127.0.0.1 tiepxdev.local
```

Lúc này vấn đề xảy ra mỗi khi reload lại page, mình sử dụng câu lệnh time để đo thời gian phản hồi của request với curl

```zsh
➜  ~ time curl -I http://tiepxdev.local/about
HTTP/1.1 200 OK
Date: Sun, 16 Aug 2020 15:42:09 GMT
Server: Apache
Set-Cookie: grav-site-40d1b2d=23f85fda3a132e1b9f740b108b13779b; expires=Sun, 16-Aug-2020 16:12:09 GMT; Max-Age=1800; path=/; domain=tiepxdev.local; HttpOnly
Expires: Sun, 23 Aug 2020 15:42:10 GMT
Cache-Control: max-age=604800
Pragma: no-cache
Content-Encoding: none
Content-Length: 11160
Connection: close
Content-Type: text/html;charset=UTF-8

curl -I http://tiepxdev.local/about  0.01s user 0.01s system 0% cpu 5.442 total
```

Kết quả là cần tới hơn 5 giây mới có response.

### Cách khắc phục

Chỉ cần thêm một dòng nữa với nội dung `::1` vào sau dòng `127.0.0.1 tiepxdev`.local trong file `/etc/hosts`:

```zsh
127.0.0.1 tiepxdev.local
`::1`
```

Sau đó thử lại:

```zsh
➜  ~ time curl -I http://tiepxdev.local/about
HTTP/1.1 200 OK
Date: Sun, 16 Aug 2020 15:46:10 GMT
Server: Apache
Set-Cookie: grav-site-40d1b2d=22f72815964539c400f3b0eb2e6b7abd; expires=Sun, 16-Aug-2020 16:16:10 GMT; Max-Age=1800; path=/; domain=tiepxdev.local; HttpOnly
Expires: Sun, 23 Aug 2020 15:46:10 GMT
Cache-Control: max-age=604800
Pragma: no-cache
Content-Encoding: none
Content-Length: 11160
Connection: close
Content-Type: text/html;charset=UTF-8

curl -I http://tiepxdev.local/about  0.00s user 0.01s system 4% cpu 0.364 total
```

Giờ thì chỉ mất có 364ms. Ổn rồi.

### Lý giải

#### Dòng `::1` là gì?

Dòng `::1` là dòng cấu hình ipv6, dòng `127.0.0.1` là dòng cấu hình ipv4.

#### Tại sao vấn đề này không xảy ra trên Windows hay Linux

Trên MacOS, có một service tên [Bonjour](https://developer.apple.com/bonjour/), service này giúp các thiết bị Apple giao tiếp qua mạng với nhau một cách dễ dàng mà không cần cấu hình. Bonjour cho phép các thiết bị giao tiếp với nhau chỉ bằng tên thiết bị tự đặt mà không cần một máy chủ phân giải tên miền nào. Vì thế trên MacOS, bất cứ host name nào có đuôi .local sẽ đều bị Bonjour hiểu nhầm thành một Bonjour host, thay vì là một host trên DNS server bình thường. Vì thế, request đến domain .local sẽ bị điều hướng qua cho `Bonjour` xử lý trước, và sẽ mất một khoảng thời gian (có thể là để retry vài lần, mình đoán thế 😛) trước khi Bonjour trả về lỗi và MacOS chuyển tiếp request cho DNS server.

Việc thêm vào cấu hình ipv6 cho cùng domain đó sẽ giúp MacOS nhanh chóng nhận ra là phải chuyển request đó cho DNS server ngay lập tức, thay vì đưa cho `Bonjour`.

### Fun fact 😄

Trước kia mọi người thường dùng tên miền `.dev` ở local (cũng là một cách để tránh hiện tượng kể trên). Tuy nhiên từ khi `Google` chính thức đăng kí tên miền `.dev` vào ngày 19/02/2019, tên miền `.local` trở nên thịnh hành hơn ở local (mình lại đoán thế 😛).

---
