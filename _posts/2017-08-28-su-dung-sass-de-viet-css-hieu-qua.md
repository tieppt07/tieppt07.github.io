---
layout: post
title: Sử dụng SASS để viết CSS hiệu quả
---


### 1. SASS là gì?
SASS là phần mở rộng của CSS cho phép bạn sử dụng các qui tắc như nested, variable, mixin, import ... nhằm viết CSS nhanh hơn và có cấu trúc rõ ràng hơn.

### 2. Ưu điểm
Ưu điểm:
    - Tương thích hoàn toàn với CSS.
    - Có thêm phần mở rộng: variable, nesting, mixin...
    - Nhiều chức năng thao tác với màu sắc
    - Nâng cao kiểm soát thư viện
    - Định dạng tốt và dễ tùy chỉnh
    - Cộng đồng lớn, được phát triển bởi 1 công ty kĩ thuật và hàng trăm nhà phát triển

### 3. Cài đặt và cách sử  dụng
    - SASS là một ứng dụng viết bằng Ruby nên trước tiên bạn cần cài đặt Ruby trên máy nhé.
    - Cài đặt SASS
    `gem install sass`
    - Chuyển đổi tập tin .sass sang .css
    `sass app.sass app.css`

    - Tự động thực hiện chuyển đổi trong quá trình làm việc:
    `sass --watch app.sass:app.css`

    - Chuyển đổi tất cả một thư mục trong quá trình làm việc:
    `sass --watch app/sass:public/css`

### 4. Syntax
#### 4.1. Variables
    Dùng biến để lưu trữ thông tin mà bạn muốn sử dụng lại trong suốt quá trình style. Bạn có thể lưu màu sắc, font hoặc bất kì giá trị gì mà bạn muốn. SASS sử dụng kí hiệu $ để định nghĩa biến.
```css
// SASS
$font-stack:    Helvetica, sans-serif
$primary-color: #333

body
    font: 100% $font-stack
    color: $primary-color

// CSS được compile
body {
    font: 100% Helvetica, sans-serif;
    color: #333;
}
```

#### 4.2. Nesting
SASS cho phép bạn tổ chức lại các dòng code css theo hệ thống phân cấp giống như HTML. Điều này giúp bạn dễ maintain và bảo trì style hơn.

```css
// SASS
nav
    ul
        margin: 0
        padding: 0
        list-style: none

    li
        display: inline-block

        a
            display: block
            padding: 6px 12px
            text-decoration: none


// CSS được compile
nav ul {
    margin: 0;
    padding: 0;
    list-style: none;
}

nav li {
    display: inline-block;
}

nav li a {
    display: block;
    padding: 6px 12px;
    text-decoration: none;
}
```

#### 4.3. Import
Bạn có thể chia nhỏ style của bạn ra nhiều files khác nhau giúp dễ quản lí và maintain code hơn. SASS sửa dụng `@import` để import file .sass
```scss
// _reset.sass
html,
body,
ul,
ol
    margin:  0
    padding: 0

// base.sass
@import reset

body
    font: 100% Helvetica, sans-serif
    background-color: #efefef

// CSS được compile
html, body, ul, ol {
    margin: 0;
    padding: 0;
}

body {
font: 100% Helvetica, sans-serif;
    background-color: #efefef;
}
```

#### 4.4. Mixin
Cú pháp CSS có rất nhiều tiền tố của nhà cung cấp. Mixin giúp bạn tạo ra 1 `CSS declarations` mà bạn muốn sử dụng nhiều lần trong website của bạn
```scss
// SASS
=border-radius($radius)
-webkit-border-radius: $radius
-moz-border-radius:    $radius
-ms-border-radius:     $radius
border-radius:         $radius

.box
    border-radius(10px)

// CSS được compile
.box {
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -ms-border-radius: 10px;
    border-radius: 10px;
}
```

#### 4.5. Kế thừa, mở rộng
Đây là tính năng hữu ích nhất của SASS. Sửa dụng `@extend` cho phép bạn chia sẽ các thuộc tính style.
```scss
// SASS
.message
    border: 1px solid #ccc
    padding: 10px
    color: #333

.success
    @extend .message
    border-color: green

.error
    @extend .message
    border-color: red

.warning
    @extend .message
    border-color: yellow

// CSS được compile
.message, .success, .error, .warning {
    border: 1px solid #cccccc;
    padding: 10px;
    color: #333;
}

.success {
    border-color: green;
}

.error {
    border-color: red;
}

.warning {
    border-color: yellow;
}
```

6. `Làm Toán`
SASS có thể thực hiện 1 số phép tính đơn giản với các toán tử hạng chuẩn như `+ - * / %`
```scss
// SASS
.container
    width: 100%

article[role="main"]
    float: left
    width: 600px / 960px * 100%


aside[role="complementary"]
    float: right
    width: 300px / 960px * 100%

// CSS được compile
.container {
    width: 100%;
}

article[role="main"] {
    float: left;
    width: 62.5%;
}

aside[role="complementary"] {
    float: right;
    width: 31.25%;
}
```

#### 4.7. Statement trong SASS
- `if`
```scss
// SASS
$type: monster;
p {
    @if $type == ocean {
        color: blue;
    } @else if $type == matador {
        color: red;
    } @else if $type == monster {
        color: green;
    } @else {
        color: black;
    }
}

// CSS được compile
p {
    color: green; }
```

- `for`
```scss
// SASS
@for $i from 1 through 3 {
    .item-#{$i} { width: 2em * $i; }
}

// CSS được compile
.item-1 {
    width: 2em; }
.item-2 {
    width: 4em; }
.item-3 {
    width: 6em; }
```

- `each`
```scss
// SASS
@each $animal in puma, sea-slug, egret, salamander {
.#{$animal}-icon {
    background-image: url('/images/#{$animal}.png');
}
}

// CSS được compile
.puma-icon {
    background-image: url('/images/puma.png'); }
.sea-slug-icon {
    background-image: url('/images/sea-slug.png'); }
.egret-icon {
    background-image: url('/images/egret.png'); }
.salamander-icon {
    background-image: url('/images/salamander.png'); }
```

- `while`
```scss
// SASS
$i: 6;
@while $i > 0 {
    .item-#{$i} { width: 2em * $i; }
    $i: $i - 2;
}

// CSS được compile
.item-6 {
    width: 12em; }

.item-4 {
    width: 8em; }

.item-2 {
    width: 4em; }
```

### 5. Tổng kết
Như các bạn thấy, chỉ với quy tắc biến ta đã có thể tái cấu trúc lại mã nguồn CSS một cách logic, rõ ràng. Ngoài ra, việc khai báo biến như vậy giúp chúng ta tránh được việc viết đi viết lại một đoạn mã CSS. Từ đó, giúp tiết kiệm thời gian viết mã, tăng năng suất và nhanh chóng hoàn thành sản phẩm. Chưa hết, việc cấu trúc như vậy còn giúp mã nguồn rõ ràng hơn, giúp dễ bảo trì và phát triển,…

Đó là một trong những lợi ích chỉ với việc sử dụng biến mà chúng ta vừa tham khảo. Còn rất nhiều lợi ích khác từ việc sử dụng Sass thay cho việc viết CSS theo cách thông thường mà có thể đến khi nào các bạn sử dụng thì mới có thể thấy hết được. Vậy bạn đã sẵn sàng để chuyển sang sử dụng Sass thay cho cách viết CSS thông thường?

Nguồn tham khảo: [http://sass-lang.com](http://sass-lang.com)

----
