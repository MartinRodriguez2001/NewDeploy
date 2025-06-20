class PostHashtag < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag
  
  validates :hashtag_id, uniqueness: { scope: :post_id }
  
  after_create :log_creation
  after_destroy :log_destruction
  
  private
  
  def log_creation
    Rails.logger.debug "PostHashtag creado: post_id=#{post_id}, hashtag_id=#{hashtag_id}, hashtag=#{hashtag.tag}"
  end
  
  def log_destruction
    Rails.logger.debug "PostHashtag eliminado: post_id=#{post_id}, hashtag_id=#{hashtag_id}"
  end
end