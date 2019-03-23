---
layout: post
title: Cài đặt Laravel Homestead bằng Vagrant Box trên Ubuntu
---

Laravel homestead cung cấp môi trường lập trình hoàn hảo cho lập trình viên, được hỗ trợ chính thức bởi Laravel. Vậy các bước cài đặt ra sao, cùng mình tìm hiểu nhé :)

### Vagrant là gì?

Vagrant là một sản phẩm của HashiCorp, nó là một công cụ giúp chúng ta xây dựng môi trường phát triển. Hiểu đơn giản thì vagrant sẽ là cầu nối giữa máy tính cá nhân của chúng ta và máy ảo. Chúng ta vẫn code trên máy chúng ta như bình thường, và vagrant sẽ tự động đồng bộ nó với máy ảo, và máy ảo sẽ làm nhiệm vụ biên dịch và thông dịch.

### 1. Cài đặt Virtual-box

Link tải Virtual-box: https://www.virtualbox.org/wiki/Downloads

### 2. Cài đặt Vagrant

Link tải Vagrant: https://www.vagrantup.com/downloads.html

### 3. Cài đặt Homestead

#### 3.1. Add box Vagrant

```sh
$ vagrant box add laravel/homestead
```

![Untitled.png](/uploads/5a71eab9-00e6-48bf-b17e-393ae577cbb0.png)

#### 3.2. Clone và cấu hình Homestead

```sh
$ cd ~
$ git clone https://github.com/laravel/homestead.git Homestead
```

Nếu bạn chưa cài đặt Git thì gõ lệnh sau để cài đặt:

```sh
$ sudo apt-get install git
```

Cấu hình Homestead

```sh
$ cd Homestead
```

Tạo file Homestead.yaml nằm trong thư mục ~/.homestead

```sh
$ bash init.sh
```

Tạo ssh key

```sh
$ cd ~/.ssh
$ ssh-keygen -t rsa -C "you@homestead"
```

### 4. Tạo 1 ví dụ project Laravel

1. Tạo folder project để chứa source code

```sh
$ cd ~
```

```sh
$ sudo mkdir project
```

2. Tạo 1 project laravel trong thư mục project vừa tạo

```sh
$ cd project
```

```sh
$ composer create-project laravel/laravel laravel --prefer-dist
```

3. Cấu hình file Homestead.yaml

```sh
$ cd ~
```

```sh
$ sudo vi .homestead/Homestead.yaml
```

File > .homestead/Homestead.yaml

![Capture.PNG](/uploads/0a577734-64f5-451f-9b16-7414415ccdd3.png)

Nhìn qua chắc bạn cũng có thể hình dung ra, mọi thứ trong `~/project` trên máy thật sẽ được đồng bộ với `/home/vagrant/project` trên máy ảo.

`192.168.10.10` chính là ip của máy ảo, bạn có thể đổi tuỳ ý, miễn là không bị trùng với local của bạn là được.

4. Mở file /etc/hosts lên và thêm vào dòng này vào cuối file:

`192.168.10.10  bloglaravel.app`

Vậy là xong, giờ chúng ta đã có môi trường ngon lành để làm việc với đầy đủ các công cụ, dịch vụ cần thiết mà không cần mất công đi cài đặt từng cái một, config từng cái một.

Giờ thì bật trình duyệt lên và gõ đường link: `bloglaravel.app`

![Screenshot from 2016-05-21 12-34-22.png](/uploads/76e338a8-76cf-4dfb-ba87-d0531732379a.png)

Một số câu lệnh làm việc với Vagrant:

- `vagrant up` #Khởi động máy ảo

- `vagrant reload` #Restart máy ảo

- `vagrant halt` #Tắt máy ảo

- `vagrant ssh` #Truy cập máy ảo qua ssh

----
