class Author < ApplicationRecord
  has_many :books

  scope :get_author_by_id, ->(id) { where("id = ?", id) }
  scope :sorted, -> { order(name: :asc) }

  validates_presence_of :name
end
