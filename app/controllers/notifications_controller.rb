class NotificationsController < ApplicationController
  def index
    if current_user.passive_notifications.find_by(action: "Goods", checked: false).presence
      @notifications = current_user.passive_notifications.includes([:visiter], [:post]).where(checked: false)
    else
      @notifications = current_user.passive_notifications.includes([:visiter]).where(checked: false)
    end
  end

  def destroy_all_your_notifications
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
