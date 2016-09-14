# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

module Jekyll
  class Menus
    module Drops
      class Menu < Liquid::Drop
        attr_reader :parent, :identifier, :menu
        def initialize(menu, identifier, parent)
          @parent = parent
          @identifier = identifier
          @menu = menu
        end

        #

        def find
          to_a.find do |item|
            yield item
          end
        end

        #

        def select
          to_a.select do |item|
            yield item
          end
        end

        #

        def to_a
          @menu.map { |item| Item.new(item, parent) }.sort_by(
            &:weight
          )
        end

        #

        def each
          to_a.each do |drop|
            yield drop
          end
        end
      end
    end
  end
end
