---
layout: post
title: "Tối ưu browser rendering: Javascript"
---

60fps là mục tiêu cuối cùng của một web page "mượt"

### Nhìn lại rendering pipeline của trình duyệt.

![https://thinhdora.me/development/toi-uu-browser-rendering-javascript/rendering-pipeline.jpg](https://thinhdora.me/development/toi-uu-browser-rendering-javascript/rendering-pipeline.jpg)

Qua các phần trước của bài viết thì chúng ta đã tìm hiểu về: `Style calculations`, `Layout`, `Paint` và `Compositing`. Trong bài viết này, chúng ta sẽ tìm hiểu về yếu tố cuối cùng ảnh hưởng đến rendering performance, đó là việc sử dụng Javascript.

Mặc dù là yếu tố cuối cùng chúng ta nhắc đến, nhưng Javascript lại là yếu tố đầu tiên được khởi chạy ở trong rendering pipeline (hình trên). Javascript thường kích hoạt sự thay đổi về mặt giao diện, có thể là kích hoạt trực tiếp bằng cách thay đổi styling ví dụ chiều cao, chiều rộng, dẫn đến thay đổi layout, có thể là kích hoạt gián tiếp thông qua việc thêm, xoá, sort phần tử DOM. Việc tối ưu thời gian thực thi JS rất quan trọng vì nếu đoạn code của bạn thực thi trong khoảng thời gian không ko đủ nhanh, nếu nhẹ sẽ khiến FPS bị giảm, nặng hơn có thể gây treo giao diện người dùng.

Vậy cụ thể, ...

### Những yếu tố nào trong khi sử dụng JS có thể gây ra sự giảm hiệu năng?

Sử dụng `setInterval` hoặc `setTimeout` cho việc update thay đổi giao diện.

Có một bài toán rất phổ thông đối với web developer, đó là animation. Ví dụ cụ thể, chúng ta có 1 hình vuông trên màn hình, chúng ta cần làm hình vuông đó chạy sang phải, chưa cần biết điểm dừng.

Trường hợp thứ nhất, nếu chúng ta sử dụng `setInterval`, đoạn code sẽ trông như sau:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <style>
        #my-box {
            width: 15px;
            height: 15px;
            position: fixed;
            left: 15px;
        top: 15px;
            background: red;
        }
    </style>
</head>
<body>
    <div id="my-box"></div>

    <script>
        const myBox = document.getElementById('my-box');
        myBox.style.left = '0px';

        const moveBoxToRight1px = () => {
            const positionLeft = myBox.style.left;
            let oldLeft = parseInt(positionLeft.substring(0, positionLeft.length - 2));
            const newLeft = oldLeft + 1;
            myBox.style.left = newLeft + 'px';
        };
        setInterval(moveBoxToRight1px, 16);

    </script>
</body>
</html>
```

Với việc sử dụng `setInterval` như trên, chúng ta vẫn đạt được yêu cầu đề ra của bài toán. Tuy nhiên việc sử dụng `setInterval` này thường không được khuyến nghị, và được khuyến nghi thay thế bằng `requestAnimationFrame`. Đoạn code sẽ thay đổi một chút như sau:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <style>
        #my-box {
            width: 15px;
            height: 15px;
            position: fixed;
            left: 15px;
        top: 15px;
            background: red;
        }
    </style>
</head>
<body>
    <div id="my-box"></div>

    <script>
        const myBox = document.getElementById('my-box');
        myBox.style.left = '0px';

        const moveBoxToRight1px = () => {
            const positionLeft = myBox.style.left;
            let oldLeft = parseInt(positionLeft.substring(0, positionLeft.length - 2));
            const newLeft = oldLeft + 1;
            myBox.style.left = newLeft + 'px';
            requestAnimationFrame(moveBoxToRight1px);
        };
        requestAnimationFrame(moveBoxToRight1px);

    </script>
</body>
</html>
```

Về kết quả sau cùng, 2 cách cho ra kết quả tương đương. Tuy nhiên, vấn đề xảy ra ở đây là chúng ta sẽ khó có thể khớp thời điểm thực thi callback với thời điểm khung hình được render khi sử dụng `setInterval`. Tại sao thế? Vì param thứ 2 của `setInterval` chỉ nhận vào giá trị số nguyên từ 0 đến 2^31 - 1 (32-bit signed integer), trong khi để đạt được 60fps, mỗi khung hình sẽ có thời gian thực thi là 1000/60 bằng xấp xỉ 16.66666.....6666667, tức là chúng ta không thể sử dụng chính xác được thời gian lặp callback là 1000/60 cho `setInterval`. Điều này đồng nghĩa là sẽ có khả năng callback được thực thi tại một thời điểm nào đó không phải là thời điểm đầu tiên của mỗi khung hình.

Nếu các bạn đã từng thử tìm hiểu về web game, chắc ko lạ gì thằng `requestAnimationFrame` này.

Ở đây mình có kết hợp cả 2 cách làm trên một màn hình cho các bạn dễ so sánh:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    <style>
        #my-box-1,
        #my-box-2 {
            width: 15px;
            height: 15px;
            position: fixed;
            left: 15px;
        }
        #my-box-1 {
            top: 15px;
            background: red;
        }
        #my-box-2 {
            top: 35px;
            background: blue;
        }
    </style>
