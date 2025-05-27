class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      user.update(last_login_at: Time.current)
      flash[:notice] = "¡Bienvenido de nuevo, #{user.user_name}!"
      redirect_to main_path
    else
      flash.now[:alert] = "Email o contraseña incorrectos"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Has cerrado sesión exitosamente"
    redirect_to login_path
  end
end
