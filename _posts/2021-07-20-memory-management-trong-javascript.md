---
layout: post
title: "Memory management trong Javascript"
published: false
---

Không giống như các ngôn ngữ bậc thấp, lập trình viên phải chủ động cấp phát, giải phóng bộ nhớ, Javascript sẽ tự tính toán bộ nhớ cần thiết và tự thu hồi bộ nhớ khi biến đó không được sử dụng nữa.

Không giống như các ngôn ngữ bậc thấp, lập trình viên phải chủ động cấp phát, giải phóng bộ nhớ, Javascript sẽ tự tính toán bộ nhớ cần thiết và tự thu hồi bộ nhớ khi biến đó không được sử dụng nữa. Phương pháp tự thu hồi bộ nhớ trong javascript được gọi là `garbage collection`. Tuy nhiên, việc "tự thu hồi bộ nhớ" không hẳn lúc nào cũng tự động một cách triệt để, và sẽ có một số trường hợp nhất định khiến bộ nhớ không được giải phóng.

Trong phần 1, chúng ta sẽ tìm hiểu chủ yếu về cơ chế hoạt động của `memory management` trong javascript.

### Vòng đời bộ nhớ

Vòng đời của bộ nhớ luôn tuân theo thứ tự: Cấp phát > Sử dụng (read, write) > Giải phóng. Sự khác biệt rõ ràng nhất giữa ngôn ngữ bậc thấp như C so với ngôn ngữ bậc cao hơn nằm ở giai đoạn cấp phát và giải phóng. Chúng ta thử lướt qua vòng đời bộ nhớ khi JS chạy sẽ trông như thế nào.

#### Cấp phát

Nhằm giảm thiểu công sức cho lập trình viên, JS cấp phát ngay trong lúc khởi tạo. Sau đây là 1 số ví dụ:

```js
var n = 123; // cấp phát bộ nhớ cho số 123
var s = 'azerty'; // cấp phát bộ nhớ cho chuỗi 'azerty'

// cấp phát bộ nhớ cho object
var o = {
  a: 1,
  b: null
};

// cấp phát bộ nhớ cho mảng
var a = [1, null, 'abra'];

// cấp phát bộ nhớ cho 1 hàm (cũng là 1 object, chính xác là callable object)
function f(a) {
  return a + 2;
}

// hàm callback cũng đc cấp phát bộ nhớ
someElement.addEventListener('click', function() {
  someElement.style.backgroundColor = 'blue';
}, false);

// cấp phát bộ nhớ cho 1 Date object
var d = new Date();
// cấp phát bộ nhớ cho 1 DOM element
var e = document.createElement('div');
```

#### Sử dụng

Sử dụng không có gì phức tạp, ví dụ:

```js
var topic = 'memory management';
console.log(topic); // Đọc
topic = 'memory'; // Ghi
```

#### Giải phóng

Giai đoạn này mới là mấu chốt của vấn đề chúng ta đang nói tới. Chúng ta thử suy nghĩ một cách tự nhiên xem khi nào bộ nhớ cần thu hồi? Tất nhiên sẽ là khi bộ nhớ đó không cần dùng nữa, ví dụ cụ thể hơn là khi một biến không còn "giá trị lợi dụng" nữa, nó cần được dọn ra khỏi bộ nhớ.

Ở ngôn ngữ bậc thấp hơn JS, lập trình viên sẽ là nhân tố đưa ra quyết định khi bộ nhớ đó không cần dùng nữa. Sau đây là 1 ví dụ đơn giản trong C,

```c++
#include <stdio.h>
#include <stdlib.h>

int main () {
   char *str;

   /* khởi tạo biến & cấp phát bộ nhớ */
   str = (char *) malloc(15);
   strcpy(str, "tutorialspoint");
   printf("String = %s,  Address = %u\n", str, str);

   /* cấp phát lại bộ nhớ khi nối thêm chuỗi */
   str = (char *) realloc(str, 25);
   strcat(str, ".com");
   printf("String = %s,  Address = %u\n", str, str);

    /* thu hồi bộ nhớ đã cấp phát cho str sau khi đã in lên màn hình (không còn dùng biến str nữa) */
   free(str);

   return(0);
}
```

Trong JS, hầu hết các trường hợp chúng ta ko cần thu hồi bộ nhớ của một biến khi ko sử dụng nữa, "garbage collection" sẽ lo vụ này. Tuy nhiên vẫn sẽ có những trường hợp garbage collection không thể quyết định được.

### Garbage collection

Để biết được điểm hạn chế của Garbage collection, chúng ta cần tìm hiểu cách Garbage collection đưa ra quyết định.

#### Nhắc lại về sự tham chiếu (references)

Trong JS, một biến được gán cho kiểu dữ liệu không nguyên thủy như object và array không có được trực tiếp giá trị mà chỉ tham chiếu đến giá trị đó trong bộ nhớ. Biến đó không thực sự chứa giá trị. Một trường hợp khác đó là object tham chiếu đến một object khác thuộc về 1 thuộc tính của chính nó. Ví dụ:

```json
{
  a: {
    b: 2
  }
};
```

2 trường hợp trên gọi là tham chiếu rõ ràng (explicitly). Chúng ta sẽ đi sâu hơn vào ví dụ này ở phía dưới. Ngoài ra bản thân object hay array đó cũng mặc định tham chiếu đến prototype của nó, trường hợp này gọi là tham chiếu ngầm (implicitly). Sự tham chiếu cũng là khái niệm chính mà Garbage collection sử dụng để đưa ra quyết định

