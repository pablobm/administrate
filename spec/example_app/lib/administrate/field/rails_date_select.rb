require "administrate/field/base"

module Administrate
  module Field
    class RailsDateSelect < Administrate::Field::Base
      def to_s
        data
      end
    end
  end
end
