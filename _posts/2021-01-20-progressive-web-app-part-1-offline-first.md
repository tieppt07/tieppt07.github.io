---
layout: post
title: "Progressive Web App (part 1): Offline-first"
---

Trong series này, chúng ta sẽ cùng tìm hiểu một công nghệ không quá xa lạ nhưng rất hữu ích trong Web Development - Progressive Web App.

Trong series này, chúng ta sẽ cùng tìm hiểu một công nghệ không quá xa lạ nhưng rất hữu ích trong Web Development - Progressive Web App. Qua series này, các bạn sẽ nắm được:

### Progressive Web App PWA là gì

Các vấn đề tồn đọng của web truyền thống và cách PWA giải quyết
Service Worker - web API làm nên sức mạnh cho PWA
Trong phần 1 của series, chúng ta sẽ cùng tìm hiểu về chiến lược Offline-first trong web development và Service Worker góp phần thế nào trong chiến lược này.

Single-page application liệu đã đủ
Trong một thập niên trở lại đây, nhờ sự phát triển nhanh chóng và mạnh mẽ của Web API, một loạt framework hỗ trợ xây dựng single-page app (SPA) như AngularJS, Ember.js, React, ... đã ra đời. Ưu điểm của Single-page app so với Multiple-page app (MPA) đã được nói rất nhiều và có lẽ không cần bàn cãi. SPA góp phần "đáng kể" trong việc giúp người dùng có một trải nghiệm xuyên suốt, không bị gián đoạn cho mỗi lần chuyển đổi view. Tuy nhiên vẫn chỉ là góp phần "đáng kể" vì SPA vẫn có một giai đoạn làm gián đoạn trải nghiệm người dùng: lần load app đầu tiên.

Nếu không có internet, thì dù có SPA, chúng ta cũng lại gặp khủng long T-rex như MPA mà thôi:

![no-internet-connection](https://thinhdora.me/development/progressive-web-app-part-1-offline-first/www-google-com-vn-2018-07-21-10-03-56.jpg)

Tuy nhiên gặp khủng long T-rex vẫn còn tốt chán vì "đau một lần rồi thôi". Sẽ còn đau dai dẳng hơn nữa khi gặp tình trạng mạng "một vạch":

![progressive](https://thinhdora.me/development/progressive-web-app-part-1-offline-first/ain-amp-039-t-nobody-got-time-for-slow-wifi_o_2428207.jpg)

Chúng ta sẽ phải chờ, phải chờ, phải chờ ... và không biết đến khi nào ứng dụng mới load xong. Vậy bài toán đặt ra là, làm thế nào để mỗi lần người dùng khởi động SPA, ứng dụng có thể xuất hiện càng nhanh càng tốt?

### Offline-first

Có rất nhiều các giải pháp để tăng tốc độ lần tải đầu tiên như sử dụng proxy server (như aws cloudfront, cloudflare), sử dụng cache server như Redis, ... Tuy nhiên, các công nghệ đó đều có một điểm chung là vẫn phụ thuộc vào mạng nói chung (Online-first).

Vậy offline-line first là gì. Offline-first tức là mang lên màn hình người dùng càng nhanh - càng nhiều - càng tốt những thứ đã được cache sẵn trong chính thiết bị người dùng. Chúng ta vẫn sẽ cần đến mạng, tuy nhiên chúng ta sẽ không viện đến mạng trước tiên. Chúng ta sẽ "lục lọi" trong cache và lấy dữ liệu có sẵn càng nhiều càng tốt, dựng lên một ứng dụng hoàn chỉnh trước mắt người dùng với nội dung của lần truy cập gần đây nhất. Đồng thời trong quá trình đó, chúng ta vẫn thực hiện request lên server để lấy dữ liệu. Sau khi ứng dụng đã xuất hiện chuẩn chỉnh trước mắt người dùng, chúng ta sẽ xem xét đến request chúng ta đã thực hiện. Nếu request đã thành công, chúng ta sử dụng dữ liệu mới cập nhật lên màn hình cho người dùng, thay thế dữ liệu cũ, đồng thời cache tiếp dữ liệu đó cho lần tải app tiếp theo. Nếu request thất bại, chúng ta có thể hiển thị cho người dùng một thông báo "không có kết nối". Nếu mạng chậm và request mất quá nhiều thời gian mà chưa có phản hồi, sau một khoảng thời gian ấn định trước, chúng ta có thể hiển thị một thông báo cho người dùng "Kết nối rùa bò. Quý khách có thể quay lại sau".

### Service Worker

#### Tổng quan

Chúng ta đã nhận thức được vấn đề, đã có hướng giải quyết. Giờ chúng ta sẽ xét đến công cụ giúp chúng ta thực hiện giải pháp.

`
Service Worker - a feature let us control the network, rather than letting the network controls you.
`

Service Worker là một kiểu Web Worker, có nghĩa là nó thực thi ở một luồng riêng biệt và không tương tác trực tiếp với người dùng. Hiểu nôm na thì service worker hoạt động như một proxy đứng giữa người dùng và mạng. Tại đây, bạn có thể thao túng được kết nối giữa người dùng và mạng. Ví dụ như nhận request từ người dùng nhưng không cho request đi tiếp đến server, mà truy cập vào cache, trả lại cache cho người dùng ...

![progressive](https://thinhdora.me/development/progressive-web-app-part-1-offline-first/The-offline-cookbook-JakeArchibald-com-2018-07-22-22-15-36.jpg)

#### Độ tương thích

Tính đến thời điểm viết bài này thì gần như tất cả các tính năng của Service Worker đã được hỗ trợ bởi các trình duyệt hiện đại gồm Chrome, Firefox, Opera, Safari và Edge.

![progressive](https://thinhdora.me/development/progressive-web-app-part-1-offline-first/Is-service-worker-ready-2018-07-21-11-29-08.jpg)

Để biết chi tiết hơn về mức độ support từ các trình duyệt, các bạn có thể truy cập địa chỉ https://jakearchibald.github.io/isserviceworkerready/

Trong phần tiếp theo, chúng ta sẽ đi sâu tìm hiểu về Service Worker qua một số ví dụ cũng như công cụ giúp phát triển và debug.

### Tham khảo

- [https://classroom.udacity.com/courses/ud899](https://classroom.udacity.com/courses/ud899)
- [https://github.io/isserviceworkerready/](https://github.io/isserviceworkerready/)

---
