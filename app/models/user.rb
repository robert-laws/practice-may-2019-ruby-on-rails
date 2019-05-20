class User < ApplicationRecord
  # for cases where using a different table name than rails convention
  # can also rename class and file to match AdminUser / admin_user.rb
  self.table_name = "admin_users"

  # join table association
  has_and_belongs_to_many :pages

  # rich join table association
  has_many :section_edits
end
