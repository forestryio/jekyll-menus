# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

module Jekyll
  class Menus
    module Drops
      class Item < Liquid::Drop
        def initialize(item, parent)
          @parent = parent
          @item =
            item
        end

        #

        def children
          out = @parent.find { |menu| menu.identifier == @item["identifier"] }

          if out
            return out.to_a
          end
        end

        #

        def url
          @item[
            "url"
          ]
        end

        #

        def title
          @item[
            "title"
          ]
        end

        #

        def identifier
          @item[
            "identifier"
          ]
        end

        #

        def weight
          @item[
            "weight"
          ]
        end

        #

        def before_method(method)
          if @item.has_key?(method.to_s)
            return @item[
              method.to_s
            ]
          end
        end

        alias_method :liquid_method_missing, :before_method
      end
    end
  end
end
