---
layout: post
title: Sử dụng NPM scripts làm build tool thay cho Grunt và Gulp?
---

Grunt và Gulp, 2 task runner rất phổ biến, chắc đã quá quen thuộc và trở thành một phần với ai làm việc nhiều với Javascript rồi. Tuy nhiên bạn đã bao giờ gặp khó khăn với chúng và nghĩ đến việc thoát khỏi sự phụ thuộc vào chúng và quay trở lại dùng npm package nguyên thủy chưa?

## Nhược điểm của Grunt và Gulp
### Thực sự nó cũng chẳng làm mọi thứ gọn lại ...
... Nếu ko muốn nói là phình to ra. Grunt và Gulp đều có chung một mục tiêu là trừu tượng hoá các tác vụ của developer vào một lá bùa, đối với Grunt là gruntfile.js, đối với Gulp là gulpfile.js. Giả sử khi các bạn cần dùng jshint, nếu bạn dùng Grunt, bạn sẽ phải tìm pakage jshint cho grunt. Cùng ko khó lắm, mình cần thì chắc chắn cũng có thằng khác cần, kiểu gì cũng có, chúng ta có grunt-contrib-jshint để sử dụng JS lint với Grunt, với Gulp cũng đơn giản, chúng ta có gulp-jshint. Sau khi config các kiểu tỏng gruntfile và gulpfile, câu lệnh sau cùng chúng ta cần để thực thi task JS lint:

- với Grunt: grunt jshint
- với Gulp: gulp jshint
- chỉ với jslint: jshint **.js Câu lệnh cuối cùng cũng chẳng khác nhau là mấy. Đó là chưa kể đến...

### Grunt và Gulp phụ thuộc nhiều vào plugins
Cả 2 công cụ này đều sẽ ko có tác dụng gì nếu ko có plugins có nó đi kèm. Ở 2 plugins grunt-contrib-jshint và gulp-jshint kể trên, chúng đều cần đến package gốc là jshint. Đây là dependencies tree của grunt-contrib-jshint, các bạn có thể xem thử trong file package-lock.json.

```json
// package-lock.json
"grunt-contrib-jshint": {
  "version": "2.0.0",
  "resolved": "https://registry.npmjs.org/grunt-contrib-jshint/-/grunt-contrib-jshint-2.0.0.tgz",
  "integrity": "sha512-4qR411I1bhvVrPkKBzCUcrWkTEtBuWioXi9ABWRXHoplRScg03jiMqLDpzS4pDhVsLOTx5F9l+0cnMc+Gd2MWg==",
  "dev": true,
  "requires": {
    "chalk": "^2.4.1",
    "hooker": "^0.2.3",
    "jshint": "~2.9.6"
  }
}
```
Giả sử bạn phát hiện ra một công cụ, node package hay ho nào đó, việc đầu tiên nếu bạn muốn dùng nó với Grunt hoặc Gulp là tìm một package wrapper cho 2 thằng này. Nếu chưa có ai viết thì sao? Một là ngồi chờ, hai là tự bạn viết. Nếu tự bạn viết, thay vì chỉ phải đọc cách dùng command line của package hay ho kia, bạn sẽ phải đọc cả API doc của package đó, và tất nhiên cả API doc của Grunt và Gulp nếu bạn viết lần đầu. Trong một số trường hợp, sẽ có 1 số task bạn cần dùng Grunt, một số task chỉ thằng Gulp mới làm được, lúc đó bạn có thể sẽ tìm thấy một số thứ giúp đc bạn, như gulp-grunt chẳng hạn.

Quote từ readme của gulp-grunt:

What if your favorite grunt plugin isn't available for gulp yet? Don't fret, there is nothing to worry about! Why don't you just hook in your grunt configuration?

Lệ thuộc vào plugin cũng đồng nghĩa với việc mọi update từ package gốc sẽ cần thời gian để author của plugin cập nhật vào package của họ.

### Documentation giữa package gốc và wrapper plugins ko có nhiều sự kết nối
Documentation của công cụ gốc luôn tốt hơn documentation của wrapper plugins. Nếu bạn sử dụng Grunt và Gulp, bạn ko chỉ phải đọc hiểu documentation của công cụ gốc mà sẽ phải đọc cả của wrapper plugin.

## Ưu điểm của việc sử dụng NPM như một task runner (hoặc build tool)
### Giải phóng sự lệ thuộc vào plugins
Điểm này thì dễ nhận ra rồi, chúng ta sẽ ko cần dùng các wrapper của Grunt và Gulp như grunt-contrib-jshint hay gulp-jshint mà có thể sử dụng trực tiếp gói jshint.

Tính đến thời điểm viết bài: NPM hiện tại có khoảng 800000 packages.

