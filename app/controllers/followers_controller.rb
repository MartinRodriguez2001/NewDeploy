class FollowersController < ApplicationController
  before_action :require_user

  def index
  end

  def show
  end

  def new
  end

  def create
    @followed = User.find(params[:followed_id])
    
    respond_to do |format|
      if current_user.id != @followed.id
        begin
          relationship = current_user.follow(@followed)
          
          if relationship && relationship.persisted?
            flash[:notice] = "Ahora estás siguiendo a #{@followed.user_name}"
            
            format.turbo_stream # Uses create.turbo_stream.erb template
            format.html { redirect_back(fallback_location: user_path(@followed)) }
          else
            flash[:alert] = "No se pudo seguir al usuario"
            format.turbo_stream { head :unprocessable_entity }
            format.html { redirect_back(fallback_location: user_path(@followed)) }
          end
        rescue => e
          Rails.logger.error "Error following user: #{e.message}"
          flash[:alert] = "Ocurrió un error al intentar seguir al usuario"
          
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_back(fallback_location: user_path(@followed)) }
        end
      else
        flash[:alert] = "No puedes seguirte a ti mismo"
        
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: user_path(@followed)) }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    relationship = Follower.find(params[:id])
    @followed = relationship.followed
    
    respond_to do |format|
      if relationship.follower == current_user
        begin
          current_user.unfollow(@followed)
          flash[:notice] = "Has dejado de seguir a #{@followed.user_name}"
          
          format.turbo_stream # Uses destroy.turbo_stream.erb template
          format.html { redirect_back(fallback_location: user_path(@followed)) }
        rescue => e
          Rails.logger.error "Error unfollowing user: #{e.message}"
          flash[:alert] = "Ocurrió un error al dejar de seguir al usuario"
          
          format.turbo_stream { head :unprocessable_entity }
          format.html { redirect_back(fallback_location: user_path(@followed)) }
        end
      else
        flash[:alert] = "No tienes permiso para realizar esta acción"
        
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: user_path(@followed)) }
      end
    end
  end
end
