class User < ApplicationRecord
  # for cases where using a different table name than rails convention
  # can also rename class and file to match AdminUser / admin_user.rb
  self.table_name = "admin_users"

  # join table association
  has_and_belongs_to_many :pages

  # rich join table association
  has_many :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  # validate_presence_of :email
  # validates_length_of :email, maximum: 100
  # validates_format_of :email, with: EMAIL_REGEX
  # validates_confirmation_of :email

  # replaces above with a shorthand version
  validates :email, presence: true, length: { maximum: 100 }, format: { with: EMAIL_REGEX }, confirmation: true
end