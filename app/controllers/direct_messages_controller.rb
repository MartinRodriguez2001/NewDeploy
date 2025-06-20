class DirectMessagesController < ApplicationController
  before_action :require_user
  before_action :set_conversation, only: [:index, :create]
  
  def index
    @messages = DirectMessage.between(current_user, @other_user)
                           .includes(:sender, :receiver)
                           .order(created_at: :asc)
                           .page(params[:page])
                           .per(20)
    
    @message = DirectMessage.new
  end
  
  def create
    @message = current_user.sent_messages.build(message_params)
    @message.receiver = @other_user
    
    if @message.save
      respond_to do |format|
        format.html { redirect_to direct_messages_path(user_id: @other_user.id) }
        format.json { render json: @message }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def set_conversation
    @other_user = User.find(params[:user_id])
    @conversation = DirectMessage.between(current_user, @other_user)
  end
  
  def message_params
    params.require(:direct_message).permit(:content)
  end
end 