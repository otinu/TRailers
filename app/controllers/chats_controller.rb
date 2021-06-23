class ChatsController < ApplicationController
  def show
    @companion = User.find(params[:id])
    @me = current_user
    rooms = @me.all_rooms
    user_rooms = UserRoom.find_by(user_id: @companion.id, room_id: rooms)
    if user_rooms.nil?
      @room = Room.create
      UserRoom.create(user_id: @companion.id, room_id: @room.id)
      UserRoom.create(user_id: @me.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)

    @@companion = @companion.id # createアクションにて使用
  end

  def create
    @chat = current_user.chats.new(chat_params)
    unless @chat.save
      @chat.message = "1～50文字！" if cookies[:locale] == "ja"
      @chat.message = "1～50Characters！" if cookies[:locale] == "en"
    end

    companion_id = @@companion
    user = User.find(companion_id)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ", current_user.id, companion_id, 'Chat'])
    if temp.blank?
      notification = user.passive_notifications.new(visiter_id: current_user.id, action: 'Chat')
      notification.save
    end
  end

  def destroy
    @chat = Chat.find(params[:id])
    @room = @chat.room
    @chat.destroy
    @chats = @room.chats
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
