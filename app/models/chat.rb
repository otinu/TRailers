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
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ", current_user, companion, 'Chat'])
    if temp.blank?
      notification = user.passive_notifications.new(visiter_id: current_user, action: 'Chat')
      notification.save
    end
  end
end
