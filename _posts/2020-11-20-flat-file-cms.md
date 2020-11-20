---
layout: post
title: Flat file CMS
---

Một hệ quản trị nội dung (CMS) thường đi kèm với 2 thành phần chính ở phía server gồm Data Layer (Database) và Application Layer. Tuy nhiên, đôi khi mô hình này trở nên dư thừa với những yêu cầu ko cần đến độ phức tạp cao. Từ thực tiễn này, `Flat-file CMS` ra đời.

### Flat-file CMS là gì?

Trước tiên, là một `CMS` (Content management system), nếu các bạn chưa rõ CMS thì có thể tự tìm hiểu thêm, chúng ta sẽ không đi sâu vào khái niệm này.
Tiếp theo, cái này mới là chủ chốt, không có hệ quản trị cơ sở dữ liệu (database-less). Hay nói một cách chính xác hơn, dữ liệu được lưu trữ và truy vấn từ các file plain text, nên nếu chúng ta gọi là flat-file database cũng đúng. Tuy nhiên trong tâm tưởng của các developer thì mình chắc rằng, nhắc đến database mọi người sẽ nghĩ đến nó là một hệ thống lưu trữ, gồm nhiều công cụ hỗ trợ, hơn là một nơi lưu trữ đơn thuần. Vì thế gọi là database-less CMS hay flat-file CMS là chính xác nhất.

### Flat-file CMS hoạt động thế nào?

Như tên gọi của nó, flat-file CMS không có DB, dữ liệu sẽ được lưu trữ ở các file, dưới dạng plain text, có thể chỉnh sửa bằng các text editor. Thường thì mỗi file sẽ chứa một dạng dữ liệu (đối tượng dữ liệu) nhất định, ví dụ dữ liệu bài viết blog, dữ liệu trang landing, ... Các file dữ liệu này sẽ được map với một template nhất định (do CMS hoặc do theme quy định). Khi có request đến, CMS sẽ lấy ra trang nội dung kết hợp với template đã quy định để cho ra kết quả web page cuối cùng.

### Ưu nhược điểm

#### Ưu điểm

1. Cho bạn nhiều lựa chọn môi trường triển khai. Việc chọn một môi trường khởi chạy flat-file CMS rất linh hoạt, có thể là shared hosting, cloud hosting, ..., miễn là có thể thực thi một server language như php, ruby, ....

2. Tốc độ triển khai nhanh gọn Cũng từ tính chất database-less, việc triển khai flat-file CMS rất nhanh gọn. Bạn chỉ cần một FTP client, upload files lên là xong, website đã có thể sẵn sàng khởi chạy.

3. Tốc độ runtime Trong các website không quá phức tạp, việc giảm lược được database query sẽ giúp tăng tốc độ tải trang. Hơn nữa, với các website có traffic lớn, việc liên đới đến DBMS sẽ đòi hỏi một lượng tài nguyên kha khá.

4. Backup dễ dàng và nhanh chóng Việc backup website data giờ đây chỉ còn là việc copy file nội dung vào một chỗ an toàn, thay vì phải chạy script để export database. Việc restore cũng thế, chỉ cần copy trả files vào đúng vị, website lại sẵn sàng.

5. Ngoài ra việc sử dụng plain text files để lưu trữ content, đồng nghĩa với việc bạn có thể backup những files này bằng version control system (VCS) như Git. Còn gì tuyệt vời hơn khi có một nơi lưu trữ an toàn như Github mà lại còn track được nội dung thay đổi?!

6. Migrate dễ dàng hơn Nếu bạn đã từng migrate website của bạn giữa các hosting, chắc không dưới một lần bạn từng gặp chuyện database import lỗi (Có hàng tá nguyên nhân khiến database import lỗi, mình sẽ ko đi sâu vào vấn đề này). Việc không sử dụng database góp phần làm giảm thêm một cơn đau đầu mỗi khi migrate website sang hosting khác.

7. Bảo mật Thực ra yếu tố này không đến trực tiếp từ flat-file CMS, mà đến từ lý do flat-file CMS được chọn. Thường flat-file CMS được chọn cho các website độ phức tạp thấp, mà độ phức tạp thấp thì đồng nghĩa với việc có ít rủi ro bảo mật phát sinh. Tiếp nữa là việc không sử dụng DB cũng giảm thiểu các rủi ro phát sinh, nhất là từ SQL. SQL luôn là thứ được ưu tiên cao nhắm đến để tìm các sơ hở bảo mật.

### Nhược điểm

Tất nhiên, "everythings come with price", cái gì cũng có giá của nó.

