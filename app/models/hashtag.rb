class Hashtag < ApplicationRecord
  has_many :post_hashtags, dependent: :destroy
  has_many :posts, through: :post_hashtags
  
  validates :tag, presence: true, uniqueness: true

  def self.find_or_create_by_tag(tag)
    tag = tag.downcase.strip
    Rails.logger.debug "Buscando o creando hashtag: #{tag}"
    hashtag = find_or_create_by(tag: tag)
    Rails.logger.debug "Hashtag encontrado/creado: #{hashtag.id} - #{hashtag.tag}"
    hashtag
  end
  before_save :normalize_tag
  
  private
  
  def normalize_tag
    self.tag = self.tag.downcase.strip if self.tag
  end
end