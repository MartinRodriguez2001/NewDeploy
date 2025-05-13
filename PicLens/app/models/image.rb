class Image < ApplicationRecord
  belongs_to :post
  has_one_attached :file
  
  validates :image_url, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
