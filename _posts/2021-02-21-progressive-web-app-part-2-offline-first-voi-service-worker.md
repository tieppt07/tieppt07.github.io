---
layout: post
title: "Progressive Web App (part 2): Offline-first với Service Worker"
---

Ở phần trước của series Progressive Web App (PWA), chúng ta đã đi qua vấn đề tồn đọng lớn của Single Page App (SPA) - không có khả năng hoạt động offline, và cách giải quyết của PWA - cũng là ưu điểm lớn nhất của PWA - Offline-First strategy. Trong phần tiếp theo này, chúng ta sẽ tìm hiểu sâu hơn về Service Worker - thứ đem lại sức mạnh Offline-first cho PWA.

### Các tính chất của Service Worker

`Service Worker` (SW) là một trong 3 kiểu `Web Worker` (2 người anh em còn lại là `Worker` và `Dedicated Worker`. Và vì cùng là họ hàng Worker, SW kế thừa một tính chất điển hình của `Web Worker`, đó là hoạt động ở một luồng riêng biệt (context riêng biệt) so với window context mặc định. Với trình duyệt chrome, khi mở developer tools > console, chúng ta sẽ có một tuỳ chọn giúp thay đổi console context hiện tại. Mặc đinh, context của chúng ta sẽ là top hay window context. Khi chuyển sang SW context, chúng ta có thể thực thi các câu lệnh từ console vào SW context.

![](https://thinhdora.me/development/progressive-web-app-part-2-service-worker/ManageThinh-Bui-2018-08-21-22-06-27.jpg)

Chính vì khả năng hoạt động ở một luồng tách biệt, SW kết hợp với SPA mang lại sức mạnh offline. SW giúp chúng ta kiểm soát hoàn toàn request từ ứng dụng tới server, kiểm soát cache, từ đó đưa ra các phương án hoạt động offline phù hợp cho từng trường hợp cụ thể. Ngoài ra SW còn mang lại sức mạnh Push Notification trên trình duyệt cho web app. Đây cũng là một trong những tính năng nổi bật của PWA, sẽ được đề cập trong các bài viết sau.

Bên cạnh điểm mạnh nói trên, SW cũng thừa hưởng cả một số hạn chế của họ hàng Web Worker ví dụ như ko truy cập được vào DOM, do hoạt động ở một luồng hoàn toàn riêng biệt nên hoàn toàn bất đồng bộ dẫn đến một số API đồng bộ như synchronous XHR, localStorage, ... sẽ không thể hoạt động bên trong SW. Tuy nhiên những hạn chế này không quan trọng vì nhiệm vụ chính của SW là hoạt động ngầm và không tương tác trực tiếp với người dùng. Một điểm cần chú ý nữa đó là SW không hoạt động với cổng 80 đồng nghĩa với việc đường dẫn ứng dụng của bạn sau khi deploy phải hoạt động dưới định dạng https.

### Tích hợp Service Worker vào Web App hiện tại của bạn

Cũng giống như 2 người anh em Web Worker kia, SW cũng sẽ được viết riêng thành một file và sẽ được đăng kí với trình duyệt trong quá trình khởi chạy. Giả sử chúng ta tạo mới một file với tên gọi service-worker.js vào thư mục gốc web app hiện tại của bạn. Để bắt đầu sử dụng, chúng ta cần đăng kí file service-worker.js này. Chúng ta gọi đến thuộc tính serviceWorker của Navigator object, sẽ có được một ServiceWorkerContainer object. Với ServiceWorkerContainer, chúng ta có thể bắt đầu thao tác với SW như đăng kí, xoá, nâng cấp, giao tiếp với SW, ...

```js
navigator.serviceWorker.register('/service-worker.js');
```

Method `register()` trả về một Promise instance, do đó chúng ta có thể viết tiếp:

```js
navigator.serviceWorker.register('/service-worker.js').then(function(result) {
  console.log('Success');
}).catch(function() {
  console.log('Whoops!');
});
```

Nếu trước đó ứng dụng của bạn đã đăng kí SW với trình duyệt một lần rồi, thì ở những lần tải sau, method register() sẽ trả về một Promise instance của lần đăng kí đã tồn tại trước đó.

### Vòng đời hoạt động (Lifecycle)

Sau khi đăng kí thành công, service worker sẽ bắt đầu vòng đời của nó gồm:

- Download
- Install
- Activate

Service Worker sẽ được tải về máy ngay khi người dùng truy cập site hoặc web app có sử dụng SW. Như đã nói trước đó, nếu SW đã được đăng kí, ở lần sử dụng tiếp theo - thay vì tải lại service worker - trình duyệt sẽ chủ động sử dụng lại instance của lần khơi tạo trước đó. Tuy nhiên, (tối thiểu) mỗi 24h hoặc ít hơn, trình duyệt sẽ tự động tải lại SW.

Quá trình cài đặt sẽ chỉ được thực hiện nếu file SW lần đầu tiên được tải xuống hoặc mới hơn file đã được tải xuống trước đó. Nếu SW lần đầu tiên được tải xuống (tức là trước đấy bạn chưa từng sử dụng site/app đó), SW sẽ được cài đặt và kích hoạt ngay lập tức.

Nếu trước đó đã SW đã được cài đặt và kích hoạt, sau khi phiên bản mới hơn của SW file được tải về, nó vẫn sẽ được cài đặt ngầm ngay lập tức, tuy nhiên việc activated thì sẽ được xem xét.

![](https://thinhdora.me/development/progressive-web-app-part-2-service-worker/Offline-Web-Applications-Udacity-2018-08-21-21-59-45.jpg)

Lúc này SW sẽ ở trạng thái `waiting` (chờ được kích hoạt). Chỉ khi nào không còn một page/tab nào trên trình duyệt của bạn sử dụng SW instance cũ nữa, lúc này SW mới mới được kích hoạt. Trong quá trình dev, với trình duyệt Chrome, bạn có thể vào dev tools > Application > Service Worker, check vào Update on reload.

![](https://thinhdora.me/development/progressive-web-app-part-2-service-worker/ManageThinh-Bui-2018-08-21-22-20-07.jpg)

Nếu check vào tuỳ chọn này, dù cho bất kể còn tab nào khác đang sử dụng chung SW instance với tab hiện tại, chỉ cần reload lại tab hiện tại, version mới hơn của SW sẽ được cài đặt. (tất nhiên tuỳ chọn này chỉ có hiệu lực khi bạn mở developer tool).

Bên trong SW file, chúng ta sẽ được cung cấp install event. Đây là thời điểm thích hợp để chuẩn bị cho quá trình sử dụng SW. Thông thường tại đây, chúng ta sẽ cache các asset file phục vụ cho việc chạy app offline:

```js
var cacheName = 'my-app-v1';
var filesToCache = [
  '/',
  '/index.html',
  '/favicon.ico',
  '/js/main.js',
  '/css/demo.css',
];

self.addEventListener('install', function(e) {
  console.log('[ServiceWorker] Install');
  e.waitUntil(
      caches.open(cacheName).then(function(cache) {
        console.log('[ServiceWorker] Caching app shell');
        return cache.addAll(filesToCache);
      })
  );
});
```

Ngoài install event, chúng ta cũng có activate event. Đây là thời điểm phù hợp cho việc dọn dẹp cache của bản cũ.

```js
var cacheName = 'my-app-v1';
self.addEventListener('activate', function(e) {
  console.log('[ServiceWorker] Activate');
  e.waitUntil(
      caches.keys().then(function(keyList) {
        return Promise.all(keyList.map(function(key) {
          if (key !== cacheName) {
            console.log('[ServiceWorker] Removing old cache', key);
            return caches.delete(key);
          }
        }));
      })
  );
  return self.clients.claim();
});
```

Cuối cùng là một event mang lại sức mạnh to lớn cho PWA, đó là fetch event. Tại đây, bạn sẽ đánh chặn request từ app, và tự viết logic của chính bạn quyết định việc sẽ trả về gì cho người dùng.

```js
var dataCacheName = 'my-app-data-v1';
self.addEventListener('fetch', function(e) {
  console.log('[ServiceWorker] Fetch', e.request.url);
  var dataUrl = 'my-app-api.com';
  // trường hợp request lên địa chỉ api
  if (e.request.url.indexOf(dataUrl) > -1) {
    e.respondWith(
        // lấy dữ liệu mới nhất về, cache lại, và trả về cho người dùng
        caches.open(dataCacheName).then(function(cache) {
          return fetch(e.request).then(function(response) {
            cache.put(e.request.url, response.clone());
            return response;
          });
        })
    );
  }
  else {
    // ... còn không thì trả về cached asset files
    e.respondWith(
        caches.match(e.request).then(function(response) {
          return response || fetch(e.request);
        })
    );
  }
});
```

### Scoping

Một điểm đáng lưu tâm khi sử dụng SW đó là scoping - tầm hoạt động của SW.

```js
navigator.serviceWorker.register('sw.js', {
  scope: '/my-app/'
});
```

Ở ví dụ trên, khi đăng kí SW, ngoài tham số thứ nhất là file SW, lần này chúng ta có thêm tham số thứ hai để xác định phạm vi hoạt động cho SW file, tạm hiểu là nếu từ bên trong file sw.js, bạn chỉ có thể chạm đến các file có đường dẫn `/my-app/`. Ví dụ file sw.js vừa đăng kí có thể chạm đến `/my-app/main.js`, `/my-app/foo/bar`, nhưng sẽ không thể chạm đến đường `/`, `/not-my-app`, `/my-app`. Mình xin nhấn mạnh lại là /my-app cũng sẽ bị coi là shallow URL và nằm ngoài scope chúng ta vừa đăng kí ở trên.

Vậy nếu chúng ta không khai báo scope thì sao. Khi đó scope mặc định sẽ chính là vị trí của SW file đang đứng. Ví dụ:

| SW file location | Default scope |
| --- | ----------- |
|/sw.js | / |
|/foo/sw.js | /foo/|
|/foo/bar/sw.js| /foo/bar/|

Tới đây các bạn đã có thể có được cái nhìn sơ lược về cách SW mang lại sức mạnh Offline-first cho Web App. Các bạn có thể tự thực hành làm một ví dụ với hướng dẫn cụ thể từ Google để làm quen với cách sử dụng SW.

Trong phần tiếp theo, chúng ta sẽ cùng tìm hiểu về các chiến lược thao túng cache và request bên trong SW.

Tham khảo:
- [https://developers.google.com/web/fundamentals/codelabs/your-first-pwapp/](https://developers.google.com/web/fundamentals/codelabs/your-first-pwapp/)
- [https://classroom.udacity.com/courses/ud899](https://classroom.udacity.com/courses/ud899)

---
