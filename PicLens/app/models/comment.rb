class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :text, presence: true, length: { maximum: 300 }
  
  after_create :create_notification
  
  private
  
  def create_notification
    if user_id != post.user_id
      Notification.create(
        user: post.user,
        notifiable: self,
        notification_type: 'comment',
        message: "#{user.user_name} comentó en tu publicación: \"#{text.truncate(30)}\"",
        read: false
      )
    end
  end
end