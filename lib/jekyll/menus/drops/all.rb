# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

module Jekyll
  class Menus
    module Drops
      class All < Liquid::Drop
        def initialize(menus)
          @menus = menus
        end

        #

        def find
          to_a.find do |menu|
            yield menu
          end
        end

        #

        def to_a
          @menus.keys.map do |identifier|
            self[
              identifier
            ]
          end
        end

        #

        def each
          to_a.each do |drop|
            yield drop
          end
        end

        #

        def [](key)
          if @menus.key?(key)
            then Menu.new(@menus[key],
              key, self
            )
          end
        end
      end
    end
  end
end
