class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    if current_user
      stream_for current_user
    end
  end
 
  def unsubscribed
    stop_all_streams
  end
end 