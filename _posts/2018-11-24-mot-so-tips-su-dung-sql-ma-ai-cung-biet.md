---
layout: post
title: Một số tips sử dụng SQL mà ai cũng biết ^^
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

ref: https://developer.chrome.com/extensionsSQL là viết tắt của Structured Query Language, là ngôn ngữ truy vấn mang tính cấu trúc.
Nó được thiết kế để quản lý dữ liệu trong một hệ thống quản lý cơ sở dữ liệu quan hệ (RDBMS).
SQL là ngôn ngữ cơ sở dữ liệu, được sử dụng để tạo, xóa trong cơ sở dữ liệu, lấy các hàng và sửa đổi các hàng, …
Tất cả DBMS như MySQL, Oracle, MS Access, Sybase, Informix, Postgres và SQL Server sử dụng SQL như là ngôn ngữ cơ sở dữ liệu chuẩn.

1. Giữ tên cột và bảng đơn giản
    Sử dụng một từ cho tên bảng thay vì hai. Nếu bạn cần sử dụng nhiều từ, hãy sử dụng dấu gạch dưới thay vì dấu cách hoặc dấu chấm.
Có dấu chấm “.” trong tên của các object sẽ gây nhầm lẫn giữa tên lược đồ và cơ sở dữ liệu. Mặt khác, sử dụng spaces có nghĩa là bạn cần phải thêm dấu ngoặc kép trong truy vấn của mình để cho nó có thể chạy.
Giữ tên cột và bảng được nhất quán bằng chữ thường để người dùng không phải nhầm lẫn nếu bạn chuyển sang cơ sở dữ liệu phân biệt chữ hoa chữ thường.

2. Xử lý vấn đề ngày, tháng, năm trong SQL
    Chuyển đổi date thành datetime biểu để cải thiện hiệu suất.
Sẽ khó hơn khi làm việc với các ngày được lưu trữ dưới dạng chuỗi vì thế hãy đảm bảo những chúng không bao giờ được dùng để hiển thị ngày tháng.
Không chia nhỏ năm, tháng và ngày thành các cột riêng biệt. Điều này khiến cho các truy vấn khó viết và lọc hơn nhiều.
Luôn sử dụng UTC cho múi giờ của bạn. Nếu bạn có sự kết hợp giữa UTC và non-UTC, điều đó sẽ khiến cho việc hiểu dữ liệu khó khăn hơn nhiều.

3. Hiểu rõ thứ tự execute và chạy Query
   Việc hiểu thứ tự truy vấn có thể giúp bạn hiểu cách truy vấn hoạt động cũng như lí do vì sao truy vấn của bạn sẽ không chạy.
    ```
    FROM – Includes JOINs so consider using a CTE or subquery to do filtering first.
    WHERE - To limit the joined dataset.
    GROUP BY – Collapses fields down with aggregate functions (COUNT, MAX, SUM, AVG)
    HAVING - Performs the same function as the WHERE clause with aggregate values.
    SELECT - Specifies values and aggregations remaining in the set after grouping.
    ORDER BY – Returns the table sorted by a column or multiple columns.
    LIMIT – Specifies how many rows to be returned to avoid returning too much data.
    ```

4. Hãy dùng EXISTS thay vì IN để kiểm tra sự tồn tại của dữ liệu.

5. Tránh * trong câu lệnh SELECT. Hãy dùng tên cột thích hợp.

6. Chọn loại dữ liệu thích hợp.
    Ví dụ lưu chuỗi sử dụng loại varchar thay vì sử dụng loại Text. Khi muốn sử dụng loại Text, là khi bạn cần lưu dữ liệu lơn (nhiều hơn 8000 ký tự)

7. Tránh dùng nchar và nvarchar vì cả hai đều tăng bộ nhớ lên gấp đôi so với char và varchar.

8. Tránh NULL đối với những trường mà đã cố định độ dài. Trong trường hợp yêu cầu là NULL hãy sử dụng một trường loại varchar với độ dài tùy biến thì vẫn lấy space ít hơn là NULL.

9. Tránh dùng mệnh đề Having. Chỉ nên dùng khi muốn lọc kết quả trả về.

10. Hãy tạo ra indexs là cách tốt nhất tăng tốc. Indexs bao gồm Clustered và Non-Clustered.

11. Hãy giữ index của clustered nhỏ thôi vì trường mà dùng trong cluster index đó thì cũng được dùng trong non-clustered index.

12. Đa số cột được chọn nên đặt trong non-clustered index.

13. Những index nào không được dùng thì nên xóa đi.
Tốt hơn là tạo ra index trên những cột có giả trị là số thay vì là ký tự. Giá trị số sử dụng ít bộ nhớ hơn ký tự.

14. Dùng câu lệnh join thay vì dùng select trong select
Hãy sử dụng mệnh đề WHERE để giới hạn cỡ của bảng kết quả trả về mà được tạo ra với câu lệnh join.

15. Sử dụng UNION ALL thay vì UNION nếu có thể.

16. Sử dụng tên Schema trước tên đối tượng SQL.

17. Giữ transaction nhỏ nhất có thể vì transaction khóa việc xử lý dữ liệu bảng và có thể dẫn đến kết quả bị deadlocks.

ref:
- [dev.to](https://dev.to/helenanders26/five-sql-tips-2hb)
- [ibm.com](https://www.ibm.com/support/knowledgecenter/en/SSZLC2_7.0.0/com.ibm.commerce.developer.soa.doc/refs/rsdperformanceworkspaces.htm)

----
