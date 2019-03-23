---
layout: post
title: Tìm hiểu về file .htaccess
---

### 1. Định nghĩa
`.htaccess` là một tập tin dùng để cấu hình máy chủ web apache. Nó được máy chủ chấp nhận như là một thành phần và cho phép chúng ta thực hiện điều hướng và bật các tính năng một cách linh hoạt hoặc bảo vệ một folder nào đó của trang web. File .htaccess không được viết từ một ngôn ngữ lập trình nào, nó được viết bởi những quy tắc Regular Expression nên nếu bạn không nắm vững kiến thức này thì thao tác với file .htaccess rất khó khăn. Và nếu bạn chỉnh sửa file với một lỗi dù chỉ là nhỏ thì khi truy cập vào website của bạn sẽ xuất hiện lỗi 500. Vì thế hãy thận trọng khi chỉnh sửa file .htaccess và hãy luôn luôn có một file backup trước khi đụng đến.

### 2. Sử dụng

2.1. Cho phép file .htaccess viết lại cấu hình apache

Mở file: `/etc/apache2/sites-available/default`, sửa `AllowOverride All` thành `AllowOverride None`:

```yaml
<Directory /var/www/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    allow from all
</Directory>
```

Khởi động lại apache:
```sh
$ sudo service apache2 restart
```

Dòng lệnh bắt đầu 1 file .htaccess:
```yaml
Options +FollowSymLinks
RewriteEngine On
RewriteBase /
```

2.2. Chuyển hướng URL

Một trong những ứng dụng phổ biến của htaccess là xử lý các lỗi như lỗi không tìm thấy dữ liệu hoặc lỗi không theo được. Các lỗi này được thể hiện thông qua các con số mà máy chủ đáp trả. Lỗi thông dụng nhất là lỗi không tìm thấy dữ liệu 404.

`ErrorDocument 404 https://viblo.asia/404.html`

`ErrorDocument 401 https://viblo.asia/401.html`

`ErrorDocument 403 https://viblo.asia/403.html`

`ErrorDocument 500 https://viblo.asia/500.html`

2.3. Thiết lập trang index mặc định

Thiết lập file mặc định thay vì file index

`DirectoryIndex homepage.html`

2.4. Chặn không cho phép xem files và folder

`Options All -Indexes`

### 3. Một số ký tự thường sử dụng trong file .htaccess

3.1. [Begin-End] Danh sách các ký tự bắt đầu là Begin, kết thúc là End
- [a-z] => chấp nhận các ký tự thường từ a đến z
- [A-Z] => chấp nhận các ký tự hoa từ A đến Z
- [0-9] => chấp nhận các ký tự từ 0 đến 9
- [a-c] => chấp nhận các ký tự từ a đến c
- [a-zA-Z0-9] chấp nhận các chữ cái thường, hoa và các ký tự số

3.2. {Min,Max} Danh sách chuỗi mà tối thiểu là Min và tối đa là Max
- [a-z]{5,10} => các ký tự từ a tới z dài từ 5 đến 10 ký tự
- [A-Z]{1,100} => các ký tự từ A tới Z dài từ 1 đến 100 ký tự
- [0-9]{10} => ký tự số dài 1 ký tự
- [a-zA-Z]{1,} => các ký tự chữ hoa hoặc chữ thường dài từ 1 ký tự trở lên

3.3. ^ và $ Danh sách các ký tự bắt đầu là ^, kết thúc là $
- ^ [a->z]{10}$ => chuỗi tự bắt  đầu là chữ cái thường, kết thúc cũng là chữ cái thường  và dài 10 ký tự.

3.4. dấu chấm "." đại diện cho ký tự bất kì

- .{10,20} => ký tự bất kỳ dài từ 10 đến 20 ký tự

### 4. Mốt số kí hiệu riêng của .htaccess

- [F] - Forbidden: Kí tự này dùng để chỉ định server sẽ trả về client trang lỗi 403 nếu truy cập vào những nơi không được phép.
- [L] - Last rule: kí tự này để ấn định rằng bước trước đã xong thì ngừng và không tiếp tục thực thi lệnh rewrite tiếp theo nữa.

- [N] - Next: chỉ thị cho server tiếp tục rewrite cho đến rule kế tiếp.

- [G] - Gone: Chỉ định server trả về client trang báo lỗi không tồn tại (no longer exit)

- [P] - Proxy: chỉ định server điểu kiển các yêu cầu được ấn định bởi mod_proxy

- [C] - Chain: Chỉ định server thực hiện rule hiện hành song song với rule trước đó.

- [R] - Redirect: chỉ định server đổi hướng request sang một trang khác trong trường hợp trình duyệt gởi yêu cầu duyệt một trang được sửa chữa đường dẫn (rewrite) trước đó.

- [NC] - No-case: Chỉ định server match không phân biệt hoa thường.

- [PT] - Pass Through: có nghĩa là dùng kí tự để buộc "rewrite engine" ấn định bảng giá trị của uri trở thành giá trị của tên files.

- [OR] - Toán tử kiểm tra từ trên xuống dưới, nếu điều kiện nào đúng thì dừng.

- [NE] - No Escape: Chỉ định server xử lí các gói tin trả về mà không dùng kí tự thoát

- [NS] - No Subrequest: Chỉ định server bỏ qua thư mục hiện hành nếu request nhắm vào thư mục con.

- [QSA] - Append Query String: chỉ định server gắn chuỗi truy vấn vào cuối cùng của URL

- [S=x] Skip: Chỉ định server bỏ qua không xem xét  x rules tiếp theo nữa nếu một rule đã được thực thi.

- [T=MIME-type] - Khai báo định dạng files của server.

- -d Kiểm tra thư mục có tồn tại hay không?

- -f Kiểm tra file có tồn tại hay không

- -s Kiểm tra giá trị của file có khác 0 hay không?

### 5. Mã thông báo trả về từ server

- 401 - Authorization Required : Lỗi chưa được xác thực user và password
- 400 - Bad request : Lỗi truy cập không hợp lệ, do server không chấp nhận request, hoặc request thiếu một số yêu cầu nào đó.
- 403 - Forbidden : Lỗi truy cập vào trang bị cấm
- 500 - Internal Server Error : Lỗi do server
- 404 - Wrong page : Lỗi truy cập vào trang không tồn tại
- 301 - Moved Permanently: 302 - Moved Temporarily: Lỗi truy cập vào trang đã bị di chuyển.

Nguồn tham khảo:
- [http://httpd.apache.org/docs/current/howto/htaccess.html](http://httpd.apache.org/docs/current/howto/htaccess.html)
- [http://www.htaccess-guide.com/](http://www.htaccess-guide.com/)

----
