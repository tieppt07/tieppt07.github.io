---
layout: post
title: RESTFUL Web API Standards
---

### 1. API là gì?
API là chữ viết tắt của Application Programming Interface (giao diện lập trình ứng dụng), nó là các cổng giúp các hệ thống có thể giao tiếp với nhau. Ví dụ khi bạn muốn lấy danh sách bạn bè trên Facebook thì đương nhiên bạn không thể nào truy vấn vào dữ liệu của Facebook được mà phải thông qua một địa chỉ mà facebook cho phép bạn lấy, ta gọi đây là Facebook API. Vậy làm thế nào để viết API theo chuẩn RESTFUL?

### 2. RESTFUL URLs & actions
* Một URL định danh một tài nguyên hệ thống (resource)

    | Resource | GET | POST | PUT | DELETE |
    | -------- | -------- | -------- | -------- | -------- |
    || READ | CREATE | UPDATE | DELETE |
    | cars     | Lấy thông tin danh sách xe     | Tạo 1 xe mới | Cập nhật tất cả xe | Xoá toàn bộ xe   |
    | cars/2 | Trả về thông tin của xe được chọn | N/A     | Cập nhật 1 xe được chọn     | Xoá xe được chọn   |

* URL nên sử dụng danh từ, không dùng động từ.
    * Sử dụng danh từ:
        http://example.com/cars
        http://example.com/cars/1
    * Không sử dụng động từ:
        http://example.com/getAllCars
        http://example.com/createNewCar
        http://example.com/deleteAllRedCars

* Không trộn lẫn cả danh từ số ít và số nhiều. Chỉ sử dụng danh từ số nhiều cho tất cả các tài nguyên.
    * Nên:
               http://example.com/cars
               http://example.com/cars/1
               http://example.com/dogs
    * Không nên:
               http://example.com/car
               http://example.com/car/1
               http://example.com/dog

