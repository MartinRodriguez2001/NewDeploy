class DirectMessage < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :content, presence: true
  validates :sender_id, presence: true
  validates :receiver_id, presence: true
  
  scope :between, ->(user1, user2) {
    where(sender: user1, receiver: user2)
      .or(where(sender: user2, receiver: user1))
      .order(created_at: :asc)
  }
  
  # Comentamos este callback para evitar errores con ApplicationCable
  # after_create_commit :broadcast_message
  
  private
  
  # def broadcast_message
  #   DirectMessageChannel.broadcast_to(
  #     [sender, receiver],
  #     {
  #       id: id,
  #       content: content,
  #       sender_id: sender_id,
  #       receiver_id: receiver_id,
  #       created_at: created_at
  #     }
  #   )
  # end
end 