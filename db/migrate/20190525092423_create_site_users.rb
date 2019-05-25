class CreateSiteUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :site_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username, limit: 30
      t.string :hashed_password, limit: 30

      t.timestamps
    end
  end
end
