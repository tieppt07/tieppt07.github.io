---
layout: post
title: Sử dụng Trait trong PHP
---

![](/images/posts/develo-design-social-hero-1024x536.jpg)

Trong khi phát triển tính năng mới, tôi thấy cần phải sử dụng lại các phương thức ở các class khác, mà PHP lại không hỗ trợ đa kế thừa. Rất may họ đã sinh ra Traits để giải quyết vấn đề này.

Có một đoạn code ví dụ đơn giản như thế này:
```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

/**
 * Class Post
 *
 * @package App
 */
class Post extends Model
{
    /**
     * @return string
     */
    public function getTitle()
    {
        return $this->getAttribute('title');
    }

    /**
     * @param string $title
     * @return $this
     */
    public function setTitle(string $title)
    {
        $this->setAttribute('title', $title);

        return $this;
    }

    /**
     * @param Account $account
     * @return $this
     */
    public function setAccount(Account $account)
    {
        $this->account()->associate($account);

        return $this;
    }

    /**
     * @return Account|null;
     */
    public function getAccount()
    {
        return $this->getAttribute('account');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function account()
    {
        return $this->belongsTo(Account::class, 'account_id', 'id');
    }
}
```

Ta có một số phương thức được định nghĩa cho thuộc tính Post và quan hệ Account. Bây giờ khi ta thêm một model khác có mối quan hệ với Account, ta sẽ phải thêm các phương thức tương tự. Điều này có thể tốn thời gian và nếu muốn thay đổi các phương thức, ta sẽ phải sửa nó trên tất cả các model có mối quan hệ đó.

### Sử dụng Traits
Ta sẽ bắt đầu với định nghĩa trên trang [php.net](https://www.php.net/manual/en/language.oop5.traits.php):

Traits là một cơ chế để tái sử dụng code trong các ngôn ngữ kế thừa đơn lẻ như PHP. Sử dụng Trait nhằm giảm một số hạn chế của thừa kế đơn bằng cách cho phép coder sử dụng lại các methods một cách tự do trong một số class độc lập.

Traits giống như một class, nhưng nó sẽ nhóm các function mà chúng ta muốn sử dụng trong các class khác. Ta không thể tự khởi tạo một object từ Traits. Nó là một bổ sung cho thừa kế truyền thống và cho phép mở rộng theo chiều ngang. Đó là việc áp dụng các methods của class mà không yêu cầu kế thừa.

Đây là lý do hoàn hảo cho việc sử dụng một traits. Ta sẽ tạo một trait có tên HasAccountTrait , sẽ có tất cả các phương thức cho mối quan hệ belongsTo của function account():

```php
<?php

namespace App;

/**
 * Class HasAccountTrait
 *
 * @package App
 */
trait HasAccountTrait
{
    /**
     * @param Account $account
     * @return $this
     */
    public function setAccount(Account $account)
    {
        $this->account()->associate($account);

        return $this;
    }

    /**
     * @return Account|null;
     */
    public function getAccount()
    {
        return $this->getAttribute('account');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function account()
    {
        return $this->belongsTo(Account::class, 'account_id', 'id');
    }
}
```

Từ đó ta có thể thu gọn model Post ở trên để sử dụng Trait, dưới đây là model Post đã được thu gọn:
```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
/**
 * Class Post
 *
 * @package App
 */
class Post extends Model
{
    use HasAccountTrait;

    /**
     * @return string
     */
    public function getTitle()
    {
        return $this->getAttribute('title');
    }

    /**
     * @param string $title
     * @return $this
     */
    public function setTitle(string $title)
    {
        $this->setAttribute('title', $title);

        return $this;
    }
}
```

### Kết luận
Traits là giải pháp tuyệt vời cho việc tránh kế thừa phức tạp trong những ngôn ngữ đơn kế thừa như PHP.

Traits giúp code của chúng ta không bị lặp hay làm phức tạp thêm kể cả khi ta thêm các chức năng, phương thức vào class.

Trait là một phương pháp giải quyết vấn đề nhanh gọn. Chúng ta "hãy dùng và cảm nhận", hãy đối mặt với vấn đề xảy ra chứ đừng cố gắng tìm những tình huống cụ thể nào nên sử dụng `Traits`, từ đó có thể rút ra case study riêng cho mình.

Ref:
- [https://medium.com/@kshitij206/traits-in-laravel-5db8beffbcc3](https://medium.com/@kshitij206/traits-in-laravel-5db8beffbcc3)
- [https://viblo.asia/p/traits-in-php-and-laravel-l0rvmxzQGyqA](https://viblo.asia/p/traits-in-php-and-laravel-l0rvmxzQGyqA)

---
