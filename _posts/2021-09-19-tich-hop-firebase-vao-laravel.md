---
layout: post
title: "Tích hợp Firebase vào Laravel"
---

Firebase là một nền tảng để phát triển ứng dụng di động và trang web, bao gồm các API đơn giản và mạnh mẽ mà không cần backend hay server.

![firebase](/images/posts/firebase-la-gi.jpg)

Lợi ích của Firebase là gì? Firebase còn giúp các lập trình viên rút ngắn thời gian triển khai và mở rộng quy mô của ứng dụng mà họ đang phát triển.
Firebase là dịch vụ cơ sở dữ liệu hoạt động trên nền tảng đám mây – cloud. Kèm theo đó là hệ thống máy chủ cực kỳ mạnh mẽ của Google. Chức năng chính là giúp người dùng lập trình ứng dụng bằng cách đơn giản hóa các thao tác với cơ sở dữ liệu. Cụ thể là những giao diện lập trình ứng dụng API đơn giản
Đặc biệt, còn là dịch vụ đa năng và bảo mật cực tốt. Firebase hỗ trợ cả hai nền tảng Android và IOS. Không có gì khó hiểu khi nhiều lập trình viên chọn Firebase làm nền tảng đầu tiên để xây dựng ứng dụng cho hàng triệu người dùng trên toàn thế giới.

### Ưu điểm nổi bật của Firebase

- Tạo tài khoản và sử dụng dễ dàng
- Tốc độ phát triển nhanh
- Nhiều dịch vụ trong một nền tảng
- Được cung cấp bởi Google
- Tập trung vào phát triển giao diện người dùng
- Firebase không có máy chủ
- Học máy (Machine Learning)
- Tạo lưu lượng truy cập
- Theo dõi lỗi
- Sao lưu

### Các hạn chế của Firebase

- Không phải là mã nguồn mở
- Người dùng không có quyền truy cập mã nguồn
- Firebase không hoạt động ở nhiều quốc gia
- Chỉ hoạt động với Cơ sở dữ liệu NoSQL
- Không phải tất cả các dịch vụ Firebase đều miễn phí
- Chỉ chạy trên Google Cloud
- Thiếu Dedicated Servers và hợp đồng doanh nghiệp
- Không cung cấp các API GraphQL

### Tích hợp Firebase vào dự án Laravel

#### Tạo firebase project

1. Truy cập vào URL https://console.firebase.google.com để tạo project.

![firebase-add-project](/images/posts/firebase-add-project.png)

Truy cập vào trang quản lí project:

![firebase-admin](/images/posts/firebase-admin.png)

2. Tạo key cho projects

Truy cập vào URL Service Accoung https://console.cloud.google.com/iam-admin/serviceaccounts.

![firebase-service-acc](/images/posts/firebase-service-acc.png)

Bấm vào dấu 3 chấm để tạo key, chọn loại `json`. File json sẽ gồm các thông tin sau:

```json
{
  "type": "service_account",
  "project_id": "xxx",
  "private_key_id": "xxx",
  "private_key": "-----BEGIN PRIVATE KEY-----\nxxx\n-----END PRIVATE KEY-----\n",
  "client_email": "xxx@appspot.gserviceaccount.com",
  "client_id": "xxx",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x5/xxx%40appspot.gserviceaccount.com"
}

```

### Cài đặt Firebase PHP SDK kreait/firebase-php

Cài đặt package bằng composer:

```bash
$ composer require kreait/firebase-php
```

Thêm provider vào config:

```php
<?php
// config/app.php
return [
    // ...
    'providers' => [
        // ...
        Kreait\Laravel\Firebase\ServiceProvider::class
    ]
    // ...
];
```

Publish firebase config:

```bash
$ php artisan vendor:publish --provider="Kreait\Laravel\Firebase\ServiceProvider" --tag=config
```

Gán giá trị `GOOGLE_APPLICATION_CREDENTIALS` là đường dẫn file json:

```
// .env Mình đặt file json bằng cấp với file .env
GOOGLE_APPLICATION_CREDENTIALS=./firebase_credentials.json
```

Tạo FirebaseService để tương tác với Google Firebase:

```php
<?php
// app/Services/FirebaseService.php
namespace App\Services;

class FirebaseService
{
    protected $auth;

    public function __construct()
    {
    }
}
```

Tạo thử token:

```php
<?php

namespace App\Services;

use Kreait\Firebase\Auth;

class FirebaseService
{
    protected $auth;

    public function __construct(
        Auth $auth
    ) {
        $this->auth = $auth;
    }

    public function createCustomToken()
    {
        $uid = 'some-uid';
        $customToken = $this->auth->createCustomToken($uid);
        dd($customToken->toString());
    }
}
```

Kết quả:

![firebase-token](/images/posts/firebase-token.png)

### Tương tác với Firebase Realtime Database

```php
<?php
// ...
use Kreait\Firebase\Database;

class FirebaseService
{
    protected $auth;

    public function __construct(
        Database $database
    ) {
        $this->database = $database;
    }

    public function save()
    {
        $this->database->getReference('users')->push([
            'name' => 'phung.xuan.tiep',
            'email' => 'phung.xuan.tiep@sun-asterisk.com',
        ]);
    }
}
```

Kết quả:

![firebase-rtd](/images/posts/firebase-rtd.png)

#### Truy xuất dữ liệu

`Database Snapshots` là bản sao bất biến của dữ liệu tại vị trí Cơ sở dữ liệu Firebase tại thời điểm truy vấn. Không thể sửa đổi và sẽ không bao giờ thay đổi.

```php
$reference = $this->database
    ->getReference('path/to/child/location')
    ->getSnapshot()
    ->getValue();
//
// [
//   "-Mk1Ez5T7y0IzG-Fvtyn" => [
//     "email" => "phung.xuan.tiep@sun-asterisk.com",
//     "name" => "phung.xuan.tiep",
//   ]
// ]
```

`Shallow queries` là một tính năng nâng cao, được thiết kế để giúp bạn làm việc với bộ dữ liệu lớn mà không cần tải xuống mọi thứ. Đặt giá trị này thành true để giới hạn độ sâu của dữ liệu được trả về tại một vị trí. Nếu dữ liệu tại vị trí là nguyên thủy JSON (chuỗi, số hoặc boolean), giá trị của nó sẽ đơn giản được trả về.

Nếu ảnh chụp nhanh dữ liệu tại vị trí là đối tượng JSON, các giá trị cho mỗi khóa sẽ bị cắt ngắn thành true.

```php
$reference = $this->database
    ->getReference('path/to/child/location')
    ->shallow()
    ->getSnapshot()
    ->getValue();
//
// [
//   "-Mk1Ez5T7y0IzG-Fvtyn" => true
// ]
```

Tham khảo thêm tại [https://firebase-php.readthedocs.io/en/stable/realtime-database.html](https://firebase-php.readthedocs.io/en/stable/realtime-database.html).



Chúng ta sẽ tương tác với với nhiều chức năng khác của firebase ở các bài sau...


Tham khảo
- [https://wiki.matbao.net/firebase-la-gi-giai-phap-lap-trinh-khong-can-backend-tu-google/](https://wiki.matbao.net/firebase-la-gi-giai-phap-lap-trinh-khong-can-backend-tu-google/)
- [https://firebase-php.readthedocs.io/en/stable/authentication.html](https://firebase-php.readthedocs.io/en/stable/authentication.html)
- [https://firebase-php.readthedocs.io/en/stable/setup.html](https://firebase-php.readthedocs.io/en/stable/setup.html)

---
