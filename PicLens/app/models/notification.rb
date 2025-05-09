class Notification < ApplicationRecord
  belongs_to :user
  
  validates :notification_type, presence: true
  validates :is_read, inclusion: { in: [true, false] }
end