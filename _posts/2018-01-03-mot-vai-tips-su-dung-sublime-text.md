---
layout: post
title: Một vài tips sử dụng Sublime Text
---

Sublime Text 3 là một text editor khá mới, tuy miễn phí mà mạnh mẽ, hỗ trợ rất nhiều tính năng thú vị. Các điểm mạnh của Sublime Text có thể kể đến như:
* Miễn phí (thực ra là bản unregistered, thỉnh thoảng hiện sẽ ra pop-up thông báo bạn đang dùng thử và nhắc bạn mua bản chính thức nhưng bạn có thể bỏ qua và tiếp tục sử dụng)
* Nhẹ, khởi động nhanh, tốn ít tài nguyên
* Nhiều tính năng hữu ích như chỉnh sửa tại nhiều vị trí một lúc, soạn thảo toàn màn hình, soạn thảo với layout nhiều cột…
* Hỗ trợ nhiều plugin mạnh mẽ bởi cộng đồng developer đông đảo
* Giao diện đơn giản, tinh tế, có sẵn và hỗ trợ cài đặt nhiều theme
* …
Bài viết này sẽ hướng dẫn bạn cài đặt và tùy chỉnh Sublime Text 3 trên Ubuntu 16.04, cùng với đó cũng giới thiệu một số thủ thuật giúp tăng năng suất khi sử dụng Sublime Text 3.

