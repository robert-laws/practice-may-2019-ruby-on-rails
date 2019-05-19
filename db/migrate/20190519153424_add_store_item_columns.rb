class AddStoreItemColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :store_items, :name, :string
    add_column :store_items, :quantity, :integer
    add_column :store_items, :cost, :float
  end
end
