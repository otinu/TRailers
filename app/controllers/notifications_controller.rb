class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  def destroy_all_your_notifications
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
