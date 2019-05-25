class AddPasswordDigestToSiteUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column "site_users", "hashed_password"
    add_column "site_users", "password_digest", :string
  end
end
