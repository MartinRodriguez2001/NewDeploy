class FollowersController < ApplicationController
  before_action :require_user

  def index
  end

  def show
  end

  def new
  end

  def create
    @user = User.find(params[:followed_id])
    
    if current_user.id != @user.id
      current_user.follow(@user)
      flash[:notice] = "Ahora estás siguiendo a #{@user.user_name}"
    else
      flash[:alert] = "No puedes seguirte a ti mismo"
    end
    
    # Redirigir de vuelta a la página anterior o al perfil del usuario
    redirect_back(fallback_location: user_path(@user))
  end

  def edit
  end

  def update
  end

  def destroy
    relationship = Follower.find(params[:id])
    @user = relationship.followed
    
    if relationship.follower == current_user
      current_user.unfollow(@user)
      flash[:notice] = "Has dejado de seguir a #{@user.user_name}"
    else
      flash[:alert] = "No tienes permiso para realizar esta acción"
    end
    
    # Redirigir de vuelta a la página anterior o al perfil del usuario
    redirect_back(fallback_location: user_path(@user))
  end
end
