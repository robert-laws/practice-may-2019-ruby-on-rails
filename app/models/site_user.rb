class SiteUser < ApplicationRecord
  has_secure_password

  scope :sorted, -> { order(last_name: :asc, first_name: :asc) }
  
  # validations
  validates_presence_of :first_name
  validates_length_of :first_name, maximum: 255

  validates_presence_of :last_name
  validates_length_of :last_name, maximum: 255

  validates_presence_of :username
  validates_length_of :username, maximum: 30
  validates_uniqueness_of :username

  validates_presence_of :password
  validates_confirmation_of :password, message: "both passwords must match"

  def name
    self.first_name + " " + self.last_name
  end
end