---
layout: post
title: Tìm hiểu về Laravel Collective
---

# Laravel Collective là gì? Làm thế nào để sử dụng?
HTML Collective là một package hỗ trợ cho Laravel dùng để xây dựng các Form HTML.
Để sử dụng Laravel Collective bạn chạy câu lệnh terminal sau:
`composer require laravelcollective/html`

Thêm `Provider` và `Aliases` vào file `config/app.php`:
```php
    // ...
    'providers' => [
        // ...
        Collective\Html\HtmlServiceProvider::class,
        // ...
    ],
    // ...
    'aliases' => [
        // ...
        'Form' => Collective\Html\FormFacade::class,
        'Html' => Collective\Html\HtmlFacade::class,
        // ...
    ],
    // ...
```

# Cách sử dụng

### 1. Mở đóng thẻ `form` html:
```php
{!! Form::open(['method' => 'POST', 'url' => 'foobar']) !!}
    //
{!! Form::close() !!}
```
Đoạn code trên generate ra HTML như sau:
![](https://viblo.asia/uploads/d67d134f-edbe-4658-b1cd-37cdc75d23cc.png)

Ngoài ra, bạn có thể sử dụng `routes` đã được định nghĩa hoặc `controller@action` để binding ra `action` của thẻ `form` HTML:
```php
Form::open(['method' => 'POST', 'action' => 'HomeController@fooBar'])

Form::open(['method' => 'POST', 'routes' => 'home.foobar'])
```

### 2. Truyền biến qua form:
```php
Form::open(['method' => 'POST', 'url' => "foobar/$id"])

Form::open(['method' => 'POST', 'action' => ['HomeController@fooBar', 'id' => $id]])

Form::open(['method' => 'POST', 'routes' => ['home.foobar', 'id' => $id]])
```

Nếu `form` cho phép upload files thì thêm option `files`:
```php
Form::open(['method' => 'POST', 'url' => 'foobar', 'files' => true])
```

### 3. Generate các thẻ HTML input(text, textarea, radio, select, checkbox):
```php
    // Generating A Label Element
    Form::label('email', 'E-Mail Address')
    <label for="email">E-Mail Address</label>


    // Generating A Text Input
    Form::text('username')
    <input name="username" type="text">

    Form::text('username', 'tieppt')
    <input name="username" type="text" value="tieppt">

    // Generating A Hidden Input
    Form::hidden('username')
    <input name="username" type="hidden">


    // Generating A Password Input
    Form::password('password', ['class' => 'awesome'])
    <input name="password" type="password" value="" class="awesome">


    // Generating A Email Input
    Form::email('email')
    <input name="email" type="email" value>

    Form::text('email', 'example@gmail.com')
    <input name="email" type="email" value="example@gmail.com">

    // Generating A File Input
    Form::file('file')
    <input name="file" type="file">


    // Generating A Checkbox Input
    Form::checkbox('hobbies', 'value')
    <input name="hobbies" type="checkbox" value="value">

    Form::checkbox('hobbies', 'value', true)
    <input checked="checked" name="hobbies" type="checkbox" value="value">


    // Generating A Radio Input
    Form::radio('name', 'value')
    <input name="role" type="radio" value="value">

    Form::radio('name', 'value', true)
    <input checked="checked" name="role" type="radio" value="value">


    // Generating A Number Input
    Form::number('number', 1)
    <input name="number" type="number" value="1">


    // Generating A Date Input
    Form::date('dob', \Carbon\Carbon::now())
    <input name="dob" type="date" value="2017-04-23">


    // Generating A Select Options
    Form::select('size', ['L' => 'Large', 'S' => 'Small'])
    <select name="size">
        <option value="L">Large</option>
        <option value="S">Small</option>
    </select>


    // Generating A Checkboxes
    Form::select('size', ['L' => 'Large', 'S' => 'Small'], null, ['multiple' => true])
    <select multiple="multiple" name="size">
        <option value="L">Large</option>
        <option value="S">Small</option>
    </select>

    // Generating A Grouped List
    {!! Form::select('animal',[
        'Cats' => ['leopard' => 'Leopard'],
        'Dogs' => ['spaniel' => 'Spaniel'],
    ]) !!}
    <select name="animal">
        <optgroup label="Cats">
            <option value="leopard">Leopard</option>
        </optgroup>
        <optgroup label="Dogs">
            <option value="spaniel">Spaniel</option>
        </optgroup>
    </select>


    // Generating A Drop-Down List With A Range
    Form::selectRange('number', 10, 15)
    <select name="number">
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        <option value="13">13</option>
        <option value="14">14</option>
        <option value="15">15</option>
    </select>


    // Generating A List With Month Names
    Form::selectMonth('month')
    <select name="month">
        <option value="1">January</option>
        <option value="2">February</option>
        <option value="3">March</option>
        <option value="4">April</option>
        <option value="5">May</option>
        <option value="6">June</option>
        <option value="7">July</option>
        <option value="8">August</option>
        <option value="9">September</option>
        <option value="10">October</option>
        <option value="11">November</option>
        <option value="12">December</option>
    </select>

    //Generating A Button
    Form::submit('Click Me!')
    <input type="submit" value="Click Me!">

     Form::reset('Click Me!')
    <input type="reset" value="Click Me!">

     Form::button('Click Me!')
    <button type="button">Click Me!</button>
```

### 4. Binding dữ liệu vào form:
```php
{!! Form::open(['method' => 'PATCH', 'route' => ['users.update', $user->id]]) !!}
    {!! Form::text('name', $user->name) !!}
    {!! Form::text('email', $user->email) !!}
{!! Form::close() !!}

// Bind dữ liệu bằng form model. Các attributes value của thẻ input sẽ tự động match với các value của key tương ứng trong model $user
{!! Form::model($user, ['method' => 'PATCH', 'route' => ['users.update', $user->id]]) !!}
    {!! Form::text('name') !!}
    {!! Form::text('email') !!}
{!! Form::close() !!}
```
Kết quả:
![](https://viblo.asia/uploads/fcd7beeb-618c-4dae-a9c2-e88ee2138301.png)

### 5. 1 số truờng hợp binding dữ liệu cụ thể
Selected option khi hiển thị dữ liệu
```php
Form::select('size', ['L' => 'Large', 'M' => 'Medium', 'S' => 'Small'], 'S')
// Kết quả
<select name="size">
    <option value="L">Large</option>
    <option value="S" selected>Small</option>
</select>

Form::select('size', ['L' => 'Large', 'M' => 'Medium', 'S' => 'Small'], ['S', 'M'], ['multiple' => true])
// Kết quả
<select multiple="multiple" name="size">
    <option value="L">Large</option>
    <option value="M" selected="selected">Medium</option>
    <option value="S" selected="selected">Small</option>
</select>
```

Checked  checkboxes:
```php
Form::checkbox('hobbies', 'value', true)
// Kết quả
<input checked="checked" name="hobbies" type="checkbox" value="value">

$sizes = ['L' => 'Large', 'M' => 'Medium', 'S' => 'Small'];
$checkedSizes =  ['L' => 'Large', 'S' => 'Small'];
@foreach ($sizes as $size)
    Form::checkbox('checkbox', $size, in_array($size, $checkedSizes))
@endforeach
// Kết quả
<input name="checkbox" type="checkbox" value="Large" checked="checked">
<input name="checkbox" type="checkbox" value="Medium">
<input name="checkbox" type="checkbox" value="Small" checked="checked">
```

Form model hiển thị
```php
Form::model($user, ['route' => ['users.update', $user->id]])
    Form::email('email')
    Form::text('username')
    Form::password('password')
Form::close()
// Các attributes value của thẻ input sẽ tự động match với các value của key tương ứng trong model $user
// Kết quả
<form method="POST" action="http://localhost:8888/users/1" accept-charset="UTF-8">
    <input name="email" type="email" value="admin@tieppt.com" id="email">
    <input name="username" type="text" value="admin">
    <input name="password" type="password" value="">
</form>
```

----
