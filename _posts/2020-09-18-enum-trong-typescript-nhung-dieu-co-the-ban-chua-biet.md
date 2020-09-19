---
layout: post
title: Enum trong TypeScript, những điều có thể bạn chưa biết
---

Cùng tìm hiểu về TypeScript Enum một cách toàn diện nhất có thể và tiếp tục cảm nhận sứ mệnh scaling mà TypeScript mang lại.

### Ôn lại khái niệm Enum
Nếu các bạn từng tiếp xúc với một ngôn ngữ strict type như C# hay Java, chắc các bạn chẳng lạ gì khái niệm Enum. Mình tuy không sử dụng C# hay Java trong công việc, tuy nhiên khái niệm về Enum mình vẫn còn nhớ rõ từ các môn học liên quan đến Java hồi là sinh viên IT (dù sao nó cũng chẳng phức tạp đến độ dễ quên).

Enum là từ viết tắt của Enumeration (Sự liệt kê). Enum dùng để định nghĩa kiểu dự liệu với số lượng giá trị hữu hạn.

Không giống như những ngôn ngữ strict type khác, JavaScript chỉ có duy nhất một kiểu dữ liệu hữu hạn số lượng giá trị, đó là boolean. Vậy việc định nghĩa kiểu dữ liệu hữu hạn số lượng giá trị sẽ giúp ích vào việc gì?

### Các tính chất của Enum trong TypeScript
Muốn vận dụng tốt Enum vào thực tế, trước tiên bạn cần hiểu rõ về Enum.

### Khởi tạo enum
Khởi tạo enum giống như khởi tạo một object bằng cú pháp object literal, các phần tử được ngăn cách bới dấu phẩy.

```js
enum Answer {
    Yes,
    No,
}
```

Mỗi phần tử của enum đều bao gồm 2 thành phần: `name` và `value`.

### Tên của phần tử
Tên của phần tử tương tự như các đặt tên object, vì thế chúng ta có thể dùng các các đặt tên phổ biến như:

**camelCase**

```js
enum Status {
    forceChangePassword,
    emailConfirmed,
}
```

CamelCase với chữ cái đầu viết hoa. Đây cũng là convention tiêu chuẩn của TypeScript, các bạn nên sử dụng cách này.

```js
enum Place {
    HaNoi,
    SaiGon,
}
```

**snake_case**

```js
enum Song {
    falling_into_you,
    nada_sousou,
}
```

**kebab-case**. Với kebab-case, giống như cách đặt tên property cho object, các bạn cũng có thể đóng nháy đơn cho tên phần tử enum:

```js
enum Header {
    'Cache-Control',
    'Content-Encoding',
}
```
Điểm khác biệt trong việc khởi tạo tên phần tử của enum so với object literal, đó là enum không cho phép sử dụng các phép logic để khởi tạo tên phần tử.

```js
let postFix = 'uary';
enum Month {
    'Jan' + postFix, // không hợp lệ
    'Febr' + postFix, // không hợp lệ
}
```

Điều này cũng dễ hiểu thôi, việc đặt tên bằng các phép logic sẽ làm hỏng đi tính chặt chẽ trong TypeScript.

### Giá trị của phần tử
Không giống như tên phần tử, giá trị của phần tử có thể là giá trị tĩnh hoặc giá trị được tạo ra tại runtime.

```js
let postFix = 'uary';
enum Month {
    Jan = 'Jan' + postFix,
    Feb = 'Febr' + postFix,
}
```

Giá trị mặc định của các phần tử là giá trị số, bắt đầu từ 0. Ở ví dụ trên, giá trị của `Yes` sẽ là 0, và `No` sẽ là 1.

```js
enum Answer {
    Yes,
    No,
}

console.log(Answer.Yes); // 0
console.log(Answer.No); // 1
```

Thay vì để cho TypeScript tự khởi tạo giá trị, chúng ta cũng có thể chủ động khởi tạo giá trị.

```js
enum Answer {
    Yes = 1,
    No = 2,
}
```

Chúng ta cũng có thể không cần khởi tạo giá trị cho tất cả các phần tử.

```js
enum Answer {
    Yes = 1,
    No,
}
console.log(Answer.Yes); // 1
console.log(Answer.No); // 2
```

Như ví dụ trên, giá trị của phần tử No sẽ được tự động khởi tạo tăng thêm 1 đơn vị so với phần tử trước nó (là phần tử Yes), nhấn mạnh là tăng 1 đơn vị theo phần tử trước đó.

