---
layout: post
title: Lần đầu viết PHP package cho Laravel
---

Hiện nay, Laravel là một framework PHP được rất nhiều công ty sử dụng để triển khai các dự án. Khi thực hiện một chức năng trong ứng dụng laravel có nhiều chức năng ở trong nhiều dự án khác nhau. Vậy nên để sử dụng lại các chức năng đó chúng ta tạo một package, khi cần sử dụng chúng ta chỉ cần require vào ứng dụng laravel của mình. Vậy để làm sao để tạo và publish một package? Cùng mình tìm hiểu trong bài viết này nhé. Bắt đầu nào 😄

![](/images/posts/Packagist.png)

### 1. Cài đặt project Laravel
Vì một package được tạo để thêm chức năng bổ sung cho ứng dụng Laravel của chúng ta, nên điều đầu tiên chúng ta cần làm là cài đặt project Laravel. Cách đơn giản nhất là:
```sh
composer create-project --prefer-dist laravel/laravel demoPackage
```

### 2. Cấu trúc thư mục
Tiếp theo, Chúng ta tạo một thư mục packages để chứa package trong thư mục gốc ứng dụng của chúng ta. Quy ước đặt tên package sẽ như sau:
```
creator/package_name
```

Ví dụ: Như package spatie/laravel-fractal thì spatie là tên người tạo, laravel-fractal là tên package .

Tương tự như thế, mình sẽ đặt tên package của mình như sau tieppx/firstpackage. Tạo thư mục bên trong thư mục packages mà chúng ta đã tạo, cấu trúc sẽ như sau:
```
- packages
    - tieppx
        - firstpackage
            - src
```

### 3. Tạo file composer
Mỗi package nên có một tệp composer.json, một tệp sẽ chứa tất cả các packages và các dependencies của chúng. Bên trong thư mục firstpackage chúng ta chạy lệnh sau:

```sh
composer init
```

Trên terminal sẽ hiển thị để chúng ta nhập các thông tin về package. Các bạn có thể bỏ qua phần này bằng cách ấn phím enter và nó sẽ lấy các giá trị mặc định, các bạn có thể thay đổi thông tin này trong file composer.json, nội dung file sau khi chúng ta tạo:
```composer
{
    "name": "tieppx/firstpackage",
    "authors": [
        {
            "name": "tieppx",
            "email": "tieppx@example.com"
        }
    ],
    "require": {}
}
```

Trong composer.json của chúng ta, chúng ta cần yêu cầu nó tự động tải các tệp của chúng ta, thêm vào composer.json đoạn code dưới đây:
```
"autoload": {
    "psr-4": {
        "tieppx\\firstpackage\\": "src/"
    }
}
```

### 4. Tạo service provider cho package
Service provider là điểm truy cập vào package của chúng ta. Đây là nơi duy trì tất cả các thông tin liên quan đến package của chúng ta, chẳng hạn như vị trí của views, migration, routes,... được load Bạn có thể đọc thêm về service provider trong tài liệu chính thức của Laravel.
Trong thư mục src bên trong thư mụcpackages, chúng ta tạo file `FirstPackageServiceProvider.php`:
```
- packages
    - tieppx
        - firstpackage
            - src
                - FirstPackageServiceProvider.php
            - composer.json
```

Một số điều chúng ta cần quan tâm về service provider ở đây là:

- Namespace
- Hai phương thức bắt buộc mà mọi service provider phải có (mỗi service provider gói Laravel phải có ít nhất hai phương thức: `boot()` và `register()`).
Nội dung file service provider sẽ như sau:

    ```php
    <?php
    namespace tieppx\firstpackage;

    use Illuminate\Support\ServiceProvider;

    class ContactFormServiceProvider extends ServiceProvider {
        public function boot()
        {

        }
        public function register()
        {

        }
    }
    ```


Trước khi chúng ta boot hoặc register package của chúng ta, chúng ta cần cung cấp service provider của chúng ta trong `config/app.php`:
```php
'providers' => [
    /*
    * Application Service Providers...
    */

    App\Providers\RouteServiceProvider::class,
    tieppx\firstpackage\FirstPackageServiceProvider::class,
]
```

### 5. Load package từ file composer của ứng dụng laravel
Vì chúng ta chưa triển khai package của chúng ta và nó chưa nằm trong thư mục vendor nên chúng ta cần cho laravel biết cách tải package của chúng ta như thế nào và sử dụng các chức năng của nó. Vì vậy, bên trong ứng dụng laravel của chúng ta file composer.json sẽ thêm dòng sau:
```
"autoload": {
    "psr-4": {
        "App\\": "app/",
        "tieppx\\firstpackage\\": "packages/tieppx/firstpackage/src/"
    },
    "classmap": [
        "database/seeds",
        "database/factories"
    ]
},
"autoload-dev": {
    "psr-4": {
        "Tests\\": "tests/",
        "tieppx\\firstpackage\\": "packages/tieppx/firstpackage/src/"
    }
},
```

Sau đó, trên terminaltrong thư mục gốc của ứng dụng laravel của chúng ta chạy:
```sh
composer dump-autoload
```

### 6. Tạo thư mục resources, Models, Http, Database, routes trong package
Trong thư mục src của package chúng ta tạo các thư mục views, models, controller, migration, routes, cấu truc thư mục sẽ như sau:
```
- packages
    - tieppx
        - firstpackage
            - src
                - Database
                    - migration
                - Http
                    - controllers
                - Models
                - resources
                    - views
                - routes
                - FirstPackageServiceProvider.php
            - composer.json
```


### 7. Lời kết
Trong bài viết này, mình đã giới thiệu qua về cấu trúc thư mục, các thư mục và các file cần thiết để tạo một package, trong bài viết sau Tạo một package Laravel như thế nào? (P2) mình sẽ cùng các bạn tạo một package và publish package trên packagist và sử dụng package mà chúng ta đã publish 😄 Cảm ơn các bạn đã theo dõi bài viết
---
