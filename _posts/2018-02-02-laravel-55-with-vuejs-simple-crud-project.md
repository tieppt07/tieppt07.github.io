---
layout: post
title: Laravel 5.5 with VueJS - Simple CRUD Project
---

## Laravel 5.5 VueJS Preset
Laravel 5.5 có các Frontend Preset là VueJS, ReactJS, AngularJS và None. Trong bài viết này chúng ta sẽ sử dụng VueJS Preset để sử dụng VueJS trong Laravel app.

## Cài đặt Laravel 5.5
Tạo mới laravel project sử dụng `composer` command:
```
composer create-project --prefer-dist laravel/laravel LaravelVue
```
Cấu hình Database trong file `.env`:
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel_vuejs_db
DB_USERNAME=root
DB_PASSWORD=root
```
Migrate dữ liệu với `command`, chúng ta được 2 bảng mặc định `users` và `password_resets`:
```
php artisan migrate
```
Tạo Route và Api Controller:
```php
// Route
Route::get('users', function () {
    return view('user.blade.php');
});
Route::group(['prefix' => '/v1', 'namespace' => 'Api\V1', 'as' => 'api.'], function () {
    Route::resource('users', 'UsersController', ['except' => ['create', 'edit']]);
});
```
```php
<?php 
namespace App\Http\Controllers\Api\V1;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CompaniesController extends Controller
{
    public function index()
    {
        return response()->json([
            'status' => true,
            'users' => User::all(),
        ]);
    }

    public function show($id)
    {
        return response()->json([
            'status' => true,
            'user' => User::findOrFail($id),
        ]);
    }

    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);
        $user->update($request->all());

        return response()->json([
            'status' => true,
            'user' => $user,
        ]);
    }

    public function store(Request $request)
    {
        $user = User::create($request->all());

        return response()->json([
            'status' => true,
            'user' => $user,
        ]);
    }

    public function destroy($id)
    {
        $user = User::findOrFail($id);
        $user->delete();
        return response()->json([
            'status' => true,
        ]);
    }
}
```
Trong view `home.blade.php` của Laravel thêm tag:
```php
@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="panel panel-default">
                    <div class="panel-heading">Users</div>

                    <div class="panel-body">
                        <user-component></user-component>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

```
OK, phần API đến đây là ngon lành, ta có thể test luôn với `Postman`. Tiếp theo ta sẽ đến phần Vue.js
## Cài đặt Preset VueJS
Như đã nói ở trên chúng ta cài đặt VueJS Preset bằng command:
```
php artisan preset vue
```
Để compile assets, chúng ta sử dụng command:
```
npm install && npm run dev
```
Cài thêm `vue-resource` package để có thể gọi api:
```js
this.$http.get
this.$http.post
...
```
Bắt đầu code VueJS trong file `resources/assets/js/app.js`:
```js
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component('example', require('./components/Example.vue'));
Vue.component('user-component', require('./components/User.vue'));

const app = new Vue({
    el: '#app'
});
```
Tạo file `resources/assets/js/components/User.vue`:
* Hiển thị danh sách users:
    ```html
    <template>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="user in users.data">
                    <td>{{ user.name }}</td>
                    <td>{{ user.username }}</td>
                    <td>{{ user.email }}</td>
                    <td class="text-center">
                        <button class="btn btn-warning btn-xs" @click="showUser(user.id)" data-toggle="modal" data-target=".form-user">Edit</button>
                        <button class="btn btn-danger btn-xs" :disabled="!cannotDelete(user.id, user.role)" @click="deleteUser(user.id)">Delete</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </template>

    <script>
        export default {
            data() {
                return {
                    selectedUser: {
                        id: '',
                        name: '',
                        username: '',
                        email: '',
                    },
                    users: [],
                }
            },
            getList(page = 1, key = null) {
                this.$http.get('/api/users?page=' + page + '&key=' + key).then(response => {
                    this.key = key;
                    this.users = response.data.users;
                    this.page = response.data.users.current_page;
                });
            }
        }
    </script>
    ```
* Thêm chức năng thêm/sửa user trong file `resources/assets/js/app.js`:
    ```html
    <div class="modal fade form-user" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="gridSystemModalLabel">User</h4>
                </div>
                <div class="modal-body">
                    <form action="#" v-on:submit.prevent="">
                        <div class="row">
                            <div class="col-sm-6 form-group" >
                                <label for="username" class="control-label">Username</label>
                                <input type="text" v-model="newUser.username" name="username" class="form-control" maxlength="15">
                            </div>
                            <div class="col-sm-6 form-group">
                                <label for="name" class="control-label">Name</label>
                                <input type="text" v-model="newUser.name" name="name" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-6 form-group">
                            <label for="name" class="control-label">Name</label>
                            <input type="text" v-model="newUser.name" name="name" class="form-control">
                        </div>
                        <button type="button" class="btn btn-primary" v-show="!edit" @click="createUser">Create</button>
                        <button type="button" class="btn btn-primary" v-show="edit" @click="updateUser(newUser.id)">Update</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </form>
                </div>
            </div>
        </div>
    </div> <!-- modal -->

    updateUser(id) {
        this.$http.patch('/api/users/' + id, this.newUser).then(response => {
                this.getList();
        });
    },
    createUser() {
        this.$http.post('/api/users', this.newUser).then(response => {
                this.getList();
        });
    }
    ```
   
Bạn có thể truy cập vào đường dẫn http://localhost:8000/users để xem thành quả :) Các bạn có thể tìm hiểu vào tham khảo thêm tại [Laravel](https://laravel.com/docs/5.5/frontend#writing-vue-components) và [VueJS](https://vuejs.org/v2/guide/)