### 1. Cài đặt Sublime Text 3 bằng command line
1. Install the key:
```
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```
2. Thêm repository:
```
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
```
3. Update & cài đặt Sublime Text 3
```
sudo apt-get update
sudo apt-get install sublime-text
```
4. Cài đặt [package control](https://packagecontrol.io/installation) cho Sublime Text 3 (optional)
Package Control là một plugin hữu ích của Sublime Text cho phép bạn cài đặt và quản lý các package như các bộ gõ, theme…. Cách đơn giản nhất để cài đặt Package Control là thông qua giao diện dòng lệnh của Sublime Text. Bạn vào View > Show Console hoặc ấn tổ hợp phím Ctrl + `, sau đó copy paste đoạn code sau vào giao diện dòng lệnh và ấn Enter để tiến hành cài đặt.
```
import urllib.request,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

### 2. Một vài tips khi sử dụng Sublime Text 3
1. Command Palette `Ctrl + Shift + P`
`Command Palette` cho phép bạn nhanh chóng truy cập các tùy chỉnh của Sublime Text, gọi các lệnh của Package Control, thay đổi syntax của code… chỉ bằng cách thao tác trên bàn phím. Ví dụ bạn có thể cài package mới thông qua Command Palette bằng cách ấn `Ctrl + Shift + P` rồi gõ vào install package.
![](https://viblo.asia/uploads/e367ac88-4e82-4d36-8229-9e2eeee28365.png)

2. Goto Anything `Ctrl + P`
Là một tính năng vô cùng hữu ích, với `Goto Anything` bạn có thể mở nhanh chóng một file, chuyển đến một dòng hay một method trong file đó. Bạn ấn `Ctrl + P` và sau đó

    Gõ một phần của tên file để tìm kiếm và mở file đó
    Gõ @ và tên method để chuyển đến method đó
    Gõ : và số dòng để chuyển đến dòng tương ứng
    Gõ # để tìm kiếm một từ trong file
    Các shortcut trên có thể kết hợp với nhau, chẳng hạn để chuyển đến dòng số 10 của file `UserController.php` bạn có thể ấn `Ctrl + P` rồi gõ vào `UserController.php:10`.
    
3. Split Editing
Bạn có thể chia chiếc màn hình của mình thành nhiều các cửa sổ để soạn thảo. Để làm điều này bạn vào `View > Layout > Columns:2` hoặc dùng shortcut `Shift + Alt + 2`. Bạn cũng có thể soạn thảo với hai cửa sổ đặt trên dưới bằng cách ấn `Shift + Alt + 8`. Để quay lại chế độ một cửa sổ bình thường bạn chỉ cần ấn `Shift + Alt + 1`.

4. 1 số các hot keys hữu ích
* `Ctrl+ K + B`: ẩn/hiện side bar
* `Ctrl + /`: comment
* `Ctrl + Shift + /`: comment dạng block
* `Ctrl + K + U`: chuyển text sang dạng uppercase
* `Ctrl + K + L`: chuyển text sang dạng lowercase
* `Ctrl + L`: select 1 dòng
* `Ctrl + Shift + K`: xóa 1 dòng
* `Ctrl + ]`: indent
* `Ctrl + [`: bỏ indent
* `Ctrl + Shift + D`: nhân đôi dòng
* `Ctrl + J`: nối dòng với dòng tiếp theo
* `Ctrl + Shift + [`: đóng 1 đoạn code
* `Ctrl + Shift + ]`: mở 1 đoạn code
* `Ctrl + F`: tìm kiếm
* `Ctrl + H`: tìm kiếm và thay thế
* `Ctrl + Shift + N`: mở cửa sổ mới
* `Ctrl + N`: mở tab mới
* `Alt + <number>`: chuyển tab (ví dụ Alt + 3)

### 3. Một vài plugins phục vụ code Laravel
1. [ Laravel Blade Highlighter](https://packagecontrol.io/packages/Laravel%20Blade%20Highlighter)
Hỗ trợ hiển thị syntax code của Blade engine.

2. [Laravel 5 Snippets](https://packagecontrol.io/packages/Laravel%205%20Snippets)
Package này giúp biến Sublime Text thành 1 IDE với 1 loạt các suggestions code theo cấu trúc {class}::{function}
VD: Auth::check()

3. [Laravel​Collective HTML Form Snippets](https://packagecontrol.io/packages/LaravelCollective%20HTML%20Form%20Snippets)
Package Form/Html đã bị lược bỏ khỏi Laravel kể từ phiên bản 5.0, nhưng vẫn tiếp tục được bảo trì và cung cấp cho người dùng cài đặt nếu cần. Chính vì sự tiện lợi của nó nên vẫn được yêu thích cho đến tận ngày hôm nay, cài package này cho Sublime Text này đồng nghĩa với việc bạn phải instal package [laravelcollective/html](https://laravelcollective.com/) trong Laravel

| Trigger Text | Output |
| -------- | -------- |
| formopen | {!! Form::open() !!} |
| formclose | {!! Form::close() !!} |
| formtoken | {!! Form::token() !!} |
| formmodel | {!! Form::model($user, []) !!} |
| formlabel | {!! Form::label($for, $text, []) !!} |
| formtext | {!! Form::text($name, $value, []) !!} |
| formtextarea | {!! Form::textarea($name, $value, []) !!} |
| formpassword | {!! Form::password($name, []) !!} |
| formhidden | {!! Form::hidden($name, $value, []) !!} |
| formemail | {!! Form::email($name, $value, []) !!} |
| formfile | {!! Form::file($name, []) !!} |
| formcheckbox | {!! Form::checkbox($name, $value, $checked, []) !!} |
| formradio | {!! Form::radio($name, $value, $checked, []) !!} |
| formnumber | {!! Form::number($name, $value, []) !!} |
| formdate | {!! Form::date($name, \Carbon\Carbon\::now(), []) !!} |
| formselect | {!! Form::select($name, $optionsArray, $defaultKey, []) !!} |
| formselectrange | {!! Form::selectRange($name, $min, $max), [] !!} |
| formselectmonth | {!! Form::selectMonth($name, []) !!} |
| formsubmit | {!! Form::submit($text, []) !!} |

4. [Laravel Helper Completions](https://packagecontrol.io/packages/Laravel%20Helper%20Completions)
Package support việc tìm kiếm các helper functions của Laravel rất tiệt lợi
List các functions Package hỗ trợ:
    
```
array_add
array_build
array_collapse
array_divide
array_dot
array_except
array_first
array_flatten
array_forget
array_get
array_has
array_last
array_only
array_pluck
array_prepend
array_pull
array_set
array_sort
array_sort_recursive
array_where
app_path
base_path
config_path
database_path
elixir
public_path
resource_path
storage_path
camel_case
class_basename
class_uses_recursive
data_get
dd
e
ends_with
head
last
object_get
preg_replace_sub
snake_case
starts_with
str_contains
str_finish
str_is
str_limit
str_plural
str_random
str_replace_array
str_singular
str_slug
studly_case
title_case
trans
trans_choice
trait_uses_recursive
action
asset
secure_asset
route
url
secure_url
abort
abort_if
abort_unless
auth
back
bcrypt
cache
collect
config
csrf_field
csrf_token
dispatch
env
event
factory
info
logger
method_field
old
redirect
request
response
rety
session
view
value
with
```

5. [Emmet](https://packagecontrol.io/packages/Emmet) 
Công cụ cải thiện tốc độ và workflow của lập trình viên web. Emmet hỗ trợ viết code nhanh cho HTML và CSS dựa trên snippets (những đoạn mã dựng sẵn cho việc tái sử dụng nhiều lần).