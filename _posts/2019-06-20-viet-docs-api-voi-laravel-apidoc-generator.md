---
layout: post
title: Viết API docs với Laravel Apidoc Generator
---

Sau một thời gian dài viết document API bằng "cơm" thì được anh em khai sáng cho một số Tools hỗ trợ. Trong bài viết này, mình xin phép được chia sẻ một công cụ khá hay cũng như sơ qua cách sử dụng `Laravel Api Doc Generator`.

![](/images/posts/201906-banner-0_kO-ZlVt37tyk9TlK.jpg)

### 1. Cài đặt
#### Yêu cầu
tối thiểu PHP 7 và Laravel 5.5

#### Cài đặt
Cài đặt bằng composer:
```sh
$ composer required mpociot/laravel-apidoc-generator
```

Thêm ServiceProvider vào config:
```php
// config/app.php
'providers' => [
    \Mpociot\ApiDoc\ApiDocGeneratorServiceProvider::class,
]
```

Tạo file config: `config/apidoc.php`
```sh
$ php artisan vendor:publish --provider="Mpociot\ApiDoc\ApiDocGeneratorServiceProvider" --tag=apidoc-config
```

Chạy thử xem sao :D
```sh
php artisan apidoc:generate
```
Kết quả chúng ta được
![](/images/posts/ScreenShot2019-06-21at10.51.17PM.png)

Sau khi quá trình này được hoàn tất, tài liệu HTML sẽ được ghi vào file: public\docs\index.html
Bật server và truy cập vào `http://localhost:8000/docs/index.html` docs để xem kết quả:
```sh
php artisan server
```
![](/images/posts/ScreenShot2019-06-21at10.56.09PM.png)

### 3. Phân tích
- Cột bên trái là list các `routes` được code trong dự án.
- Phần còn lại là thông tin chi tiết của API đấy:
    - Phương thức: GET/POST/PATCH/PUT/DELETE.
    - Route.
    - Example request & example response.
- Các routes không được xử lí trong controllers sẽ bị skip generate docs.
- Phần mô tả routes ở cột bên trái chính là comment của function xử lí routes đó trong controller.

### 4. Cấu hình
Giờ thì cùng xem file config/apidoc.php có những thông số gì nào?

- `output`: đây là thiết lập đường dẫn cho file Document của bạn khi nó sinh ra. File document này được sinh ra là 1 file HTML và có chứa cả CSS, vì vậy hãy sử dụng đường dẫn tuyệt đối cho nó. Nếu bạn không thay đổi gì thì đường dẫn mặc định là public/docs
- `base_url`: base URL sẽ được sử dụng cho các ví dụ và Postman collection. Giá trị mặc định của base URL được lấy trong config(app.url)
- `postman`: không chỉ tạo ra một file document thông thường, laravel-apidoc-generator còn hỗ trợ sinh ra Postman Collection (nếu chưa biết về Postman thì bạn có thể tìm hiểu ở đây nhé)
- `enabled`: có sinh ra Postman Collection hay không. Giá trị mặc định ở đây là true
- `name`: đặt tên cho collection được xuất ra. Nếu bạn để trống thì sẽ lấy tên mặc định từ config('app.name')."API"
- `description`: mô tả chi tiết cho collection
- `logo`: thay vì sử dụng logo mặc định, bạn có thể tùy chỉnh logo của project của bạn trong file Document. Cũng giống như output, bạn phải sử dụng đường dẫn tuyệt đối đến file logo của bạn. Chú ý: ảnh logo nên để kích thước 230 x 52.
    ```php
    'logo' => resource_path('views') . '/api/logo.png'
    ```
- `routes`: phần này được lưu trữ dưới dạng mảng các route, mỗi route chứa một số quy định xem routes nào thuộc group nào, áo dụng những quy định nào. Điều này giúp cho chúng ta có thể tuỳ chỉnh những chi tiết cho từng route.
- `match`: xác định các quy định được sử dụng trong route thuộc một group. Có 3 loại rules được định nghĩa ở đây:
- `domains`: trong 1 project có thể có
- `prefixes`: đây là phần tiền tố cho các route. Kiểu như các route có domain và prefix chỉ định thì sẽ áp dụng các rule chỉ định. Ví dụ như sau:
    ```php
    <?php
        return [
            'routes' => [
                //những route có tiền tố là users hoặc apps thì sẽ cần xác thực người dùng, sử dungj authorization truyền trong headers
                [
                    'match' => [
                        'domains' => ['*'],
                        'prefixes' => ['users/*', 'apps/*'],
                    ],
                    'apply' => [
                        'headers' => [ 'Authorization' => 'Bearer {your-token}']
                    ]
                ],
                // còn những route có tiền tố là stats, status thì public và không cần xác thực
                [
                    'match' => [
                        'domains' => ['*'],
                        'prefixes' => ['stats/*', 'status/*'],
                ],
            ],
        ],
    ];
    ```
- `versions`: đây là đánh số phiên bản cho các route. CHÚ Ý: phần này chỉ hoạt động nếu bạn sử dụng Dingo Router.
- `apply`: sau khi định nghĩa trong match, trong phần apply sẽ chỉ định những thiết lập được áp dụng cho những routes này khi chạy lệnh generate.
- `headers`: phần header này sẽ được hiển thì trong phần example requests trong tài liệu (cột đen ở phía bên phải màn hình ấy). Headers được khai báo dưới dạng key => value như thế này:
    ```php
    'headers' => [
        'Authorization' => 'Bearer {token}',
        'Api-Version' => 'v2',
    ],
    ```
- `response_calls`: mặc định, response call sẽ chỉ được sinh ra cho những route có method GET, tuy nhiên bạn vẫn có thể tự cấu hình chi tiết.



Ref:
- [https://laravel-apidoc-generator.readthedocs.io/en/latest/](https://laravel-apidoc-generator.readthedocs.io/en/latest/)

---
