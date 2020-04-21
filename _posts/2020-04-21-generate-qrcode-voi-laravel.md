---
layout: post
title: Generate QrCode với Laravel
---

QR Code là chữ viết tắt của chữ Quick response code (Mã phản hồi nhanh) hay còn gọi là mã vạch ma trận (matrix-barcode) là dạng mã vạch hai chiều (2D) thế hệ mới có thể được đọc bởi một máy đọc mã vạch hay smartphone (điện thoại thông minh) có chức năng chụp ảnh (camera) với ứng dụng chuyên biệt để quét mã vạch.

![wordpress](/assets/generate-qr-code-in-laravel.png)

Bên trong một mã QR có thể chứa các thông tin liên quan đến sản phẩm, hoặ trang web, thông tin sự kiện, thông tin liên hệ, tin nhắn, hoặc cả một đoạn văn bản vị trí thông tin địa lý. Tùy thuộc vào thiết bị đọc mã vạch QR khi bạn quét nó sẽ dẫn tới các kết quả có chứa sẵn bên trong.

Trong bài viết này mình sẽ sử dụng package Simple-qrcode. Trong ví dụ này, mình sẽ chỉ cho bạn cách gửi sms và email với mã qr được tạo, bạn cũng có thể tạo mã qr cho địa lý, số điện thoại, tin nhắn văn bản.

### Cài đặt package Simple QrCode

Thêm đoạn code sau vào file `composer.json`:

```json
"require": {
    "simplesoftwareio/simple-qrcode": "~2"
}
```

Sau đó chạy lệnh:

```bash
$ composer update
```

Đối với Laravel <= 5.4 cần đăng kí `providers` và `alias` trong file `config/app.php`:

```php
//config/app.php

'providers' => [
    SimpleSoftwareIO\QrCode\QrCodeServiceProvider::class
],

'aliases' => [
    'QrCode' => SimpleSoftwareIO\QrCode\Facades\QrCode::class
],
```

### Sử dụng

- Cơ bản

    ```php
    QrCode::generate('Make me into a QrCode!');
    ```

- Chỉnh size

    ```php
    QrCode::size(300)->generate('Make me into a QrCode!');
    ```

- Tạo mã QR có color.

    ```php
    QrCode::backgroundColor(255, 55, 0)
        ->generate('Make me into a QrCode!');
    });
    ```

- Thay đổi format ảnh Qr code

    ```php
    QrCode::format('png');  //Will return a PNG image
    QrCode::format('eps');  //Will return a EPS image
    QrCode::format('svg');  //Will return a SVG image
    ```

- Thay đổi `margin`

    ```php
    QrCode::margin(100);
    ```

- Generate email

    ```php
    QrCode::email($to, $subject, $body);

    //Fills in the to address
    QrCode::email('foo@bar.com');

    //Fills in the to address, subject, and body of an e-mail.
    QrCode::email('foo@bar.com', 'This is the subject.', 'This is the message body.');

    //Fills in just the subject and body of an e-mail.
    QrCode::email(null, 'This is the subject.', 'This is the message body.');
    ```

- Generate số điện thoại

    ```php
    QrCode::phoneNumber($phoneNumber);

    QrCode::phoneNumber('555-555-5555');
    QrCode::phoneNumber('1-800-Laravel');
    ```

- Generate SMS

    ```php
    QrCode::SMS($phoneNumber, $message);

    //Creates a text message with the number filled in.
    QrCode::SMS('555-555-5555');

    //Creates a text message with the number and message filled in.
    QrCode::SMS('555-555-5555', 'Body of the message');
    ```

- Scan wifi để kết nốt :v

    ```php
    QrCode::wiFi([
        'encryption' => 'WPA/WEP',
        'ssid' => 'SSID of the network',
        'password' => 'Password of the network',
        'hidden' => 'Whether the network is a hidden SSID or not.'
    ]);

    //Connects to an open WiFi network.
    QrCode::wiFi([
        'ssid' => 'Network Name',
    ]);

    //Connects to an open, hidden WiFi network.
    QrCode::wiFi([
        'ssid' => 'Network Name',
        'hidden' => 'true'
    ]);

    //Connects to an secured, WiFi network.
    QrCode::wiFi([
        'ssid' => 'Network Name',
        'encryption' => 'WPA',
        'password' => 'myPassword'
    ]);
    ```

- Generate kinh độ, vĩ độ

    ```php
    QrCode::geo($latitude, $longitude);

    QrCode::geo(37.822214, -122.481769);
    ```

### Một số prefix sử dụng Qr Code

| Usage  | Prefix  |Example |
|---|---|---|
|  Website URL | http://   | http://tieppt07.github.io   |
|  Secured URL | https://   | https://tieppt07.github.io   |
|  E-mail Address | mailto:   | mailto:support@example.io   |
|  Phone Number | tel:   | tel:555-555-5555   |
|  Text (SMS) | sms:  | sms:555-555-5555   |
|  Text (SMS) With Pretyped Message | sms:  | sms:I am a pretyped message   |
|  Text (SMS) With Pretyped Message and Number | sms:  | sms:555-555-5555:I am a pretyped message   |
|  Geo Address | geo:  | geo:-78.400364,-85.916993   |
|  MeCard | mecard:   | MECARD:Simple, Software;Some Address, Somewhere, 20430;TEL:555-555-5555;EMAIL:support@simplesoftware.io;   |
|  Wifi | 	wifi:   | wifi:WEP/WPA;SSID;PSK;Hidden(True/False)   |


Mong rằng với bài chia sẽ nhở này sẽ giúp ích được phần nào cho các bạn trong các dự án liên quan tới qr-code. 

refs: 
- [https://www.simplesoftware.io/simple-qrcode/](https://www.simplesoftware.io/simple-qrcode/)

---
