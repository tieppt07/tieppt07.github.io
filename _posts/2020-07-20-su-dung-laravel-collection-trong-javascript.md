---
layout: post
title: Sử dụng Laravel Collection trong Javascript
---

Trong quá trình phát triển các ứng dụng, chắc hẳn bạn đã từng phải xử lý các thao tác tính toán, tìm kiếm, sắp xếp, ... phức tạp trên một tập dữ liệu. Việc này có lẽ đã khiến cho bạn tốn kha khá thời gian. Chính vì điều này, Laravel Collections đã ra đời.

![collectjs](/images/posts/collectjs-dependency-free-wrapper-for-working-with-arrays-objects.png)

Nếu bạn đã từng làm việc với Laravel, chắn chắn bạn đã từng sử dụng qua Laravel Collections. Đây là một lớp hỗ trợ cho bạn xử lý các thao tác trên một tập dữ liệu vô cùng đơn giản, hiệu quả, nhanh chóng. Nay Laravel Collections còn có thể được sử dụng trong JavaScript thông qua thư viện Collect.js.

### 1. Cài đặt

```sh
npm install collect.js --save
```

### 2. Sử dụng
Việc sử dụng khá đơn giản. để sử dụng chúng ta sẽ gọi collect.js từ thư viện ra như sau:

```js
import collect from "collect.js";
```

Trả về mảng tất cả các phần tử trong collection.

```js
collect([1, 2, 3]).all();

// [1, 2, 3]
```

Tính trung bình các phần tử trong là số trong collection.

```js
collect([1, 3, 3, 7]).avg();

// 3.5
```

Phương thức `chunk()` giúp chúng tách ra thành từ phần riêng biệt với kích thước nhất định.

```js
const collection = collect([1, 2, 3, 4, 5, 6, 7]);
const chunks = collection.chunk(4);
chunks.all();

// [[1, 2, 3, 4], [5, 6, 7]]
```

Phương thức `collapse()` gộp một tập hợp nhiều mảng trong một collection thành một.

```js
const collection = collect([[1], [{}, 5, {}], ['xoxo']]);
const collapsed = collection.collapse();
collapsed.all();

// [1, {}, 5, {}, 'xoxo']
```

Phương thức `combine()` kết hợp key của một collection với value của một mảng (array) hoặc một collection khác và trả về một đối tượng (object)

```js
const collection = collect(['name', 'number']);
const combine = collection.combine(['Mohamed Salah', 11]);
combine.all();

// {
//   name: 'Mohamed Salah',
//   number: 11
// }
```

Phương thức `concat()` cho phép ta hợp nhất 2 hoặc nhiều collection, array, object:

```js
const collection = collect([1, 2, 3]);
let concatenated = collection.concat(['a', 'b', 'c']);
concatenated = concatenated.concat({
  name: 'Mohamed Salah',
  number: 11,
});
concatenated.all();

// [1, 2, 3, 'a', 'b', 'c', 'Mohamed Salah', 11]
```

Phương thức `contains()` xác định xem collection có chứa item hay không:

```js
const collection = collect({
  name: 'Mohamed Salah',
  number: 11,
});

collection.contains('name');
// true

collection.contains('age');
// false

collection.contains('Mohamed Salah');
// true
```

Phương thức `count()` đếm số phần tử trong collection:

```js
const collection = collect([1, 2, 3, 4]);
collection.count();

// 4
```

Ngoài ra còn rất nhiều các `methods` thông dụng khác. Bạn có thể xem thêm [tại đây](https://github.com/ecrmnn/collect.js).


---
