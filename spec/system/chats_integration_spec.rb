require 'rails_helper'

describe 'Chat送信のテスト' do
  let!(:user) { FactoryBot.build(:user, :first) }

  it "メッセージの送信", js: true do
    sign_up_as(user)
    visit chat_path(user)
    fill_in 'chat[message]', with: "こんにちわ"
    find("#chat_message").send_keys :return
    expect(page).to have_content "こんにちわ"
  end
end
