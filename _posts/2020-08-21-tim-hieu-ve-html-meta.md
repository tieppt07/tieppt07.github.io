---
layout: post
title: Tìm hiểu về HTML meta
---

### Trước tiên tìm hiểu HTML là gì?

`HTML` viết tắt của `Hypertext Markup Language` là ngôn ngữ lập trình dùng để xây dựng và cấu trúc lại các thành phần có trong website. `HTML` tạm dịch là ngôn ngữ đánh dấu siêu văn bản. Người ta thường sử dụng HTML trong việc phân chia các đoạn văn, heading, links, blockquotes,… Mỗi tài liệu HTML bao gồm 1 bộ tag (hay còn gọi là element). Nó tạo ra một cấu trúc tương tự như cây thư mục với các heading, `section`, paragraph,… và một số khối nội dung khác. Hầu hết tất cả các HTML element đều có một tag mở và một tag đóng với cấu trúc <tag></tag>. 

### Thẻ Meta là gì?
Thẻ meta là 1 trong những `tag` đc đề cập ở trên, là những dòng mã đặt trong phần đầu `<head>` của trang html để cung cấp thông tin về trang web cho công cụ tìm kiếm. Những thông tin đó thường gồm: nhan đề, từ khóa chính, tóm tắt nội dung, ngôn ngữ chính được sử dụng...

Cần phải khẳng định rằng, thẻ `meta` là để cho các công cụ tìm kiếm như [Google](https://support.google.com/webmasters/answer/79812?hl=en) hiểu nội dung của trang, chứ không cung cấp thông tin trực tiếp đến người dùng.

### Các thuộc tính của thẻ <meta>

- `charset`:	Xác định kiểu mã hóa ký tự của trang web.
- `name`:	Xác định "tên của một loại thông tin" mà bạn muốn cung cấp thêm cho trang web.
- `http-equiv`:	Xác định việc tải lại trang
- `content`:	Xác định nội dung của loại thông tin mà bạn muốn cung cấp cho trình duyệt và các công cụ tìm kiếm
`
#### Thuộc tính `charset`

Thuộc tính `charset` dùng để xác định kiểu mã hóa ký tự của trang web (Tiếng Việt của chúng ta sử dụng kiểu mã hóa ký tự là UTF-8).

```html
<meta charset="UTF-8">
```

####  Thuộc tính `name`

Thuộc tính `name` dùng để xác định tên của một loại thông tin mà bạn muốn cung cấp thêm cho trang web. Thuộc tính name chỉ dùng để xác định tên của loại thông tin mà bạn muốn cung cấp thêm cho trang web, còn nội dung của thông tin đó thì phải sử dụng thuộc tính content.

Dưới đây là một số giá trị thường được dùng bởi thuộc tính name:

- `author`: Xác định tên tác giả (chủ sở hữu) của trang web.

  Ví dụ:
  ```html
  <meta name="author" content="Web cơ bản">
  ```

- `keywords`: Xác định danh sách những từ khóa mà bạn muốn khi người dùng gõ vào các cỗ máy tìm kiếm như `google`, `bing`, ... thì sẽ hiển thị kết quả là trang web của bạn.
  
  Ví dụ: Bạn muốn khi người dùng gõ trên google một trong những từ khóa bên dưới sẽ hiển thị kết quả là trang web của bạn.

  ```html
  <meta name="keywords" content="xem phim hd,phim hay,phim hành động">
  ```
  Lưu ý: Giữa các từ khóa phải được ngăn cách bởi dấu phẩy.

- `description`
  Mô tả ngắn gọn nội dung chính của trang web (khoảng 150 ký tự là hợp lý)

  Ví dụ:
  ```html
  <meta name="description" content="Website xem phim hành động hay chất lượng full HD hoàn toàn miễn phí">
  ```
  Lưu ý: Nội dung của thuộc tính description tốt nhất nên chứa các từ trong danh sách từ khóa (keywords), điều đó sẽ hỗ trợ tốt cho thuộc tính keywords cũng như việc hiển thị trang web của bạn trên các cỗ máy tìm kiếm.


#### Thuộc tính `http-equiv`

Thuộc tính http-equiv thường được dùng để: Xác định kiểu nội dung và kiểu mã hóa ký tự của trang web.
Xác định việc tải lại trang.

Lưu ý: Tương tự như thuộc tính name, thuộc tính http-equiv phải sử dụng kèm với thuộc tính content.

Dưới đây là các giá trị được dùng bởi thuộc tính http-equiv:

- `content-type`: Xác định kiểu nội dung và kiểu mã hóa ký tự của trang web.

  Ví dụ:
  ```html
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  ```
  Tuy nhiên, ta có thể thay thế bằng `<meta charset="UTF-8">` cho ngắn gọn hơn.

- `refresh`: Xác định việc trang sẽ tự động được tải lại.
  Ví dụ: Sau 2 giây trang sẽ tự động được tải lại.
  ```html
  <!DOCTYPE html>
  <html>
  <head>
      <meta http-equiv="refresh" content="2">
  </head>
  <body>
      <h1>Bức tranh bên dưới có tên là The Scream</h1>
      <img src="../image/the-scream.jpg">
  </body>
  </html>
  ```

#### Thuộc tính `content`

Thuộc tính content dùng để xác định nội dung của loại thông tin mà bạn muốn cung cấp cho trình duyệt và các công cụ tìm kiếm.

```html
<meta name="description" content="Nội dung chính của trang" />
```

Trong rất nhiều thẻ meta khác nữa, như meta Abstract, meta Author, meta Copyright, meta Designer … nhưng những thẻ meta này không quan trọng nên mình không đưa vào bài viết này. Bạn có thể tự tìm hiểu thêm nhé. Các bạn nên quan tâm đến các thẻ: meta description, meta robots và title ( mình có nói phía trên là title không phải là một thẻ meta nhưng nó thường được coi là một thể tương tự). Meta description được sử dụng để hiển thị thêm thông tin về nội dung của trang web. Công cụ tìm kiếm sử dụng nó trong SERPs của họ.

ref:
- [https://carly.com.vn/blog/the-meta/](https://carly.com.vn/blog/the-meta/)
- [http://webcoban.vn/html/the-meta-la-gi-the-meta-dung-de-lam-gi-cach-su-dung-the-meta-trong-html.html](http://webcoban.vn/html/the-meta-la-gi-the-meta-dung-de-lam-gi-cach-su-dung-the-meta-trong-html.html)

---
