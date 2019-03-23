---
layout: post
title: Gửi SMS bằng Laravel phục vụ bảo mật 2 lớp
---

Có rất nhiều trang web bắt xác thực tài khoản sau khi đăng kí/đăng nhập, bằng cách người dùng phải nhập 1 đoạn code được gửi về email/số đt khi đăng kí.
Trong bài viết này, chúng ta sẽ tìm cách tích hợp hệ thống bảo mật 2 lớp đơn giản bằng `Middleware` và `Session` vào ứng dụng Laravel.

Quy trình thường thấy của một hệ thống login xác thực bằng số đt diễn ra như sau:
* Người dùng truy cập vào login page.
* Nhập tài khoản mật khẩu.
* Một đoạn code được gửi về số điện thoại.
* Quay trở lại trang web, nhập đoạn code được gửi về số đt rồi sử dụng trang web bình thường.

### 1. Tạo ứng dụng
#### 1.1 Tạo project Laravel thông qua composer
```sh
$ composer create-project --prefer-dist laravel/laravel otp
```

#### 1.2 Chuẩn bị dữ liệu
Sửa lại 1 chút file migrate cho bảng `users`:
```php
Schema::create('users', function (Blueprint $table) {
    $table->increments('id');
    $table->string('name')->nullable();
    $table->string('email')->unique();
    $table->string('phone')->unique();
    $table->string('password');
    $table->string('phone_code')->nullable();
    $table->rememberToken();
    $table->timestamps();
});
```
Chạy lệnh migration để tạo bảng dữ liệu
```
php artisan migrate
```

#### 1.3 Generate chức năng login mặc định của Laravel
Bằng cách chạy lệnh:
```sh
$ php artisan make:auth
```
chúng ta được như sau:
![](https://images.viblo.asia/b7899619-7e3d-4aea-8cf1-2a1a9a64b670.png)

#### 1.4 Cài đặt package `nexmo-laravel`
[Nexmo](https://developer.nexmo.com/messaging/sms/code-snippets/send-an-sms) là một dịch vụ của Vonage phát triển và tiếp thị API truyền thông để cho phép các nhà phát triển và doanh nghiệp nhanh chóng đổi mới cách họ giao tiếp với khách hàng bằng cách gọi điện, nhắn tin...

Cài đặt [nexmo-laravel](https://github.com/Nexmo/nexmo-laravel) thông qua composer bằng dòng lệnh:
```sh
$ composer require nexmo/laravel
```

Thêm `provider` và `alias` vào file `config/app.php`:
```php
// config/app.php

'providers' => [
    // Other service providers...

    Nexmo\Laravel\NexmoServiceProvider::class,
],

'aliases' => [
    ...
    'Nexmo' => Nexmo\Laravel\Facade\Nexmo::class,
],
```

Đăng kí tài khoản Nexmo ở đây: https://dashboard.nexmo.com/sign-up

Điền key và secret của nexmo vào file `.env`
```yaml
// .env
NEXMO_KEY=my_api_key
NEXMO_SECRET=my_secret
```

#### 1.5 Thêm view "Nhập OTP"
View này dùng để người dùng nhập OTP được gửi đến số điện thoại sau khi đăng nhập.
```php
// resources/views/auth/otp.blade.php
...
@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">One Time Password</div>

                    <div class="card-body">
                        <form method="POST" action="{{ route('otp.check') }}">
                            @csrf

                            <div class="form-group row">
                                <label for="name" class="col-md-4 col-form-label text-md-right">{{ __('Code') }}</label>

                                <div class="col-md-6">
                                    <input id="otp" type="text" class="form-control{{ $errors->has('otp') ? ' is-invalid' : '' }}" name="otp" value="{{ old('otp') }}" required autofocus>

                                    @if ($errors->has('otp'))
                                        <span class="invalid-feedback" role="alert">
                                        <strong>{{ $errors->first('otp') }}</strong>
                                    </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group row mb-0">
                                <div class="col-md-8 offset-md-4">
                                    <button type="submit" class="btn btn-primary">
                                        {{ __('Verify') }}
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
```

Chúng ta được:
![](https://images.viblo.asia/99ae7ec1-d462-48d5-8247-c3ff66c3be78.png)

#### 1.6 Định nghĩa thêm 1 middleware:
```php
// app/Http/Middleware/OtpMiddleware
public function handle($request, Closure $next, $guard = null)
{
    if (!$request->user()->isActiveOtp()) {
        return redirect('otp');
    }

    return $next($request);
}
```

```php
// app/User.php
public function isActiveOtp()
{
    if ($this->phone_code && session()->has('otp')) {
        return $this->phone_code == session()->get('otp');
    }

    return false;
}
```

```php
// app/Http/Kernel.php
protected $routeMiddleware = [
    'otp' => \App\Http\Middleware\OtpMiddleware::class,
];
```

#### 1.7 Tạo Controller view/post OTP và thêm Routes:
```php
// routes/web.php
...
Route::group(['middleware' => 'auth'], function () {
    Route::get('otp', 'OtpController@showOtpForm')->name('otp.show');
    Route::post('otp', 'OtpController@postOtp')->name('otp.check');

    Route::group(['middleware' => 'otp'], function () {
        Route::get('/', 'HomeController@index')->name('home');
    });
});
...
```

```php
// app/Http/Controllers/OtpController.php
public function showOtpForm()
{
    if (Auth::user()->isActiveOtp()) {
        return redirect('home');
    }
    return view('auth.otp');
}
```

#### 1.8 Xử lý gửi OTP
Thêm phần code xử lí tạo token và gửi token qua sms đến số điện thoại của người dùng sau khi đăng nhập thành công:
```php
// app/Http/Controllers/Auth/LoginController.php
...
public function authenticated(Request $request, $user)
{
    $code = str_random(6);
    $user->update([
        'phone_code' => $code,
    ]);

    return Nexmo::message()->send([
        'to'   => $user->phone,
        'from' => 'xxxxxxxx',
        'text' => "{$code} is your identity code."
    ]);
}
...
```

Mail nhận được:
![](https://images.viblo.asia/2eddd8a1-a4c5-42f2-b3ae-154d64495f34.png)

#### 1.9 Xử lí authenticate(chứng thực) bằng OTP
Giờ thì OTP đã gửi đến số điện thoại, tạo controller action để xử lý chuỗi sự kiện xảy ra khi người dùng nhập OTP. Chúng ta sẽ chứng thực người dùng trong method sau:
```php
// app/Http/Controllers/OtpController.php
public function postOtp(Request $request)
{
    if ($request->get('otp', null) == Auth::user()->phone_code) {
        session()->put(['otp' => $request->otp]);

        return redirect('home');
    }

    return back()->withInput()->withErrors(['otp' => 'Wrong identity code.']);
}
```
Sau khi click vào link trong email chúng ta được kết quả:
![](https://images.viblo.asia/907a2386-d7e1-4e09-940c-7610de8e5f2d.png)

### 2. Tổng kết
Như vậy, chúng ta đã thành công với với việc chứng thực 2 lớp thông qua sms. Đây là 1 cách hữu hiệu để bảo vệ tài khoản của người dùng khỏi bị tấn công.

Hi vọng bài viết hữu ích với các bạn :)

ref: [https://medium.com/techtrument/send-sms-from-laravel-application-d3ac9d1a4fac](https://medium.com/techtrument/send-sms-from-laravel-application-d3ac9d1a4fac)

----
