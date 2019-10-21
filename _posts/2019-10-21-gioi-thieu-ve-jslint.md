---
layout: post
title: Giới thiệu về JSLint
---

Như các bạn đã biết, javascript là một ngôn ngữ rất phổ biến và mạnh mẽ. Việc sử dụng javascript trong thiết kế web là gần như bắt buộc, tuy nhiên khá nhiều trang web hiện nay có hiệu năng chưa tốt mà nguyên nhân lại bắt nguồn chính từ những dòng code JS. Nguyên nhân chính là do chúng ta thiếu những công cụ để debug, rút gọn, tối ưu code trong quá trình lập trình. Trong bài viết này, tôi muốn giới thiệu mọi người một công cụ để hỗ trợ tối ưu, làm gọn và đẹp code JS, đó là `JSLint`.

### I. JS lint là gì?

JSlint là một `Linting tool`. Linting tool có thể giúp developer tối ưu hóa code và viết code chất lượng cao. Linting là một quy trình kiểm tra code, tìm lỗi trong code nguồn, và đánh dấu các bug tiềm năng. Đa số công cụ linting (`linter`) sử dụng kỹ thuật phân tích code tĩnh. Nói cách khác, code được kiểm tra mà không cần phải chạy. Các bạn có thể lint vào nhiều dịp khác nhau, như ngay trong lúc bạn viết code, hoặc khi bạn save file, khi bạn ủy thác các thay đổi, hoặc ngay trước khi đưa code vào production. Dù bạn đi theo workflow nào, bạn cần phải lint thường xuyên để tránh nhiều tình huống dở khóc dở cười trong tương lai.

Linter không đơn thuần chỉ là công cụ ngăn ngừa lỗi, chúng còn có thể tìm được các lỗi khó nhận biết, giúp ích rất nhiều cho việc debug.

### II. Sử dụng JSlint như thế nào?

JSLint được Douglas Crockford ra mắt lần đầu năm 2002, và đến giờ nó vẫn chưa mất đi vị thế của mình. Vì thế, bạn có thể tin tưởng đây là một công cụ linting trên JavaScript ổn định và đáng tin cậy.

JSLint có thể xử lý mã nguồn JavaScript và JSON text, công cụ đi kèm với một tùy chỉnh có sẵn đi theo chuẩn JS của Crockford trong cuốn sách của ông JavaScript: The Good Parts.

Để sử dụng JSLint, chúng ta chỉ cần truy cập vào trang [http://www.jslint.com](http://www.jslint.com) để có thể sử dụng nó.

Giao diện chính của nó bao gồm 2 phần, phần 1 là để chúng ta có thể nhập đoạn code cần đánh giá, và phần bên dưới, là các option. Các bạn có thể tìm hiểu chi tiết từng option trong quá trình sử dụng, nó không quá khó khăn để hiểu đâu 😄. Mình xin ví dụ một vài option và ý nghĩa của nó như sau:

- Mục Asume: Lựa chọn môi trường phát triển.
- Mục Tolerale: Tùy chọn các mục để nới lỏng hơn các luật kiểm tra của Jslint, ví dụ như cho phép dùng hàm eval, toán tử bit, khai báo nhiều biến var, cho phép sử dụng dấu nháy kép với string…
- Mục Number: Điền giới hạn tối đa độ dài dòng và số cảnh báo.
- Mục Global variable: Nhập các biến toàn cục của đoạn code vào.

### III. Dùng hàm time trong JS để kiểm tra thời gian thực thi code

Sau khi sửa lại code JS theo những cảnh báo từ Jslint, các bạn có thể chạy lại đoạn code và sử dụng hàm time để kiểm tra xem chúng ta đã rút gọn thời gian chạy được bao nhiêu so với ban đầu.


Javascript hỗ trợ hàm `console.time()` và `console.timeEnd()`, ví dụ chúng ta có thể dùng như sau:
```js
console.time("time for loop");
for(var i =0; i < 1000; i++){
    var object = new DemoObject(i);
}
console.timeEnd("time for loop");
```

Khi chạy trên trình duyệt, ta sẽ nhận được thời gian chạy vòng lặp đó là time for loop: 0.082ms. Từ ví dụ trên, chúng ta có thể kết luận rằng, khi sử dụng, chúng ta chỉ cần để đoạn lệnh cần đo hiệu năng vào trong cặp `time()` và `timeEnd()` là được. Một lưu ý nho nhỏ, đó là đoạn string được truyền vào phải giống nhau. Và do đó, chúng ta có thể sử dụng các cặp lồng nhau 1 cách dễ dàng.

Trên đây là phần giới thiệu sơ lược về cách sử dụng JSlint, hy vọng các bạn có thể sử dụng tốt nhất công cụ này để tối ưu hóa và làm sạch code js trong các dự án của mình. Cảm ơn các bạn đã theo dõi bài viết và hẹn gặp lại các bạn trong các bài viết sau.


---