1. Database-less Hơi lạ đúng ko. Từ nãy giờ ưu điểm toàn xoay quanh database-less, giờ lại lôi database-less ra làm nhược điểm đầu tiên? Thực chất việc sử dụng file để lưu trữ content (có thể tạm gọi là 1 kiểu database, file database chẳng hạn) chắc chắn nó còn có trước khi người ta phát minh ra Database system với query language. Cơ mà tại sao người ta cần nghĩ ra Database trong khi có thể lưu trữ dữ liệu ở dạng flat-file. Dễ hiểu thôi, đó là vì database sẽ giúp giải quyết các bài toán lưu trữ và query dữ liệu phức tạp, chịu tải cao, hay phức tạp hơn như 4 tính chất ACID của transaction.

2. Tốn nhiều công sức hơn nếu muốn triển khai các tính năng "phổ thông" Thực sự vậy. Các tính năng phổ thông gồm những gì? Có thể đó là tìm kiếm, phân loại, comment, ... Các tính năng dường như khá hiển nhiên với các website này sẽ trở nên tốn kha khá công sức hơn để code nếu sử dụng database-less CMS. Tất nhiên là vẫn làm được, cơ mà tốn công!

3. Tốc độ runtime? Tốc độ runtime cũng là cái vừa nằm trong list ưu điểm luôn. Việc loại bỏ database sẽ giúp thời gian tải trang tăng lên khi lượng dữ liệu liên đới đến request tải trang nhỏ, tuy nhiên khi lượng dữ liệu liên đới tăng lên, thời gian tải trang sẽ cũng tăng theo. Ví dụ bạn có trang blog cá nhân. Nếu bạn cần xem một bài viết cụ thể, bạn chỉ đọc một file. Tuy nhiên nếu bạn cần lọc các bài viết theo một tiêu chí nào đó chẳng hạn, bạn sẽ phải đọc tất cả các files chứa bài viết. Số lượng file sẽ tỉ lệ thuận với tốc độ xử lý. Đối với database, lượng dữ liệu xử lý là tương đương, tuy nhiên Database system sẽ được đọc ghi trong bộ nhớ máy tính, thay vì đọc ghi trên ổ cứng.

### Flat-file CMS sẽ phù hợp với mục đích cụ thể nào.

Như mình đã nói ngay từ đầu, để chọn `flat-file CMS` thì website của các bạn nên:

- Không có nhiều yêu cầu phức tạp, tính năng phức tạp.

- Dữ liệu không có cấu trúc tổ chức nhất định.

Cụ thể hơn thì các bạn có thể dùng flat file CMS cho việc làm blog cá nhân, các website tĩnh, landing page, website show thông tin là chủ yếu.

Blog này của mình hiện tại cũng vừa được mình chuyển sang sử dụng một flat file CMS có tên Grav. Mình sẽ giới thiệu chi tiết về thằng này ở bài viết sau.

### Có thể khắc phục được các nhược điểm trên không?

#### Về tốc độ tải trang

Kể cả các CMS DB-less và có sử dụng DB cũng đang sử dụng một cách: Caching. Tối ưu kiểu gì cũng thua hết caching.

#### Về độ phức tạp của website

Nếu website của bạn cần những yêu cầu phức tạp, ví dụ website bán hàng online chẳng hạn, tốt nhất bạn nên sử dụng một CMS có DB. Không có cách nào làm giảm công sức implemetation nếu bạn cố đấm ăn xôi với DB-less CMS.

### Còn khái niệm Static site generator thì sao?

Có thể đọc xong bài này các bạn chợt nhớ ra có một khái niệm tương tự thằng flat-file CMS này đâu đó đúng ko? Từ khóa đó là Static site generator (SSG).

Một số blog về tech thì đưa ra sự phân biệt, đó là: SSG không có giao diện người dùng để quản lý nội dung, còn Flat-file CMS thì có giao diện.

Như mình thấy, Flat-file CMS và SSG đúng là không hoàn toàn giống nhau, tuy nhiên cách phân biệt trên chưa chính xác. Tại sao?

- Flat-file CMS không nhất thiết phải có giao diện quản trị. Ví dụ thằng Grav mình đang dùng, việc cài đặt giao diện quản trị là optional. Bạn hoàn toàn có thể quản trị site bằng các edit các file thông qua editor.

- Giao diện quản trị không phải là yếu tố mang đến cái tên CMS, mà phải là các công cụ bên dưới, giúp quản lý content, ví dụ tagging, categorizing, theming, extenablity, ...

- Một SSG phổ biến nhất và được hỗ trợ trực tiếp bởi Github, đó là Jekyll. Bản thân thằng này tự gọi nó là SSG, tuy nhiên như mình tìm hiểu thì nó cũng hoàn toàn làm được những thứ thằng Grav đang làm.

- Điểm khác biệt lớn nhất giữa Flat-file CMS và SSG, đó là Flat-file CMS sẽ build ra html tại thời điểm người dùng request đến web page của bạn. Đối với SSG, bạn cần chạy lệnh build để tạo ra (generate) ra các file .html trước, sau đó khi người dùng request, server sẽ chỉ cần tìm đến file .html tương ứng rồi trả về. Hiểu nôm na thì Flat-file CMS giống như thông dịch, còn SSG giống như biên dịch vậy.

---
