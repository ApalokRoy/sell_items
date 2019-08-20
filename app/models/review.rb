class Review < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: :user_id
  belongs_to :post
  belongs_to :approved, class_name: "User", foreign_key: :approved_id, optional: true

  validates :rating, presence: true, numericality: {
            less_than_or_equal_to: 5,  only_integer: true }
  validates :heading, presence: true, length: { minimum: 10 }
  validate :approved_post

  scope :yet_to_be_approved, -> { where(approved_id: nil) }
  scope :approved, -> { where.not(approved_id: nil) }
 
  def approved_post
    unless post.approved_id.present?
      errors.add(:post_id, "must be approved")
    end
  end

  def blank_stars
    5 - rating.to_i
   end
end