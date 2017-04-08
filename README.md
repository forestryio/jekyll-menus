# Jekyll Menus

Complex, and infinite Hugo-like menus for Jekyll.

## Usage

In Jekyll Menus you can create `_data/menus.yml`, or add menu items via your front-matter in pages as well! Both are merged into the same menus if the identifiers match so you can even split off menus between the two, and so that you can have menus that have internal and external links.

### Setup

Add Jekyll Menus to your `Gemfile`:
```yaml
  gem "jekyll-menus"
```
Then add the following to your `_config.yml` file:

```yaml
gems:
  - jekyll-menus
```



### Front-Matter Examples
#### Using a String key to add an item to the menu

You can add an item to any menu by simply doing `menus: identifier` inside of your front-matter. If you do it this way, the string is the identifier (the menu you wish to place the item on) and all the other data is inferred from Jekyll, such as the items own identifier (take from the files slug,) title, and it defaults the weight to `-1` for you, making it so that your menu item is pretty much automatic aside from needing to add itself.

##### Example

```yml
---
menus: main
---
```

#### Using an array to add an item to multiple menus

Like string keys, you can create an array of string keys, that allows you place an item on multiple identifiers at once, and like the string version, it will infer the data from Jekyll.

##### Example

```yml
---
menus:
  - header
  - footer
---
```

#### Adding a menu item with data

Jekyll Menus uses the keys, `title`, `weight`, `identifier` (slug), and `url`, you can customize said data and even add your own data, to do that you make the menu item hash with the data and any data you do not override is inferred like the other ways to add menu items.  And like adding it to multiple identifiers with an array, you can do the same here by turning menus into an array and adding multiple hashes.

##### Examples

```yml
---
menus:
  main:
    url: "/custom-url"
---
```

```yaml
menus:
  - header
  - main:
      url: "/custom-url"
```

### Using `_data/menus.yml`

***All data within _menus.yml must provide `url`, `title`, `identifier`, with `weight` being optional.***

Menu items within data files must follow a key array format, or a key hash format, we do not accept string formats because we cannot infer data and to do so would be pretty expensive.

#### Examples

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

***It should be noted that _data/menus.yml are both read and merged, so you can have one, or both... we won't judge you if you happen to use both of these files at once, it's your choice!***

### Adding menu items to menu items

In Jekyll-Menus each item has it's own identifier (slug) that identifier can be used to have other items on it, and is used to find associated menus.  So you can create your own base identifiers (like header, footer, main or otherwise) and each item on that has it's own identifier.

So given you have a file called `about.html` or `about.md`, and you do the following:

```yaml
menus: main
```

and, then you have `about/person.md`, you can add that to the `about` item with the following front-matter:

```yaml
menus: about
```

... Because `about.md` didn't have it's own identifier, the identifier was extracted from the page name (slug) so the identifier would be `about`, if you have `my-custom-page.md` or `my_custom_page.md` then the identifiers would be those without the file extension.

#### Customizing the identifier on an item

You can customize the identifier on any item (the base identifiers are already custom as you have to create them yourself by adding an item onto an identifier that doesn't exist.)  To customize the identifier you just add the identifier key like the following:

```
menus:
  main:
    identifier: my-identifier
```

At that point, you can add sub-menus or items onto that identifier by using it as the identifier for in your front-matter (or even inside of your data files if it really pleases you.)

### Custom Menu Data

You can add any amount of custom data you wish to an item, we do not remove
data, and we do not block it, we will pass any data you wish to put into the
into the menu item.  It is up to you what data you put there, we only check
that our own keys exist, and if they don't then we fail in certain scenarios.

#### Example

```
menu:
  main:
    weight: 4
    customData: value
```

## Outputting the menu's
### A basic menu

Given you have several pages with the following:

```yaml
menu: header
```

You can output those with the following:

```html
<header>
  <nav>
    <ul>
      {% for item in site.menus.header %}
        <li><a href="{{ item.url }}">
          {{ item.title }}
        </a></li>
      {% endfor %}
    </ul>
  </nav>
</header>
```

### Recursive Menu output

If you want to output recursive menus efficiently you should start working with an include, so you can recurse on that include and have infinite menus if you ***really*** want.

#### Example

`_includes/menus.html`

```html
<ul>
  {% for item in menu %}
    <li>
      <span>
        <a href="{{ item.url }}">
          {{ item.title }}
        </a>
      </span>

      {% if item.children %}
        {% assign menu = item.children %}
        {% include
          _menus.html
        %}
      {% endif %}
  {% endfor %}
</ul>
```

`_layouts/default.html`

```html
<html>
  <body>
    <header>
      <nav>
        {% assign menu = site.menus.main %}
        {% include
          _menus.html
        %}
      </nav>
    </header>

    {{ content }}
  </body>
</html>
```
