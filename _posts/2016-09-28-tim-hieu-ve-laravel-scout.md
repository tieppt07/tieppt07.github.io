---
layout: post
title: Tìm hiểu về Laravel Scout
---

### 1. Scout là gì?

 Laravel Scout cung cấp giải pháp tìm kiếm full-text, hỗ  trợ đánh index dành cho Eloquent Model. Hiện tại Scout được sử dụng dựa vào Algolia driver, tuy nhiên bạn vẫn có thể tự mở rộng scout theo ý riêng của mình.

### 2. Cài đặt

 Giống như các package khác của laravel, bạn có thể cài đặt Scout qua composer:

 `composer require laravel/scout`

 Cài đặt Algolia driver:

 `composer require algolia/algoliasearch-client-php`

 Thêm Provider vào file `config/app.php` :

 `Laravel\Scout\ScoutServiceProvider::class,`

 Cấu hình Scout bằng command:

 `php artisan vendor:publish --provider="Laravel\Scout\ScoutServiceProvider"`

 => File `config/scout.php` sẽ được sinh ra.

 Bạn đã cài đặt xong Laravel Scout, giờ nếu muốn sử dụng, hãy thêm `Laravel\Scout\Searchable` vào Model bạn muốn sử dụng. VD: Post Model:

```PHP
 <?php

namespace App;

use Laravel\Scout\Searchable;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use Searchable;
}
```

### 3. Queueing

 Khi không sử dụng đến Scout, bạn nên cấu hình Queue bằng cách gán giá trị `true` cho queue driver trong file `config/scout.php`:

 `'queue' => true,`

 Sử dụng queue có mục đích gì? Ngay cả khi không sử dụng Scout trong Model, mỗi lần bạn request đến server để lấy dữ liệu, thì bạn đều phải request đến Algolia (driver của Scout). Điều này sẽ làm website của bạn chậm lại 1 cách nhanh chóng. Vì thế khi không cần sử dụng Scout, bạn nên nghĩ đến việc sử dụng Queue.

### 4. Cấu hình Scout trong Model

 Cấu hình Index cho Model bằng cách override phương thức `searchableAs()` trong Model:

```PHP
 <?php

 namespace App;

 use Laravel\Scout\Searchable;
 use Illuminate\Database\Eloquent\Model;

 class Post extends Model
 {
    use Searchable;

    /**
     * Get the index name for the model.
     *
     * @return string
     */
    public function searchableAs()
    {
        return 'posts_index';
    }
 }
```

 Định nghĩa các thuộc tính có thể tìm kiếm bằng cách override phương thức `toSearchableArray()` trong model:

```PHP
 <?php

 namespace App;

 use Laravel\Scout\Searchable;
 use Illuminate\Database\Eloquent\Model;

 class Post extends Model
 {
    use Searchable;

    /**
    * Get the indexable data array for the model.
    *
    * @return array
    */
    public function toSearchableArray()
    {
        $array = $this->toArray();

        // Customize array...

        return $array;
    }
 }
```

### 5. Sử dụng

 Sau khi cài đặt và cấu hình Scout, chúng ta có thể bắt đầu tìm kiếm bằng phương thức `search()` với param truyền vào là 1 single string:

```PHP
 // Get all records from Model Post that match the term "Mancheste United"
 Post::search('Mancheste United')->get();

 // Get all records from Model Post that match the term "Mancheste United",
 // limited to 20 per page and reading the ?page query parameter,
 // just like Eloquent pagination
 Post::search('Mancheste United')->paginate(20);

 // Get all records from Model Post that match the term "Mancheste United",
 // and have an author_id field set to 2
 Review::search('Llew')->where('author_id', 2)->get();

 // Get all records from Model Post that match the value of $request->key,
 Post::search($request->key)->get();
```

 Một số trường hợp đặc biệt:

```PHP
 // Pause Indexing
 Post::withoutSyncingToSearch(function () {
    // Perform model actions...
 });

 // Index to all records
 Post::all()->searchable();

 // Index through relationship
 $author->posts()->searchable();

 // Un-index records
 Post::where('views_count', '<' , 10)->unsearchable();
```

 Nguồn tham khảo: https://laravel.com/docs/5.3/scout

----
