class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: { scope: :post_id }
  
  after_create :create_notification
  
  private
  
  def create_notification
    if user_id != post.user_id
      Notification.create(
        user: post.user,
        notifiable: self,
        notification_type: 'like',
        message: "A #{user.user_name} le gustó tu publicación: \"#{post.caption.truncate(30)}\"",
        read: false
      )
    end
  end
end