---
layout: post
title: Một số lưu ý khi viết CSS
---

### Sử dụng Class để định dạng CSS, không nên dùng Id
Chúng ta đã biết #id trong CSS là để chỉ đích danh một element, nó giống như số chứng minh thư của bạn, mỗi người dùng một cái, không có hai người nào có chung số CMT. Còn .class thì khác, nó để nhóm những elements có đặc điểm chung để xử lý luôn một thể.

VD:
```html
<img src="url" class="image" id="poster">

#poster {
    width: 600px
}

.image {
    width: 200px;
}
```
Bạn mong chờ kết quả hiện ra, và rồi những hình ảnh bình thường đều chỉ có width là 200px, riêng cái ảnh poster vẫn lừng lững to đùng với width 600px. Tại sao?!
Vì #id có quyền ưu tiên hơn .class.
Một số thứ tự ưu tiên cơ bản, viết theo thứ tự giảm dần, từ ưu tiên cao tới ưu tiên thấp
* ID > class > thẻ html
* inline css viết trong file html > css viết trong thẻ style trong file html > css viết trong file css
* đích danh > kế thừa
* viết sau > viết trước

### Trình duyệt đọc CSS selector từ phải sang trái
Nếu có một selector là footer > a, bạn nghĩ trình duyệt sẽ đi tìm footer trước, rồi trong footer nó sẽ lùng sục a đúng không? Sự thật thì ngược lại. Nó đi tìm tất cả các a trong cả cái trang web trước, rồi nó tìm xem cái a nào có bố là footer.

Vậy nên nếu bạn chọn footer>div (chọn div con của footer) thì trình duyệt sẽ phải tìm tất cả các div trong trang. Hoặc tệ hơn là footer>* (chọn tất cả những gì bên trong footer, * nghĩa là tất cả) trình duyệt sẽ tìm tất cả mọi element trong trang. Thật kinh khủng.

Vậy nên hãy tránh dùng những đứa con là element quả phổ biến như div, a, p, img... mà thay vào đó hãy dùng class.

### Không nên dùng CSS để xóa Style
Giả sử bạn có một đoạn văn in đậm, bạn muốn nó nổi bật. Sẵn cái class ban nãy red-bold-uppercase-text, bạn nhanh trí thêm class này vào đoạn văn đó.

Nhưng mà bạn chỉ cần đỏ và đậm thôi, không cần viết hoa. Như một lẽ đương nhiên bạn sẽ xóa sổ kiểu viết hoa
```css
.red-bold-uppercase-text {
    ...
    font-weight: normal;
 }
 ```
Nó có tác dụng và tương đối dễ làm ở ví dụ nhỏ này. Nhưng nếu bạn dùng thêm vài lần như thế, và cần nhiều dòng css chứ không đơn giản một dòng, khi đó code vừa dài vừa khó bảo trì chỉnh sửa sau này.

Giải pháp ở đây là tách css trong class ra thành nhiều class để sử dụng cho linh hoạt. Một class chỉ để tô đỏ và đậm:
```css
.red-text {
    color:red;
}

.bold-text {
    font-weight:bold;
}
```
và một class chỉ để viết hoa:
```css
.uppercase-text {
    text-transform: uppercase;
{
```
Như vậy thay vì dùng css để xóa style, bạn chỉ dùng css để thêm style

### Nguy hiểm khi chọn element bằng CSS child/descendant combinator
Child combinator là sử dụng dấu > để lựa chọn con của một element, ví dụ sau đây là lựa chọn các link nằm ngay bên trong footer
```css
footer > a{
    color: red
}
```
Descendant combinator là sử dụng dấu cách để lựa chọn con cháu chắt... của một element, ví dụ sau đây lựa chọn các link nằm trong chân trang, dù link này thực ra nằm bên trong một đoạn văn rồi đoạn văn này nằm bên trong chân trang thì cũng ok.
```css
footer a {
    color: red
}
```

Tại sao nó lại nguy hiểm?

Vì khi thay đổi vị trí các element trong html là định dạng css của các element này hỏng hết

Bạn bỏ cái link ra khỏi footer vì bạn không thích nó nằm ở đó nữa, vô tình cái link không còn là child của footer, và mọi css đã viết cho nó sẽ không còn nhận ra nó là ai. Nếu file html bị xáo trộn nhiều, thì việc đổi tên cha mẹ cho hàng chục hàng trăm element children không hề đơn giản. Giải pháp là đặt tên class cho element ngay từ đầu và dùng class để định dạng css
```css
.redlink{
    color: red;
}
```
Như vậy thì dù là child của elements nào thì vẫn sẽ màu đỏ thôi

ref:
* [kipablog](https://kipalog.com/posts/Nguy-hiem-cuc-co-ban-nhung-it-de-phong-khi-lua-chon-element-de-dinh-dang-CSS)
* [https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)

----
