module Administrate
  class ResourceResolver
    def initialize(controller_path)
      controller_path_parts = controller_path.split("/")
      namespace_path_parts = []
      begin
        if controller_path_parts.empty?
          fail "Could not resolve the namespace and the controller for #{controller_path}"
        end
        candidate_controller_name = controller_path_parts.join("/")
        candidate_controller_name.singularize.camelcase.constantize
      rescue NameError
        namespace_path_parts << controller_path_parts.shift
        retry
      end

      @controller_path_parts = controller_path_parts
      @namespace = namespace_path_parts.empty? ? nil : namespace_path_parts.join("/")
    end

    attr_reader :namespace

    def dashboard_class
      ActiveSupport::Inflector.constantize("#{resource_class_name}Dashboard")
    end

    def resource_class
      ActiveSupport::Inflector.constantize(resource_class_name)
    end

    def resource_name
      model_path_parts.map(&:underscore).join("__").to_sym
    end

    def resource_title
      model_path_parts.join(" ")
    end

    private

    def resource_class_name
      model_path_parts.join("::").singularize
    end

    def model_path_parts
      @model_path_parts ||= begin
        *init, last = controller_path_parts
        (init + [last.singularize]).map(&:camelize)
      end
    end

    def controller_path
      controller_path_parts.join('/')
    end

    attr_reader :controller_path_parts
  end
end
