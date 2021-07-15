class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, length: { maximum: 50, minimum: 1 }

  def self.create_user_room(room, companion, me)
    UserRoom.create(user_id: companion, room_id: room)
    UserRoom.create(user_id: me, room_id: room)
  end

  def self.make_notification(companion, current_user)
    user = User.find(companion)
    temp = Notification.where(visiter_id: current_user, visited_id: companion, action: "Chat")
    if temp.blank?
      user.passive_notifications.create(visiter_id: current_user, action: "Chat")
    end
  end
end
