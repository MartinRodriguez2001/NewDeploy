class Post < ApplicationRecord
  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activity_histories, dependent: :destroy
  
  
  has_many :post_hashtags, dependent: :destroy
  has_many :hashtags, through: :post_hashtags
  
  validates :caption, length: { maximum: 500 }

  after_save :assign_hashtags_from_caption

  private

  def assign_hashtags_from_caption
    return unless caption.present?
    tags = caption.scan(/#\w+/).map { |t| t.delete('#') }
    self.hashtags = tags.map { |tag| Hashtag.find_or_create_by_tag(tag) }
  end
end