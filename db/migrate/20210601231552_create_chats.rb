class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.bigint :user_id, null: false
      t.bigint :room_id, null: false
      t.string :message
      t.timestamps
    end
    add_foreign_key :chats, :users
    add_foreign_key :chats, :rooms
  end
end
