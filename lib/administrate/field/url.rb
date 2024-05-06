require_relative "base"

module Administrate
  module Field
    class Url < Field::Base
      def self.searchable?
        true
      end

      def self.read_value(object, attribute)
        if attribute == :download_link
          # Ideally this would be a different field type, but just for
          # a quick prototype I'm using the Url field and using
          # this little dirty condition to display a different value.
          "This is a download link"
        else
          super
        end
      end

      def truncate
        data.to_s[0...truncation_length]
      end

      def html_options
        @options[:html_options] || {}
      end

      private

      def truncation_length
        options.fetch(:truncate, 50)
      end
    end
  end
end
