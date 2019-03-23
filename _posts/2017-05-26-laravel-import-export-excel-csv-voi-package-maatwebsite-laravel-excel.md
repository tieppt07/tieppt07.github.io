---
layout: post
title: Laravel Import/Export excel, csv với package Maatwebsite/Laravel-Excel
---

# 1. Tính năng
Laravel-Excel là 1 package mang power của PHPExcel vào Laravel. Nó có các chức năng như: import dữ liệu từ file excel/csv vào collection, export models/array/view ra tệp excel, import hàng loạt files...

Các tính năng vượt trội của Laravel-Excel:
- Import vào Laravel collection.
- Import hàng loạt files.
- Export Laravel Blade views ra file excel/csv với các options css.
- Nhiều cài đặt cấu hình tuỳ chọn.
- Chunked and queued import.
- Chỉnh sửa các tệp excel.
...

Yêu cầu:
- PHP version >= 5.3.7
- Laravel >= 4.1
- PHPOffice PHPExcel >= 1.8.0 (included by composer.json).
- PHP extension php_zip enabled (required if you need PHPExcel to handle .xlsx .ods or .gnumeric files).
- PHP extension php_xml enabled.
- PHP extension php_gd2 enabled (optional, but required for exact column width autocalculation).

# 2. Cài đặt
- Requires package trong file `composer.json`:

```
// Laravel 4:
"maatwebsite/excel": "~1.3"

// Laravel 5:
"maatwebsite/excel": "~2.1.0"
```

- Chạy command `composer update`.
- Thêm `ServiceProvider` và `Alias` trong file `config/app.php`

```php
// ServiceProvider
'Maatwebsite\Excel\ExcelServiceProvider',

// Alias
'Excel' => 'Maatwebsite\Excel\Facades\Excel',
```

- Publish config file:

```sh
// Laravel 4:
// The config files can now be found at app/config/packages/maatwebsite/excel
$ php artisan config:publish maatwebsite/excel

// Laravel 5:
// The config files can now be found at config/excel.php
$ php artisan vendor:publish
```

# 3. Sử dụng

## 3.1 Import
Import 1 file

```php
    Excel::load('file.xls', function($reader) {

        // reader methods

    });
 ```

CSV Settings
cài đặt CSV options với các biến thuộc tính protected `$delimiter`, `$enclosure` and `$lineEnding`
```php
    class UserListImport extends \Maatwebsite\Excel\Files\ExcelFile {

        protected $delimiter  = ',';
        protected $enclosure  = '"';
        protected $lineEnding = '\r\n';

    }
```

Chọn sheet thao tác
```php
// 1 sheet
Excel::selectSheets('sheet1')->load();

// many sheets
Excel::selectSheets('sheet1', 'sheet2')->load();

// Chọn sheet theo indexindex
Excel::selectSheetsByIndex(0, 1)->load();
```

Lấy dữ liệu sau khi load file với hàm `get()`
```php
    Excel::load('file.xls', function($reader) {

        // get title
        $workbookTitle = $reader->getTitle();

        foreach($reader as $sheet)
        {
            // get sheet title
            $sheetTitle = $sheet->getTitle();
        }

    })->get();
```

Giới hạn đọc file
```php
    // Lấy số dòng
    $reader->takeRows(10);
    // or
    $reader->limitRows(10);

    // Skip dòng
    $reader->skipRows(10);

    // Lấy & giới hạn số cột
    $reader->takeColumns(10);
    // or
    $reader->limitColumns(10);
```

## 3.2 Export
Export 1 file đơn giản

```php
    Excel::create('Filename', function($excel) {

        // Set the title
        $excel->setTitle('Our new awesome title');

        // Chain the setters
        $excel->setCreator('Maatwebsite')
              ->setCompany('Maatwebsite');

        // Call them separately
        $excel->setDescription('A demonstration to change the file properties');

    });
```

Export và download file với `export()` or `download()`
```php
    // $ext = xls, xlsx, csv, pdf...

    Excel::create('Filename', function($excel) {

    })->export($ext);

    // or
    Excel::create('Filename', function($excel) {

    })->download($ext);
```

Custom đường dẫn export filefile
```php
Excel::create('Filename', function($excel) {

    // Set sheets

})->store($ext, storage_path('excel/exports'));
```

Export sử dụng blade view cho nhiều sheets
```php
    Excel::create('newfile.xls', function($excel) {

        $excel->sheet('sheet 1', function($sheet) {

            $sheet->loadView('view_first');
        });

        $excel->sheet('sheet 2', function($sheet) {

            $sheet->loadView('view_second');
        });

    });

    // Truyền biến ra blade view
    // Cách 1:
    $sheet->loadView('view', ['key' => 'value']);

    // Cách 2:
    $sheet->loadView('view')->with('key', 'value');

    // Cách 3:
    $sheet->loadView('view')->withKey('value');
```

Tạo file từ mảng:
```php
Excel::create('Filename', function($excel) {

    $excel->sheet('Sheetname', function($sheet) {

        $sheet->fromArray(array(
            array('data1', 'data2'),
            array('data3', 'data4')
        ));

    });

})->export($ext);
```

Styling sheet
```php
// Font family
$sheet->setFontFamily('Comic Sans MS');

// Set font with ->setStyle()`
$sheet->setStyle(array(
    'font' => array(
        'name'      =>  'Calibri',
        'size'      =>  12,
        'bold'      =>  true
    )

    $sheet->cell('A1', function($cell) {

        // Set black background
        $cells->setBackground('#000000');

        // Set font
        $cells->setFont([
            'family'     => 'Calibri',
            'size'       => '16',
            'bold'       =>  true
        ]);

        // Set all borders (top, right, bottom, left)
        $cells->setBorder('solid', 'none', 'none', 'solid');

    });
));


```

## 3.3 Styling sheet với blade view
```html
<html>
    <body>
        <!-- Horizontal alignment/big title -->
        <td align="right"><h1>Big title</h1></td>

        <!--  Vertical alignment/bold -->
        <td valign="middle"><b>Bold cell</b></td>

        <!-- Rowspan/bold -->
        <td rowspan="3"><strong>Bold cell</strong></td>

        <!-- Colspan/italic -->
        <td colspan="6"><i>Italic cell</i></td>

        <!-- Width/image -->
        <td width="100"><img src="img.jpg" /></td>

        <!-- Height/black background -->
        <td height="100" style="background-color: #000000;">Cell with height of 100</td>

        // sử dụng tag style để css
        <style>
            tr td {
                background-color: #ffffff;
            }

            tr > td {
                border-bottom: 1px solid #000000;
            }
        </style>
    </body>
</html>
```

Share view cho các sheets với hàm `shareView()`
```
    Excel::shareView('folder.view')->create();
```

Ở trên là 1 số các chức năng chính mà package `maatwebsite/excel` có thể làm được. Các bạn có thể tìm hiểu thêm ở tại:  [maatwebsite/excel](http://www.maatwebsite.nl/laravel-excel/docs)

----
