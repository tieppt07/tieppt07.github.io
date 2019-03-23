---
layout: post
title: Laravel Accessors and Mutators
---

Accessors và Mutators cho phép bạn định dạng các thuộc tính khi lấy chúng từ Model hoặc thiết lập giá trị cuả chúng trước khi lưu vào cơ sở dữ liệu. Accessors được sử dụng để định dạng thuộc tính khi bạn lấy chúng ra khỏi cơ sở dữ liệu, trong khi mutators định dạng các thuộc tính trước khi lưu vào cơ sở dữ liệu.

### Định nghĩa một Accessor

Để định nghĩa một accessor, bạn tạo một phương thức `getFooAttribute()` trong model, với Foo là tên của cột bạn muốn truy cập và tên phương thức dưới dạng camel cased (vd first_name trở thành getFirstNameAttribute()  ).

Trong ví dụ này, tôi sẽ định nghĩa accessors cho một số thuộc tính:

```PHP
class User extends Model
{
    /**
     * Get the user's address.
     *
     * @param  string  $value
     * @return string
     */
    public function getAddressAttribute($value)
    {
        return strtolower($value);
    }

    /**
     * Get the user's first name.
     *
     * @param  string  $value
     * @return string
     */
    public function getFirstNameAttribute($value)
    {
        return ucfirst($value);
    }

    /**
     * Get the user's full name.
     *
     * @return string
     */
    public function getFullNameAttribute()
    {
        return $this->first_name . $this->last_name;
    }
}
```

Giá trị ban đầu của các cột được thông qua accessor, cho phép bạn xử lý và trả về giá trị. Để truy cập các giá trị của các mutator, bạn có thể chỉ đơn giản là truy cập vào các thuộc tính hoặc qua phương thức:

```PHP
$user = App\User::find($id);
$firstName = $user->first_name;
$address = $user->address;
$fullName = $user->getFullNameAttribute();
```

### Định nghĩa một Mutator

Ngược với Accessor là Mutator. Mutator giúp bạn định dạng các thuộc tính trước khi lưu vào cơ sở dữ liệu. Phương thức định nghĩa Mutator giống với Accessor, có dạng camel cased và có tên là cột bạn muốn truy cập (first_name trở thành setFirstNameAttribute() ).

VD:

```PHP
class User extends Model
{
     /**
     * Set the user's first name.
     *
     * @param  string  $value
     * @return string
     */
    public function setFirstNameAttribute($value)
    {
        $this->attributes['first_name'] = strtolower($value);
    }

    /**
     * Set the user's password.
     *
     * @param  string  $value
     * @return string
     */
    public function setPasswordAttribute($value)
    {
        $this->attributes['password'] = bcrypt($value);
    }
}
```

Ở đây ta không return gì, vì Mutator trực tiếp truy cập và xử lý, thiết lập giá trị mới cho thuộc tính.

### Full VD một model sử dụng Accessors và Mutators

```PHP
 class User extends Model
{
    /**
     * @var array
     */protected $fillable = ['first_name', 'last_name', 'email', 'password', 'last_login', 'settings', 'created_at', 'updated_at'];

    /**
     * Capitalize first name when retrieved from the database
     *
     * @param $value
     * @return string
     */
    public function getFirstNameAttribute($value)
    {
        return ucfirst($value);
    }

    /**
     * Capitalize last name when retrieved from the database
     *
     * @param $value
     * @return string
     */
    public function getLastNameAttribute($value)
    {
        return ucfirst($value);
    }

    /**
     * Get members full name
     *
     * @return string
     */
    public function getFullNameAttribute()
    {
        return ucfirst($this->first_name) . ' ' . ucfirst($this->last_name);
    }

    /**
     * Custom format for the last login date
     *
     * @param $value
     * @return string
     */
    public function getLastLoginAttribute($value)
    {
        return \Carbon\Carbon::parse($value)->format('d.m.Y.');
    }

    /**
     * Capitalize first BEFORE saving it to the database
     *
     * @param $value
     * @return string
     */
    public function setFirstNameAttribute($value)
    {
        $this->attributes['first_name'] = ucfirst($value);
    }

    /**
     * Capitalize last name BEFORE saving it to the database
     *
     * @param $value
     * @return string
     */
    public function setLastNameAttribute($value)
    {
        $this->attributes['last_name'] = ucfirst($value);
    }

    /**
     * Make sure that password is encrypted
     *
     * @param $value
     */
    public function setPasswordAttribute($value) {
        $this->attributes['password'] = Hash::make($value);
    }

    /**
     * Make sure that we get an array from JSON string
     *
     * @param $value
     * @return array
     */
    public function getSettingsAttribute($value) {
        return json_decode($value, true);
    }

    /**
     * Encode an array to a JSON string
     *
     * @param $value
     */
    public function setSettingsAttribute($value)
    {
        $this->attributes['settings'] = json_encode($value);
    }

}
```

### Dùng cái gì và dùng khi nào?

 Có trường hợp bạn chỉ sử dụng accessor hoặc mutator nhưng đôi khi là cả hai.
 VD:
 - Với thuộc tính password, bạn chỉ sử dụng Mutator để mã hóa password trước khi lưu vào cơ sở dữ liệu

 - Chúng ta có thể sử dụng cả 2 Accessor và Mutator để json_encoding và json_decoding đối tuowjgn JSON trong PostgreSQL

```PHP
/**
* Make sure that we get an array from JSON string
*
* @param $value
* @return array
*/
public function getSettingsAttribute($value) {
    return json_decode($value, true);
}

/**
* Encode an array to a JSON string
*
* @param $value
*/
public function setSettingsAttribute($value)
{
    $this->attributes['settings'] = json_encode($value);
}
```

 Như vậy, với Accessors và Mutators, toàn bộ dự án của bạn sẽ luôn luôn có những hành động xử lý nhất định khi tương tác với cơ sở dữ liệu, giúp cho model được sử dụng linh hoạt hơn và ngắn gọn hơn. Nếu bạn sử dụng thuần thục chúng thì code của bạn sẽ trở nên đẹp hơn rất nhiều. Hi vọng tôi đã giúp các bạn hiểu về Accessors và Mutators. Hãy sử dụng chúng vào dự án một cách hiểu quả :)

### Tài liệu tham khảo

 - https://laravel.com/docs/5.2/eloquent-mutators#accessors-and-mutators
 - https://bosnadev.com/2015/12/17/laravel-accessors-mutators/

----
