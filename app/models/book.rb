class Book < ApplicationRecord
  belongs_to :author

  BOOK_TYPES = ["book", "short story", "play"]

  validates_presence_of :title
  validates_length_of :title, maximum: 255

  validates_inclusion_of :book_type, in: BOOK_TYPES, message: "must be one of: #{BOOK_TYPES.join(', ')"
end
