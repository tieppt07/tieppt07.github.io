---
layout: post
title: HTTP Tests trong Laravel
---

### 1. Giới thiệu
Laravel cung cấp 1 `fluent` API để thực hiện các HTTP requests cùng với kiểm tra đầu ra của các requests cho ứng dụng của bạn.
Chúng ta thử test trường hợp access vào route '/':
```php
public function testBasicTest()
{
    // check access vào route / có trả về HTTP status code là 200 hay ko.
    $response = $this->get('/');
    $response->assertStatus(200);
}
```

### 2. Session / Authentication
Laravel cung cấp một số `helpers` để làm việc với sessions trong quá trình kiểm thử HTTP.  Bạn có thể thiết lập một mảng session bằng method `withSession()`. Việc này rất hữu dụng để load dữ liệu session trước khi thực hiện HTTP requests.

```php
<?php

use App\User;

class ExampleTest extends TestCase
{
    public function testApplication()
    {
        $user = factory(User::class)->create();

        // Truy cập đến đường dẫn / với session foo => bar dưới vai trò là user $useruser
        $response = $this->actingAs($user)
                         ->withSession(['foo' => 'bar'])
                         ->get('/');
    }
}
```

### 3. Testing JSON APIs
Laravel cũng cung cấp một số `helpers` để kiểm thử các JSON APIs và các response của chúng. Ví dụ, các phương thức `json`, `get`, `post`, `put`, `patch`, và `delete` có thể được sử dụng để thực hiện các requests với các động từ HTTP khác nhau. Bạn cũng có thể dễ dàng truyền dữ liệu và header đến các method này.
```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        // Truyền dữ liệu name = Sally đến url /user qua phương thức POST
        $response = $this->json('POST', '/user', ['name' => 'Sally']);

        // Xác nhận response trả về có match với created => true hay không
        $response->assertStatus(200)
                 ->assertExactJson([
                    'created' => true,
                 ]);
    }
}
```

### 4. Testing File Uploads
Class `Illuminate\Http\UploadedFile` cung cấp các methods dùng để fake ra các files hoặc images cho việc kiểm thử. Kết hợp với `Storage` facades, việc kiểm thử upload files trở nên dễ dàng hơn.

```php
<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ExampleTest extends TestCase
{
    public function testAvatarUpload()
    {
        // fake storage disk tên là avatars
        Storage::fake('avatars');

        // truyền ảnh avatar đến url avatar với method POST
        $response = $this->json('POST', '/avatar', [
            'avatar' => UploadedFile::fake()->image('avatar.jpg')
        ]);

        // Xác nhận có tồn tại file avatar.jpg
        Storage::disk('avatars')->assertExists('avatar.jpg');

        // Xác nhận không tồn tại file missing.jpg
        Storage::disk('avatars')->assertMissing('missing.jpg');
    }
}
```

### 5. Các Assertions khả dụng
Laravel cung cấp rất nhiều 'xác nhận' mà bạn có thể sử dụng để chạy unittest 1 cách dễ dàng
| Assertions | Description |
| -------- | -------- |
| $response->assertStatus($code)  | Xác nhận trả về status code $code|
| $response->assertRedirect($uri) | Xác nhận chuển hướng đến url $uri |
| $response->assertHeader($headerName, $value = null) | Xác nhận response trả về có chứa header $headerName |
| $response->assertCookie($cookieName, $value = null) | Xác nhận  có chứa cookie $cookieName |
| $response->assertPlainCookie($cookieName, $value = null) | Xác nhận có chứa cookie $cookieName không được mã hóa |
| $response->assertSessionHas($key, $value = null) | 	Xác nhận session có chứa key $key  |
| $response->assertSessionHasErrors(array $keys) | 	Xác nhận session có chứa lỗi cho field $key |
| $response->assertSessionMissing($key) | 	Xác nhận session không chứa key $key |
| $response->assertJson(array $data) | 	Xác nhận response json trả về có chứa mảng $data. |
| $response->assertJsonFragment(array $data) | 	Xác nhận resonse json fragment trả về có chứa mảng $data |
| $response->assertJsonMissing(array $data) | 	Xác nhận response json trả về không chứa mảng $data. |
| $response->assertExactJson(array $data) | 	Xác nhận response json trả về trùng khớp với mảng $data |
| $response->assertJsonStructure(array $structure) | 	Xác nhận response trả về có cấu trúc json |
| $response->assertViewIs($value) | 	Xác nhận response trả về view $value |
| $response->assertViewHas($key, $value = null) |  Xác nhận response trả về view có chứa key $key. |


Các bạn có thể tìm hiểu thêm ở documents của Laravel:
[https://laravel.com/docs/5.4/http-tests](https://laravel.com/docs/5.4/http-tests)

----
