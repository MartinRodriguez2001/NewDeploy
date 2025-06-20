class ActivityHistory < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  
  validates :activity_type, presence: true
end