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
    redirect_to @notification.notifiable
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
