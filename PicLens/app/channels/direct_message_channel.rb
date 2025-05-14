class DirectMessageChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_for [current_user, User.find(params[:user_id])]
    end
  end

  def unsubscribed
    stop_all_streams
  end
end 