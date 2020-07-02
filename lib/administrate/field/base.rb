require_relative "deferred"
require "active_support/core_ext/string/inflections"

module Administrate
  module Field
    class Base
      def self.with_options(options = {})
        Deferred.new(self, options)
      end

      def self.html_class
        field_type.dasherize
      end

      def self.associative?
        self < Associative
      end

      def self.searchable?
        false
      end

      def self.field_type
        to_s.split("::").last.underscore
      end

      def self.permitted_attribute(attr, _options = nil)
        attr
      end

      def initialize(resource, attribute, options = {})
        @resource = resource
        @attribute = attribute
        @options = options
      end

      def html_class
        self.class.html_class
      end

      def name
        attribute.to_s
      end

      def data
        resource.public_send(attribute)
      end

      def to_partial_path(action_name)
        "/fields/#{self.class.field_type}/#{action_name}"
      end

      attr_reader :resource, :attribute, :options
    end
  end
end
