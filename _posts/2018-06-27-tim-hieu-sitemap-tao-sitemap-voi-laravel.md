---
layout: post
title: Tìm hiểu sitemap, tạo sitemap với laravel
---

Là một công đoạn nhỏ chỉ mất 5 phút để làm xong, tuy nhiên việc tạo sitemap & khai báo với Google sẽ mang lại lợi ích rất thiết thực cho bạn. Vì vậy bất cứ khi nào bạn làm một website mới, đừng nên bỏ qua công việc này.
![](https://images.viblo.asia/4d135709-ccc3-491c-9986-8347c538a91d.png)

### 1. Sitemap là gì?
Sitemap ở đây chính là sơ đồ của trang web mà bạn đang quản trị. Một Sitemap sẽ mang trong mình 2 chức năng chính đó là:
- Hiển thị Sitemap phục vụ nhu cầu, trải nghiệm của người dùng
- Hiển thị Sitemap phục vụ bot tìm kiếm trong việc thu thập thông tin, dữ liệu
Ở đây thì với Sitemap phục vụ người dùng và Sitemap dàng riêng cho các bot tìm kiếm sẽ có những sự khác nhau. Đối với Sitemap hiển thị đến người dùng, Sitemap này chỉ nên hiển thị theo phân cấp website kèm với đó là bạn sẽ không nên sử dụng bất kỳ hiệu ứng hình ảnh nào cả. Đối với Sitemap phục vụ bot tìm kiếm, chúng vô hình chung là những dòng lệnh XML được sắp xếp có trình tự.
Sitemap dành cho bot tìm kiếm là một tập tin XML có tên sitemap.xml. Trong đó, các biến trong tập tin này sẽ được khai báo hoàn toàn khác nhau dựa vào mức độ quan trọng, lần cập nhập cuối hay đường dẫn của trang. Sau đây sẽ là ví dụ về tập tin XML mà bot tìm kiếm sẽ nhìn thấy.


Trong đoạn code dưới thì loc là biến đường dẫn, lastmod là sự thay đổi và priority là độ quan trọng
``` xml
<url>
    <loc>https://viblo.asia/p/mysql-danh-index-cho-hieu-nang-cao-qzaGzdwVkyO</loc>
    <lastmod>2018-06-20T18:00:12+07:00</lastmod>
    <priority>1.0</priority>
</url>
```

### 2. Chức năng
Thông thường, những mạng lưới thu thập thông tin thường phát hiện những nội dung của trang web từ những liên kết nội bộ trong trang web đó, hoặc từ những trang web khác trỏ về. Sitemaps sẽ bổ sung dữ liệu để công cụ tìm kiếm có thể lấy được toàn bộ đường dẫn và hiểu về các dữ liệu liên quan.

Sử dụng giao thức Sitemap không đảm bảo được website của bạn sẽ xuất hiện trên công cụ tìm kiếm. Nhưng sẽ giúp cho công cụ tìm kiếm xử lý nội dung, thông tin & dữ liệu ở website bạn 1 cách nhanh & chính xác hơn.

Theo các chuyên gia về SEO thì sitemap không trực tiếp làm gia tăng thứ hạng từ khóa của bạn trên kết quả tìm kiếm, nhưng ví dụ có một vài bài viết trên trang web của bạn không (hoặc lâu) được lập chỉ mục (index) thì sitemap sẽ chính là công cụ khai báo cho google về các bài viết này, từ đó Google có thể lập chỉ mục cho các bài viết nhanh chóng.

Hoặc có bất cứ nội dung nào được cập nhật trên website của bạn, sitemap sẽ giúp Google phát hiện ra điều đó sớm hơn. Tương tự đối với page, danh mục hay thẻ tag,…Điều này ảnh hưởng gián tiếp tới SEO.

Phương thức hoạt động rất đơn giản, sau khi bạn tạo sitemap và thêm vào trên Google Search Console (Công đoạn này mình sẽ hướng dẫn ở trong bài này), các bot tìm kiếm của Google hay công cụ tìm kiếm khác sẽ theo các đường link trong sitemap này & thông báo để lập chỉ mục.


Việc tạo sitemap rất hữu ích đối với các website mới, vì những website mới luôn gặp khó khăn về vấn đề index (rất ít backlink trỏ về nên những con bọ của Google không thèm ghé thăm), XML sitemap sẽ thay mặt bạn nói với Google “Tôi có website mới, hãy vào do thám và index website của tôi”

Còn đối với các website cũ, XML sitemap sẽ giúp cho Google biết được mức độ cập nhật của website, giúp cho website bạn có được cái nhìn tổng quan hơn từ công cụ tìm kiếm, từ đó có thể xếp hạng chính xác hơn trên kết quả tìm kiếm.

a. Vai trò của Sitemap đối với người dùng: Đối với những trang web lớn, đồ sộ về những thông tin thì việc lựa chọn mục nào, nội dung nào để xem cũng là vấn đề cần cân nhắc. Và nhằm xác định được phần nào cần thiết để theo dõi nội dung trên website, người dùng có thể chọn cách xem Sitemap của website để lựa chọn. Với cách này, người dùng họ sẽ nhanh chóng tìm thấy được những nội dung họ cần, nằm trong một mục cụ thể nào đó chẳng hạn mà khi xem cây thư mục Sitemap họ có thể dễ dàng tìm ra. Trong trường hợp người dùng họ muốn tìm kiếm chính xác một nội dung nào đó trên website thì họ có thể chọn chức năng tìm kiếm trên web

b. Vai trò của Sitemap trong Seo: Sitemap sẽ là một yếu tố cần thiết đển bot tìm kiếm có thể index đến tất cả các trang, nội dung trên web, không bỏ sót bất kỳ đường dẫn nào. Sitemap cũng giúp cho các chỉ mục sau khi được index sẽ sắp xếp một cách tốt hơn, bot tìm kiếm sẽ hiểu sâu hơn về nội dung mà website của bạn đang hướng đến. Tuy nhiên, có một điều bạn cần biết đó chính là Sitemap chỉ tập trung sự quan tâm vào những đường dẫn mà bạn đã khai báo, các chỉ số còn lại không phải mối quan tâm bởi có thể vì một lý do nào đó mà bạn cấu hình nhầm Sitemap dẫn đến hệ quả tiêu cực là website bị rớt hạng trên trang kết quả tìm kiếm

### 3. Tạo Sitemap với Laravel
**Cài đặt gói [roumen/sitemap](https://github.com/Laravelium/laravel-sitemap) với terminal:**
```sh
$ composer require roumen/sitemap
```

**Thêm Servide Provider:**
```php
Roumen\Sitemap\SitemapServiceProvider::class,
```

**Publish các file config:**
```sh
$ php artisan vendor:publish --provider="Roumen\Sitemap\SitemapServiceProvider"
```

**Ví dụ: Generate sitemap xml:**
```php
Route::get('mysitemap', function(){
    // create new sitemap object
    $sitemap = App::make("sitemap");

    // add items to the sitemap (url, date, priority, freq)
    $sitemap->add(URL::to(), '2012-08-25T20:10:00+02:00', '1.0', 'daily');
    $sitemap->add(URL::to('page'), '2012-08-26T12:30:00+02:00', '0.9', 'monthly');

    // get all posts from db
    $posts = DB::table('posts')->orderBy('created_at', 'desc')->get();

    // add every post to the sitemap
    foreach ($posts as $post)
    {
        $sitemap->add($post->slug, $post->modified, $post->priority, $post->freq);
    }

    // generate your sitemap (format, filename)
    $sitemap->store('xml', 'sitemap_index.xml');
    // this will generate file sitemap_index.xml to your public folder
});
```

Tham khảo:
* [https://github.com/Laravelium/laravel-sitemap](https://github.com/Laravelium/laravel-sitemap)
* [https://laravel-news.com/laravel-sitemap](https://laravel-news.com/laravel-sitemap)

----