```js
enum Month {
    Jan,
    Feb = 3,
    Mar,
    Apr = 6,
    May,
    Jun,
}
console.log(Month.Jan) // 0
console.log(Month.Feb) // 3
console.log(Month.Mar) // 4
console.log(Month.Apr) // 6
console.log(Month.May) // 7
console.log(Month.Jun) // 8
```

Tuy nhiên cần chú ý, việc bỏ qua khởi tạo chỉ hợp lệ khi phần tử trước nó là dạng số.

```js
enum Month {
    Jan,
    Feb = 3,
    Mar,
    Apr = 6,
    May = 'May',
    Jun, // compiler sẽ báo lỗi `Enum member must have initializer`
}
```

Nếu phần tử trước đó không phải dạng số, compiler sẽ báo lỗi Enum member must have initializer.

### Tính ứng dụng và lợi ích
#### Dùng Enum như một bản mô tả cho giá trị
Trong thực tế, chúng ta sẽ gặp rất nhiều trường hợp cần so sánh biến với một vài string nhất định, khi đó chúng ta có thể sử dụng Enum như một biện pháp ràng buộc.

Ví dụ một đối tượng học sinh có các cấp độ học lực:

```js
interface Student {
    level: number;
}
```

Giả sử các dev quy ước với nhau, học sinh này yếu nếu giá trị là 1, trung bình nếu giá trị là 2, và tốt nếu giá trị là 3

Mỗi lần cần một hành động gì đó liên quan đến học lực của học sinh, chúng ta sẽ so sánh trực tiếp như sau:

```js
switch(student.level) {
    case 1:
        // do something
        break;
    case 2:
        // do something
        break;
    case 3:
        // do something
        break;
}
```
Chúng ta có thể làm tốt hơn bằng cách sử dụng enum:

```js
enum StudentLevel {
    Bad = 1,
    Average = 2,
    Good = 3
}
```

Lúc này chúng ta có thể enforce kiểu cho thuộc tính level bằng `enum StudentLevel`.

```js
interface Student {
    level: StudentLevel;
}
```

Và so sánh cũng bằng Enum:

```js
switch(student.level) {
    case StudentLevel.Bad:
        // do something
        break;
    case StudentLevel.Average:
        // do something
        break;
    case StudentLevel.Good:
        // do something
        break;
}
```

Một bài toán thực tế khác về việc sử dụng Enum như một bản mô tả giá trị, đó là sử dụng Enum để mô tả quyền (permission) trong HĐH Unix base.

Trước tiên chúng ta cùng ôn lại bài toán hồi học ở trường này (hình như mình được học từ môn tên là Principle of Operating System :D).

Chúng ta quy ước:

nếu user có quyền đọc, ta cho giá trị 1
nếu user có quyền ghi, ta cho giá trị 2
nếu user có quyền xoá, ta cho giá trị 4
Tại sao lại chọn các giá trị là mũ của 2 này. Cùng nhìn vào giá trị cơ số 2 của từng giá trị trên nhé:

```
1 == 00000000000000000000000000000001
2 == 00000000000000000000000000000010
4 == 00000000000000000000000000000100
```

Các giá trị của mũ 2 (1, 2, 4, 8, ...) có một đặc điểm là chỉ có một bit 1, còn lại là các bit 0 ở bên phải, số lượng bit 0 tương ứng với số mũ.

Do đó, chúng ta có thể sử dụng toán tử OR của so sánh bit để tổng hợp giá trị.

Giả sử user được cấp quyền đọc và ghi, tương ứng 1 hoặc 2, chúng ta có thể sử dụng toán tử OR:

```js
const permission = 1 | 2; // 3 == 00000000000000000000000000000011
```

Như vậy, nếu user permission có giá trị 3, chúng ta có thể hiểu được user được cấp quyền đọc và ghi.

Tương tự cách kết hợp như vậy, chúng ta sẽ có tổng cộng 8 loại quyền (tính cả 3 quyền đọc, ghi, xoá cơ bản):

```
0, // None
1, // Read
2, // Write
3, // Read + Write
4, // Delete
5, // Read + Delete
6, // Write + Delete
7, // Read + Write + Delete
```

Thay vì phải đau đầu nhớ từng loại quyền này, chúng ta có thể dùng Enum để mô tả quyền:

Chúng ta có thể mô tả quyền cơ bản:

```js
enum Permission {
   Read = 1,
   Write = 2,
   Delete = 4,
}
```

Và mô tả các quyền kết hợp:

