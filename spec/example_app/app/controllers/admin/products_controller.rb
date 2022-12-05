module Admin
  class ProductsController < Admin::ApplicationController
    private

    def find_resource(param)
      resource_class.find_by!(slug: param)
    end
  end
end
