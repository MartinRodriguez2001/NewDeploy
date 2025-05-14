class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user if logged_in?
  end
 
  def unsubscribed
    stop_all_streams
  end
end 