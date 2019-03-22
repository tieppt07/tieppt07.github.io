---
layout: post
title: Đăng nhập bằng MagicLink thay vì Password!
---

Bước xác minh, trong nhiều năm qua, đã có những bước tiến mạnh mẽ. Chúng ta đã chứng kiến sự thay đổi từ tổ hợp email-password sang xác minh mạng xã hội, và cuối cùng là xác minh lược bỏ password (mà thực ra lại giống kiểu xác minh "chỉ email" hơn). 
Trong trường hợp login lược bỏ password, ứng dụng sẽ giả định bạn nhận login link từ inbox nếu email được cung cấp đúng là của bạn.

Quy trình thường thấy của một hệ thống login không password diễn ra như sau:
* Người dùng truy cập vào login page
* Nhập địa chỉ email và xác nhận
* Một đường link được gửi đến email
* Khi click vào link, họ được chuyển hướng trở lại ứng dụng và đăng nhập
* Đường link bị vô hiệu hóa

Đây là một cách xác minh tiện lợi nếu bạn không tài nào nhớ được password cho ứng dụng đó, nhưng bạn lại nhớ email khai báo lúc đăng ký. Một điểm thú vị là thậm chí cả `Slack` cũng dùng đến kỹ thuật này.

Trong bài viết này, chúng ta sẽ tìm cách tích hợp hệ thống MagicLink vào ứng dụng Laravel.

### 1. Tạo ứng dụng
#### 1.1 Tạo project Laravel thông qua composer
```
composer create-project --prefer-dist laravel/laravel magiclink
```

#### 1.2 Chuẩn bị dữ liệu
Sửa lại 1 chút file migrate cho bảng `users`:
```php
Schema::create('users', function (Blueprint $table) {
    $table->increments('id');
    $table->string('name')->nullable();
    $table->string('email')->unique();
    $table->timestamp('email_verified_at')->nullable();
    $table->string('password')->nullable();
    $table->string('magic_link_token')->nullable();
    $table->rememberToken();
    $table->timestamps();
});
```

#### 1.3 Generate chức năng login mặc định của Laravel
Bằng cách chạy lệnh:
```
php artisan make:auth
```
chúng ta được như sau:
![](https://images.viblo.asia/b7899619-7e3d-4aea-8cf1-2a1a9a64b670.png)

#### 1.4 Thêm view "Login bằng MagicLink"
Thêm đường link "Login with MagicLink" để chuyển hướng người dùng sang custom login view, tại đây người dùng sẽ cung cấp địa chỉ email mà không cần nhập password.
```php
// resources/views/layouts/app.blade.php
...
@guest
    <li class="nav-item">
        <a class="nav-link" href="{{ route('magic_link.show') }}">{{ __('Login with MagicLink') }}</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="{{ route('login') }}">{{ __('Login') }}</a>
    </li>
    @if (Route::has('register'))
        <li class="nav-item">
            <a class="nav-link" href="{{ route('register') }}">{{ __('Register') }}</a>
        </li>
    @endif
@else
...
```

```php
// resources/views/auth/magic_link/login.blade.php
@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Login') }}</div>

                <div class="card-body">
                    @if (session('success'))
                        <div class="alert alert-success">
                            {{ session('success') }}
                        </div>
                    @endif
                    <form method="POST" action="{{ route('magic_link.send_token') }}">
                        @csrf

                        <div class="form-group row">
                            <label for="email" class="col-md-4 col-form-label text-md-right">{{ __('E-Mail Address') }}</label>

                            <div class="col-md-6">
                                <input id="email" type="email" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" value="{{ old('email') }}" required autofocus>

                                @if ($errors->has('email'))
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $errors->first('email') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>

                        <div class="form-group row">
                            <div class="col-md-6 offset-md-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>

                                    <label class="form-check-label" for="remember">
                                        {{ __('Remember Me') }}
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group row mb-0">
                            <div class="col-md-8 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    {{ __('Send Magic Link') }}
                                </button>

                                <a class="btn btn-link" href="{{ route('login') }}">
                                    {{ __('Login with Password') }}
                                </a>
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
![](https://images.viblo.asia/3e6d2f13-c580-4d3c-bd09-9ea5a7054e6a.png)
#### 1.5 Tạo Controller và thêm Routes:

```php
// routes/web.php
...
Route::get('/login/magic-link', 'Auth\MagicLinkLoginController@showLoginForm')->name('magic_link.show');
Route::post('/login/magic-link', 'Auth\MagicLinkLoginController@sendToken')->name('magic_link.send_token');
Route::get('/login/magic-link/{token}', 'Auth\MagicLinkLoginController@authenticate')->name('magic_link.authenticate');
...
```

```php
// app/Http/Controllers/Auth/MagicLoginController.php
<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;

class MagicLinkLoginController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function showLoginForm()
    {
        return view('auth.magic_link.login');
    }
}
```

#### 1.6 Xử lý gửi MagicLink
Thêm phần code xử lí tạo token và gửi MagicLink cho email:
```php
// app/Http/Controllers/Auth/MagicLoginController.php
...
use Illuminate\Http\Request;
use App\User;
use Mail;
...
public function sendToken(Request $request)
{
    $this->validate($request, [
        'email' => 'required|email|max:255|exists:users,email'
    ]);

    $user = User::whereEmail($request->email)->first();

    $user->update([
        'magic_link_token' => str_random(50),
    ]);

    $magicLink = route('magic_link.authenticate', [
        $user->magic_link_token,
        'remember' => $request->get('remember'),
        'email' => $request->email,
    ]);

    Mail::raw(
        "Click link to login: $magicLink",
        function ($message) use ($user) {
            $message->to($user->email)
                    ->subject('Click the magic link to login');
        }
    );

    return back()->with('success', 'We\'ve sent you a magic link!');
}
...
```

Thử nhập email và bấm nút "Send Magic Link" được:
![](https://images.viblo.asia/a2e1fba9-0e8b-4753-82ae-3b6fdf212833.png)

Mail nhận được:
![](https://images.viblo.asia/036465aa-fa4e-4568-81a3-efc86972dc9a.png)

#### 1.7 Xử lí authenticate(chứng thực) bằng MagicLink
Giờ thì chúng ta đã có URL, tạo controller action để xử lý chuỗi sự kiện xảy ra khi người dùng click vào URL từ email. Tạo action authenticate trong MagicLoginController. Chúng ta sẽ xác minh người dùng ngay trong method này:
```php
// app/Http/Controllers/Auth/MagicLoginController.php
...
use Auth;
...
public function authenticate(Request $request, $token)
{
    $user = User::whereMagicLinkToken($token)->first();
    Auth::login($user, $request->remember);

    return redirect('home');
}
...
```
Sau khi click vào link trong email chúng ta được kết quả:
![](https://images.viblo.asia/907a2386-d7e1-4e09-940c-7610de8e5f2d.png)

### 2. Tổng kết
Như vậy, chúng ta đã thành công với cách đăng nhập không password bên cạnh cách xác minh truyền thống. Nhiều người cho rằng cách này sẽ mất nhiều thời gian hơn cách đăng nhập bằng password thông thường, nhưng dùng password liệu có nhanh và bảo mật hơn chăng?

Hi vọng bài viết hữu ích với các bạn :)

ref: https://www.sitepoint.com/lets-kill-the-password-magic-login-links-to-the-rescue/