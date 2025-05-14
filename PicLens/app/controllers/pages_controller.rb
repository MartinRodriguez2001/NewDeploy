class PagesController < ApplicationController
  before_action :require_user, only: [:dashboard, :main]

  def home
  end

  def dashboard
    @user = current_user
    @recent_posts = current_user.posts.order(created_at: :desc).limit(5)
    @followers = current_user.followers.limit(5)
    @following = current_user.following.limit(5)
  end

  def main
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc)
    @followers = current_user.followers
    @following = current_user.following
  end
end
