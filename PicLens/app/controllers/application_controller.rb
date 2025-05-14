class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = "Debes iniciar sesión para realizar esta acción"
      redirect_to login_path
    end
  end

  def require_same_user
    unless current_user == @user
      flash[:alert] = "No tienes permiso para realizar esta acción"
      redirect_to root_path
    end
  end
end