* Sử dụng sub-resource cho các mối quan hệ
        GET /cars/711/drivers (lấy danh sách tài xế của xe 711)
        GET /cars/711/drivers/4 (lấy thông tin tài xế #4 của xe 711)

* Sử dụng HTTP verbs (GET, POST, PUT, DELETE) để thực thi trên các collections và elements.
* Để phiên bản (version number) tại base URL. Ví dụ: http://example.com/v1/path/to/resource.
* URL v. header:
    * Nếu nó thay đổi logic bạn viết để tổ chức trả về (response), đặt nó trong URL.
    * Nếu nó không thay đổi logic cho mỗi response như thông tin Oauth, đặt nó trên header.

* Good URLs
    * Danh sách categories:
        GET http://www.example.com/api/v1/categories
    * Filter như một query:
        GET http://www.example.com/api/v1/categories?year=2016&sort=desc
        GET http://www.example.com/api/v1/categories?tag=api&year=2016
    * Tất cả các posts thuộc category này:
        GET http://www.example.com/api/v1/categories/1234/posts
    * Thêm một article cho một category cụ thể:
        POST http://example.com/api/v1/categories/1234/posts

* Bad URLs
    * Dùng danh từ số ít:
    http://www.example.com/category
    http://www.example.com/category/1234
    http://www.example.com/category/1234/post/3
    * Sử dụng động từ trong URL:
    http://www.example.com/category/1234/create
    * Filter bên ngoài query string
    http://www.example.com/magazines/2011/desc

### 3. Responses
* Không để giá trị `values` trong khóa `keys`
* Thông tin mở rộng (`metadata`) nên chỉ chứa những thuộc tính của các gói dữ liệu trả về, chứ không phải thuộc tính của những thành phần có trong gói dữ liệu đó. Ví dụ không trả về thông tin của type của category trong tập results.

```json
    {
        "metadata": {
            "total": 200,
            "per_page": 2,
            "current_page": 1,
            "last_page": 20,
            "next_page_url": "http://example.com/api/posts?page=2&limit=2&offset=2",
            "prev_page_url": null,
            "from": 5,
            "to": 6,
        },
        "data": [
            {
                "id": "1234",
                "category": "sport",
                "title": "Public Water Systems",
                "tags": [
                    {"id": "125", "name": "Environment"},
                    {"id": "834", "name": "Water Quality"}
                ],
                "created": "1231621302"
            },
            {
                "id": 2351,
                "category": "school",
                "title": "Public Schools",
                "tags": [
                    {"id": "125", "name": "Elementary"},
                    {"id": "834", "name": "Charter Schools"}
                ],
                "created": "126251302"
            }
        ]
    }
```


* Không nên để giá trị `values` nằm trong khoá `keys`:

```json
"tags": [
    {"125": "Environment"},
    {"834": "Water Quality"}
],
```

### 4. Tổ chức lỗi với HTTP status code

* 200 – OK
* 400 – Bad Request
* 401 – Unauthorized
* 403 – Forbidden
* 404 – Not found
* 422 – Unprocessable Entity
* 500 – Internal Server Error

```json
{
    "status": false,
    "code": 404
}
```

### 5. Vesions
* Không release một API mà không có một số  xác định phiên bản (version number).
* Các phiên bản nên là số tự nhiên, không dùng số thập phân, với prefix là v. Ví dụ:
        Good: v1, v2, v3
        Bad: v-1.1, v1.2, 1.3
* Bảo trì APIs ít nhất một phiên bản trở về trước.

### 6. Ví dụ Request & Response (Resouce CRUD users)
* GET: http://example.com/api/v1/users?limit=2 (Danh sách users)

```json
// Response
{
    "total": 4,
    "per_page": "2",
    "current_page": 1,
    "last_page": 2,
    "next_page_url": "http://localhost:8000/api/users?page=2",
    "prev_page_url": null,
    "from": 1,
    "to": 2,
    "data": [
        {
            "id": 1,
            "username": "admin",
            "email": "admin@retailstore.com",
            "role": 0,
            "display_name": "Admin",
            "last_store": null,
            "created_at": "2017-01-19 23:00:33",
            "updated_at": "2017-01-19 23:00:33",
            "deleted_at": null
        },
        {
            "id": 2,
            "username": "tieppx",
            "email": "tiep@retailstore.com",
            "role": 1,
            "display_name": "Tiep",
            "last_store": null,
            "created_at": "2017-01-19 23:00:33",
            "updated_at": "2017-01-19 23:00:33",
            "deleted_at": null
        }
    ]
}
```
* GET: http://example.com/api/v1/users/1 (Danh sách user #1)

```json
{
    "success": true,
    "user": {
        "id": 1,
        "username": "admin",
        "email": "admin@retailstore.com",
        "role": 0,
        "display_name": "Admin",
        "last_store": null,
        "created_at": "2017-01-19 23:00:33",
        "updated_at": "2017-01-19 23:00:33",
        "deleted_at": null
    }
}
```

 * POST: http://example.com/api/v1/users (Tạo user mới)

```json
// Request
{
    "username": "tiep",
    "email": "tiep@rs.com", ,
    "role": 0,
    "display_name": "tiep",
    "password": "secret"
}

// Response
{
    "success": true,
    "user": {
        "username": "tiep",
        "email": "tiep@rs.com",
        "role": "0",
        "display_name": "tiep",
        "updated_at": "2017-02-26 16:00:43",
        "created_at": "2017-02-26 16:00:43",
        "id": 5
    }
}
```

* PATCH/PUT: http://example.com/api/v1/users/5 (Sửa user #1)

```json
// Request
{
    "username": "tieppt",
    "email": "tiep123@rs.com", ,
    "role": 0,
    "display_name": "tiep",
    "password": "secret"
}

// Response
{
    "success": true,
    "user": {
        "id": 5,
        "username": "tieppt",
        "email": "tiep123@rs.com",
        "role": "0",
        "display_name": "tiep",
        "updated_at": "2017-02-26 16:00:43",
        "created_at": "2017-02-26 16:00:43"
    }
}
```

* DELETE: http://example.com/api/v1/users/1 (Xoá user #1)

```json
// Response
{
    "success": true
}
```


Link tham khảo:
* [https://www.infosys.com/digital/insights/Documents/restful-web-services.pdf](https://www.infosys.com/digital/insights/Documents/restful-web-services.pdf)
* [http://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/](http://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/)

----
