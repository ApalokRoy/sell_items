class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user 
  
  validates :message_body, :conversation_id, :user_id, presence: true

  scope :ordering, -> { order("created_at DESC") }

  def message_time
    time = created_at.localtime
    time.strftime("#{time.day.ordinalize} %b, %Y at %l:%M %p")
  end
end