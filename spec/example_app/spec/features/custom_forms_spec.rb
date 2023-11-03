require "rails_helper"

RSpec.feature "Custom forms", type: :feature do
  it "accepts a dropdown-based date field" do
    visit new_admin_page_path

    click_on "Create Page"
  end
end
