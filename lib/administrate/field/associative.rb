require_relative "base"

module Administrate
  module Field
    class Associative < Base
      def display_associated_resource
        associated_dashboard.display_resource(data)
      end

      def associated_class
        associated_class_name.constantize
      end

      private

      def associated_dashboard
        "#{associated_class_name}Dashboard".constantize.new
      end

      #def associated_class(resource_class, attr)
        #reflection(resource_class, attr).klass
      #end

      def associated_class_name
        reflection.class_name
      end

      def reflection
        resource.class.reflect_on_association(attribute)
      end

      def primary_key
        options.fetch(:primary_key, :id)
      end

      def foreign_key
        options.fetch(:foreign_key, :"#{attribute}_id")
      end
    end
  end
end
