class ChatsController < ApplicationController
  before_action :require_user
  
  def index
    @users = User.where.not(id: current_user.id)
  end
  
  def show
    @user = User.find(params[:id])
    @messages = DirectMessage.between(current_user, @user)
                             .includes(:sender, :receiver)
                             .order(created_at: :asc)
    @message = DirectMessage.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @message = current_user.sent_messages.build(message_params)
    @message.receiver = @user
    
    if @message.save
      redirect_to chat_path(@user), notice: "Mensaje enviado"
    else
      @messages = DirectMessage.between(current_user, @user)
      render :show
    end
  end
  
  private
  
  def message_params
    params.require(:direct_message).permit(:content)
  end
end
