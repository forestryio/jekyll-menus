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

        def method_missing(method, *args)
          if args.size == 0 && @item.has_key?(method.to_s)
            return @item[
              method.to_s
            ]

          else
            super
          end
        end
      end
    end
  end
end
