module Administrate
  module Page
    class Base
      def initialize(dashboard, options = {})
        @dashboard = dashboard
        @options = options
      end

      def resource_name
        @resource_name ||=
          dashboard.class.to_s.scan(/(.+)Dashboard/).first.first.underscore
      end

      def resource_path
        @resource_path ||= resource_name.gsub("/", "_")
      end

      def collection_includes
        dashboard.try(:collection_includes) || []
      end

      def item_includes
        dashboard.try(:item_includes) || []
      end

      private

      def attribute_field(resource, dashboard, attribute_name)
        field_type = dashboard.attribute_type_for(attribute_name)
        field_type.new(resource, attribute_name)
      end

      attr_reader :dashboard, :options
    end
  end
end
