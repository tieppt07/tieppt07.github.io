---
layout: post
title: Copy nội dung trên web vào clipboard bằng một click chuột
---

Khi sử dụng một web page, rất nhiều khi người dùng sẽ cần copy một nội dung có sẵn. Những nội dung này nhiều khi nhà phát triển có thể dễ dàng đoán được. Ví dụ như 2 nền tảng Git nổi tiếng là Github và Bitbucket, ở khu vực hiển thị repo url, họ đều trang bị sẵn một button giúp người dùng dễ dàng copy repo url chỉ bằng 1 click chuột.

![](https://images.viblo.asia/783e8625-2e58-4113-921f-2f24ac6d990f.jpg)

Hay đôi khi phức tạp hơn, ví dụ người dùng muốn copy một table sau đó copy vào bảng tính excel để dễ dàng thống kê.

![](https://images.viblo.asia/3077b346-3a37-49a5-bd77-750868b05350.jpg)

Trong bài này mình sẽ hướng dẫn thực hiện copy bằng 1 click chuột với cả 2 trường hợp trên.

### Trường hợp 1: Copy một chuỗi đơn giản

#### Cách thực hiện
Tức là giống trường hợp Github hay Bitbucket nói trên. Trường hợp này rất phổ biến, nếu bạn search thì có cả đống hướng dẫn. Ngay cả trên W3School cũng có luôn ([https://www.w3schools.com/howto/howto_js_copy_clipboard.asp](https://www.w3schools.com/howto/howto_js_copy_clipboard.asp)). Mình sẽ lấy luôn ví dụ của trang này:

Đầu tiên là file html:

```html
<input type="text" value="Hello World" id="myInput">

<button onclick="myFunction()">Copy text</button>
```

```js
function myFunction() {
  var copyText = document.getElementById("myInput");
  copyText.select();
  document.execCommand("copy");
}
```
Cách hoạt động thì rất dễ hiểu. Chúng ta cho đoạn text cần copy vào 1 input hoặc textarea. Sau đó select node này. Input hoặc textarea element sẽ có sẵn 1 phương thức có tên `select()`. Phương thức này sẽ bôi đen nội dung bên trong input hoặc textarea. Khi đó chúng ta chỉ cần execute command copy là nội dung sẽ được bê vào clipboard.

#### Độ tương thích
Các web API được sử dụng ở trên đều tương thích với IE9 trở lên


### Trường hợp 2: Copy một cấu trúc phức tạp hơn như table
#### Cách thực hiện
Trường hợp này thì phức tạp hơn một chút, vì chúng ta sẽ ko chỉ làm việc với một element như trường hợp trên. Ví dụ table sẽ chứa rất nhiều element con.

Đầu tiên chúng ta cần một table nhỏ để test như sau:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Document</title>
  <style>
    table,
    th,
    td {
        border: 1px solid #999;
        border-collapse: collapse;
    }
  </style>
</head>
<body>
  <table id="table">
    <thead>
      <tr>
        <th>name</th>
        <th>skill</th>
        <th>Nov 18</th>
        <th>Nov 19</th>
        <th>Nov 20</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John Doe</td>
        <td>Web</td>
        <th>1</th>
        <th>n/a</th>
        <th>1/2</th>
      </tr>
      <tr>
        <td>Jane Doe</td>
        <td>Mobile</td>
        <th>n/a</th>
        <th>1</th>
        <th>1</th>
      </tr>
    </tbody>
  </table>

  <button>select and copy</button>
</body>
</html>
```

Nội dung HTML hiện tại trông sẽ thế này:

![](https://images.viblo.asia/16791481-3232-41a2-ab48-b07aec420339.png)

Tiếp đến là phần Javascript. Để copy được một element tập hợp nhiều element con như table, chúng ta sẽ sử dụng đến một Web API có tên Range và Selection. Range: Các bạn có thể hiểu DOM là một tập hợp nhiều element nodes, mỗi node đều có content như text hoặc node con hoặc rỗng, thì Range là một interface đại diện cho một mảnh DOM. ([https://developer.mozilla.org/en-US/docs/Web/API/Range](https://developer.mozilla.org/en-US/docs/Web/API/Range)) Selection: Là một object đại điện cho một đoạn bôi đen của người dùng ([https://developer.mozilla.org/en-US/docs/Web/API/Selection](https://developer.mozilla.org/en-US/docs/Web/API/Selection)).

Đầu tiên chúng ta sẽ khởi tạo một instance Range bằng phương thức `createRange()` và một selection bằng phuơng thức `getSelection()`:

```js
let range, selection;
range = document.createRange();
selection = window.getSelection();
```

Tiếp theo sau khi khởi tạo Range, chúng ta cho đối tượng range thêm thông tin. Một đối tượng Range cần các thuộc tính `startContainer` (node bọc đầu), `endContainer` (node bọc cuối), `endOffset` (index của child item đầu), `startOffset` (index child item cuối). Chúng ta sẽ sử dụng phương thức `selectNode`() để tự động gán giá trị cho các thuộc tính này ([https://developer.mozilla.org/en-US/docs/Web/API/Range/selectNode](https://developer.mozilla.org/en-US/docs/Web/API/Range/selectNode))

```js
const elementToSelect = document.getElementById('table');
range.selectNode(elementToSelect);
```
`selectNode()` nhận một DOM element làm parametter. Sau khi truyền vào `document.getElementById('table')`, start và end container sẽ nhận chính là parent node của table, ở đây là body.

Tiếp đến là sử dụng selection để bôi đen nội dung. Để cẩn thận hơn thì trước khi sử dụng selection, chúng ta sẽ remove tất cả các selection hiện có:

```js
selection.removeAllRanges();
```

Tiếp theo rất dễ hiểu, sử dụng method `addRange()` để bôi đen nội dung.

```js
selection.addRange(range);
```

Và cuối cùng sử phương thức `execCommand()` để thực thi lệnh Copy giống trường hợp đơn giản lúc trước:

```js
document.execCommand('Copy');
```
Đây là đoạn JS đầy đủ, chúng ta sẽ cho tất cả vào 1 function để dễ dàng bind vào button đã tạo sẵn:

```js
function selectAndCopy() {
    const elementToSelect = document.getElementById('table');
    const range = document.createRange();
    const selection = window.getSelection();
    selection.removeAllRanges();
    range.selectNode(elementToSelect);
    selection.addRange(range);
    document.execCommand('Copy');
}
```

Phía HTML, chúng ta bind function `selectAndCopy()` vào event onclick của button:

```js
<button onclick="selectAndCopy()">select and copy</button>
```

Đến đây các bạn có thể thử chạy, click vào nút select and copy, sau đó paste tạo một bảng tính google sheet hoặc excel, sau đó paste thử.

![](https://images.viblo.asia/23ed824f-63c8-4b7d-b86b-6f89beee834e.jpg)

#### Độ tương thích
Các web API được sử dụng ở trên đều tương thích với IE9 trở lên


---
