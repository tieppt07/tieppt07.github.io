---
layout: post
title: Giới thiệu vài PHP Framework phổ biến hiện nay
---

## PHP Framework là gì?
Framework là một bộ mã nguồn được xây dựng, phát triển và đóng gói – phân phối bởi các chuyên gia lập trình hoặc bởi các công ty lập trình. PHP frameworks làm cho sự phát triển của những ứng dụng web viết bằng ngôn ngữ PHP trở nên trôi chảy hơn, bằng cách cung cấp 1 cấu trúc cơ bản để xây dựng những ứng dụng đó. Hay nói cách khác.

PHP framework giúp đỡ các bạn thúc đẩy nhanh chóng quá trình phát triển ứng dụng, giúp bạn tiết kiệm được thời gian, tăng sự ổn định cho ứng dụng, và giảm thiểu số lần phải viết lại code cho lập trình viên. Ngoài ra Framework còn giúp những người mới bắt đầu có thể xây dựng các ứng dụng ổn định hơn nhờ việc tương tác chính xác giữa các Database, code (PHP) và giao diện (HTML) 1 cách riêng biệt. Điều này cho phép bạn dành nhiều thời gian để tạo ra các ứng dụng web, hơn là phí thời gian để viết các đoạn mã lặp lại trong 1 project.
Ý tưởng chung đằng sau cách thức hoạt động của 1 PHP framework phải kể đến mô hình Model-View-Controller (MVC). MVC là 1 mô hình trong lập trình, cho phép tách biệt các mã nghiệp vụ (business logic) và giao diện (UI) thành các phần riêng biệt, điều này đồng nghĩa với việc ta có thể chỉnh sửa chúng 1 cách riêng lẻ. Trong cụm từ MVC thì: Model (M) có thể hiểu là phần xử lý các thao tác về nghiệp vụ (business logic), View được hiểu là phần xử lý lớp giao diện (presentation layer), và Controller làm nhiệm vụ lọc các request đc gọi từ user, có chức năng như 1 route: điều chỉnh, phân luồng các yêu cầu để gọi đúng Model & View thích hợp. Về cơ bản, MVC chia nhỏ quá trình xử lý của 1 ứng dụng, vì thế nên bạn có thể làm việc trên từng thành phần riêng lẻ, trong khi những thành phần khác sẽ không bị ảnh hưởng tới. Thực chất, điều này giúp đỡ bạn lập trình PHP nhanh hơn và ít phức tạp hơn.

## Lì do gì chúng ta nên sử dụng PHP Framework trong lập trình web?
    * Giúp các lập trình viền tăng tốc quá trình phát triển ứng dụng.
        Việc sử dụng lại các mã lệnh giống nhau trong nhiều project sẽ giúp các bạn tiết kiệm được thời gian và công sức 1 cách đáng kể. Một framework sẽ cung cấp sẵn các module nền tảng cần thiết để xây dựng 1 project, vì thế, các lập trình viên có thể tận dụng được thời gian để phát triển các ứng dụng thực tế, hơn là mất thời gian để xây dựng lại nền tảng trên mỗi project.
    * Sự ổn định, mã nguồn sạch đẹp, dễ dàng phát triển, bảo trì.
    * Nhóm làm việc với nhau hiệu quả hơn, hiểu ý nhau hơn, tốc độ hơn (có sự thống nhất về code).
    * Hiệu năng cũng như bảo mật sẽ được chăm sóc và cập nhật thường xuyên nhờ cộng đồng phát triển
    * Có sẵn rất nhiều thành phần mở rộng (extensions)

## Một số PHP Framework phổ biến hiện nay

