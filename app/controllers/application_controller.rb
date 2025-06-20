class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :check_banned

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "No tienes permiso para realizar esta acción"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end
  
  def after_sign_in_path_for(resource)
    main_path
  end
  
  def after_sign_up_path_for(resource)
    main_path
  end

  private

  def require_user
    authenticate_user!
  end

  def check_banned
    if current_user&.banned?
      sign_out current_user
      flash[:alert] = "Tu cuenta ha sido baneada. Contacta al administrador."
      redirect_to root_path
    end
  end
end
