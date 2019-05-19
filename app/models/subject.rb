class Subject < ApplicationRecord
  # has_one :page # one-to-one

  has_many :pages
end
