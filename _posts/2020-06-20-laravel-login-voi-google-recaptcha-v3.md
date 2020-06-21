---
layout: post
title: Laravel login với Google reCaptcha v3
---

Trong bài viết này, Mình sẽ triển khai cách xác thực người người dùng bằng Recaptcha trong Laravel 7.0.

![google-recaptcha-v3](/assets/google-recaptcha-v3.png)

Google ReCaptcha là một hệ thống giống như captcha, cung cấp bảo mật chống lại tin tặc và robot dò mã. Nó đảm bảo rằng người dùng máy tính là một con người. Đây là hệ thống captcha tốt nhất và được sử dụng nhiều nhất hiện có khi người dùng chỉ cần nhấp vào nút kiểm tra và trong một số trường hợp, thì là chọn một số hình ảnh tương tự liên quan đến câu hỏi conman.

Trong ví dụ này, mình sẽ tạo 1 form `login` và triển khai mã `captcha` của `Google`.

### Các bước triển khai cơ bản.

- Step 1: Cài đặt `Laravel 7.0`.
- Step 2: Đăng kí dịch vụ [Google Recaptcha v3](https://www.google.com/recaptcha/admin/create).
- Step 3: Cài đặt gói `biscolab/laravel-recaptcha`.
- Step 4: Triển khai Recaptcha vào source code.

### Cài đặt `Laravel 7.0`.

Sử dụng câu lệnh sau để cài đặt `laravel` bản mới nhất:

```bash
    $ composer create-project --prefer-dist laravel/laravel google-recaptcha-v3
```

Tạo chức năng đăng nhập với command của `laravel`:

```bash
    $ composer require laravel/ui

    $ php artisan ui vue --auth
```

### Đăng kí dịch vụ [Google Recaptcha v3](https://www.google.com/recaptcha/admin/create).

Tiếp theo các bạn hay truy cập vào link [https://www.google.com/recaptcha/admin/create](https://www.google.com/recaptcha/admin/create) để tạo `Google reCaptcha` cho website của bạn.

![google-recaptcha-v3](/assets/recaptchaReg.PNG)

Trang kế tiếp sau khi Submit sẽ như thế này.

![google-recaptcha-v3](/assets/recaptchaKey.PNG)

### Cài đặt gói [biscolab/laravel-recaptcha](https://laravel-recaptcha-docs.biscolab.com/docs/installation).

Sử dụng câu lệnh sau để cài đặt gói `biscolab/laravel-recaptcha`:

```bash
    $ composer require biscolab/laravel-recaptcha
```

Đăng kí `providers` và `aliases` trong `config/app.php`:

```php
    'providers' => [
        Biscolab\ReCaptcha\ReCaptchaServiceProvider::class,
    ];

    'aliases' => [
        'ReCaptcha' => Biscolab\ReCaptcha\Facades\ReCaptcha::class,
    ];
```

Publish cấu hình cho gói `biscolab/laravel-recaptcha`:

```sh
    $ php artisan vendor:publish --provider="Biscolab\ReCaptcha\ReCaptchaServiceProvider"
```

File `config/recaptcha.php` được sinh ra sau khi publish như sau:

```php
    return [
        'api_site_key'                  => env('RECAPTCHA_SITE_KEY', ''),
        'api_secret_key'                => env('RECAPTCHA_SECRET_KEY', ''),
        // changed in v4.0.0
        'version'                       => 'v3', // supported: "v3"|"v2"|"invisible"  <<==== trong bài viết này mình sử dụng v3
        // @since v3.4.3 changed in v4.0.0
        'curl_timeout'                  => 10,
        'skip_ip'                       => [], // array of IP addresses - String: dotted quad format e.g.: "127.0.0.1"
        // @since v3.2.0 changed in v4.0.0
        'default_validation_route'      => 'biscolab-recaptcha/validate',
        // @since v3.2.0 changed in v4.0.0
        'default_token_parameter_name' => 'token',
        // @since v3.6.0 changed in v4.0.0
        'default_language'             => null,
        // @since v4.0.0
        'default_form_id'              => 'biscolab-recaptcha-invisible-form', // Only for "invisible" reCAPTCHA
        // @since v4.0.0
        'explicit'                     => false, // true|false
        // @since v4.0.0
        'tag_attributes'               => [
            'theme'                    => 'light', // "light"|"dark"
            'size'                     => 'normal', // "normal"|"compact"
            'tabindex'                 => 0,
            'callback'                 => null, // DO NOT SET "biscolabOnloadCallback"
            'expired-callback'         => null, // DO NOT SET "biscolabOnloadCallback"
            'error-callback'           => null, // DO NOT SET "biscolabOnloadCallback"
        ]
    ];
```

Cập nhật API key trong `.env`:

```bash
    # in your .env file
    RECAPTCHA_SITE_KEY=YOUR_API_SITE_KEY
    RECAPTCHA_SECRET_KEY=YOUR_API_SECRET_KEY
```

### Triển khai Recaptcha vào source code.

Thêm `stack` script vào `app.blade.php`:

```php
    @yield('script')
```

Triển khai `biscolab-recaptcha` trong `login.blade.php`:

```php
    @section('script')
        <script type="text/javascript">
            function callbackThen(response){
                // read HTTP status
                console.log(response.status);

                // read Promise object
                response.json().then(function(data){
                    console.log(data);
                });
            }
            function callbackCatch(error){
                console.error('Error:', error)
            }
        </script>

        {!! htmlScriptTagJsApi([
            'action' => 'homepage',
            'callback_then' => 'callbackThen',
            'callback_catch' => 'callbackCatch'
        ]) !!}
    @endsection
```

Kết quả chúng ta được:

![google-recaptcha-v3](/assets/v3.PNG)

ref:

- [https://laravel-recaptcha-docs.biscolab.com/docs/intro](https://laravel-recaptcha-docs.biscolab.com/docs/intro)
- [https://m.dotdev.co/google-recaptcha-integration-with-laravel-ad0f30b52d7d](https://m.dotdev.co/google-recaptcha-integration-with-laravel-ad0f30b52d7d)

---
