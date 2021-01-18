---
app_slug: test-app
layout: app-section
---

Test App Press Kit

This is a demo of all styled elements in Jekyll Now.

[View the markdown used to create this post](https://raw.githubusercontent.com/barryclark/www.jekyllnow.com/gh-pages/_posts/2014-6-19-Markdown-Style-Guide.md).

This is a paragraph, it's surrounded by whitespace. Next up are some headers, they're heavily
influenced by GitHub's markdown style.

## Header 2 (H1 is reserved for post titles)##

### Header 3

#### Header 4

A link to [Jekyll Now](http://github.com/barryclark/jekyll-now/). A big ass literal link
<http://github.com/barryclark/jekyll-now/>

An image, located within /images

![an image alt text]({{ site.baseurl }}/images/jekyll-logo.png "an image title")

- A bulletted list

* alternative syntax 1

- alternative syntax 2
  - an indented list item

1. An
2. ordered
3. list

Inline markup styles:

- _italics_
- **bold**
- `code()`

> Blockquote
>
> > Nested Blockquote

Syntax highlighting can be used with triple backticks, like so:

```javascript
/* Some pointless Javascript */
var rawr = ['r', 'a', 'w', 'r'];
```

Use two trailing spaces  
on the right  
to create linebreak tags

Finally, horizontal lines

---

---

**Hello world**, this is my first Jekyll blog post.

I hope you like it!

# Highlighter

## Ruby

```ruby
def show
  puts "Outputting a very lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong line"
  @widget = Widget(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @widget }
  end
end
```

## Php

```php
<?php
  print("Hello {$world}");
?>
```

## Java

```java
public class java {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```

## HTML

```html
<html>
  <head>
    <title>Title!</title>
  </head>
  <body>
    <p id="foo">Hello, World!</p>
    <script type="text/javascript">
      var a = 1;
    </script>
    <style type="text/css">
      #foo {
        font-weight: bold;
      }
    </style>
  </body>
</html>
```

## Console

```console
# prints "hello, world" to the screen
~# echo Hello, World
Hello, World

# don't run this
~# rm -rf --no-preserve-root /
```

## Css

```css
body {
  font-size: 12pt;
  background: #fff url(temp.png) top left no-repeat;
}
```

## Yaml

```yaml
---
one: Mark McGwire
two: Sammy Sosa
three: Ken Griffey
```
