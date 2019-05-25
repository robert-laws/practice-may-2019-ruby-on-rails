class Author < ApplicationRecord
  has_many :books

  scope :get_author_by_id, ->(id) { where("id = ?", id) }
  scope :sorted, -> { order(name: :asc) }

  FORBIDDEN_NAMES = ['Don Dome', 'Abe Area', 'Zed Zone']

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_numericality_of :age

  validate :name_is_allowed
  validate :no_new_authors_on_saturday, on: :create

  private

  def name_is_allowed
    if FORBIDDEN_NAMES.include?(name)
      errors.add(:name, "has been restricted from use")
    end
  end

  def no_new_authors_on_saturday
    if Time.now.wday == 6
      errors.add(:base, "No new users on Saturday.")
    end
  end
end
