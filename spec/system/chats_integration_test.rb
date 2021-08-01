require 'rails_helper'

describe 'Chat送信のテスト' do
let!(:user1) { FactoryBot.build(:user, :first) }
let!(:user2) { FactoryBot.build(:user, :second) }

  it "メッセージの送信", js: true do
    sign_up_as(user1)
    visit chat_path(user1)
    fill_in 'chat[message]', with: "こんにちわ"
    find("#chat_message").send_keys :return
    expect(page).to have_content "こんにちわ"
  end
end