# Frozen-string-literal: true
# Copyright: 2015 Forestry.io - MIT License
# Encoding: utf-8

module Jekyll
  class Menus
    module Utils module_function
      def deep_merge(old, _new)
        return old | _new if old.is_a?(Array)

        old.merge(_new) do |_, o, n|
          (o.is_a?(Hash) && n.is_a?(Hash)) || (o.is_a?(Array) &&
              n.is_a?(Array)) ? deep_merge(o, n) : n
        end
      end

      def deep_merge!(old, _new)
        old.replace(deep_merge(
          old, _new
        ))
      end
    end
  end
end
