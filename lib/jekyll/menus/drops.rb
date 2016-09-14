# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

module Jekyll
  class Menus
    module Drops
      autoload :Menu, "jekyll/menus/drops/menu"
      autoload :All,  "jekyll/menus/drops/all"
      autoload :Item, "jekyll/menus/drops/item"
    end
  end
end
