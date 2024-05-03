module Admin
  class OrdersController < Admin::ApplicationController
    private

    def new_resource(*)
      super.tap do |resource|
        if %w[new create].include?(action_name) && !pundit_user.admin?
          resource.customer = pundit_user
        end
      end
    end
  end
end
