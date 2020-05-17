---
layout: post
title: Abstract trong PHP
---

Trong bài này, chúng ta cùng tìm hiểu về `Abstract` Class trong PHP.

![wordpress](/images/posts/abstract.jpg)

### Abstract Class là gì?

Lớp trừu tượng trước tiên, nó chính là 1 lớp, nhưng nó được gọi là lớp trừu tượng vì:

- Lớp này sẽ chứa các phương thức trừa tượng.
- Các lớp khác khi kế thừa lớp trừu tượng sẽ phải định nghĩa các phương thức trừu tượng ấy.
- Một class chỉ có thể kế thừa 1 lớp trừu tượng.

Cú pháp để khai báo 1 abstract class:

```php
abstract class Database
{
    abstract protected function fetchAll();
    abstract protected function findBySlug();
}
```

### Lưu ý khi sử dụng Abstract class

- Dùng thế này là sai vì `function fetchAll` là `abstract` function nên không code trong đó.

    ```php
    abstract class Database
    {
        abstract protected function fetchAll()
        {
            var_dump('all results');
        }
    }
    ```

- Khởi tạo đối tượng từ một Abstract class là sai.

    ```php
    abstract class Database
    {
        abstract protected function fetchAll();
    }

    $db = new Database();
    ```

- Thuộc tính trong `Abstract` class.

    ```php
    abstract class Database
    {
        public $table; // Đúng
        abstract public $rules; // Sai, vì thuộc tính không thể để dạng Abstract

        abstract protected function fetchAll(); // Đúng
        abstract private function findBySlug(); // Sai, Abstract function không thể private
    }
    ```


- Tất cả các lớp kế thừa từ `Abstract` class đều phải định nghĩa lại các method của `Abstract` Class.

    ```php
    abstract class Database
    {
        public $table;

        abstract protected function fetchAll();
    }

    class User extends Database
    {
        protected function fetchAll()
        {
            // TO DO
        }
    }
    ```

### Vai trò của Abstract Class trong PHP

Ép buộc người lập trình phải tuân thủ theo một số các phương thức và các phương thức này đã được định nghĩa sẵn những thứ cơ bản, giúp cho lập trình viên có thể kế thừa các phương thức này và phát triển lớp con của họ.

### Ví dụ

Sau đây mình xin giới thiệu các bạn một Abstract class và 1 class extends từ Abstract class cho các bạn dễ hiểu.

```php
abstract class Person
{
    protected $firstName;
    protected $lastName;

    public function __construct($firstName, $lastName)
    {
        $this->firstName = $firstName;
        $this->lastName  = $lastName;
    }

    public function __toString()
    {
        return sprintf("%s, %s", $this->lastName, $this->firstName);
    }

    abstract public function getSalary();
}
```

Với lớp trừu tượng Person trên nếu dùng khởi tạo trực tiếp lớp như sau sẽ lỗi:

```php
$p = new Person('John','Doe');
```
Để sử dụng đúng, cần kế thừa lớp trừu tượng và định nghĩa lại hàm trừu tượng cần thiết:

```php
class Employee extends Person
{
    private $salary;

    public function __construct ($firstName, $lastName, $salary)
    {
        parent::__construct($firstName, $lastName);
        $this->salary = $salary;
    }

    public function getSalary()
    {
        return $salary;
    }
}


$e = new Employee('John', 'Doe', 5000);
echo $e;
```

ref:
- [https://toidicode.com/lop-truu-tuong-abstract-trong-php-huong-doi-tuong-103.html](https://toidicode.com/lop-truu-tuong-abstract-trong-php-huong-doi-tuong-103.html)
- [http://it.die.vn/a/abstract-trong-php/](http://it.die.vn/a/abstract-trong-php/)

---
