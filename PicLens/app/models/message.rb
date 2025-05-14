class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  validates :content, presence: true
  
  scope :between, ->(user1, user2) {
    where(sender: user1, receiver: user2)
      .or(where(sender: user2, receiver: user1))
      .order(created_at: :asc)
  }
end