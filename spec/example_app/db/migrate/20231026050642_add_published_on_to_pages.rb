class AddPublishedOnToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :published_on, :date
  end
end
