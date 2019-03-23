---
layout: post
title: Laravel xử lý ảnh với package ImageIntervention Phần 2
---

Chúng ta tiếp tục tìm hiểu về các functions trong package ImageIntervention trong phần 2. 😃

### Change color balance of an image
```php
// value between -100 and +100
$img->colorize($red, $green, $blue);

// take out red color and add blue
$img->colorize(-100, 0, 100);

// just add a little green tone to the image
$img->colorize(0, 30, 0);
```

### Change the brightness of an image
```php
// value between -100 and +100
// increase brightness of image
$img->brightness(35);
```

### Change the contrast of an image
```php
// value between -100 and +100
// increase brightness of image
$img->contrast(65);
```

### Destroy - Free up memory
Giải phóng RAM với ảnh hiện tại trước khi đoạn mã PHP kết thúc.
```php
// create an image
$img = Image::make('public/foo.jpg');

// perform some modifications and destroy resource
$img->resize(320, 240);
$img->save('public/small.jpg');
$img->destroy();
```

### Mirror an image
```php
// h for horizontal (default) or v for vertical flip
// flip image vertically
$img->flip('v');
```

### Invert colors of an image
```php
// create Image from file and reverse colors
$img = Image::make('public/foo.jpg')->invert();
```

### Set opacity of an image
```php
// 100% for opaque and 0% for full transparency
// create new Intervention Image from file and set image full transparent
$img->opacity(0);
```

### Trim away parts of an image
Chức năng này cần sử dụng thêm driver GD
```php
// trim image (by default on all borders with top-left color)
Image::make('public/foo.jpg')->trim();

// trim image (on all borders with bottom-right color)
Image::make('public/foo.jpg')->trim('bottom-right');

// trim image (only top and bottom with transparency)
Image::make('public/foo.jpg')->trim('transparent', array('top', 'bottom'));

// trim image (only left side top-left color)
Image::make('public/foo.jpg')->trim('top-left', 'left');

// trim image on all borders (with 40% tolerance)
Image::make('public/foo.jpg')->trim('top-left', null, 40);

// trim image and leave a border of 50px by feathering
Image::make('public/foo.jpg')->trim('top-left', null, 25, 50);
```

Trên đây là một số hàm cơ bản để xử lí ảnh sử dụng package [Intervention Image](http://image.intervention.io/) . Các bạn có thể tìm hiểu thêm tại đây [http://image.intervention.io](http://image.intervention.io/)

----