### Dependencies và build tool nằm chung một chỗ.
Việc đầu tiên khi dùng Grunt và Gulp - ko phải là nghĩ đến Grunt hoặc Gulp - mà là nghĩ đến NPM. Chúng ta vẫn sẽ phải quản lý dependencies cho Grunt và Gulp thông qua NPM. Cụ thể, đây là ví dụ của việc sử dụng jshint trực tiếp với NPM script thay cho Gulp và Grunt.

```json
"devDependencies": {
  "jshint": "latest"
},
"scripts": {
  "lint": "jshint **.js"
}
```

## Sức mạnh của NPM script
### Sử dụng NPM script không cần nhiều đến kĩ năng command line
Hầu hết các npm packages đều đưa ra giao diện dòng lệnh giúp cho kể cả những dev có trình độ command line thấp cũng có thể sử dụng. Và các câu lệnh cũng đều trừu tượng hoá các dòng lệnh của từng HĐH khác nhau. Ví dụ nếu bạn muốn dùng câu lệnh phá huỷ vũ trụ "rm -rf", npm cũng có sẵn một package mạnh mẽ rimraf. Chỉ cần đọc doc của package và dùng thôi, tất nhiên là nó có thể được dùng xuyên nền tảng.

### NPM script mạnh hơn bạn nghĩ
Nếu bạn chưa biết, bạn có thể tìm hiểu pre và post hooks ([https://docs.npmjs.com/misc/scripts#description](https://docs.npmjs.com/misc/scripts#description)).

```json
{
  "name": "npm-script",
  "version": "1.0.0",
  "description": "npm scripts example",
  "scripts": {
    "prebuild": "echo Run before build",
    "build": "cross-env NODE_ENV=production webpack",
    "postbuild": "echo Run after build"
  }
}
```

Như ở ví dụ trên, khi bạn chạy npm run build, ko chỉ một lệnh build đc chạy mà sẽ có 3 lệnh được chạy theo thứ tự pre -> build -> post.

Trong trường hợp các câu lệnh của bạn trở nên quá dài hoặc quá phức tạp, đơn giản thôi, hãy viết tách ra một file javascript và gọi lại trong npm script:
```json
{
  "name": "npm-scripts",
  "version": "1.0.0",
  "description": "npm scripts example",
  "scripts": {
    "build": "node build.js"
  }
}
```
Việc sử dụng một file javascript độc lập để viết cú pháp build, bạn vẫn hoàn toàn tận dụng được bất cứ package nào bạn cần, chỉ khác là viết bằng cú pháp javascript thôi.

### NPM script hoàn toàn có thể đáp ứng được cross-platform.
Có một vài cách để đáp ứng câu lệnh cho tất cả các nền tảng như Windows hoặc Unix. Một trong số đó như đã đề cập ở trên là sử dụng npm package cho những câu lệnh không được hỗ trợ xuyên nền tảng, ví dụ: rimraf thay cho lệnh rm -rf, cross-env giúp set biến môi trường với cùng 1 dòng lệnh trên cả Windows và Unix, ... Ngoài ra, còn một package rất nổi tiếng giúp chạy các Unix-based commands trên tất cả các HĐH, đó là shelljs.

## Nhược điểm
Nói nhiều về ưu điểm thì cũng phải nói đến nhược điểm cho khách quan.

### Bạn không thể comment trong package.json
Vì vậy bạn nên break các script ra, mỗi script chỉ làm một nhiệm vụ nhất định (giống quy tắc viết hàm small single responsibility functions), và đặt tên cho script bao hàm đủ ý nghĩa. Nếu vẫn chưa đáp ứng được sự tường minh bạn mong muốn, bạn có thể chuyển phần logic phức tạp sang một file js và thực hiện script ở file độc lập đó như đã nói kể trên.

### Bạn không thể dùng biến trong package.json
Cũng như trên, bạn có thể chuyển những script quá logic sang một file js. Tuy nhiên, thực tiễn thì hầu như ở các npm script trong các dự án, biến được sử dụng nhiều nhất là biến môi trường, và biến môi trường thì đã được set từ lúc người dùng gõ câu lệnh rồi.

## Kết
Nếu bạn chưa tin npm script thay thế được Grunt và Gulp, hãy xem thử Boostrap 4 sống ra sao chỉ với npm script nhé.

Tham khảo:

- [https://deliciousbrains.com/npm-build-script/](https://deliciousbrains.com/npm-build-script/)
- [https://medium.freecodecamp.org/why-i-left-gulp-and-grunt-for-npm-scripts-3d6853dd22b8](https://medium.freecodecamp.org/why-i-left-gulp-and-grunt-for-npm-scripts-3d6853dd22b8)


---
