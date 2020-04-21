---
layout: post
title: Tìm hiểu AdonisJS - Laravel phiên bản NodeJS
---

Nodejs là một công nghệ đang nổi, đồng nghĩa với việc Javascript ngày càng trở nên phổ biến hơn. Có rất nhiều framework node js được sinh sôi hàng ngày. Trong đó có một MVC framwork cũng đang phổ biến `AdonisJS`.

### 1. AdonisJS là gì?

AdonisJs được lấy cảm hứng từ một PhP Framework gọi là `Laravel`. Nó mượn các khái niệm về tiêm phụ thuộc và các nhà cung cấp dịch vụ để viết code đẹp có thể kiểm chứng được tới cốt lõi của nó. Kế thừa những tính năng nổi bật của nodejs, Adonis cũng tập trung vào một số thành phần khác hỗ trợ như:

- Powerful ORM to make secure SQL queries.
- API & Session based Authentication System.
- Easy way to send emails via SMTP or Web Service (Mailgun, Mandrill, etc.)
- Validate & Sanitise every user’s inputs.
- Strong emphasis on security.
- Extendable application layout.


### 2. Cài đặt Adonis như thế nào?

#### 2.1. Yêu cầu cơ bản!

Cũng có một phần chuyên biệt, document của adonis cũng dễ tìm hiểu và sử dụng. Hướng dẫn cài đặt cho Adonis chúng ta cũng có thể tìm hiểu tại: [https://adonisjs.com/docs/4.1/installation](https://adonisjs.com/docs/4.1/installation).
Về cơ bản, chúng ta cần phải đạt các yêu cầu theo từng phiên bản, chẳng hạn phiên bản mới nhất hiện nay là V3.2:

- Node.js >= 8.0.0
- npm >= 3.0.0
- git

#### 2.2. Adonis-CLI

- Để cài đặt Adonis-CLI:

```sh
$ npm i -g adonis-cli
```
- Tương tự với laravel/installer, Adonis-CLI sử dụng để tạo mới project:

```sh
$ adonis new project_name
```

- Mở rộng với Adonis-CLI:

| Flag  | Value  | Description  |
|---|---|---|
| --skip-install  | Boolean  | Bỏ qua cài đặt các package từ npm hoặc yarn  |
| --branch  | String  | Chọn branch source để cài đặt, mặc định là branch master  |
| --blueprint  | String  | Tạo một project từ repo git (ex: adonisjs/adonis-app)  |
| --yarn/--npm  | Boolean  | sử dụng npm hoặc yarn để cài đặt các module  |

#### 2.3. Khởi tạo project mới

- Sau khi cài đặt bằng câu lệnh trên thành công chúng ta nhận được kết quả:

```
✔ Your current Node.js & npm version match the AdonisJs requirements!

⠋ Cloning master branch of adonisjs/adonis-app blueprint
    clone: Repository cloned

⠧ Installing dependencies using npm
```

- Tiếp tục chạy lệnh:

```sh
$ cd project_name
$ npm run serve:dev
```

- Nếu nhận được kết quả sau thì bạn đã cài đặt và tạo mới một project với Adonis thành công:

```sh
[nodemon] starting `node server.js`
info adonis:framework serving app on http://localhost:3333
```

Mặc định Adonis sử dụng cổng `3333`. Nào hãy mở [http://localhost:3333](http://localhost:3333) để tận hưởng thành quả nào!!!

![](/images/posts/aa9138af-779c-4aca-8325-87c7061c0c2b.png)

### 3. Kiếm tra Adonis folder

#### 3.1. Cấu trúc thư mục.

Thiết kế lấy cảm hứng từ laravel, Adonis cũng có một cấu trúc thư mục gần giống với laravel các phiên bản trước đây:

```
├── app
│   ├── Commands
│   ├── Http
│   ├── Listeners
│   ├── Model
├── bootstrap
├── config
├── database
│   ├── migrations
│   └── seeds
├── providers
├── public
├── resources
│   └── views
├── storage
```

Nếu các bạn đã từng làm việc qua với `Laravel`, hẳn chúng ta cũng đoán được chức năng của từng thư mục rồi! =))

#### 3.2. Ace - Config - Autoload - Provider - Alias

Tương tự với Artisan của laravel, Ace cũng được sử dụng để tạo các thành phần như `controllers`, `models`, chạy `migrations` hay chạy những command line của provider. Ngoài ra chúng ta cũng có thể tạo cho riêng mình những command line riêng, chúng được đặt trong thư mục `app/Commands`, đồng thời để Ace có thể sử dụng được, chúng ta cần đăng ký command line vừa tạo trong file `bootstrap/app.js`. Bạn có thấy giống với laravel ko nào? Để tìm hiểu thêm bạn có thể thử chạy câu lệnh: `/ace -h` hoặc có thể tìm hiểu thêm tại link

#### 3.3. Configuration

Config được sử dụng bằng cách nạp Provider: Adonis/Src/Config .

