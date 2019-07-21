class Category < ApplicationRecord
  before_save { self.name = name.downcase }

  validates :name, presence: true, length: { maximum: 50 },
                  uniqueness: { case_sensitive: false }

  scope :ordering, -> { order("name") }
end
