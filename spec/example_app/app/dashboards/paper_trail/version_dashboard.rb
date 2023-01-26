require "administrate/base_dashboard"

module PaperTrail
  class VersionDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      event: Field::String,
      object: Field::Text,
      object_changes: Field::Text
    }.freeze

    COLLECTION_ATTRIBUTES = ATTRIBUTE_TYPES.keys
    SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys
    FORM_ATTRIBUTES = ATTRIBUTE_TYPES.keys
  end
end
