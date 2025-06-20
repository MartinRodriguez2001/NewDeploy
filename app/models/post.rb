class Post < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activity_histories, dependent: :destroy
  
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags
  
  validates :caption, length: { maximum: 500 }
  
  attr_accessor :hashtag_list
  
  def hashtag_list
    hashtags.pluck(:tag).join(',')
  end
end