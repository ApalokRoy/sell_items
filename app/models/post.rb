class Post < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: :user_id
  belongs_to :category
  belongs_to :approved, class_name: "User", foreign_key: :approved_id, optional: true

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true

  VALID_PHONE_REGEX = /((\+*)((0[ -]+)*|(91 )*)(\d{12}+|\d{10}+))|\d{5}([- ]*)\d{6}/

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 15 },
                    format: { with: VALID_PHONE_REGEX }
  validates :user_id, :category_id, :city, presence: true
end
