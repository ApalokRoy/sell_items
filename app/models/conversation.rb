class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :receiver, class_name: "User", foreign_key: :receiver_id
  belongs_to :post

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: [:receiver_id, :post_id]
  
  scope :between, -> (sender_id,receiver_id, post_id) do
		where("((conversations.sender_id = ? AND conversations.receiver_id =?)
    OR (conversations.sender_id = ? AND conversations.receiver_id =?)) 
    AND (conversations.post_id = ?)", 
    sender_id, receiver_id, receiver_id, sender_id, post_id)
  end
end