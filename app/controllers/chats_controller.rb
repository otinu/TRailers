class ChatsController < ApplicationController
  def show
    @companion = User.find(params[:id])
    @me = current_user
    rooms = @me.all_rooms
    user_rooms = UserRoom.find_by(user_id: @companion.id, room_id: rooms)
    if user_rooms.nil?
      @room = Room.create
      Chat.create_user_room(@room.id, @companion.id, @me.id)
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
      @chat.message = "1～50文字！" if cookies[:locale] == "ja" || cookies[:locale] == nil
      @chat.message = "1～50Characters！" if cookies[:locale] == "en"
    end
    # 通知の作成
    companion_id = @@companion
    Chat.make_notification(companion_id, current_user.id)
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
