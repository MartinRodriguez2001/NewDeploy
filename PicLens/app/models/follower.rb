class Follower < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
  validates :follower_id, uniqueness: { scope: :followed_id }
  
  validate :not_follow_self
  
  private
  
  def not_follow_self
    errors.add(:follower_id, "you cannot follow yourself") if follower_id == followed_id
  end
end