class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy
  has_many :chats_as_user1, class_name: "Chat", foreign_key: "user_id1", dependent: :destroy
  has_many :chats_as_user2, class_name: "Chat", foreign_key: "user_id2", dependent: :destroy
  has_many :active_relationships, class_name: "Follower", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Follower", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :avatar
  
  def profile_picture
    avatar
  end
 
  def following?(other_user)
    following.include?(other_user)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id)&.destroy
  end

  def active_for_authentication?
    super && !banned
  end

  def inactive_message
    banned ? "Usted ha sido baneado permanentemente" : super
  end
  
  validates :user_name, presence: true,
                      length: { minimum: 3 }, 
                      format: { with: /\A[a-zA-Z0-9_]+\z/, 
                               message: "solo puede contener letras, números y guiones bajos" }
  
  ROLES = { user: "user", admin: "admin" }.freeze
  
  validates :role, inclusion: { in: ROLES.values }
  
  after_initialize :set_default_role, if: :new_record?
  
  def user?
    role == ROLES[:user]
  end
  
  def admin?
    role == ROLES[:admin]
  end
  
private

  def set_default_role
    self.role ||= ROLES[:user]
  end
end