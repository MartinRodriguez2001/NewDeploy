class UserTokensController < ApplicationController
  before_action :set_user_token, only: %i[show edit update destroy]

  def index
    @user_tokens = UserToken.where(user_id: params[:user_id])
  end

  def show
  end

  def new
    @user_token = UserToken.new(user_id: params[:user_id])
  end

  def create
    @user_token = UserToken.new(user_token_params)
    if @user_token.save
      redirect_to user_user_tokens_path(@user_token.user_id),
                  notice: 'Token creado correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user_token.update(user_token_params)
      redirect_to user_user_tokens_path(@user_token.user_id),
                  notice: 'Token actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    user_id = @user_token.user_id
    @user_token.destroy
    redirect_to user_user_tokens_path(user_id),
                notice: 'Token eliminado correctamente.'
  end

  private

  def set_user_token
    @user_token = UserToken.find(params[:id])
  end

  def user_token_params
    params.require(:user_token)
          .permit(:token, :expires_at, :user_id)
  end
end
