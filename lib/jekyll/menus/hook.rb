# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

module Jekyll
  module Drops
    class SiteDrop
      attr_accessor :menus
    end
  end
end

Jekyll::Hooks.register :site, :pre_render do |site, payload|
  payload.site.menus = Jekyll::Menus.new(site).to_liquid_drop
end
