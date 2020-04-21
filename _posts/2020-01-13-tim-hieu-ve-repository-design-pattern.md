---
layout: post
title: Tìm hiểu về Repository Design Pattern
---

Design patterns là các giải pháp đã được tối ưu hóa, được tái sử dụng cho các vấn đề lập trình mà chúng ta gặp phải hàng ngày. Nó là một khuôn mẫu đã được suy nghĩ, giải quyết trong tình huống cụ thể rồi.
Repository Pattern là một mẫu thiết kế trong design pattern.

### Repository Design Pattern

Trong bài viết này, tôi cùng các bạn sẽ cùng nhau thảo luận về `Repository Pattern` nhưng trước hết hãy cùng nhau tìm hiểu qua về `Design Pattern`

### Design Pattern là gì?

- `Design Pattern` là một kỹ thuật trong lập trình hướng đối tượng, cung cấp cho chúng ta cách tư duy trong các tình huống xảy ra của lập trình hướng đối tượng cũng như trong quá trình phân tích thiết kế và phát triển phần mềm. Vì vậy Design Pattern không phải là một Class, cũng không phải là một Library, và cũng không hề là một ngôn ngữ cụ thể nào cả.
- `Design Pattern` cung cấp cho chúng ta các mẫu thiết kế, các giải pháp cho các vấn đề chung thường gặp trong lập trình, đảm bảo sẽ cung cấp cho chúng ta các giải pháp tối ưu trong việc giải quyết các vấn đề trong lập trình.

### Phân loại Design Pattern

#### Design Pattern được chia làm 3 nhóm chính:

- Nhóm khởi tạo (Creational): giúp chúng ta trong việc khởi tạo các đối tượng, cung cấp các thủ thuật để khởi tạo đối tượng mà không cần đến từ khóa new. VD: Abstract Factory, Factory Method, Singleton, Builder, Prototype...
- Nhóm cấu trúc (Structural): thường dùng để giải quyết mối quan hệ giữa các thực thể (entities), giúp thao tác với các đối tượng dễ dàng hơn. VD: Adapter, Bridge, Composite, Decorator, Facade, Proxy và Flyweight...
- Nhóm hành vi (Behavioral): dùng trong việc thể hiện các hành vi của đối tượng, tương tác (communicate) giữa các đối tượng dễ dàng hơn. VD: Interpreter, Template Method, Chain of Responsibility, Command, Iterator, Mediator, Memento, Observer, State, Strategy và Visitor...

### Vì sao nên sử dụng Design Pattern?

- Design Pattern cung cấp cho chúng ta các giải pháp ở dạng tổng quát nhất, giúp chúng ta tăng tốc độ phát triển phần mềm thông qua các mô hình đã được kiểm nghiệm thực tế.
- Sử dụng Design Pattern giúp chúng ta tránh được các lỗi tiềm ẩn (nhất là trong những hệ thống lớn), đồng thời có khả năng tái sử dụng cao để có thể dễ nâng cấp và bảo trì trong tương lai.

### Repository Pattern là gì?

- Repository Pattern là lớp trung gian giữa tầng Business Logic và Data Access, giúp cho việc truy cập dữ liệu chặt chẽ và bảo mật hơn.
- Repository đóng vai trò là một lớp kết nối giữa tầng Business và Model của ứng dụng.
- Thông thường thì các phần truy xuất, giao tiếp với database năm rải rác ở trong code, khi bạn muốn thực hiện một thao tác lên database thì phải tìm trong code cũng như tìm các thuộc tính trong bảng để xử lý. Điều này gây lãng phí thời gian và công sức rất nhiều.
- Với Repository design pattern, thì việc thay đổi ở code sẽ không ảnh hưởng quá nhiều công sức chúng ra chỉnh sửa.
- Một số lý do chung ta nên sử dụng Repository Pattern:
  - Một nơi duy nhất để thay đổi quyền truy cập dữ liệu cũng như xử lý dữ liệu.
  - Một nơi duy nhất chịu trách nhiệm cho việc mapping các bảng vào object.
  - Tăng tính bảo mật và rõ ràng cho code.
  - Rất dễ dàng để thay thế một Repository với một implementation giả cho việc testing, vì vậy bạn không cần chuẩn bị một cơ sở dữ liệu có sẵn.
  - Hãy cùng nhau tìm hiểu thêm về Repository qua ví dụ cụ thể để có thể hình dung dễ hơn. Tôi sẽ sử dụng sự trợ giúp của Laravel để mô tả rõ hơn. Các bạn nên lưu ý Laravel hay các MVC Framework khác đều có thể áp dụng ý tưởng của Repository.

### Controller không sử dụng Repository

Trong những ứng dụng MVC điển hình, việc thực hiện CRUD với một resource bất kỳ như sau:

```php
<?php

namespace Acme\Controllers;

use Acme\Models\Post;

class PostController extends BaseController 
{
  public function index()
  {
    $posts = Post::paginate(20);
    return View::make('post.index', compact('posts'));
  }

  public function show($id)
  {
    $post = Post::findOrFail($id);
    return View::make('post.show', compact('post'));
  }
}
```

