require "administrate/base_dashboard"
require "administrate/field/date_dropdown"

class PageDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    product: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    body: Field::Text,
    published_on: Field::DateDropdown,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    title
    published_on
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    product
    id
    title
    body
    published_on
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    product
    title
    body
    published_on
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
