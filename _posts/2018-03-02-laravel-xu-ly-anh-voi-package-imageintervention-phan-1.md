---
layout: post
title: Laravel xử lý ảnh với package ImageIntervention Phần 1
---

## Introduction
Intervention Image là một thư viện xử lý ảnh mã nguồn mở PHP. Nó cung cấp một cách dễ dàng để tạo, chỉnh sửa hình ảnh và hỗ trợ hiện tại hai thư viện xử lý ảnh phổ biến nhất là GD Library và Imagick.

## Installation
Yêu cầu môi trường:
Bắt buộc
* PHP >= 5.4
* Fileinfo Extension
* GD Library (>=2.0)
* Imagick PHP extension (>=6.5.7)

Cài đặt thông qua composer:

`composer require intervention/image`

Thêm `providers` và `aliases`:

```php
Intervention\Image\ImageServiceProvider::class

...

'Image' => Intervention\Image\Facades\Image::class
```

Sử dụng `ImageIntervention` trong Laravel:
```php
// include composer autoload
require 'vendor/autoload.php';

// import the Intervention Image Manager Class
use Intervention\Image\ImageManagerStatic as Image;

// configure with favored image driver (gd by default)
Image::configure(array('driver' => 'imagick'));

// and you are ready to go ...
$img = Image::make('public/foo.jpg')->resize($width, $height);
```

## Functions
### Đọc thông số của image
```php
// read width of image
$img->width();

// get file size
$img->->filesize();

// read height of image
$img->height();
```

### Tạo empty image
```php
// create a new empty image resource with transparent background
$img = Image::canvas($width, $height);

// create a new empty image resource with red background
$img = Image::canvas($width, $height, $backgroundColor);
```

### Resize
Thay đổi kích thuước ảnh dựa theo chiều rộng và chiều dài của ảnh:
```php
// resize image to fixed size
$img->resize($width, $height);

// resize only the width of the image
$img->resize($width, null);

// resize only the height of the image
$img->resize(null, height);

// resize the image to a width of 300 and constrain aspect ratio (auto height)
$img->resize($width, null, function ($constraint) {
    $constraint->aspectRatio();
});

// resize the image to a height of 200 and constrain aspect ratio (auto width)
$img->resize(null, height, function ($constraint) {
    $constraint->aspectRatio();
});

// prevent possible upsizing
$img->resize(null, height, function ($constraint) {
    $constraint->aspectRatio();
    $constraint->upsize();
});
```

### Rotate
Xoay ảnh theo 1 góc nhất định:
```php
// rotate image 45 degrees clockwise
$img->rotate(-$degree);
```

### Crop
Cắt ảnh dựa theo chiều được xác định:
```php
// crop image
$img->crop($width, $height, $xCordinateTopLeft, $yCordinateTopLeft);
```

### Fit
Kết hợp crop và resize 1 cách thông minh: xử lí ảnh theo tỉ lệ kích thước của ảnh:
```php
// crop the best fitting 5:3 (600x360) ratio and resize to 600x360 pixel
$img->fit($width = 600, $height = 360);

// crop the best fitting 1:1 ratio (200x200) and resize to 200x200 pixel
$img->fit($width = 200);

// add callback functionality to retain maximal original image size
$img->fit($width = 800, $height = 600, function ($constraint) {
    $constraint->upsize();
});
```

Trên đây là 1 vài các chức năng cơ bản của package `Intervention Image`. Mình sẽ giới thiệu tiếp thêm các chức năng ở phần sau :)

reference: [Intervention Image](http://image.intervention.io/)

----