### 1. CakePHP
![](https://viblo.asia/uploads/b827c1ce-2b8c-49be-a8d5-459917bf0f67.png)
CakePHP là 1 lựa chọn tuyệt với cho những lập trình viên có kiến thức nâng cao về PHP. Nó dựa trên cùng 1 nguyên tắc thiết kế với Ruby on Rails, là 1 framework mạnh về khía cạnh rapid development , giúp lập trình viên đẩy nhanh quá trình phát triển ứng dụng của họ. Với các hệ thống hỗ trợ, tính đơn giản và mỗi trường mở cao đã giúp cho CakePHP trở thành 1 trong những framework phổ biến nhất hiện nay.
    * Ưu điểm
        * Cấu trúc MVC rõ ràng giúp cho công tác lập trình cũng như bảo trì dễ dàng hơn.
        * Tương thích với các phiên bản 4 và 5 của PHP
        *    Nguồn mở, miễn phí, có cộng đồng sử dụng và hỗ trợ rộng lớn (trên website chính, trên kênh chat IRC, và diễn đàn những người yêu thích CakePHP), những người mới bắt đầu có thể tìm thấy rất nhiều tài liệu, project để tham khảo.
        * Hỗ trợ tạo kết nối đến cơ sở dữ liệu một cách đơn giản và thuận lợi, chỉ với một chuỗi kết nối đặt trongfile configs/database.php
        * Generate code tự động dựa trên cơ sở dữ liệu đã có: với việc sử dụng Cake Console được CakePHP hỗ trợ sẵn, chỉ mất vài phút để tạo ra các view, model, controller tương ứng với table đã có.
        * Kiểm tra và nhận biết tự động các ràng buộc, quan hệ trong cơ sở dữ liệu.
        * Phân quyền cho người dùng, nhóm người dùng (ACL) một cách uyển chuyển.
        * Routes URL rõ ràng, dễ hiểu.
        * Data Validation.
        * Cung cấp sẵn tiện ích xử lý dữ liệu (Data Sanitization)
        * Cung cấp khả năng lưu tạm (Caching).
        * Có khả năng triển khai trên hầu hết các máy chủ, hosting…hỗ trợ php và mysql hiện nay.
        * Tích hợp sẵn nhiều thư viện hỗ trợ cho việc lập trình và thiết kế giao diện trở nên đơn giản như: Ajax,HTML Form, Javascript…
        * Có sẵn các công cụ xử lý Email, Security, Session, Cookies, Request Handling.
        * Dễ dàng viết thêm thư viện hỗ trợ, liên kết với ứng dụng khác (thông qua vendors) ví dụ như liên kết với Zend Framework
        * Hỗ trợ nhiều hệ Quản Trị CSDL (MySql, Oracle, PostgreSQL, DB2…)
        * Có thư viện Tree Behavior giúp cho bạn tạo 1 chuyên mục đa cấp . Lúc đó nó quản lý chuyên mục như một nhánh cây. Thư viện này rất thích hợp cho bạn xây dựng 1 hệ thống quản lý nhân sự có phân cấp phức tạp , chia làm nhiều nhánh.

### 2. CodeIgniter
![](https://viblo.asia/uploads/73ea4d5f-5bd9-4468-80d1-9a950e10fd2a.png)
CodeIgniter là một PHP framework rất nhẹ và đã có tuổi đời gần 10 năm (được phát hành vào năm 2006). CodeIgniter có quá trình cài đặt rất đơn giản và chỉ đòi hỏi cấu hình tối thiểu. Codelgniter được biết đến như 1 framework dễ hiểu và dễ sử dụng, cho hiệu suất cao. Không giống như Symfony, PHP framework này phục vụ mục đích lý tưởng cho việc xây dưng các ứng dụng chia sẻ , lưu trữ. Nó cung cấp các giải pháp đơn giản, và có một thư viện video hướng dẫn phong phú, diễn đàn hỗ trợ, và cung cấp sẵn 1 hướng dẫn sử dụng cho người mới bắt đầu. PHP framework này rất phù hợp cho 1 người mới làm quen với framework.
    * Ưu điểm
        * Tốc độ nhanh
            CodeIgniter được đánh giá là một PHP framework  có  tốc độ nhanh  nhất hiện nay. Bằng cơ chế lưu nội dung vào bộ đệm (cache), kiểm tra bộ đệm trước khi tiến hành thực hiện yêu cầu, CodeIgniter giảm số lần truy cập và xử lý dữ liệu, từ đó tối ưu hóa tốc độ tải trang.
        * Hệ thống thư viện phong phú
    CodeIgniter cung cấp các thư viện phục vụ cho những tác vụ thường gặp nhất trong lập trình web, chẳng hạn như truy cập cơ sở dữ liệu, gửi email, kiểm tra dữ liệu, quản lý session, xử lý ảnh…đến những chức năng nâng cao như XML-RPC, mã hóa, bảo mật…
        * Bảo  mật hệ thống
    Cơ chế kiểm tra dữ liệu chặt chẽ, ngăn ngừa XSS và SQL Injection của CodeIgniter giúp giảm thiểu các nguy cơ bảo mật cho hệ thống.
        * Nhỏ gọn
        Gói cài đặt chỉ 404KB (không bao gồm phần User Guide). So với các PHP framework khác như CakePHP (1.3MB), Symfony (5.08MB) hay Zend Framework (5.66MB)…kích thước của CodeIgniter giúp giảm thiểu đáng kể không gian lưu trữ.
    * Nhược điểm
        * Chưa hỗ trợ Object Relational Mapping
        Object Relational Mapping (ORM) là một kỹ thuật  lập  trình, trong đó các  bảng của cơ sở dữ liệu được  ánh  xạ thành các đối tượng trong chương trình. Kỹ thuật  này  giúp  cho  việc  thực  hiện các thao tác trong cơ sở dữ liệu  (Create  Read  Update  Delete – CRUD)  dễ dàng,  mã  nguồn  ngắn  gọn hơn. Hiện  tại, CodeIgniter vẫn chưa hỗ trợ ORM.
        * Chưa hỗ trợ AJAX
        AJAX  (Asynchronous  JavaScript  and  XML) đã trở thành  một  phần không thể thiếu trong bất kỳ ứng dụng Web 2.0 nào. AJAX giúp nâng cao tính tương tác giữa người dùng và hệ thống, giúp cho người dùng có cảm giác như đang sử dụng ứng dụng desktop vì các thao tác đều  diễn ra “tức  thời”. Hiện tại,  CodeIgniter  vẫn chưa có thư viện dựng sẵn nào để hỗ trợ xây dựng ứng dụng AJAX. Lập trình viên phải sử dụng các thư viện bên ngoài, như jQuery, Script.aculo.us, Prototype hay Mootools…
        * Chưa hỗ trợ một  số module thông  dụng
        So sánh với framework  khác, CodeIgniter  không có các module thực thi một số tác vụ thường gặp trong quá trình xây dựng ứng dụng web như Chứng thực người dùng (User Authorization), trình phân tích RSS (RSS Parser) hay trình xử lý PDF…
        * Chưa hỗ trợ Event-Driven Programming
        Event-Driven Programming (EDP) là một nguyên lý lập trình, trong đó các luồng xử lý của hệ thống sẽ dựa vào các sự kiện, chẳng hạn như click chuột, gõ bàn phím không phải  là  một  khuyết điểm  to  lớn  của CodeIgniter  vì  hiện tại,  chỉ có  một  số ít  framework  hỗ trợ EDP,  bao  gồm  Prado,  QPHP và Yii.

### 3. Symfony
![](https://viblo.asia/uploads/d87c39b2-5e6f-4434-ab5d-9a5bf5a080e3.jpg)
Symfony framework được sử dụng bởi nhiều dự án lớn, chẳng hạn như hệ thống quản trị nội dung Drupal hay phần mềm diễn đàn phpBB, thậm chí Laravel mà chúng tôi đã đề cập ở ý 1 cũng dựa trên Symfony. Symfony có một cộng đồng phát triển đông đảo và nhiệt tình. Đây được dự đoán sẽ là PHP framework hoàn thiện nhất.

Symfony Components là các thư viện có thể tái sử dụng cho phép bạn hoàn tất các tác vụ khác nhau, chẳng hạn như tạo ra các biểu mẫu, cấu hình đối tượng, định tuyến, chứng thực, làm khuôn mẫu... Bạn có thể cài đặt bất cứ Components với Composer PHP nào.
    * Ưu điểm
        * Module hóa
        * Dễ dàng mở rộng
        * Có nhiều tính năng hoàn chỉnh
        * Hỗ trợ Doctrine2.
    * Nhược điểm: khá cồng kềnh và chậm chạp bởi chính sự đa dạng về tính năng của nó.

### 4. Laravel
![](https://viblo.asia/uploads/cf6fe3f2-e1eb-4110-8acd-5cbfb2735d73.png)
Mặc dù Laravel là một PHP framework tương đối mới (được phát hành năm 2011) nhưng theo các khảo sát trực tuyến gần đây do Sitepoint phát hành thì đây là một trong những framework được các nhà phát triển sử dụng nhiều nhất. Laravel có một hệ sinh thái rộng lớn với một nền tảng triển khai và lưu trữ tức thời. Trang web chính thức của Laravel cung cấp nhiều hướng dẫn dưới dạng video được gọi là Laracasts.

Laravel có rất nhiều tính năng cho phép phát triển ứng dụng một cách nhanh chóng. Laravel có các Blade Templating Engine - đây là một templating framework tương tự như cách thức hoạt động của Smart Templating Engine, nó sử dụng các thẻ tùy chỉnh và các hàm để chia tách mã code tốt hơn. Laravel cũng có các elegant syntax trang bị cho các tác vụ mà bạn thường xuyên phải làm như xác thực, các phiên, hàng chờ, nhớ đệm... Ngoài ra, Laravel còn bao gồm một môi trường phát triển cục bộ được gọi là Homestead.
    * Ưu điểm
        * Routes mới mẻ và đầy mạnh mẻ. Mọi url đều có thể quản lý trong file routes/web.php.
        * Master layout được tích hợp sẵn cùng Blade template giúp code của chúng ta trên nên gọn gàng và tiện dụng. Các file layout có thể dẽ dàng extend của nhau giúp code ngắn gọn, dễ quản lý.
        * Migration quản lý database thật dễ dàng khi làm việc nhóm.
        * Eloquent class đầy mạnh mẽ nổi bật khi xử lý cơ sở dữ liệu quan hệ 1 – N và N – N, tối ưu tất cả các câu truy vấn.
        * Composer quản lý và tích hợp các thư viện khác thật hay và không lo lắng khi thư viện đó bị thay đổi, laravel có đầy đủ các thư viện cơ bản đủ để thực hiện mọi yêu cầu của chúng ta.
        * Document dễ đọc, dễ hiểu và có đầy đủ các ví dụ. Tuy ra đời muộn hơn các framework khác nhưng laravel lại có hướng dẫn chi tiết và đầy đủ ví dụ ngay tại trang chủ, các ví vụ để đọc đễ hiểu, cộng đồng phát triển rộng lớn và luôn luôn được update kịp thời
        * Eloquent ORM: đây là một ORM tuyệt vời với khả năng migration data và làm việc tốt với MySQL, Postgres, SQL Server và SQLite, MongoDB. Các câu truy vấn database dễ hiểu, nhanh chóng.
        * Package-libery phong phú, đa dạng, đáp ứng được hầu hết các nhu cầu cơ bản của chúng ta.
        * User authentication được tích hợp sẵn, lập trình viên chỉ cần gọi class là có thể sử dụng theo ý muốn..

### 5. Phalcon
![](https://viblo.asia/uploads/d4d71326-ddd0-4f69-9aae-704a8f6e771c.jpg)
Phalcon framework được phát hành từ năm 2012 và nhanh chóng được đón nhận bởi cộng đồng các nhà phát triển PHP. Phalcon được ví là nhanh như *chim ưng* (như đúng tên gọi) với tốc độ thực thi mã nhanh nhất nhờ được viết bởi C và C++. Bạn cũng không cần phải học ngôn ngữ lập trình C bởi các chức năng có sẵn đã được biểu diễn dưới dạng các lớp PHP để có thể sử dụng cho bất cứ ứng dụng nào.

    * Ưu điểm
        * Hiệu năng vượt bậc so với các Framework khác do được viết bởi C và C++.
        * Module hoá được những thành phần cần thiết cho một ứng dụng (như ORM, các Template Engine cho việc hiển thị, PHQL), gần như đầy đủ không cần dùng đến thư viện của bên thứ 3.
        * Cài đặt Phalcon như một phần mở rộng (Extension) giúp đơn giản hóa việc cài đặt ứng dụng lên máy chủ.
    * Nhược điểm
        * Việc Phalcon được viết bằng ngôn ngữ lập trình C vừa là ưu điểm đồng thời cũng là nhược điểm của Framework này – Đó là vấn đề lỗi phát sinh đến từ extension của Phalcon.

Nguồn:
* https://www.sitepoint.com/best-php-framework-2015-sitepoint-survey-results/
* http://www.amarinfotech.com/why-laravel-is-best-php-framework-in-2016.html
* http://www.hongkiat.com/blog/best-php-frameworks/

----