```js
enum Permissions {
    ReadYesWriteNoDeleteNo = Permission.Read, // == 1 ~ Read
    ReadNoWriteYesDeleteNo = Permission.Write, // == 2 ~ Write
    ReadYesWriteYesDeleteNo = Permission.Read | Permission.Write, // == 3 ~ Read + Write
    ReadNoWriteNoDeleteYes = Permission.Delete, // == 4 ~ Delete
    ReadYesWriteNoDeleteYes = Permission.Read | Permission.Delete, // == 5 ~ Read + Delete
    ReadNoWriteYesDeleteYes = Permission.Write | Permission.Delete, // == 6 ~ Write + Delete
    ReadYesWriteYesDeleteYes = Permission.Read | Permission.Write | Permission.Delete, // == 7 ~ Read + Write + Delete
}
```

Rất rõ ràng phải ko?

#### Dùng Enum để gom các constant vào một nhóm
Một ứng dụng khá gần gũi với các frontend dev, đó là các trạng thái màu sắc của Bootstrap. Chúng ta có thể gom các trạng thái này thành một Enum:

```js
enum BootstrapStatus {
  success = 'success',
  info = 'info',
  warning = 'warning',
  danger = 'danger',
}
```

Trong quá trình sử dụng, Typescript sẽ đảm bảo các dev ko thể sử dụng một status nào khác.

#### Dùng Enum thay cho boolean (trong một số trường hợp nhất định thôi nhé)
Ví dụ:

```js
let result: boolean;
```

Có thể làm tốt hơn bằng cách

```js
enum Result {
    failure,
    success
}

let result: Result;
```

#### Túm lại các lợi ích
- Enum có thể đóng vai trò như một giao diện tiếp cận với dữ liệu thực, giúp mô tả trạng thái dữ liệu rõ ràng hơn, rất có lợi cho việc làm tường minh code
- Vẫn với vai trò là một giao diện đứng trước dữ liệu thực, cho dù sau này khi giá trị thực tương ứng (ví dụ giá trị cho từng StudentLevel cần thay đổi, đổi sang dạng string chẳng hạn, ) bạn cũng sẽ ko cần tốn nhiều công sức đi sửa từng vị trí switch - case, hay if - else, bạn chỉ cần sửa lại giá trị cho từng phần tử Enum.
- Enum sẽ giúp thu gọn / cố định khoảng giá trị, giúp cho các thành viên trong team dev ko thể sử dụng sai giá trị được (compiler sẽ enforce việc này)
- Nếu các bạn sử dụng IDE hoặc một Editor tốt như Visual Studio Code, bạn sẽ có lợi thế khi được suggestion đến tận răng nếu dùng Enum.

#### Chú ý trong việc sử dụng Enum để tránh lọt type checking
Có một chú ý quan trọng khi sử dụng Enum trong TypeScript, đó là các bạn nên sử dụng giá trị chuỗi, thay vị giá trị số.

```js
enum Result {
    Success,
    Failure,
}

function showResult(result: Result) {
    // 
}

showResult(2); // compiler sẽ không thông báo lỗi
```

Cách giải quyết đó là các bạn nên dùng giá trị chuỗi:

```js
enum Result {
    Success = 'success',
    Failure = 'failure',
}

function showResult(result: Result) {
    console.log(result)
}

showResult('another'); // compiler sẽ báo lỗi ở đây
```

Lúc này compiler sẽ báo lỗi, dù chúng ta vẫn truyền chuỗi, nhưng giá trị không nằm trong tập hợp giá trị của Result.

### Tạm kết
Nếu các bạn muốn biết thêm thực sự Enum được biến đổi thành dạng gì trong Javascript, các bạn có thể dùng [TypeScript Playground](https://www.typescriptlang.org/play). Tiện thể test luôn mấy ví dụ bên trên.

Một lần nữa, qua các ví dụ ở trên, các bạn có thể thấy, nếu không có Enum nói riêng và TypeScript nói chung (so với JavaScript), mọi thứ sẽ vẫn chạy. Tuy nhiên nếu có TypeScript, mọi thứ chắc chắn sẽ chạy tốt hơn, scale tốt hơn do sự tường minh mà TypeScript mang lại.

Hi vọng bài viết sẽ giúp cho những ai mới tiếp cận với ngôn ngữ strict type như TypeScript biết cách vận dùng Enum vào thực tế, cũng như giúp những ai đang sử dụng TypeScript rồi có thể dùng Enum tốt hơn


---
