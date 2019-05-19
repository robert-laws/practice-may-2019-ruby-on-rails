class StoreItem < ApplicationRecord
  scope :quantity, lambda { where(quantity: 5)}
  
  scope :sorted, lambda { order(quantity: :asc)}
  
  scope :newest_first, lambda { order(created_at: :desc)}

  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

  scope :quantity_greater, ->(query) {where(["quantity > ?", query])}

  scope :cost_between, ->(cost_one, cost_two) { where(["cost > ? AND cost < ?", cost_one, cost_two])}

  scope :limit_two, -> {limit(2)}
end
