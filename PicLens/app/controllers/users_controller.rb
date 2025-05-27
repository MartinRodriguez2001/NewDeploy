class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def discover
    @users = User.where.not(id: current_user.id)
                 .where.not(id: current_user.following.pluck(:id))
                 .order(created_at: :desc)
                 .page(params[:page]).per(12)
  end

  def show
    @posts = @user.posts.includes(:images, :likes, :comments).order(created_at: :desc)
    
    @followers = @user.passive_relationships.includes(follower: [:profile_picture_attachment])
    @following = @user.following
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.bio = "Usuario de PicLens"
    
    default_avatars = [
      "https://api.dicebear.com/6.x/fun-emoji/svg?seed=Aneka&backgroundColor=b6e3f4",
      "https://api.dicebear.com/6.x/fun-emoji/svg?seed=Felix&backgroundColor=d1d4f9",
      "https://api.dicebear.com/6.x/micah/svg?seed=Coco&backgroundColor=b6e3f4",
      "https://api.dicebear.com/6.x/micah/svg?seed=Daisy&backgroundColor=d1d4f9",
      "https://api.dicebear.com/6.x/thumbs/svg?seed=Mia&backgroundColor=ffd5dc",
      "https://api.dicebear.com/6.x/thumbs/svg?seed=Max&backgroundColor=c0aede",
      "https://api.dicebear.com/6.x/avataaars/svg?seed=Zoe&backgroundColor=ffdfbf",
      "https://api.dicebear.com/6.x/avataaars/svg?seed=Leo&backgroundColor=d1d4f9"
    ]
    @user.photo_profile = default_avatars.sample
    
    if @user.save
      session[:user_id] = @user.id
      @user.update(last_login_at: Time.current)
      
      flash[:notice] = "¡Bienvenido a PicLens, #{@user.user_name}! Tu cuenta ha sido creada exitosamente."
      redirect_to main_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    
    user_attrs = if params[:user][:password].present?
                  user_params 
                else
                  user_params.except(:password)
                end
    
    
    if params[:remove_profile_picture] == '1' && @user.profile_picture.attached?
      @user.profile_picture.purge
    end
    

    if params[:user][:profile_picture].present?
      @user.profile_picture.attach(params[:user][:profile_picture])
      user_attrs = user_attrs.except(:photo_profile) 

    elsif user_attrs[:photo_profile].present?
      if @user.photo_profile != user_attrs[:photo_profile] && @user.profile_picture.attached?
        @user.profile_picture.purge
      end
    end
    
    if @user.update(user_attrs)
      redirect_to dashboard_path, notice: 'Perfil actualizado correctamente.'
    else
      render :edit, status: :unprocessable_entity
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
      params.require(:user).permit(:user_name, :email, :password, :bio, :photo_profile)
    end
  end
end
