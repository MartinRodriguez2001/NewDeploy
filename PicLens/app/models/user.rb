class User < ApplicationRecord
  has_secure_password

  has_one_attached :profile_picture
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
  
  validates :user_name, presence: true, 
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, 
                                message: "solo puede contener letras, números y guiones bajos" },
                       length: { minimum: 3, maximum: 30 }
  
  validates :email, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :password, length: { minimum: 6 }, if: -> { new_record? || password.present? }
  
  before_save :downcase_email
  before_save :downcase_user_name

  def feed
    following_ids = "SELECT followed_id FROM followers WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
        .order(created_at: :desc)
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def update_without_password(params)
    params.delete(:password) if params[:password].blank?
    update(params)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def downcase_user_name
    self.user_name = user_name.downcase
  end
end