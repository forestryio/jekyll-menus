# Jekyll Menus

A robust, simple-to-use menu plugin for Jekyll that allows for infinitely nested menus.

## Installation

To install and use Jekyll Menus, you should have Ruby, and either [RubyGems](https://jekyllrb.com/docs/installation/#install-with-rubygems), or we recommend using [Bundler](https://bundler.io/#getting-started).  Bundler is what Jekyll will prefer you to use by default if you `jekyll new`.

### Using Bundler

You can add our gem to the `jekyll_plugins` group in your `Gemfile`:

```ruby
group :jekyll_plugins do
   gem "jekyll-menus"
end
```

And then install from shell.

```sh
bundle install
   # --path vendor/bundle
```

***If you are using Jekyll Docker, you do not need to perform this step, Jekyll Docker will perform it on your behalf when you launch the image, you only need to perform this step if you are working directly on your system.***

### Using RubyGems

```sh
sudo gem install jekyll-menus
sudo gem update  jekyll-menus
```

Once installed, add the Gem to your `_config.yml`:

```yaml
plugins:
- jekyll-menus
```

***Note in earlier versions of Jekyll, `plugins` should instead be `gems`***

## Usage

Jekyll Menus allows you to create menus by attaching posts and pages to menus through their front matter, or by defining custom menu items via `_data/menus.yml`.

Jekyll Menus adds a new option to the site variable called `site.menus`, which can be looped over just like pages, posts, and other content:

```liquid
<ul>
{% for item in site.menus.header %}
  <li class="menu-item-{{ loop.index }}">
    <a href="{{ item.url }}" title="Go to {{ item.title }}">{{ item.title }}</a>
  </li>
{% endfor %}
</ul>
```

## Menus via Front Matter

The easiest way to use Jekyll Menus is to start building menus using your existing posts and pages. This can be done by adding a `menus` variable to your front matter:

```markdown
---
title: Homepage
menus: header
---
```

This will create the `header` menu with a single item, the homepage. The `url`, `title`, and `identifier` for the homepage menu item will be automatically generated from the pages title, file path, and permalink.

You can optionally set any of the available [menu item variables](#menu-items) yourself to customize the appearance and functionality of your menus. For example, to set a custom title and weight:

```markdown
---
title: Homepage
menus:
  header:
    title: Home
    weight: 1
---
```

## Custom Menu Items via `_data/menus.yml`

The other option for configuring menus is creating menus using `_data/menus.yml`. In this scenario, you can add custom menu items to external content, or site content that isn’t handled by Jekyll.

In this file, you provide the menu key and an array of custom menu items. Custom menu items in the data file must have `url`, `title`, and `identifier` variable:

```markdown
---
header:
  - url: /api
    title: API Documentation
    identifier: api
---
```

## Sub-menus

Jekyll Menus supports infinitely nested menu items using the `identifier` variable. Any menu item can be used as a parent menu by using its identifier as the menu.

For example, in `_data/menus.yml`:

```yaml
header:
  - url: /api
    title: API Documentation
    identifier: api
```

In a content file called  `/api-support.html`:

```markdown
---
title: Get API Support
menus: api
---
```

Which can then be used in your templates by looping over the menu item’s `children` variable:

```liquid
<ul>
{% for item in site.menus.header %}
  <li class="menu-item-{{ loop.index }}">
    <a href="{{ item.url }}" title="Go to {{ item.title }}">{{ item.title }}</a>
    {% if item.children %}
      <ul class="sub-menu">
      {% for item in item.children %}
        <li class="menu-item-{{ loop.index }}">
          <a href="{{ item.url }}" title="Go to {{ item.title }}">{{ item.title }}</a>
        </li>
      {% endfor %}
      </ul>
    {% endif %}
  </li>
{% endfor %}
</ul>
```

You can also do this [recursively using a re-usable include](#recursive-menus), allowing for easily managed infinitely nested menus.

## Variables

Jekyll Menus has the following variables:

### Menus

| Variable | Description |
|---|---|
| menu.menu | Returns a JSON object with all of the menu’s items. |
| menu.identifier |  The unique identifier for the current menu, generated from the menu key. Allows for nested menu items. |
| menu.parent | The parent menu. Resolves to the site.menus object for top-level menus. |

### Menu Items

| Variable | Description |
|---|---|
| item.title | The display title of the menu item. Automatically set as the post or page title if no value is provided in front matter. |
| item.url | The URL the menu item links to. Automatically set to the post or page URL if no value is provided in front matter. |
| item.weight | Handles the order of menu items through a weighted system, starting with 1 being first. |
| item.identifier |  The unique identifier for the current menu item. Allows for nested menu items. Automatically resolved to the page’s file path and filename if not provided in front matter. |
| item.parent | The parent menu. |
| item.children | An array of any child menu items. Used to create sub-menus. |

## Custom Variables

Menu items also support custom variables, which you add to each menu item in the front matter or data file. 

For example, adding a `pre` or `post` variable to add text or HTML to your menu items:

```markdown
---
title: Homepage
menus:
  header:
    pre: <i class="icon-home"></i>
    post: " · "
---
```

## Recursive Menus

If you’re looking to build an infinitely nested menu (or a menu that is nested more than once up to a limit) then you should set up a reusable menu include that will handle this for you.

In `_includes/menu.html` :

```liquid
{% if menu %}
<ul>
{% for item in menu %}
  <li class="menu-item-{{ loop.index }}">
    <a href="{{ item.url }}" title="Go to {{ item.title }}">{{ item.title }}</a>
    {% if item.children %}
      {% assign menu = item.children %}
      {% include menu.html %}
    {% endif %}
  </li>
{% endfor %}
</ul>
{% endif %}
```

In `_layouts/default.html` (or any layout file):

```liquid
<html>
  <body>
    <header>
      <nav>
        {% assign menu = site.menus.header %}
        {% include menus.html %}
      </nav>
    </header>
    {{ content }}
  </body>
</html>
```
