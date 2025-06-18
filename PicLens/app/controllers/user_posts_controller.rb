class UserPostsController < ApplicationController
  before_action :require_user
  before_action :set_user

  def index
    @posts = @user.posts
                  .includes(:images, :hashtags, :comments, :likes)
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per(12)

    respond_to do |format|
      if @user == current_user || current_user.role == 'admin'
        format.html
      else
        format.html { 
          flash[:alert] = "No tienes permiso para ver las publicaciones de otros usuarios"
          redirect_to user_path(@user)
        }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Usuario no encontrado"
    redirect_to root_path
  end
end