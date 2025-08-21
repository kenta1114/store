class AddFieldsToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :price, :decimal, precision: 8, scale: 2
    add_column :products, :stock, :integer, default: 0
    add_column :products, :description, :text
  end
end
