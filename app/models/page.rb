class Page < ApplicationRecord
  # belongs_to :subject, { foreign_key: 'foo_id' }
  # belongs_to :subject # one-to-one

  belongs_to :subject
  has_many :sections
end
