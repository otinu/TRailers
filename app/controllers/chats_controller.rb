class ChatsController < ApplicationController
  def show
#ここでは、@userは「相手」、current_userは「自分」と考えると分かりやすい。
@user = User.find(params[:id])
#Userモデルでthroughを活用したことで、mapメソッドやpluckメソッドを使わずとも「all_rooms」だけでUserモデルとRoomsモデルの多対多を実現。
#おそらく、この方法だとN + 1問題が発生してしまうから模範解答はpluckメソッドでroom_idのみを取得している。
rooms = current_user.all_rooms
#rooms = current_user.user_rooms.pluck(:room_id)

#user_idが@user　且つ　room_idが上で取得したrooms配列の中にある数値のもののみ取得(1個または0個のはずです)。
# つまり、「UserRoomテーブルの中に相手のidと自分のidが両方入ったレコードはある？」 とfind_byで取りに行っている。
#find_byで2つ以上のカラムを検索させた場合、全ての条件に一致するレコードが見つからない場合にはnilを返す。
user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

if user_rooms.nil?
@room = Room.create
UserRoom.create(user_id: @user.id, room_id: @room.id)         #UserRoomテーブルに2行連続でcreateをするのは、今後は自分も相手も今回createするUserRoomレコードを参照できるようにするため
UserRoom.create(user_id: current_user.id, room_id: @room.id)
else
@room = user_rooms.room
end
#if文の中で定義した@roomに紐づくchatsテーブルのレコードを代入
@chats = @room.chats
#chats/show.html.erbのチャットの送信フォームの中には、文字を打ち込む窓以外に隠された窓がある <%= f.hidden_field :room_id %>。
#隠された窓には、「現在のチャットのid」が強制的に埋め込まれる。
@chat = Chat.new(room_id: @room.id)
end

def create
@chat = current_user.chats.create(chat_params)
end

def destroy
@chat = Chat.find(params[:id])
@room = @chat.room
@chat.destroy
@chats = @room.chats
end

=begin
@user = User.find(params[:id])
@rooms = current_user.all_rooms
@user_rooms = UserRoom.find_by(user_id: @user.id, room_id: @rooms)
if @user_rooms.nil?
@room = Room.create
UserRoom.create(user_id: @user.id, room_id: @room.id)         #UserRoomテーブルに2行連続でcreateをするのは、今後は自分も相手も今回のUserRoomレコードを参照できるようにするため。
UserRoom.create(user_id: current_user.id, room_id: @room.id)
else
@room = user_rooms.room
puts "elseを通りました"
end
@chats = @room.chats
end
=end

private
def chat_params
params.require(:chat).permit(:message, :room_id)
end
end