</head>
<body>
    <div id="my-box-1"></div>
    <div id="my-box-2"></div>

    <script>
        const myBox1 = document.getElementById('my-box-1');
        myBox1.style.left = '0px';

        const moveBox1ToRight1px = () => {
            const positionLeft = myBox1.style.left;
            let oldLeft = parseInt(positionLeft.substring(0, positionLeft.length - 2));
            const newLeft = oldLeft + 1;
            myBox1.style.left = newLeft + 'px';
            requestAnimationFrame(moveBox1ToRight1px);
        };
        requestAnimationFrame(moveBox1ToRight1px);

        const myBox2 = document.getElementById('my-box-2');
        myBox2.style.left = '0px';

        const moveBox2ToRight1px = () => {
            const positionLeft = myBox2.style.left;
            let oldLeft = parseInt(positionLeft.substring(0, positionLeft.length - 2));
            const newLeft = oldLeft + 1;
            myBox2.style.left = newLeft + 'px';
        };
        setInterval(moveBox2ToRight1px, 1000/60);

    </script>
</body>
</html>
```

Các bạn có thể nhìn hình minh hoạ dưới đây cho dễ hình dung (Hình minh hoạ lấy từ Google).

![https://thinhdora.me/development/toi-uu-browser-rendering-javascript/settimeout.jpg](https://thinhdora.me/development/toi-uu-browser-rendering-javascript/settimeout.jpg)

Việc sử dụng requestAnimationFrame sẽ giúp trình duyệt tự động match thời điểm thực thi callback với từng khung hình, đảm bảo sự mượt mà.

Bản thân thư viện JQuery, từ phiên bản 3 cũng đã chuyển sang dùng requestAnimationFrame cho animation. Đối với các phiên bản JQuery < 3, các bạn có thể sử dụng kèm snippet [https://github.com/gnarf/jquery-requestAnimationFrame](https://github.com/gnarf/jquery-requestAnimationFrame) để chuyển từ setInterval sang requestAnimationFrame.

### Tối ưu code để đáp ứng 60fps

Có thể bạn đã biết (hoặc chưa), javascript chỉ chạy trên một thread duy nhất (chỉ có một call stack và một memory heap), điều này đồng nghĩa với việc nếu bất cứ một task nào chạy quá lâu đều sẽ khiến những task sau phải chờ, gây nên tình trạng hụt khung hình (giật lag).

#### Sử dụng web worker

Để giảm tải cho thread duy nhất trên trình duyệt, bản thân trình duyệt cũng có một công cụ khá hữu ích và dễ dùng, đó là Web Worker. Web worker tương tự như một thread riêng biệt, và giao tiếp với thread chính thông qua Event API.

Giới hạn của worker thread là sẽ không thể sử dụng được:

- DOM API
- window object
- document object
  
Vì vậy, worker sẽ thích hợp với các tác vụ thuần tính toán, xử lý dữ liệu đủ lớn hoặc thuật toán phức tạp.

Các bạn có thể đọc bài viết trước đây của mình về Web Worker nếu muốn tìm hiểu rõ hơn.

#### Break nhỏ task vụ

Khi mà web worker không thể đáp ứng yêu cầu, và chúng ta buộc phải xử lý tác vụ trực tiếp trên main thread, chúng ta có thể sử dụng các chia nhỏ task, theo dõi xem các sub-tasks có thời gian thực thi đủ ngắn hay chưa, sau đó tiếp tục break cho đến khi các sub-tasks đáp ứng thời gian thực thi cho một khung hình.

```js
var taskList = breakBigTaskIntoMicroTasks(monsterTaskList);
requestAnimationFrame(processTaskList);

function processTaskList(taskStartTime) {
  var taskFinishTime;

  do {
    // Assume the next task is pushed onto a stack.
    var nextTask = taskList.pop();

    // Process nextTask.
    processTask(nextTask);

    // Go again if there’s enough time to do the next task.
    taskFinishTime = window.performance.now();
  } while (taskFinishTime - taskStartTime < 3);

  if (taskList.length > 0)
    requestAnimationFrame(processTaskList);

}
```

### Cân nhắc micro-optimizing (tối ưu nhỏ nhặt)

Không phải lúc nào micro-optimizing cũng tốt hoặc không tốt

Để lấy vị trí của element trên màn hình, có thể bạn từng nghe đến cả 2 thằng, `offsetTop` và `getBoundingClientRect()`. Và cũng (dễ dàng) có thể bạn cũng nghe người ta bảo rằng `offsetTop` chạy nhanh hơn `getBoundingClientRect()`, tuy nhiên thực tế, số lần bạn sử dụng đến 2 thằng này trong một frame thường rất ít, và ảnh hưởng performance gần như ko đáng kể. Đây là một ví dụ cụ thể về một khái niệm gọi là performance trap. Bạn rất có thể nghe đến những sự so sánh tương tự như trên, kiểu dùng thằng A sẽ nhanh hơn thằng B chục ms. Điều đó đúng khi so sánh trực tiếp trong môi trường runtime ví dụ V8, nhưng khi ở mức độ module hay ứng dụng thực tiễn, những chênh lệch này có thể trở nên không đáng kể và sẽ khiến bạn mất nhiều thời gian và khó khăn khi không thể dùng được công cụ đủ mạnh (những thằng chạy chậm hơn thường có giá của nó, ví dụ `getBoundingClientRect()` sẽ cho bạn nhiều thông tin hơn là `offsetTop`).

Tuy nhiên, nếu bạn làm việc với canvas, đặc biệt là làm game (thường sẽ cần tính toán rất nhiều trong từng khung hình) thì việc tối ưu nhỏ nhặt này sẽ rất có giá trị.

Tham khảo:
  - [https://developers.google.com/web/fundamentals/performance/rendering/optimize-javascript-execution](https://developers.google.com/web/fundamentals/performance/rendering/optimize-javascript-execution)

---
