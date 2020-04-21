---
layout: post
title: null và undefined trong Javascript
---

Khi làm quen với Javascript, mình đã tự hỏi tại sao lại có 2 giá trị đều mang nghĩa là "không có gì cả", đó là null và undefined. Đây là một trong những điểm dễ gây nhầm lẫn, null và undefined, hai khái niệm này không thể đồng nhất làm một dù cho ý nghĩa thực tế của chúng lại tương đối giống nhau. Vậy sự khác biệt giữa null và undefined là gì?

### Null?
- null đại diện cho một giá trị không tồn tại
- null không mặc định có mà phải được gán một cách chủ đích

```js
let a = null;
console.log(a);
// null
```

### Undefined?
Các cách tạo ra undefined value

#### 1. Không define (assign, gán) giá trị
```js
let a = 2018;
```
Trong đoạn code trên, biến a trải qua 2 giai đoạn:

- giai đoạn 1 declare: let a
- giai đoạn 2 define: = 2018 Nếu chúng ta bỏ qua giai đoạn 2, a nhận giá trị undefined:

```js
let a;
console.log(a);
// undefined
```

#### 2. Chủ động gán giống null
Và vì undefined cũng là 1 kiểu dữ liệu, chúng ta vẫn có thể gán undefined cho 1 biến như bình thường:
```js
let a = undefined;
console.log(a);
// undefined
```

#### 3. Truy cập tới 1 thuộc tính không tồn tại của 1 object
Và khi truy vấn đến 1 thuộc tính không tồn tại trong 1 object
```js
var a = {};
console.log(a.nonExistence);
// undefined
```

### Điểm chung giữa null và undefined
#### 1. Đều là falsy value
Cùng với 4 thằng `false` `0` `''(empty string)` `NaN`, `null` và `undefined` cũng là 2 falsy value

```js
console.log(!!null);
// false
console.log(!!undefined);
// false
```
hay
```js
null !== undefined
```
và
```js
null == undefined
```

#### 2. Đều là giá trị nguyên thủy (primitive value)
Mặc dù nếu các bạn kiểm tra typeof null sẽ nhận được kết quả `object`, tuy nhiên cùng với `Boolean`, `Number`, `String`, `Symbol (ES6)`, `null`, `undefined` vẫn được tính là giá trị nguyên thủy vì chúng ko có method.
(tham khảo tại https://developer.mozilla.org/en-US/docs/Glossary/Primitive)

### Sự khác biệt giữa null và undefined trong thực tế
Ví dụ khi chúng ta dùng giá trị mặc định cho param:
```js
let greet = (str = 'konichiwa') => {
  console.log(str);
}
```
và không truyền param, chúng ta sẽ nhận được giá trị mặc định chúng ta đã đặt.
```js
greet();
// konichiwa
```
và nếu chúng ta truyền string 'good afternoon':
```js
greet('good afternoon');
// good afternoon
```
Nhưng nếu chúng ta truyền null hoặc undefined, sẽ có sự khác biệt:
```js
greet(undefined);
// konichiwa
greet(null);
// null
```

Quay trở lại với đoạn định nghĩa function `greet`, cụ thể đoạn `(str = 'konichiwa')`, chúng ta có thể đọc đoạn code này bằng lời "nếu giá trị str không được định nghĩa, gán giá trị mặc định là `konichiwa`. Đó là lý do khi bạn truyền `undefined`, greet sẽ hiểu biến str không được định nghĩa, và dùng giá trị mặc định.

---