#### Quyết định dựa vào số lượng tham chiếu (thuật toán reference-counting)

Thuật toán đầu tiên của garbage collection là đếm số lượng tham chiếu đến object. Một object được xem như "hết giá trị lợi dụng" khi ko còn thằng nào tham chiếu đến nó nữa.

Ví dụ về quá trình quyết định giải phóng bộ nhớ:

```js
// Đầu tiên chúng ta có 1 object gồm 1 thuộc tính `'a'` có giá trị là 1 object khác. Vậy là hiện tại chúng ta có 2 object.
// Chúng ta gán object này vào biến `o`.
// Lúc này 2 object của chúng ta, một object được tham chiếu bởi object cha (mình sẽ gọi là object nhỏ), một object được tham chiếu bởi biến `o` (mình sẽ gọi là object lớn)
// Và - tất nhiên - 2 thằng đang đều "còn giá trị lợi dụng" :D
var o = {
  a: {
    b: 2
  }
};

// Khởi tạo biến o2, gán cho nó biến o. Lúc này:
// - object lớn đang được tham chiếu bởi `o` và `o2`
// - object nhỏ đang được tham chiếu bởi thuộc tính "a" object lớn
var o2 = o;

// Gán o cho giá trị number 1. Lúc này:
// - object lớn của chúng ta chỉ còn được tham chiếu bởi `o2`
// - object nhỏ đang được tham chiếu bởi thuộc tính "a" object lớn
o = 1;

// Tiếp tục khởi tạo một biến `oa`, gán nó tới object nhỏ. Lúc này:
// - object lớn đang được tham chiếu bởi `o2`
// - object nhỏ đang được tham chiếu bởi `oa` và object lớn
var oa = o2.a;

// Gán o2 bằng một chuỗi. Lúc này
// - object lớn ko còn được tham chiếu bởi thằng nào nữa, tuy nhiên thuộc tính của nó vẫn được tham chiếu bởi `oa`, vì thế nó "vẫn còn giá trị lợi dụng"
// - object nhỏ chỉ còn được tham chiếu bởi `oa`
o2 = 'yo';

// Gán oa  = null, lúc này object lớn hoàn toàn không còn ai tham chiếu đến nữa, nó trở thành garbage collected
oa = null;
```

Vậy trường hợp nào có thể cản trở việc quyết định giải phóng bộ nhớ trong thuật toán đếm tham chiếu này?

#### Tham chiếu vòng tròn (circular reference)

Chúng ta cùng nhìn ví dụ sau:

```js
function f() {
  var o = {};
  var o2 = {};
  o.a = o2; // o references o2
  o2.a = o; // o2 references o

  return 'azerty';
}

f();
```

Ở ví dụ trên, khi hàm f được khởi chạy, 2 object được khởi tạo và tham chiếu chéo nhau thông qua thuộc tính của chúng và hàm f trả về 1 chuỗi chả liên quan gì tới 2 thằng kia. Xét về tình và lý, chúng ta thấy trường hợp này cần giải phóng bộ nhớ vì 2 object kia vô dụng, tuy nhiên nếu áp dụng "lý" của garbage collection, 2 thằng đều đang bị tham chiếu, vì thế, garbage collection sẽ không giải phóng chúng.

Ví dụ thực tế

```js
var div;
window.onload = function() {
  div = document.getElementById('myDivElement');
  div.circularReference = div;
  div.lotsOfData = new Array(10000).join('*');
};
```

Trong ví dụ trên, nếu chẳng may chúng ta bê nguyên 'myDivElement' DOM element này vào trong biến div (biến div cũng đang tham chiếu đến 'myDivElement' DOM element) thông qua một thuộc tính thì biến div sẽ không bao giờ được giải phóng.

#### Quyết định dựa vào việc có chạm tới object hay không (Mark-and-sweep algorithm)

Thuật toán này tạo ra 1 biến global gọi là "roots" bao trùm toàn bộ các object. Trên trình duyệt, window object có thể đóng vai trò là "roots". Garbage collector sẽ định kì tìm kiếm đệ quy các object được tham chiếu từ "roots", rồi đến các object được tham chiếu từ các object vừa tìm được, nói chung tìm ra những thằng nào có mối liên hệ với nó. Những thằng còn lại (ko liên quan) sẽ bị gom để giải phóng.

Từ thời điểm năm 2012, garbage collecition của tất cả các trình duyệt đã sử dụng thuật toán này thay cho thuật toán cũ kĩ `reference-counting`, và thuật toán mới vẫn được nâng cấp đều đặn.

Quay trở lại ví dụ này:

```js
function f() {
  var o = {};
  var o2 = {};
  o.a = o2; // o references o2
  o2.a = o; // o2 references o

  return 'azerty';
}

f();
```

Với thuật toán `mark-and-sweep`, 2 objects **o** và **o2** tham chiếu đến nhau nhưng ko có mối liên hệ nào với root object sẽ bị trừ khử.

### Kết

Tham khảo:

- [https://www.tutorialspoint.com/c_standard_library/c_function_malloc.htm](https://www.tutorialspoint.com/c_standard_library/c_function_malloc.htm)
- [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Memory_Management)

---
