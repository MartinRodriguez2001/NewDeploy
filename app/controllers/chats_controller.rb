class ChatsController < ApplicationController
  before_action :require_user
  
  def index
    @users = User.where.not(id: current_user.id)
  end
  
  def show
    @user = User.find(params[:id])
    @messages = Message.where(
      "((sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?))",
      current_user.id, @user.id, @user.id, current_user.id
    ).includes(:sender, :receiver).order(created_at: :asc)
    @message = Message.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @message = current_user.sent_messages.build(message_params)
    @message.receiver = @user
    
    chat = Chat.find_or_create_by(
      user_id1: [current_user.id, @user.id].min,
      user_id2: [current_user.id, @user.id].max
    )
    @message.chat = chat
    
    if @message.save
      respond_to do |format|
        format.html { redirect_to chat_path(@user), notice: "Mensaje enviado" }
        format.turbo_stream { redirect_to chat_path(@user) }
        format.json { render json: { status: 'success', message: @message } }
      end
    else
      respond_to do |format|
        format.html do
          @messages = Message.between(current_user, @user)
          render :show
        end
        format.turbo_stream do
          @messages = Message.between(current_user, @user)
          render :show
        end
        format.json { render json: { status: 'error', errors: @message.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
end