- Giống với laravel, config trong Adonis cũng cung cấp cho ta hàm để có thể get, set config.

|Phương thức|	Chức năng|	Ví dụ|
|---|---|---|
|get(key, [defaultValue])	|Get giá trị config.	|Config.get('database.host', 'localhost')
|set(key, value)	|Set giá trị config.	|Config.set('database.host', '127.0.0.1')
- Các file config được lưu tại thư mục: config

#### 3.4. Autoload - Provider - Alias

- Autoload trong Adonis được config ở file package.json:

```json
"autoload": {
    "App": "./app"
},
```

- Provider: là những package của bên thứ 3 hoặc các package mở rộng. Trong laravel chúng ta cài đặt các package qua composer thì với Adonis chúng ta cài đặt thông qua npm hoặc yarn. Các package tải về sẽ được lưu trong `node_modules`. Để sử dụng được các provider, chúng ta cần khai báo chúng trong file `bootstrap/app.js`
- Alias: bằng cách khai báo này chúng ta có thể gọi provider một cách ngắn gọn `Command` thay vì `Adonis/Src/Command`.

```js
const aliases = {
  Command: 'Adonis/Src/Command',
  Config: 'Adonis/Src/Config',
}
```

- Bạn có thể tìm hiểu thêm tại: [IoC Container & Service Providers](http://adonisjs.com/docs/4.1/ioc-container)

#### 3.5. Routing.

Adonis cũng hỗ trợ hầu hết các loại route như của laravel:

- Các method cơ bản như: Route.get, Route.post, Route.put, Route.patch, Route.delete
- Hay muốn custom một route khác:

```js
const Route = use('Route')
// SINGLE VERB
Route.route('/', 'COPY', function * (request, response) { })

// MULTIPLE VERBS
Route.route('/', ['COPY', 'MOVE'], function * (request, response) { })
```

- Hoặc đáp ứng cho app SPA: any(url, action)

```js
Route.any('*', function * (request, response) {
  yield response.sendView('home')
})
```

- Nhóm các route lại thành 1 group hay thêm prefix: group(uniqueName, callback)

```js
Route.group('admin', function () {
  Route.get('users', function * (request, response) {
    // ...
  })
}).prefix('backend')
```

- Đặt tên cho route: as(name)

```js
#Route:
Route
  .get('users/:id', 'UserController.show')
  .as('profile')
#View
linkTo('profile', 'View Profile', { id: 1 })

// Hoặc route resource: resource(name, controller)

Route.resource('users', 'UserController')
```
- Còn nhiều phương thức hỗ trợ cho route rất mạnh mẽ nữa, bạn có thể tìm hiểu tại Routing

#### 3.6. Controller

- Controller trong Adonis được khai báo trong folder: app/Http/Controllers
- Tạo một controller bằng ace:

```js
// #Tạo một controller blank
$ ./ace make:controller Home

// # Tạo một controller resource
$ ./ace make:controller User --resource
```

- Về cơ bản, route trong Adonis cũng giống như trong Laravel, bạn có thể tìm hiểu thêm tại Controllers


### 4. Kết luận.

Adonis là một framwork nodejs khá mới, tuy nhiên nó cũng có những ưu điểm riêng nhất định. Adonis có tốc độ của ứng dụng nodejs, sức mạnh của việc kế thừa Active record, việc trừu tượng hóa cơ sở dữ liệu thành từng đối tượng khiến cho việc tương tác với cơ sở dữ liệu là khá dễ dàng. Với những ưu thế là vậy, nhưng vẫn còn những điểm yếu như chưa hỗ trợ chính thức NoSQL, hay việc custom validate và sử dụng vào form request.... Mong rằng trong những phiên bản tiếp theo, Adonis sẽ hỗ trợ những điều đó.

Còn rất nhiều điểm mạnh của Adonis mà chúng ta chưa thể đề cập hết như làm việc với `Web socket`, `Redis`, `Authenticators`, vấn đề bảo mật trong của Adonis như `CSRF Protection`, `CORS` hay `Shield Middleware` mà chúng ta sẽ đề cập đến trong những bài viết tiếp theo.Hi vọng rằng bài viết hữu ích đối với các bạn.

Chúng ta sẽ tìm tiếp vào phần sau... :D

Một số thứ về Adonis:
- [AdonisJS Oficial](http://adonisjs.com/) - [Adonis on Github](https://github.com/adonisjs)
- [Giới thiệu về AdonisJS - Scotch.IO](https://scotch.io/tutorials/meet-adonisjs-a-laravel-style-mvc-framework-for-node-js)
- [Tạo mộ ứng dụng web với Adonis](https://heera.it/adonis-laravel-ish-node-framework#.V9vW2KNh1TJ)
- [Làm việc với web socket trong Adonis](http://amanvirk.me/using-socket-io-with-adonis)
- [Cộng đồng Adonis Gitter](https://gitter.im/adonisjs/adonis-framework)

---
