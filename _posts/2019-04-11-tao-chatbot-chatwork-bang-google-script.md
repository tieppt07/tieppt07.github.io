---
layout: post
title: Tạo ChatBot Chatwork bằng Google Script
---

![](/images/posts/apps_script_64dp.png)

GAS là ngôn ngữ scripting dựa trên JavaScript cho phép người dùng thao tác với các sản phẩm của gói dịch vụ G Suite như Docs, Sheets hay Forms. Một số việc chúng ta có thể làm được với GAS như:

- Thêm menu, dialog hay sidebar vào Google Doc, Sheet và Form.
- Viết function cho Google Spreadsheet.
- Tạo các ứng dụng web độc lập hay ứng dụng web nhúng trong Google Sites.
- Giao tiếp với các dịch vụ khác của Google như AdSense, Analytics, Calendar, Drive, Gmail và Maps.
- Xây dựng các add-on mở rộng cho Google Docs, Sheets, Forms và đưa chúng lên Add-on store.
- Chuyển một ứng dụng Android thành add-on Android có thể trao đổi dữ liệu với Google Doc hay Google Spreadsheet của người dùng trên thiết bị di động.

### 1. Đặt vấn đề
Trong công ty thì mọi người sẽ liên lạc với nhau thông qua một phần mềm nào đó như Slack, Skype or Chatwork… 

Và giữa những lần chém gió với nhau điên đảo thì sẽ có một số thông báo cố định như:

- Họp team lúc 15h chiều thứ 6 hàng tuần.
- Đặt chè vào lúc 15h chiều thứ 5 hàng tuần.
- Thông báo Server A đang gặp sự cố. Cần kiểm tra ngay lập tức.

Trong bài viết này chúng ta sẽ thử tạo 1 con BOT tự động nhắn tin trên [Chatwork](https://www.chatwork.com).

### 2. Bắt tay vào làm
1. Lấy API token từ chatwork.

![](/images/posts/ScreenShot2019-04-13at22.21.29.png)


Token của chúng ta như sau.
![](/images/posts/ScreenShot2019-04-13at22.21.51.png)


Còn đây là id của phòng BOT sẽ gửi tin nhắn đến.
![](/images/posts/ScreenShot2019-04-13at22.46.26.png)

2. Code gửi tin nhắn Chatwork bằng Google App Script

Truy cập vào https://script.google.com/home/start và bấm nút "New Script" để bắt đầu code.

#### 2.1. Gửi tin nhắn đến Chatwork

Sử dụng token và room chúng ta lấy ở trên để để gửi tin nhắn thông qua [Chatwork API](http://developer.chatwork.com/vi/index.html): 
```javascript
function sendChatWorkMessage(message) {
  var token = "chatwork_token";
  var roomId = "roomID";

  var params = {
    'method' : 'post',
    'headers' : {
      'X-ChatWorkToken' : token
    },
    'payload' : {
      'body' : message
    }
  };

  var response = UrlFetchApp.fetch("https://api.chatwork.com/v2/rooms/" + roomId + "/messages", params);
  Logger.log(response.getContentText());
}
```

#### 2.2. Cài đặt trigger để tự động chạy function

Bấm vào nút ba chấm chọn `Trigger`. Chọn Trigger có sẵn hoặc bấm nút `Tạo Trigger`. 

Mình config function `sendChatWorkMessage` sẽ chạy hàng tuần vào 3pm-4pm thứ 6:

![](/images/posts/ScreenShot2019-04-14at21.31.48.png)

![](/images/posts/ScreenShot2019-04-14at21.32.00.png)

#### 2.3 Thành quả
Mình có viết thêm function check server có bị down hay ko. Và đây là tin nhắn gửi về Chatwork sau khi check server có bị down hay ko. :D
![](/images/posts/ScreenShot2019-04-13at22.25.30.png)

Hi vọng sẽ hữu ích với các bạn! :D


---
