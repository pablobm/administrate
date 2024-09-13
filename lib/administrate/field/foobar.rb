require_relative "base"

module Administrate
  module Field
    class Foobar < Field::Base
      def self.searchable?
        false
      end

      def render
        "This is a Foobar: #{resource.inspect}"
      end
    end
  end
end
