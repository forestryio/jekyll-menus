# Jekyll Menus

Complex menus for Jekyll.

## Usage

You can create `_data/menu.yml`, `_data/menus.yml`, or both, or add menu items
via your front-matter. Both are merged into the same menus so you can even
split off menus between the two, so that you can have menus that have
internal and external links! Just make sure the identifiers match.

### Front-Matter Examples
#### String Key Menu Item

```yml
---
menus: main
---
```

The above configuration will infer all data (url, title, identifier, weight)
from your page data, the default weight is "-1" and the identifier is made from
the pages slug, which Jekyll itself generates.  It will also place the page
on the "main" menu on your behalf after inferring said data.

#### Array of String Key Menu Items

```yml
---
menus:
  - header
  - footer
---
```

The above configuration will infer all data (url, title, identifier, weight)
from your page data, the default weight is "-1" and the identifier is made from
the pages slug, which Jekyll itself generates.  It will also place the page
on the "header", and "footer" menus after inferring said data.

#### Hash with Key as Identifier

```yml
---
menus:
  main:
    url: "/custom-url"
---
```

The above will place a menu on "main" and override the URL for you inferring
the rest of the data on your behalf.  You can add multiple keys with hashes
if you wish to place the item on multiple menus, and you can override as much
as you wish at that time.  ***Data is not inferred between items, so if you
override in one you must override in all, or the default values will be
used.***

### `_data/menu.yml`, `_data/menus.yml`

***All data within menu(s).yml must provide url, title, identifier, and
weight (actually weight is optional)***

Menu items within data files must follow a key array format, or a key hash
format, we do not accept string formats because we do not infer data, it's
impossible to infer such data efficiently and the data files are mostly built
for you to add external links or links to other parts of your site that are
considered sub-domains.  Examples:

```yml
main:
  - title: Title
    identifier: title
    url: url
```

```yml
main:
  title: Title
  identifier: title
  url: url
```

***It should be noted that _data/menu.yml and _data/menus.yml are both read
and merged, so you can have one, or both... we won't judge you if you happen
to use both of these files at once, it's your choice!***

### Custom Menu Data

You can add any amount of custom data you wish to an item, we do not remove
data, and we do not block it, we will pass any data you wish to put into the
into the menu item.  It is up to you what data you put there, we only check
that our own keys exist, and if they don't then we fail in certain scenarios.
