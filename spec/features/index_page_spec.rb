require "rails_helper"

search_input_selector = ".search__input"

describe "customer index page" do
  it "displays customers' name and email" do
    customer = create(:customer)

    visit admin_customers_path

    expect(page).to have_header("Customers")
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
  end

  it "links to the customer show page", :js do
    customer = create(:customer)

    visit admin_customers_path
    click_row_for(customer)

    expect(page).to have_header(displayed(customer))
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
  end

  it "links to the customer show page without javascript", js: false do
    customer = create(:customer)

    visit admin_customers_path
    click_show_link_for(customer)

    expect(page).to have_header(displayed(customer))
  end

  it "links to the edit page" do
    customer = create(:customer)

    visit admin_customers_path
    click_on "Edit"

    expect(current_path).to eq(edit_admin_customer_path(customer))
  end

  it "links to the new page" do
    visit admin_customers_path
    click_on("New customer")

    expect(current_path).to eq(new_admin_customer_path)
  end

  it "displays translated labels" do
    custom_label = "Newsletter Subscriber"

    translations = {
      helpers: {
        label: {
          customer: {
            email_subscriber: custom_label,
          },
        },
      },
    }

    with_translations(:en, translations) do
      visit admin_customers_path

      expect(page).to have_table_header(custom_label)
    end
  end

  it "paginates records based on a constant" do
    customers = create_list(:customer, 2)

    visit admin_customers_path(per_page: 1)

    expect(page).not_to have_content(customers.last.name)
    click_on "Next"
    expect(page).to have_content(customers.last.name)
  end

  describe "sorting" do
    def expect_to_appear_in_order(*elements)
      positions_to_elements = elements.each_with_object({}) do |el, hash|
        hash[page.body.index(el)] = el
      end
      elements_in_page_order = positions_to_elements.keys.sort.map { |pos| positions_to_elements[pos] }
      expect(elements_in_page_order).not_to include(nil)
      expect(elements_in_page_order).to eq(elements)
    end

    it "allows sorting by columns" do
      create(:customer, name: "unique name two")
      create(:customer, name: "unique name one")

      visit admin_customers_path
      click_on "Name"

      expect_to_appear_in_order("unique name one", "unique name two")
    end

    it "allows reverse sorting" do
      create(:customer, name: "unique name one")
      create(:customer, name: "unique name two")

      visit admin_customers_path
      2.times { click_on "Name" }

      expect_to_appear_in_order("unique name two", "unique name one")
    end

    it "toggles the order" do
      create(:customer, name: "unique name one")
      create(:customer, name: "unique name two")

      visit admin_customers_path
      3.times { click_on "Name" }

      expect_to_appear_in_order("unique name one", "unique name two")
    end

    it "preserves search" do
      query = "bar@baz.com"

      visit admin_customers_path(search: query)
      click_on "Name"

      expect(find(search_input_selector).value).to eq(query)
    end

    it "sorts has_many relationships by number of records, by default" do
      c1 = create(:customer, orders: create_list(:order, 2))
      c2 = create(:customer, orders: create_list(:order, 1))
      c3 = create(:customer, orders: create_list(:order, 5))
      c4 = create(:customer, orders: create_list(:order, 3))
      c5 = create(:customer, orders: create_list(:order, 4))

      visit admin_customers_path

      within 'table thead' do
        click_on "Orders"
      end
      expect_to_appear_in_order(c2.name, c1.name, c4.name, c5.name, c3.name)

      within 'table thead' do
        click_on "Orders"
      end
      expect_to_appear_in_order(c3.name, c5.name, c4.name, c1.name, c2.name)
    end
  end
end

describe "search input" do
  context "when resource has searchable fields" do
    let(:index_with_searchable_fields) { admin_log_entries_path }

    context "but none of them are displayed" do
      before do
        allow_any_instance_of(LogEntryDashboard).
          to receive(:collection_attributes) { [] }
        visit(index_with_searchable_fields)
      end

      it "is shown" do
        expect(page).to have_selector(search_input_selector)
      end
    end

    context "and some of them are displayed" do
      before do
        visit(index_with_searchable_fields)
      end

      it "is shown" do
        expect(page).to have_selector(search_input_selector)
      end
    end
  end

  context "when resource does not have searchable fields" do
    let(:index_without_searchable_fields) { admin_line_items_path }

    before do
      visit(index_without_searchable_fields)
    end

    it "is hidden" do
      expect(page).to_not have_selector(search_input_selector)
    end
  end
end
