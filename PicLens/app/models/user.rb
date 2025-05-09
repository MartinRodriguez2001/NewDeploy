class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :user_tokens, dependent: :destroy
  
  has_many :active_relationships, class_name: "Follower",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Follower",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :notifications, dependent: :destroy
  
  has_many :activity_histories, dependent: :destroy
  
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"
  
  has_many :reports_submitted, class_name: "Report", foreign_key: "reporter_id"
  has_many :reports_received, class_name: "Report", foreign_key: "reported_user_id"
  
  validates :user_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  
  has_secure_password
end