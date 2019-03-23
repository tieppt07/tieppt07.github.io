---
layout: post
title: Lần đầu viết chrome extension
---

Chrome là một trình duyệt đang được sử dụng phổ biến hiện nay. Có đến hơn 75% người dùng sử dụng trình duyệt Chrome (theo thống kê ở W3School https://www.w3schools.com/Browsers/default.asp).

![](https://images.viblo.asia/0bf0dcd3-20f9-4e43-b5b6-5345485d3cc5.jpg)

![](https://images.viblo.asia/a4d2f77c-4c13-4a13-98aa-cf02a7587bc6.png)

Và chắc hẳn khi sử dụng Chrome thì bạn cũng đã cài đặt ít nhất 1 extention (có thể là extention chặn quảng cáo, extention chatwork, extention đổi IP,...). Vậy extention là gì mà nó làm được nhiều việc đến vậy?

#### Chrome extension là gì?
Chrome extension đơn là là một web app nhỏ tạo ra từ sự kết hợp giữa HTML, CSS và Javascript, cho phép tương tác với Chrome thông qua một số các Javascript APIs mà Chrome cung cấp. Chrome extension có thể được config để chỉ hoạt động trên một số trang nhất định thông qua param Page Actions, hoặc thiết lập code chạy nền sử dụng Background Pages hay thậm chí thay đổi thành phần của trang web đã được load hiện tại sử dụng Content Scripts. Trong tut này, mình sẽ hướng dẫn tạo một dạng extension cơ bản nhất.

#### Cấu trúc chrome extention
Cấu trúc cơ bản của chrome-extention, mình thấy có các thành phần cơ bản sau:
* `manifest.json` để chứa các thông tin về Extention ví dụ như Version, tên, mô tả, icon Extention, các file scripts, các trang mà extention được phép hoạt động.
* `popup.js`, `popup.html` để tương tác với popup xổ ra khi chúng ta click vào extention
* `background.js` để tương tác với browser luôn, tức có khi bản muốn browser mở 1 url nào đó chẳng hạn, hay listen event nào đó của browser, hoặc access ChromeAPI.

#### Tạo project
* Điều đầu tiên cần làm là tạo thư mục project và các file cần thiết của 1 extension.
* Mô tả các thông tin cần thiết tới project với file `manifest.json`.
    ```javascript
    // manifest.json
    {
        "name": "The 1st chrome extension",
        "version": "1.0",
        "description": "By TiepPhung",
        "permissions": ["storage", "declarativeContent"],
        "browser_action": {
            "default_popup": "popup.html"
        },
        "background": {
            "scripts": ["background.js"],
            "persistent": false
        },
        "manifest_version": 2
    }
    ```
* `popup.html` và `popup.js` với các đoạn code html, js cơ bản dùng để bắt sự kiện click button và get dữ liệu từ ô input.
    ```html
    // popup.html
    <html lang="en">
    <head>
        <meta charset="utf-8">
        <title>This is a chrome extension demo.</title>
    </head>
    <body>
        <h3>LastName</h3>
        <input type="text" name="last_name" id="last_name">

        <h3>FirstName</h3>
        <input type="text" name="first_name" id="first_name">

        <button id="save">Save</button>
        <script src="popup.js"></script>
    </body>
    </html>
    ```

    ```javascript
    // popup.js
    document.getElementById("save").onclick = function () {
        var firstName = document.getElementById("first_name").value;
        var lastName = document.getElementById("last_name").value;

        console.log("on click save");
        console.log("FirstName: " + firstName);
        console.log("LastName: " + lastName);
    }
    ```

#### Import project vào chrome
Đến đây thì các bước đã hoàn thành, chỉ cần load extension lên Chrome và chạy thử là xong. Để load extension, chọn Tools -> Extensions -> Tích Developer Mode -> Chọn load unpacked extension -> Chọn đường dẫn tới thư mục project
![](https://images.viblo.asia/5ad2ca3c-c550-4ef9-a7a2-221b3615617b.png)
Sau khi load extension lên chrome thì hiện ra thế này :D
![](https://images.viblo.asia/2418495a-7020-4f94-b8d3-1a06ec062464.png)
Chạy thử thì được thế này
![](https://images.viblo.asia/728fe8e7-0c4d-481c-a921-eba85cd13979.png)

1 Chrome extension sơ sinh đã xong. Cơ bản chúng ta đã hiểu được qua cách viết và cấu trúc của 1 chrome extension như thế nào. Chúng ta sẽ gặp lại nhau ở phần sau để build chi tiết hơn 1 extension khác :D

ref: [https://developer.chrome.com/extensions](https://developer.chrome.com/extensions)

----
