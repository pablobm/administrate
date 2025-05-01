class AddBornOnToCustomers < ActiveRecord::Migration[8.0]
  def change
    change_table :customers do |t|
      t.date :born_on
    end
  end
end
