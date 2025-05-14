class NotificationsController < ApplicationController
  before_action :require_user
  before_action :set_notification, only: [:show, :mark_as_read]

  def index
    @notifications = current_user.notifications
                               .includes(:notifiable)
                               .recent
                               .page(params[:page])
                               .per(20)
  end

  def show
    @notification.mark_as_read! unless @notification.read?
    
    case @notification.notification_type
    when 'message'
      message = @notification.notifiable
      if message.present? && message.sender.present?
        redirect_to chat_path(message.sender)
      else
        redirect_to chats_path, alert: "El mensaje ya no está disponible"
      end
    when 'follow'
      follow = @notification.notifiable
      if follow.present? && follow.follower.present?
        redirect_to user_path(follow.follower)
      else
        redirect_to dashboard_path, alert: "El usuario ya no está disponible"
      end
    when 'like', 'comment'
      interaction = @notification.notifiable
      if interaction.present? && interaction.post.present?
        redirect_to post_path(interaction.post)
      else
        redirect_to posts_path, alert: "La publicación ya no está disponible"
      end
    else
      redirect_to dashboard_path
    end
  rescue StandardError => e
    Rails.logger.error("Error al redirigir notificación: #{e.message}")
    redirect_to notifications_path, alert: "No se pudo cargar el contenido relacionado con esta notificación."
  end

  def mark_as_read
    @notification.mark_as_read!
    respond_to do |format|
      format.html { redirect_back(fallback_location: notifications_path) }
      format.json { render json: { success: true } }
    end
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true)
    respond_to do |format|
      format.html { redirect_back(fallback_location: notifications_path) }
      format.json { render json: { success: true } }
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end