Chúng ta thấy code rất dễ đọc và chặt chẽ, tuy nhiên có một vấn đề cần chú ý ở đây đó là Controller được gắn chặt với Model dùng để thực hiện các thao tác với Cơ sở dữ liệu (database). Điều này gây ra 2 vấn đề nghiêm trọng như sau nếu ta không để ý:

- Chúng ta không thể viết Test cho Controller.
- Controller vô hình chung đã bị gắn chặt với ORM Layer, nếu trong tương lai chúng ta muốn thay đổi cấu trúc bảng hay thực hiện giải pháp nào đó tái cấu trúc, chúng ta sẽ gặp khó khăn trong việc phải tìm lại toàn bộ các controller và sửa.

### Giải pháp sử dụng Repository

Để giải quyết 2 vấn đề nghiêm trọng nêu ở trên, giải pháp đưa ra đó là Repository. Chúng ta sẽ có một lớp trừu tượng ngay trên tầng Cơ sở dữ liệu (database), bởi vậy thay vì việc Controller tương tác trực tiếp với Model, Controller sẽ làm việc với lớp Repository đã được đóng gói với các thao tác trong Model.

Lớp Repository có thể tưởng tượng như sau:

```php
<?php

namespace Acme\Storage;

use Acme\Models\Post;

class PostRepository 
{
  public function paginate($perPage = null, $columns = array('*'))
  {
    return Post::paginate($perPage, $columns);
  }

  public function findOrFail($id, $columns = array('*'))
  {
    return Post::findOrFail($id, $columns);
  }
  // ...etc
}
Và khi đó tương tác giữa Controller và Repository như sau:

<?php
namespace Acme\Controllers;

use Acme\Storage\PostRepository;

class PostController extends BaseController 
{
  private $postRepository;

  public function __construct(PostRepository $postRepository = null)
  {
    $this->postRepository = ($postRepository === null) ? new PostRepository : $postRepository;
  }

  public function index()
  {
    $posts = $this->postRepository->paginate(20);
    return View::make('post.index', compact('posts'));
  }

  public function show($id)
  {
    $posts = $this->postRepository->findOrFail($id);
    return View::make('post.show', compact('post'));
  }
}
```

Ta có thể thấy Controller hiện tại không còn thực hiện tương tác trực tiếp với Model nữa. Câu hỏi đặt ra là tại sao làm như thế này lại tốt? Liệu có phải chúng ta đang bôi thêm việc ra làm bằng cách chỉ thay việc tương tác giữa Controller với Model bằng cái cầu `Repository`?

Với những dự án quy mô nhỏ, bạn có thể thấy việc làm này thừa thãi và phải viết thêm nhiều code. Tuy nhiên với những dự án quy mô lớn với những logic phức tạp hay luôn thay đổi yêu cầu, lớp trừu tượng `Repository` này thực sự có ích cho bạn.

Nó giúp bạn dễ dàng hơn trong việc thay đổi sử dụng các loại ORM khác nhau, hoặc các kỹ thuật ở tầng Cơ sở dữ liệu khác nhau. Bạn có thể thay đổi sử dụng MongoDB thay vì MySQL hay tương tự như vậy mà không sợ ảnh hưởng quá nhiều đến việc xử lý logic ở Controller. Việc chúng ta cần làm chỉ là thực hiện thay đổi ở các lớp Repository thay vì phải đi tìm ở tất cả các Controller để thay đổi thao tác phù hợp với những thay đổi phía Model.

Một trong những lợi ích của kiến trúc này đó là chúng ta có thể dễ dang tạo các mock Repository Class trong unit tests:

```php
<?php

use Mockery as m;

class PostControllerTest extends PHPUnit_Framework_Testcase 
{
  private $postRepository;

  private $postController;

  public function setUp()
  {
    parent::setup();
    $this->postRepository = m::mock('Acme\Storage\PostRepository');

    // inject the mocked version of the repository
    $this->postController = new Acme\Controllers\PostController($this->postRepository);
  }

  public function tearDown()
  {
    m::close();
    parent::tearDown();
  }

  public function testIndex()
  {
    $this->postRepository->shoudlReceive('paginate')->once()->andReturn(array());
    $response = $this->postController->index();
    $this->assertEqual(array(), $response);
  }
}
```

### Kết luận

Repository Pattern không chỉ bị giới hạn trong Laravel hay trong PHP như những gì tôi đã trình bày ở trên, chỉ là sử dụng code PHP để mô tả sơ qua về mô hình này. Ngoài ra nó còn được sử dụng rất rộng rãi trong các kiến trúc phần mềm và được phát triển ở nhiều ngôn ngữ khác nhau.
Đây là một mô hình được đưa ra để bạn dễ dàng hơn trong việc đối ứng với những thay đổi của Cơ sở dữ liệu. Tất nhiên bạn không bắt buộc phải theo mô hình này ở tất cả các dự án bạn đang làm, bạn có thể chọn hoặc không chọn. Nhưng đây cũng được coi như là một trong những good practice nên theo quan điểm cá nhân tôi cái gì tốt mình nên follow vì dù sao mô hình này cũng đã được kiểm chứng và sử dụng khá rộng rãi.
Link tham khảo

- http://slashnode.com/the-repository-pattern/
- http://heera.it/laravel-repository-pattern

---
