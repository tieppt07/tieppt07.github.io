---
layout: post
title: Lumen - The stunningly fast micro-framework by Laravel
---

Laravel là framework mới ra đời, vào tháng 4 năm 2011 bởi Taylor Otwell đã nhanh chóng trở thành số 1 trong số các PHP frameworks, và dần lấy được thiện cảm của cộng đồng PHP và trở thành thay thế cho các framework cũ kỹ như Cake hay Zend, ... Laravel mang rất nhiều những ưu điểm các framework hiện đại từ các ngôn ngữ khác như Rails/Spring. Tuy nhiên Laravel vẫn có một nhược điểm và số lượng module dùng tương đối lớn, dẫn đến tốc độ không được tối ưu khi xây những service nhỏ. Vì vậy, Taylor Otwell đã release một phiên bản microframework là Lumen. Lumen là phiên bản thu nhỏ của laravel, nó nhanh hơn laravel rất nhiều và được tối ưu để xây dựng API.

### 1. Ưu điểm
`The stunningly fast micro-framework`
Ưu điểm của Lumen chắc chắn là nhanh =)) Trang chủ của Lumen có ảnh so sánh hiệu năng của Lumen với các micro-framework khác.
![](https://viblo.asia/uploads/bfd75f42-8c4c-4d6b-8443-5cfc420bfda2.png)

### 2. Nhược điểm
* Lumen được sinh ra để hướng đến API vì thế session đã không còn được hỗ trợ từ phiên bản 5.2
* Vì Lumen đã ngưng hỗ trợ session nên Lumen cũng không hỗ trợ việc đăng nhập bằng session.
...

### 3. Cài đặt
Requirements của Lumen 5.5:
* PHP >= 7.0
* OpenSSL PHP Extension
* PDO PHP Extension
* Mbstring PHP Extension

#### 3.1. Giống như Laravel, bạn có thể dễ dàng cài Lumen bằng composer:
`composer create-project --prefer-dist laravel/lumen blog`

#### 3.2. Config
Không giống như Laravel, Lumen không có thư mục config nên các cấu hình của Lumen đều nằm ở .env.
Đầu tiên chúng cần tạo .env để lưu các config cho lumen:
```php
$ cp .env.example .env

// Sử dụng hàm str_random(32) để generate ra APP_KEY
str_random(32)
=> YkLlij5hcWFD9wfjqXaffbwhMyfvpJWt
```

3. Cấu trức thư mục
    * `app` là thư mục chứa các file cấu hình, lưu trữ, tập lệnh của laravel, trong đó gồm có:
    * `Console`: các command sử dụng trong laravel
    * `Events`: thư mục chứa event, events có thể được sử dụng để thông báo đến các thành phần khác trong ứng dụng về một hành động đã xảy ra, events rất linh hoạt và tách biệt.
    * `Exceptions`: thư mục chứa các class ngoại lệ xử lý các trường hợp ngoại lệ của ứng dụng.
    * `Http`: chứa các controller và middleware
    * `Jobs`: thư mục chức class Job, là nơi xử lý các kỹ thuật liên quan đến hàng đợi (queue) và đồng bộ (synchronously) trong ứng dụng của bạn.
    * `Listeners`: Chứa cá class handler xử lý các Event trả lại kết quả.
    * `Providers`: là nơi chứa các class đăng ký (register) các ServiceProvider.
    * `User.php`: Model mặc định được tạo ra
    * `artisan`: tool mà Laravel cung cấp sẵn trong project, dùng để thực thi các lệnh CLI (command line interface) để hỗ trợ phát triển ứng dụng.
    * `bootstrap`: chứa file app.php file thiết lập cơ bản để bắt đầu chạy ứng dụng và file cấu hình nạp class tự động.
    * `composer.json`: là tập tin chứa các thiết lập về việc cài đặt, cập nhật ứng dụng bằng lệnh composer.
    * `database`: Bên trong chứa các folder factories, migration và seeder cơ sỡ dữ liệu của ứng dụng.
    * `public`: là thư mục gốc chứa file index.php Laravel dùng để chạy ứng dụng, đây cũng là nơi chứa các tài nguyên của ứng dụng như js, css …
    * `resources`: nơi chứa các template views, asset và các file ngôn ngữ.
    * `routes`: Chứa file web.php có vai trò chỉ đường cho yêu cầu (request) đi đến đâu.
    * `storage`: Chứa các file đã biên dịch từ các file view xài Blade template, chứa file sessions, caches và các file được sinh ra tự động của framework
    * `tests`: chứa các file testcase của ứng dụng.
    * `vendor`: chứa bộ mã nguồn của lumen và các thành phần đi kèm, cũng như các gói (packages) sau này sẽ thêm vào lumen
    * `.env`: chứa các config của lumen

### 4. Cơ bản về Lumen
#### 4.1. Route
Lumen ko hỗ trợ route controller, resource hay model mà chỉ có 1 số route cơ bản khả dụng như sau
```php
$router->get($uri, $callback);
$router->post($uri, $callback);
$router->put($uri, $callback);
$router->patch($uri, $callback);
$router->delete($uri, $callback);
$router->options($uri, $callback);
```

#### 4.2. Validation
Lumen hỗ trợ các rules validate như Laravel:
```php
$this->validate($request, [
    'name' => 'required',
    'email' => 'required|email|unique:users'
]);
```
Tuy nhiên messages errors của Lumen được trả về dưới dạng json thay vì redirect với flash message như Laravel.

#### 4.3. Views - Blade
Trong docs của Lumen không hề nhắc tới Blade, mình code thử và nhận thấy Lumen vẫn support Blade để làm view.

### 5. Tổng kết
Nói chung mình thấy dùng Lumen có thể đem lại performance tốt hơn cho ứng dụng nhỏ của bạn, tuy nhiên nó sẽ hạn chế đi rất nhiều tính năng mà mình thấy cần thiết ở mọi ứng dụng nên hãy cân nhắc kỹ trước khi chọn Lumen hay Laravel nhé.

ref:
* [https://lumen.laravel.com/docs/5.5](https://lumen.laravel.com/docs/5.5)
* [https://stackoverflow.com/questions/29647960/differences-and-similarities-between-lumen-and-laravel](https://stackoverflow.com/questions/29647960/differences-and-similarities-between-lumen-and-laravel)

----
