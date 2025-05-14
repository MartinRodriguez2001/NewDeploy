class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.includes(:images, :likes, :comments).order(created_at: :desc)
    @followers = @user.followers.includes(follower: [:profile_picture_attachment])
    @following = @user.following.includes(:profile_picture_attachment)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.bio = "Usuario de PicLens"
    @user.photo_profile = "https://via.placeholder.com/150"
    
    if @user.save
      redirect_to root_path, notice: "Usuario creado correctamente. ¡Inicia sesión!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:user][:profile_picture].present?
      @user.profile_picture.attach(params[:user][:profile_picture])
    end
    if @user.update(user_params.except(:profile_picture))
      redirect_to main_path, notice: 'Usuario actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'Usuario eliminado.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    if action_name == 'create'
      params.require(:user).permit(:user_name, :email, :password)
    else
      params.require(:user).permit(:user_name, :email, :password, :bio, :photo_profile, :profile_picture)
    end
  end
end
