---
layout: post
title: Tìm hiểu về Regular Expression trong PHP (phần 1)
---

### Regular Expression
Regular Expression viết tắt là RegEx là biểu thức chính quy được dùng để xử lý chuỗi thông qua biểu thức riêng của nó, những biểu thức này sẽ có những nguyên tắc riêng và bạn phải tuân theo nguyên tắc đó thì biểu thức của bạn mới hoạt động được.

### 1. Sử dụng trong PHP

 Dùng hàm `preg_match()` trong PHP

 `preg_match($pattern, $subject, $matches)`

 - `$pattern` là chuỗi Regular Expression Pattern
 - `$subject` là chuỗi nguồn mà chúng ta muốn so khớp với $pattern
 - `$matches` là danh sách kết quả trả về đúng khi so khớp $pattern và $subject

### 2. Khai báo chuỗi

 Để khai báo một chuỗi Regular Expression ta chỉ cần khai báo bắt đầu bằng ký tự `/` và kết thúc cũng là ký tự `/`.

```php
// Partern kiểm tra trong subject có tồn tại chuỗi reg không
$pattern = '/reg/';
$subject = 'regex';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

 Kết quả trả về đúng vì trong `$subject` có chứa chuỗi `reg` nên kết quả so khớp là đúng.

### 3. Ký tự bắt đầu và kết thúc

 Dùng ký tự bắt đầu `^` và ký tự kết thúc `$` đặt vào đầu và cuối chuỗi `$pattern`, nếu so khớp hoàn toàn từ đầu tới cuối thì là đúng.

```PHP
// kiểm tra trong subject co bang regex khong
$pattern = '/^regex$/';
$subject = 'regex';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 4. Phạm vi của chuỗi

 Kiểm tra một chuỗi có phải là chữ cái in thường hay không thì ta sẽ dùng ký hiệu `[min-max]`, trong đó `min` là ký tự bắt đầu, `max` là ký tự kết thúc. Hoặc `[list_chars]` trong đó `list_chars` là danh sách các ký tự cho phép.

```PHP
// kiểm tra có phải chữ cái in thường
$pattern = '/[a-z]/';
$subject = 'regex';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// kiểm tra có phải chữ cái in hoa
$pattern = '/[A-Z]/';
$subject = 'REGEX';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// kiểm tra một ký tự là chữ số
$pattern = '/[0-9]/';
$subject = 'd';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// kiểm tra một ký tự là in hoa hoặc in thường
$partern = '/[a-zA-Z]/';
$subject = 'RegEx';
if (preg_match($partern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// Pattern là chữ a hoặc số 2 hoặc chữ b
// Trong TH này, chúng ta ko sử dụng kí hiệu [min. max] để định nghĩa
// nên Regular Expression sẽ hiểu là một trong các ký tự, tức là nếu:
//   $subject có chứa ký tự a
//   $subject có chứa ký tự 2
//   $subject có chứa ký tự b
//   thì regex sẽ trả về đúng.
$pattern = '/[a2b]/';
$subject = 'a';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 5. Xác định chiều dài của chuỗi

 Kiểm tra chiều dài của một chuỗi thì ta sẽ dùng ký hiệu `{min-max}`, trong đó min là chiều dài tối thiểu, max là chiều dài tối đa.

```PHP
// kiểm tra pattern là chữ in thường từ 5 đến 10 ký tự
$pattern = '/^[a-z]{5,10}$/';
$subject = 'regular';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// kiểm tra pattern là chữ số từ 3 đến 10 ký tự
$pattern = '/^[0-9]{3,10}$/';
$subject = '6534582';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}

// kiểm tra pattern là chữ in thường có 5 ký tự
// cách 1:
$pattern = '/^[a-z]{5,5}$/';
$subject = 'sssss';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
// cách 2:
$pattern = '/^[a-z]{5}$/';
$subject = 'sssss';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

### 6. Khai báo 1 kí tự bất kì

 Để khai báo 1 kí tự bất kì chúng ta dùng ki hiệu `.` .

```PHP
// Pattern là ký tự bất kỳ dài từ 5 đến 10 ký tự
$pattern = '/^.{5,10}$/';
$subject = '32fds2';
if (preg_match($pattern, $subject)){
    echo 'Chuỗi regex so khớp';
}
```

Chúng ta sẽ tiếp tục tìm hiểu thêm 1 số quy tắc khác và cách sử dụng trong Laravel Validation ở phần 2 :)


----
