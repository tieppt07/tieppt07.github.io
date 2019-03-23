---
layout: post
title: Laravel collections - một số methods thông dụng
---

Collections là một tập hợp nhiều kết quả bởi Eloquent, mỗi collection đều là một instance từ `Illuminate\Database\Eloquent\Collection`. Eloquent collection được kế thừa từ Laravel collection nên chúng có thể xử lý được lớp dưới của Eloquent model. Các collections cho phép bạn thực hiện lắp như với một mảng , nhưng collections mạnh hơn array nhiều, chúng được cung cấp các hàm xử lý như map/reduce/chunk/where...

Collections cũng có thể đơn giản được tạo thành từ array với cú pháp như sau:
```
$collection = collect([1, 2, 3]);
```

Collection có những hàm rất hay giúp bạn dễ dàng xử lý collections và giảm bớt thời gian.

### isEmpty()/isNotEmpty()
Ngoài cách kiểm tra 1 collections có bản ghi nào không bằng `count()` thì bạn có thể sử dụng `isEmpty()/isNotEmpty()`
```php
collect([])->isEmpty();
// true

collect([])->isNotEmpty();
// false
```

### max()/min()
`max()/min()` gíup bạn lấy ra field có giá trị lớn/nhỏ nhất trong một tập hợp collections
```php
$max = collect([['foo' => 10], ['foo' => 20]])->max('foo');
// 20

$max = collect([1, 2, 3, 4, 5])->max();
// 5

$min = collect([['foo' => 10], ['foo' => 20]])->min('foo');
// 10

$min = collect([1, 2, 3, 4, 5])->min();
// 1
```

### chunk()/collapse()
Chia nhỏ/gộp các collections
```php
$collection = collect([1, 2, 3, 4, 5, 6, 7]);
$chunks = $collection->chunk(4);
$chunks->toArray();
// [[1, 2, 3, 4], [5, 6, 7]]

$collection = collect([[1, 2, 3], [4, 5, 6], [7, 8, 9]]);
$collapsed = $collection->collapse();
$collapsed->all();
// [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

Sau khi `chunk()` chúng ta có thể foreach bình thường:
```php
@foreach ($products->chunk(3) as $chunk)
    <div class="row">
        @foreach ($chunk as $product)
            <div class="col-xs-4">{{ $product->name }}</div>
        @endforeach
    </div>
@endforeach
```

### toArray()/toJson()
Chuyển từ dạng Object sang dạng mảng hoặc kiểu dữ liệu Json.
```php
$collection = collect(['name' => 'Desk', 'price' => 200]);
$collection->toArray();
/*
    [
        ['name' => 'Desk', 'price' => 200],
    ]
*/

$collection = collect(['name' => 'Desk', 'price' => 200]);
$collection->toJson();
// '{"name":"Desk", "price":200}'
```

### sortBy()/sortByDesc()
Sắp xếp collections theo key
```php
$collection = collect([
    ['name' => 'Desk', 'price' => 200],
    ['name' => 'Chair', 'price' => 100],
    ['name' => 'Bookcase', 'price' => 150],
]);

$sorted = $collection->sortBy('price');
$sorted->values()->all();
/*
    [
        ['name' => 'Chair', 'price' => 100],
        ['name' => 'Bookcase', 'price' => 150],
        ['name' => 'Desk', 'price' => 200],
    ]
*/

$sorted = $collection->sortByDesc('price');
$sorted->values()->all();
/*
    [
        ['name' => 'Desk', 'price' => 200],
        ['name' => 'Bookcase', 'price' => 150],
        ['name' => 'Chair', 'price' => 100],
    ]
*/
```

### where()/whereIn()/whereNotIn()
Lọc collections theo key
```php
$collection = collect([
    ['product' => 'Desk', 'price' => 200],
    ['product' => 'Chair', 'price' => 100],
    ['product' => 'Bookcase', 'price' => 150],
    ['product' => 'Door', 'price' => 100],
]);
$filtered = $collection->where('price', 100);
$filtered->all();
/*
    [
        ['product' => 'Chair', 'price' => 100],
        ['product' => 'Door', 'price' => 100],
    ]
*/
```

### random()
Trả về 1 kết quả bất kì trong collections
```php
$collection = collect([1, 2, 3, 4, 5]);
$collection->random();
// 4
```

### map()
Tạo ra 1 collection mới dựa trên 1 collection cũ với 1 số thay đổi
```php
$collection = collect([1, 2, 3, 4, 5]);
$multiplied = $collection->map(function ($item, $key) {
    return $item * 2;
});
$multiplied->all();
// [2, 4, 6, 8, 10]
```

### groupBy()
Nhóm collections theo key
```php
$collection = collect([
    ['account_id' => 'account-x10', 'product' => 'Chair'],
    ['account_id' => 'account-x10', 'product' => 'Bookcase'],
    ['account_id' => 'account-x11', 'product' => 'Desk'],
]);
$grouped = $collection->groupBy('account_id');
$grouped->toArray();
/*
    [
        'account-x10' => [
            ['account_id' => 'account-x10', 'product' => 'Chair'],
            ['account_id' => 'account-x10', 'product' => 'Bookcase'],
        ],
        'account-x11' => [
            ['account_id' => 'account-x11', 'product' => 'Desk'],
        ],
    ]
*/
```

Trên đây là 1 số các methods hay được sử dụng nhiều. Ngoài ra có rất nhiều các methods thông dụng khác giúp xử lý collections. Bạn có thể tham khảo thêm tại [đây](https://laravel.com/docs/5.5/collections)

----
