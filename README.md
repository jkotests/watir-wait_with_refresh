Watir::WaitWithRefresh
==============

Watir::WaitWithRefresh extends Watir to include methods that will refresh the page until or while an element is present or a block is true.

Usage
-----------

Refresh the page until an element is present:

```ruby
 element.refresh_until_present
```

Refresh the page while an element is present:

```ruby
element.refresh_while_present
```

Do something after refreshing the page makes the element present:

```ruby
element.when_present_after_refresh.text
```

Refresh the page until a block evaluates as true:

```ruby
browser.refresh_until{ browser.div.present? }
```

Refresh the page while a block evaluates as true:

```ruby
browser.refresh_while{ browser.div.present? }
```