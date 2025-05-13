class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # Valores predeterminados para bio y photo_profile
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
    # Si se sube una nueva imagen, adjuntarla
    if params[:user][:profile_picture].present?
      @user.profile_picture.attach(params[:user][:profile_picture])
    end
    if @user.update(user_params.except(:profile_picture))
      redirect_to @user, notice: 'Usuario actualizado correctamente.'
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
    # En el formulario solo permitir estos campos, pero mantener los demás para cuando se edita el perfil
    if action_name == 'create'
      params.require(:user).permit(:user_name, :email, :password)
    else
      params.require(:user).permit(:user_name, :email, :password, :bio, :photo_profile, :profile_picture)
    end
  end
end
