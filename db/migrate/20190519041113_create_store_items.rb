class CreateStoreItems < ActiveRecord::Migration[5.2]
  def change
    create_table :store_items do |t|

      t.timestamps
    end
  end
end
