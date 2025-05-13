class UserPostsController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:images, :hashtags, :comments, :likes)
  end
end 