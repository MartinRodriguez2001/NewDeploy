class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy
  has_many :posts, through: :post_hashtags
  
  validates :tag, presence: true, uniqueness: true

  def self.find_or_create_by_tag(tag)
    find_or_create_by(tag: tag.downcase.strip)
  end
end