class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :content, presence: true
  
  scope :between, ->(user1, user2) {
    where(sender: user1, receiver: user2)
      .or(where(sender: user2, receiver: user1))
      .order(created_at: :asc)
  }
  
  after_create :create_notification
  
  private
  
  def create_notification
    Notification.create(
      user: receiver,
      notifiable: self,
      notification_type: 'message',
      message: "#{sender.user_name} te envió un mensaje: \"#{content.truncate(30)}\"",
      read: false
    )
  end
end