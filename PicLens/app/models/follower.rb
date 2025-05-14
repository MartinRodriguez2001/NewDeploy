class Follower < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
  validates :follower_id, uniqueness: { scope: :followed_id }
  
  validate :not_follow_self
  
  after_create :create_notification
  
  private
  
  def not_follow_self
    errors.add(:follower_id, "you cannot follow yourself") if follower_id == followed_id
  end
  
  def create_notification
    Notification.create(
      user: followed,
      notifiable: self,
      notification_type: 'follow',
      message: "#{follower.user_name} comenzó a seguirte",
      read: false
    )
  end
end