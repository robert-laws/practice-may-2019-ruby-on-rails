class Page < ApplicationRecord
  # belongs_to :subject, { foreign_key: 'foo_id' }
  # belongs_to :subject # one-to-one
  belongs_to :subject, { optional: true }
  has_many :sections
  
  # join table association
  has_and_belongs_to_many :users
end
