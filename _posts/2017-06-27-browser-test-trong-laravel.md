---
layout: post
title: Browser test trong Laravel
---

Unit test là 1 bước rất quan trọng trong quá trình phát triển sản phẩm. Với ngôn ngữ PHP, PhpUnit được tích hợp trong Laravel cùng với những method được viết sẵn phục vụ chúng ta dễ dàng test dự án hơn.

Laravel giúp chúng ta test dự án với 4 mục như sau:
    - HTTP
    - Browser
    - Database
    - Mocking

Ở bài này, chúng ta sẽ tìm hiểu về Browser test của Laravel.

## 1. Cài đặt `dusk`

Để chạy được browser test chúng ta cần cài đặt `dusk`  với câu lệnh sau:

```sh
$ composer require laravel/dusk
```

Sau khi chạy command trên, chúng ta cần đăng kí service provider `Laravel\Dusk\DuskServiceProvider` trong method `register` của provider
`AppServiceProvider`.

```php
use Laravel\Dusk\DuskServiceProvider;

/**
 * Register any application services.
 *
 * @return void
 */
public function register()
{
    if ($this->app->environment('local', 'testing')) {
        $this->app->register(DuskServiceProvider::class);
    }
}
```

Config url và môi trường của dự án trong file .env
```yaml
APP_URL=http://localhost:8000
APP_ENV=local
```

Chạy command tiếp theo:

```sh
$ php artisan dusk:install
```

Sau khi chạy xong lệnh trên, folder `/app/tests/Browser` được tạo ra và có chứa file `ExampleTest`.

`/app/tests/Browser/ExampleTest.php`

```php
<?php

namespace Tests\Browser;

use Tests\DuskTestCase;
use Laravel\Dusk\Browser;
use Illuminate\Foundation\Testing\DatabaseMigrations;

class ExampleTest extends DuskTestCase
{
    /**
     * A basic browser test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $this->browse(function (Browser $browser) {
            $browser->visit('/')
                    ->assertSee('Laravel');
        });
    }
}
```

Method `testBasicExample` trên xác nhận có text 'Laravel' ở trong page.

Để chạy unit tests, chúng ta sử dụng câu lệnh sau:

```sh
$ php artisan dusk
```

Kết quả:

```
PHPUnit 5.7.21 by Sebastian Bergmann and contributors.

.                                                                   1 / 1 (100%)

Time: 1.8 seconds, Memory: 10.00MB

OK (1 test, 1 assertion)
```

## 2. Sử dụng và một vài ví dụ cụ thể

Để tạo 1 class test, chúng ta sử dụng command artisan: `dusk:make`.  File test được sinh ra trong folder `/app/tests/Browser`
```sh
$ php artisan dusk:make LoginTest
```

Một vài ví dụ cụ thể:

Test chức năng đăng nhập
```php
// /app/tests/Browser/LoginTest.php
public function testLogin()
{
    $user = User::where('email', 'admin@laravel.com')->first();
    if (!$user) {
        $user = factory(User::class)->create([
            'email' => 'admin@laravel.com',
            'password' => bcrypt('secret'),
        ]);
    }

    $this->browse(function (Browser $browser) use ($user) {
        $browser->visit('/login') // vào trang login page
                ->type('email', $user->email) // nhập ô text email
                ->type('password', 'secret') // nhập ô password
                ->press('Login') // bấm nút Login
                ->assertPathIs('/home');
    });
}
```

Giả lập ngường dùng đã đăng nhập để vào được màn hình `/home` với method `loginAs`
```php
$this->browse(function ($first, $second) {
    $first->loginAs(User::find(1))
          ->visit('/home');
});
```

Test chức năng chat websocket, Laravel support `Multiple Browsers` để dùng nhiều browsers trong 1 lần chạy unit test.
```php
$this->browse(function ($first, $second) {
    // Xác thực ngường dùng với method loginAs
    $first->loginAs(User::find(1))
          ->visit('/home')
          ->waitForText('Message');

    $second->loginAs(User::find(2))
           ->visit('/home')
           ->waitForText('Message')
           ->type('message', 'Hey Taylor')
           ->press('Send');

    $first->waitForText('Hey Taylor')
          ->assertSee('Jeffrey Way');
});
```

## 3. Tương tác với các elements trong html
Laravel cung cấp rất nhiều các method được dựng sẵn phục vụ việc tự động trong quá trình Browser test

```php
// Click link
$browser->clickLink($linkText);

// Retrieving values
$value = $browser->value('selector');
$text = $browser->text('selector');
$attribute = $browser->attribute('selector', 'value');

// Setting value
$text = $browser->text('selector');

// Nhập giá trị input email
$browser->type('email', 'taylor@laravel.com');

// Xoá input type email
$browser->clear('email');

// Chọn giá trị dropdown
$browser->select('size', 'Large');

// Chọn giá trị checkbox
$browser->check('terms');
$browser->uncheck('terms');

// Chọn giá trị radio
$browser->radio('version', 'php7');

// Nhập input file
$browser->attach('photo', __DIR__.'/photos/me.png');


// Click on elements
$browser->click('.selector');

// Drag & Drop
$browser->drag('.from-selector', '.to-selector');

// Dừng unit test lại 1 khoảng thời gian (unit: miliseconds)

```



## 4. Các Assertions khả dụng
Laravel cung cấp rất nhiều 'xác nhận' mà bạn có thể sử dụng để chạy unittest 1 cách dễ dàng

| Assertions | Description |
| -------- | -------- |
| assertTitle($title) | Xác nhận page title match với $title |
| assertTitleContains($title) | Xác nhận page title chứa $title |
| assertPathIs('/home') | Xác nhận đường dẫn hiện tại match với /home |
| assertPathIsNot('/home') | Xác nhận đường dẫn hiện tại ko match với /home |
| assertRouteIs($name, $parameters) | Xác nhận URL hiện tại match với route name $name |
| assertQueryStringHas($name, $value) | Xác nhận truy vấn đã tham số $name có giá trị $value |
| assertQueryStringMissing($name) | Xác nhận truy vấn thiếu tham số $name |
| assertHasCookie($name) | Xác nhận có cookie $name |
| assertCookieValue($name, $value) | Xác nhận cookie $name có giá trị $value |
| assertSee($text) | Xác nhận có text $text trong page |
| assertDontSee($text) | Xác nhận ko có text $text trong page |
| assertSeeIn($selector, $text) | Xác nhận có text $text trong selector $selector |
| assertSeeLink($linkText) | Xác nhận có link $linkText trong page |
| assertInputValue($field, $value) | Xác nhận input $field có giá trị $value |
| assertChecked($field) | Xác nhận input type checkbox checked |
| assertRadioSelected($field, $value) | Xác nhận input type radio selected |
| assertSelected($field, $value) | Xác nhận input type dropdown selected |
| assertValue($selector, $value) | Xác nhận selector $selector có giá trị $value |

Các bạn có thể tìm hiểu thêm ở documents của Laravel:
[https://laravel.com/docs/5.4/dusk](https://laravel.com/docs/5.4/dusk)

----
