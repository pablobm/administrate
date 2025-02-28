require "administrate/base_dashboard"
require "administrate/field/string_red"

class ProductMetaTagDashboard < Administrate::BaseDashboard
  ATTRIBUTES = [
    :meta_title,
    :meta_description
  ].freeze

  ATTRIBUTE_TYPES = {
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    meta_title: Field::StringRed,
    meta_description: Field::String.with_options(look: :blue)
  }.freeze

  COLLECTION_ATTRIBUTES = ATTRIBUTES
  FORM_ATTRIBUTES = ATTRIBUTES
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTES

  def display_resource(tag)
    tag.meta_title
  end
end
