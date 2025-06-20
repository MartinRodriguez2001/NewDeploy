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
    
    respond_to do |format|
      if current_user.id != @user.id
        begin
          relationship = current_user.follow(@user)
          
          if relationship && relationship.persisted?
            flash[:notice] = "Ahora estás siguiendo a #{@user.user_name}"
            
            format.turbo_stream { render turbo_stream: turbo_stream.replace("follow_button_#{@user.id}", partial: "users/unfollow_button", locals: { user: @user }) }
            format.html { redirect_back(fallback_location: user_path(@user)) }
          else
            flash[:alert] = "No se pudo seguir al usuario"
            format.turbo_stream { head :unprocessable_entity }
            format.html { redirect_back(fallback_location: user_path(@user)) }
          end
        rescue => e
          Rails.logger.error "Error following user: #{e.message}"
          flash[:alert] = "Ocurrió un error al intentar seguir al usuario"
          
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_back(fallback_location: user_path(@user)) }
        end
      else
        flash[:alert] = "No puedes seguirte a ti mismo"
        
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: user_path(@user)) }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    relationship = Follower.find(params[:id])
    @user = relationship.followed
    
    respond_to do |format|
      if relationship.follower == current_user
        begin
          current_user.unfollow(@user)
          flash[:notice] = "Has dejado de seguir a #{@user.user_name}"
          
          format.turbo_stream { render turbo_stream: turbo_stream.replace("follow_button_#{@user.id}", partial: "users/follow_button", locals: { user: @user }) }
          format.html { redirect_back(fallback_location: user_path(@user)) }
        rescue => e
          Rails.logger.error "Error unfollowing user: #{e.message}"
          flash[:alert] = "Ocurrió un error al dejar de seguir al usuario"
          
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_back(fallback_location: user_path(@user)) }
        end
      else
        flash[:alert] = "No tienes permiso para realizar esta acción"
        
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: user_path(@user)) }
      end
    end
  end
end
