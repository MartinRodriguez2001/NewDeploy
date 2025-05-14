require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:user_name) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:followers) }
    it { should have_many(:following) }
    it { should have_many(:notifications) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'methods' do
    let(:user) { create(:user) }

    it 'returns full name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end

    it 'can follow another user' do
      other_user = create(:user)
      user.follow(other_user)
      expect(user.following).to include(other_user)
    end

    it 'can unfollow another user' do
      other_user = create(:user)
      user.follow(other_user)
      user.unfollow(other_user)
      expect(user.following).not_to include(other_user)
    end
  end
end 