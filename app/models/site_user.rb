class SiteUser < ApplicationRecord
  has_secure_password

  scope :sorted, -> { order(username: :asc) }
  
  # validations
  validates_presence_of :first_name
  validates_length_of :first_name, maximum: 255

  validates_presence_of :last_name
  validates_length_of :last_name, maximum: 255

  validates_presence_of :username
  validates_length_of :username, maximum: 30
  validates_uniqueness_of :username
end