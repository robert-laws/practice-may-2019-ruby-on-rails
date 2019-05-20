class CreateAdminUsersPagesJoin < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_users_pages, id: false do |t|
      t.integer "user_id"
      t.integer "page_id"
    end
    add_index("admin_users_pages", ["user_id", "page_id"])
  end

  def down
    drop_table :admin_users_pages
  end
end
