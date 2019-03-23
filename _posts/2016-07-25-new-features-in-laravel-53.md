---
layout: post
title: New Features in Laravel 5.3
---

### 1. The new `$loop` variable
In 5.3, the `@foreach` directive is getting a bit of a superpower, in the form of a new `$loop` variable that will be available inside every `@foreach` loop.

The `$loop` variable is a stdClass object that provides meta information about the loop you're currently inside. Take a look at the properties it exposes:

- _index_: the 1-based index of the current item in the loop; 1 would mean "first item"
- _remaining_: how many items remain in the loop; if current item is first of three, would return 2
- _count_: the count of items in the loop
- _first_: boolean; whether this is the first item in the loop
- _last_: boolean; whether this is the last item in the loop
- _depth_: integer; how many "levels" deep this loop is; returns 1 for a loop, 2 for a loop within a loop, etc.
- _parent_: if this loop is within another @foreach loop, returns a reference to the $loop variable for the parent loop item; otherwise returns null
Most of this is pretty self-explanatory; it means you can do something like this:

```PHP
<ul>
    @foreach ($pages as $page)
       <li>{{ $page->title }} ({{ $loop->index }} / {{ $loop->count }})</li>
    @endforeach
</ul>
```

But you also get a reference to parent `$loop` variables when you have a loop-within-a-loop. You can use depth to determine whether this is a loop-within-a-loop, and parent to grab the `$loop` variable of its parent. That opens up templating options like this:

```PHP
<ul>
    @foreach ($pages as $page)
        <li>{{ $loop->index }}: {{ $page->title }}
            @if ($page->hasChildren())
            <ul>
            @foreach ($page->children() as $child)
                <li>{{ $loop->parent->index }}.{{ $loop->index }}:
                    {{ $child->title }}</li>
            @endforeach
            </ul>
            @endif
        </li>
    @endforeach
</ul>
```

### 2. Customizing additional parameters in `FirstOrCreate`

 This is an update to the Eloquent firstOrCreate method. If you've never used it before, you can pass an array of values to firstOrCreate and it will look up whether a record exists with those properties. If so, it'll return that instance; if not, it'll create it and then return the created instance.

Here's an example:

```PHP
$tag = Tag::firstOrCreate(['slug' => 'matts-favorites']);
```

This is good. It's very useful. But.
What if the tag with the slug matts-favorites represents a tag with the label Matts favorites?

```PHP
$tag = Tag::firstOrCreate(['slug' => 'matts-favorites', 'label' => 'Matts Favorites']);
```

OK, that worked well. But now, imagine this scenario: you want to create a tag with slug of matts-favorites and label of Matt's favorites unless there's already a tag with slug matts-favorites, in which case you just want that tag—even if it doesn't give you the label you want? Check it:

```PHP
$tag = Tag::firstOrCreate(
    ['slug' => 'matts-favorites'],
    ['label' => "Matt's Favorites"]
);
```

### 3. Shortcut global helpers

 I noticed a pattern in the global helper functions like session() and, in some ways, cookie(). There are three primary functions that they can perform: get a value, put a value, or return an instance of their backing service.

For example:
- `session('abc', null)` gets the value of abc, or an optional fallback of null.
- `session(['abc' => 'def'])` sets the value of abc to def.
- `session()` returns an instance of the SessionManager.

The third option means you can use `session()->all()` (or any other methods) just like you would `Session::all()`.

Like `session()`, the `cache()` global helper can perform three primary functions: get, put, or return an instance of the backing service.

For example:

- `cache('abc', null)` gets the cached value of abc, or an optional fallback of null.
- `cache(['abc' => 'def'], 5)` sets the value of abc to def, for the duration of 5 minutes.
- `cache()` returns an instance of the CacheManager.
The third option means you can use `cache()->forever()` (or any other methods) just like you would `Cache::forever()`.

### 4. Advanced operations with `Collection::where`

 If you want to filter a Laravel collection to only those records which meet particular criteria, you're most likely going to reach for filter() or reject(). For a quick refresh, this is how you might use both:

```PHP
$vips = $people->filter(function ($person) {
    return $person->status === 'vip';
});

$nonVips = $people->reject(function ($person) {
    return $person->status === 'vip';
});
```

You might not know it, but there's also a where() method that's pretty simple that gives you the same functionality:

```PHP
$vips = $people->where('status', 'vip');
```

Prior to 5.3, this would check strictly (===), just like in our examples above.

In 5.3, that same line is now a loose check (==), but you can also customize the comparison operator. That makes all of this possible:

```PHP
$nonVips = $people->where('status', '!==', 'vip');
$popularPosts = $posts->where('views', '>', 500);
$firstTimeUsers = $people->where('logins', '===', 1);
```

That's it! Enjoy!

Source: https://mattstauffer.co/blog/series/new-features-in-laravel-5-3

----
