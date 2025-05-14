class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  
  validates :notification_type, presence: true
  validates :message, presence: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc) }

  after_create_commit :broadcast_notification

  def mark_as_read!
    update(read: true)
  end

  private

  def broadcast_notification
    NotificationsChannel.broadcast_to(
      user,
      {
        id: id,
        message: message,
        notification_type: notification_type,
        created_at: created_at,
        read: read,
        notifiable_type: notifiable_type,
        notifiable_id: notifiable_id
      }
    )
  end
end