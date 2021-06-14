class ChatsController < ApplicationController
  def show
    @companion = User.find(params[:id]) #チャット相手
    @me = current_user
    rooms = current_user.all_rooms
    user_rooms = UserRoom.find_by(user_id: @companion.id, room_id: rooms)  # roomsで取得した全ルームの中から、ログインユーザーとチャット相手のidが入ったユーザールームがあるか検索
    if user_rooms.nil?                                                # 検索にヒットしない場合は新規ユーザールームを作成
      @room = Room.create
      UserRoom.create(user_id: @companion.id, room_id: @room.id)           # 以降は新規作成したユーザールームをどちらも検索にヒットするようにユーザールームは二つ作成
      UserRoom.create(user_id: @me.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)

    @@companion = @companion.id # チャット相手のidを通知するため、クラス変数に格納
  end

  def create
    @chat = current_user.chats.new(chat_params)
    unless @chat.save #51文字以上のチャットメッセージの場合は「送れない」旨を表示
     @chat.message = "Can't send over 51 characters"
    end

    # チャットの通知はクラス変数を利用する関係でモデルからインスタンスメソッドの呼び出しはせず、処理の内容を直接記述
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
