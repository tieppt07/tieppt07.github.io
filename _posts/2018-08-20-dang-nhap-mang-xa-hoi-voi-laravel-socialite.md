---
layout: post
title: Đăng nhập mạng xã hội với Laravel Socialite
---

Hiện nay, với một trang web thì không thể thiếu được việc sử dụng các tài khoản mạng xã hội để đăng nhập. Ở bài viết này chúng ta sẽ tìm hiểu package `Laravel Socialite` của Laravel và sử dụng `Laravel Socialite` để đăng nhập bằng `Github`.

### 1. Laravel Socialite là gì?
* Là thư viện của Laravel hỗ trợ chức năng đăng nhập thông qua tài khoản của các dịch vụ social cung cấp OAuth.
* Hiện tại, Socialite hỗ trợ việc đăng nhập sử dụng tài khoản của: `facebook`, `twitter`, `linkedin`, `google`, `github` or `bitbucket`. Ngoài ra có rất nhiều các [drivers](https://socialiteproviders.github.io/contribute.html) khác.
* Được hỗ trợ từ phiên bản Laravel 5.0 trở lên
* Có thể cài đặt dễ dàng thông qua composer.

### 2. Cài đặt/Cấu hình Laravel Socialite
Chạy câu lệnh sau để cài đặt `Laravel Socialite`.
```
composer require laravel/socialite
```

Đăng kí `Service Provider` và `Facade` trong `config/app.php`.
```php
<?php
...
	'providers' => [
	    ...
	    Laravel\Socialite\SocialiteServiceProvider::class,
	],

	...

	'aliases' => [
     	...
    	'Socialite' => Laravel\Socialite\Facades\Socialite::class,
    ],
```

Thêm thông tin xác thực vào `config/service.php`.
```php
<?php
...
    'github' => [
        'client_id' => env('GITHUB_CLIENT_ID'),         // Your GitHub Client ID
        'client_secret' => env('GITHUB_CLIENT_SECRET'), // Your GitHub Client Secret
        'redirect' => env('GITHUB_CALLBACK_URL'),
    ],
```

### 3. Đăng kí ứng dụng trên Github
Đăng kí ứng dụng trên `Github` với link: [https://github.com/settings/developers](https://github.com/settings/developers).
![](https://images.viblo.asia/8c4894f0-dfde-4db8-97bd-084b9bbb8f69.png)

Sau khi đăng kí chúng ta sẽ có  `client_id` và `client_secret` như sau:
![](https://images.viblo.asia/1278dcdd-4238-46ff-9f79-330929dd5baa.png)

Thêm các thông tin `client_id`, `client_secret`, `redirect` vào file cấu hình `.env`.

### 4. Bắt đầu code
1 vài mạng xã hội không cung cấp cho chúng ta email, vì thế chúng ta sẽ sửa lại trường email và thêm `provider`, `provider_id` trong users.

```php
    $table->string('email')->unique()->nullable();
    $table->string('provider')->nullable();
    $table->string('provider_id')->nullable();
```

Tạo `routes (app/routes/web.php)` đăng nhập bằng mạng xã hội.
```php
    Route::get('login/{provider}', 'Auth\AuthController@redirectToProvider');
    Route::get('{provider}/callback', 'Auth\AuthController@handleProviderCallback');
```

Thêm link đăng nhập mạng xã hội trong file `login.blade.php`.
```php
<a class="btn btn-link" href="{{ url('login/github') }}">
    <i class="fa fa-github-official" aria-hidden="true"></i> Đăng nhập bằng Github
</a>
```

Code function đăng nhập mạng xã hội trong controller `Auth\AuthController.php`.

```php
<?php

namespace App\Http\Controllers\Auth;

...
use Socialite;
...

class AuthController extends Controller
{
    ...
    /**
     * Redirect the user to the Github authentication page
     *
     * @return Response
     */
    public function redirectToProvider($provider) {
        return Socialite::driver($provider)->redirect();
    }

    /**
     * Obtain the user information from Github
     *
     * @return Response
     */
    public function handleProviderCallback($provider)
    {
        // Get github's user infomation
        $user = Socialite::driver($provider)->user();

        // Tạo user với các thông tin lấy được từ github
        $createdUser = User::firstOrCreate([
            'provider' => $provider,
            'name' => $user->getName(),
            'nickname' => $user->getNickname(),
            'email' => $user->getEmail(),
            'avatar' => $user->getAvatar(),
            'provider_id' => $user->getId(),
            'token' => $user->token,
        ]);

        // Login với user vừa tạo.
        Auth::login($createdUser);

        return redirect('/');
    }
}
```

Sơ qua về luồng xử lý:
* User truy cập vào login/github.
* `Socialite::driver('github')->redirect()` được gọi, đoạn xử lý này làm nhiệm vụ redirect user tới trang xác thực của Github.
* Sau khi xác thực thành công sẽ redirect về Authorization callback URL và thực hiện lấy dữ liệu của user.
* Lưu thông tin user và đăng nhập.


**ref:**
[https://laravel.com/docs/5.6/socialite](https://laravel.com/docs/5.6/socialite)

----
