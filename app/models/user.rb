class User < ApplicationRecord
  # for cases where using a different table name than rails convention
  # can also rename class and file to match AdminUser / admin_user.rb
  self.table_name = "admin_users"

  attr_accessor :first_name

  def last_name
    @last_name
  end

  def last_name=(value)
    @last_name = value
  end
end
