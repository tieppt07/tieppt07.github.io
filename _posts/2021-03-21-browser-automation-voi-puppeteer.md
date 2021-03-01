---
layout: post
title: Browser automation với Puppeteer
---

Nếu bạn thường phải làm các task liên quan đến browser automation thì `Puppeteer` là tool không thể bỏ qua.

Mọi người đều biết hiện tại `Chrome` là trình duyệt có thị phần lớn nhất. Hồi đầu năm nay thì Chrome được bổ sung tính năng mới là `Chrome Headless` (Kể từ bản Chrome 59). Nôm na là bạn có thể chạy Chrome mà không thực sự phải chạy Chrome. :D
Tiếp liền sau đó thì Google Chrome team cũng cho ra đời `Puppeteer`, một Nodejs `library` giúp bạn có thể control được Chrome Headless.
Khỏi phải nói về độ khủng của mấy tool này trong lĩnh vực browser automation, bằng chứng là khi được chính thức giới thiệu mà một loạt các tools tương tự khác thông báo ngừng phát triển, điển hình là `PhantomJS`

Bài viết này sẽ tập trung giới thiệu sơ bộ `Puppeteer`. Còn các bạn muốn tìm hiểu sâu hơn về Chrome headless thì có thể vào [đây](https://developers.google.com/web/updates/2017/04/headless-chrome#:~:text=Headless%20Chrome%20is%20shipping%20in,engine%20to%20the%20command%20line.).

### Puppeteer là gì

Nôm na thì Puppeteer là Nodejs libary chính chủ, giúp bạn điều khiển headless Chrome.
Những gì mà bạn làm được bằng giao diện người dùng trên Chrome thì bạn đều có thể làm bằng Puppeteer.
Bạn có thể xem mã nguồn của Puppeteer trên [Github](https://github.com/puppeteer/puppeteer).

Từ đó mở ra một chân trời những thứ hay ho mà bạn có thể làm được với Puppeteer.

### Puppeteer có thể làm gì?

- Chụp ảnh màn hình hoặc xuất file pdf của các trang.
- Crawl một SPA (Single-Page Application) và xuất ra nội dung pre-rendered (ví dụ như "SSR" (Server-Side Rendering)).
- Tự động gửi form, test giao diện và nhập dữ liệu từ bàn phím,...
- Tạo môi trường testing tự động cập nhật. Chạy bản thử nghiệm trong Chorme với các tính năng mới nhất và phiên bản javascript mới nhất.
- Ghi lại timeline trace cho website của bạn giúp phát hiện sớm các vấn đề về hiệu năng.
- Test Chorme Extensions.
...

### Sử dụng puppeteer

Cài đặt bằng `npm`:

```sh
$ npm install --save puppeteer
```

Excute example-file.js:

```sh
node example-file.js
```

### Examples

##### Chụp ảnh màn hình

```js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://example.com');
  await page.screenshot({ path: 'example.png' });

  await browser.close();
})();
```

##### Tạo PDF

```js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://news.ycombinator.com', {
    waitUntil: 'networkidle2',
  });
  await page.pdf({ path: 'hn.pdf', format: 'a4' });

  await browser.close();
})();
```

##### Lấy thông số màn hình của trang

```js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://example.com');

  // Get the "viewport" of the page, as reported by the page.
  const dimensions = await page.evaluate(() => {
    return {
      width: document.documentElement.clientWidth,
      height: document.documentElement.clientHeight,
      deviceScaleFactor: window.devicePixelRatio,
    };
  });

  console.log('Dimensions:', dimensions);

  await browser.close();
})();
```

Bạn có thể tìm hiểu thêm tại [đây](https://github.com/puppeteer/puppeteer#usage).

### Case study

Tự động cập nhật OKR (remaining):

```js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    headless: false,
    defaultViewport: null,
  });
  const page = await browser.newPage();
  await page.setCacheEnabled(false);
  await page.setViewport({ width: 1366, height: 768});

  // go to goals login page
  await page.goto('https://goal.sun-asterisk.vn/login');
  await page.click('a.m-login__btn');

  // wait redirect to wsm page
  await page.waitForSelector('a.wsm-btn.btn-login');
  await page.click('a.wsm-btn.btn-login');

  // fill username/pwd wsm login page
  await page.waitForSelector('.login-content #devise-login-form');
  await page.$eval('#user_email', (el, username) => el.value = username, '******');
  await page.$eval('#user_password', (el, password) => el.value = password, '******');
  await page.evaluate(() => document.querySelector('#wsm-login-button').click())

  // wait page show modal
  await page.waitForSelector('#core-values-modal #close-core-values-modal span', {
    visible: true,
  });
  await page.click('#core-values-modal #close-core-values-modal span');

  // wait login to wsm and redirect to goal objectives page
  await page.waitForSelector('#myobjectives');
  const objectives = await page.$$('#myobjectives .objectiveItem .align-middle .obj-name a');

  // Go to each objective detail page
  for (const objective of objectives) {
    const href = await page.evaluate(e => e.href, objective);

    const objectiveDetailPage = await browser.newPage();
    await objectiveDetailPage.goto(href);

    await objectiveDetailPage.evaluate(() => {
      let unchangedBtns = document.getElementsByClassName('unchanged');
      for (let unchangedBtn of unchangedBtns)
        // click remaining item buttons
        await unchangedBtn.click();
    });

    await new Promise(resolve => setTimeout(resolve, 1000));

    // close tab
    await objectiveDetailPage.close();
  }

  // close browser
  await browser.close();
})();
```

---
