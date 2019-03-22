---
layout: post
title: Laravel 5.7 có gì mới?
---

Laravel hiện nay là một PHP framework phổ biết nhất, có cộng đồng mã nguồn mở đóng góp và hỗ trợ rất tuyệt vời. Phiên bản 5.7 vừa được released vào tháng 08/2018. Bản phát hành 5.7 này sẽ nhận được bản sửa lỗi cho đến tháng 2 năm 2019 và các bản sửa lỗi bảo mật cho đến tháng 8 năm 2019. Bản phát hành này tiếp tục cải tiến cho phiên bản 5.6 trước đó và cũng bao gồm một số tính năng mới thú vị.
![](https://images.viblo.asia/2b68faad-fbc2-47b9-b552-3d9bb3167555.png)
Chúng ta sẽ tìm hiểu những tính năng mới mà phiên bản 5.7 cho ra mắt.

### 1. Resources directory
* Thư mục `assets` bên trong thư mục `Resources` sẽ không còn nữa, các thư mục con bên trong `assets` sẽ được move ra ngoài thư mục `Resources`.

    ```
    /resources
    ├── js
    ├── lang
    ├── sass
    └── views
    ```

### 2. URL Generator & Callable Syntax
* Hàm `action` để generate URL trong helper đã được cải tiến cho phép gọi như sau:
    ```php
    // 5.7
    $url = action([UserController::class, 'index']);
    $url = action([UserController::class, 'show'], ['id' => 1]);
    
    // 5.6
    $url = action('UserController@index');
    $url = action('UserController@show', ['id' => 1]);
    ```
    
### 3. New Pagination
* Cập nhật ở phiên bản này cho phép bạn hiển thị số lượng link tùy ý ở phần phân trang với method `onEachSide`:

    ```php
    {{ $paginator->links() }}
    ```
    Mặc định sẽ có 3 trang cạnh trang hiện tại được tạo ra:
    ![](https://images.viblo.asia/9fe05196-e47c-47f6-bfd1-d19ac847d569.png)
    
    ```php
    {{ $users->onEachSide(5)->links() }}
    ```
    Với config này phần phân trang sẽ hiển thị tối đa 5 link đến các trang khác.
    ![](https://images.viblo.asia/6e303ac4-64aa-484a-beaa-9200c64e1996.png)
    
### 4. Email Verification
* Đây là tính năng xác minh email người dùng khi sử dụng authentication mặc định của laravel.
* Cột mới email_verified_at đã được thêm vào bảng users để phục vụ chức năng này. Bạn thậm chí không phải update lại file migration vì file này đã được cập nhật thêm cột `email_verified_at` rồi. Việc của bạn chỉ là migrate dữ liệu.
    ```
    $table->timestamp('email_verified_at')->nullable();
    ```
* Đồng thời bạn cần implement `MustVerifyEmail` interface vào model `User`:
    ```php
    use Illuminate\Contracts\Auth\MustVerifyEmail; 

    class User extends Authenticatable implements MustVerifyEmail 
    { 
        // ... 
    }
    ```
    
### 5. Improved Error Messages
![](https://images.viblo.asia/5cc22969-ef14-45a8-8caf-2e3f81f66f62.png)
* Ở phiên bản 5.6 giả sử trong đoạn code của chúng ta có đoạn viết như sau:
    ```php
    App\User::forst();
    ```
* Ngay lập tức ta nhận được ngay message dưới đây:
    ```
    BadMethodCallException with message 'Method Illuminate/Database/Query/Builder::forst does not exist.'
    ```
Quá mơ hồ và khó hiểu phải không nào, class `App\User` kế thừa từ hàng đống class khác và `Builder` chính là class nằm ở tầng sâu nhất. Vậy cho nên khi gọi đến phương thức chưa được định nghĩa, hệ thống báo lỗi sẽ lôi thằng cuối cùng ra chịu trận mà không phải là chính ngay dòng code bị lỗi.

Kể từ phiên bản Laravel 5.7 sẽ cải thiện các thông báo lỗi này trong các thành phần của framework Laravel.

### 6. Laravel Dump Server
* Dump-server của Symphony được tích hợp trên Laravel 5.7. Nó là một lệnh thông qua gói được xây dựng bởi một thành viên cộng đồng của Laravel, Marcel Pociot.

* Lệnh này chạy ngầm trên server. Nó nhận dữ liệu được gửi từ ứng dụng và hiển thị thông qua bảng điều khiển (console). Bạn không bao giờ phải lo lắng khi chạy lệnh này, vì khi lệnh này không chạy thì dump() hoạt động như mặc định.

    ```
    php artisan dump-server

    // Output to the HTML file.
    php artisan dump-server --format=html > report.html
    ```

![](https://images.viblo.asia/c1fb8023-729d-421c-879a-8358e0448b60.png)
### Kết luận
Những thay đổi ở bản 5.7 là không quá nhiều, nhưng đó là những thay đổi tích cực, hỗ trợ tốt hơn cho chứng ta thực hiện dự án, công việc của mình.

ref: https://sujipthapa.co/blog/whats-new-coming-to-laravel-57-release