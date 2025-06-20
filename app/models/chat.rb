class Chat < ApplicationRecord
  belongs_to :user1, class_name: "User", foreign_key: "user_id1"
  belongs_to :user2, class_name: "User", foreign_key: "user_id2"
  
  has_many :messages, dependent: :destroy
  
  validates :user_id1, presence: true
  validates :user_id2, presence: true
  
  validate :unique_user_combination
  
  private
  
  def unique_user_combination
    if Chat.where("(user_id1 = ? AND user_id2 = ?) OR (user_id1 = ? AND user_id2 = ?)", 
                 user_id1, user_id2, user_id2, user_id1).exists?
      errors.add(:base, "Ya existe un chat entre estos usuarios")
    end
  end
end