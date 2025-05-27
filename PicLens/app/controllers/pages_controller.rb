class PagesController < ApplicationController
  before_action :require_user, only: [:dashboard, :main]

  def home
  end

  def dashboard
    @user = current_user
    @recent_posts = current_user.posts.order(created_at: :desc).limit(5)
    @followers = current_user.followers.limit(5)
    @following = current_user.following.limit(5)
    @suggested_users = User.where.not(id: current_user.id)
                          .where.not(id: current_user.following.pluck(:id))
                          .order("RANDOM()")
                          .limit(3)
  end

  def main
    @user = current_user
    following_ids = current_user.following.pluck(:id)
    if following_ids.any?
      @posts = Post.includes(:user, :images, :likes, :comments, :hashtags)
                   .where(user_id: following_ids)
                   .order(created_at: :desc)
                   .page(params[:page]).per(12)
    else
      @posts = Post.includes(:user, :images, :likes, :comments, :hashtags)
                   .order('RANDOM()')
                   .page(params[:page]).per(12)
    end
    @followers = current_user.followers
    @following = current_user.following
  end
end
