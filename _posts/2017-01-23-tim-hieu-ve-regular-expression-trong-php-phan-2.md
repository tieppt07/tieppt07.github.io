---
layout: post
title: Tìm hiểu về Regular Expression trong PHP (phần 2)
---

### 7. Kí hiệu đặc biệt cho các từ khoá Regex
Để khai báo kí hiệu đặc biệt chúng ta cần thêm dấu `\` để phân biệt.
```php
// Dấu chấm là ký tự đặc biệt trong regex nên phải thêm dấu \
$partern = '/\./';
$subject = 'demo';
if (preg_match($partern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 8. Khai báo kí tự này hoặc kí tự khác
Để khai báo chuỗi có thể có kí tự này hoặc kí tự khác chúng ta sử dụng dấu `|`.
```php
// Kiểm tra chuỗi pattern có kí tự A hoặc B không
$pattern = '/^A|B$/';
$subject = 'A';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 9. Gộp, nhóm Regex
Để gộp, nhóm Regex lại cho dễ nhìn, chúng ta sử dụng `()`.
```php
// Gộp nhóm A hoặc B lại thành 1 nhóm
$pattern = '/(A|B)/';
$subject = 'A';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 10. Khai báo 1 chuỗi có độ dài không giới hạn
Ở phần trước chúng ta sử dụng `{min,max}` để khai báo, tuy nhiên có cách khác ngắn gọn hơn, là sử dụng các kí tự: `*` `+` `?`
Kí tự `*` đại diện cho không hoặc nhiều kí tự
```php
// Kiểm tra chuỗi trống hoặc có những chữ cái in thường
//Cách 1:
$pattern = '/[a-z]*/';
$subject = 'dsada';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// Cách 2:
$pattern = '/[a-z]{0,}/';
$subject = 's';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

Kí tự `+` đại diện cho 1 hoặc nhiều kí tự
```php
// kiểm tra chuỗi có ít nhất 1 ký tự chữ in thường
// Cách 1:
$pattern = '/[a-z]+/';
$subject = 's';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// Cách 2:
$pattern = '/[a-z]{1,}/';
$subject = 's';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

Kí tự `?` đại diện cho 1 hoặc không có kí tự nào
```php
// Kiểm tra chuỗi có 1 hoặc không có ký tự thường nào
// Cách 2
$pattern = '/[a-z]?/';
$subject = 's';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// Cách 2:
$pattern = '/[a-z]{0,1}/';
$subject = 's';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 11. Regex phủ định
Để phủ định 1 regex chúng ta sử dụng kí tự `^`.
```php
// Kiểm tra chuỗi không có ký tự số
$pattern = '/[^0-9]{1,2}/';
$subject = 'sd';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 12. 1 số kí tự Regex đặc biệt
* `\d` - Chữ số bất kỳ ~ [0-9]
* `\D` - Ký tự bất kỳ không phải là chữ số (ngược với \d) ~ [^0-9]
* `\w` - Ký tự từ a-z, A-Z, hoặc 0-9 ~ [a-zA-Z0-9]
* `\W` - Ngược lại với \w (nghĩa là các ký tự không thuộc các khoảng: a-z, A-Z, hoặc 0-9) ~[^a-zA-Z0-9]
* `\s` - Khoảng trắng (space)
* `\S` - Ký tự bất kỳ không phải là khoảng trắng.

### 13. Kiểm tra chuỗi trong Laravel Validation
Chúng ta sử dụng rule `regex` mà Laravel đã hỗ trợ sẵn.
```php
/**
 * Store a new user.
 *
 * @param  Request  $request
 * @return Response
 */
public function store(Request $request)
{
    $this->validate($request, [
        'username' => 'required|unique:users|max:255',
        'body' => 'required|regex:/^[0-9]+-[0-9]+-[0-9]+$/'
    ]);

    // The user is valid, store in database...
}
```

Như vậy chúng ta đã tìm hiểu về các rules cơ bản của Regular Expresion. :)

----
