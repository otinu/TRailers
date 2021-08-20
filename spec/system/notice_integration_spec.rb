require "rails_helper"

describe "通知機能のテスト" do
  let!(:user) { FactoryBot.build(:user, :first) }

  it "通知一覧" do
    sign_up_as(user)
    post = Post.new(id: 1, user_id: 1, title: "通知のテスト", tag_list: "Test", explanation: "通知機能テストの用データです")
    post.post_file.attach(io: File.open('app/assets/images/Ruby_sample.png'), filename: 'Ruby_sample.png')
    sleep 2
    post.save
    User.create(id: 2, name: "Locomotive", email: Faker::Internet.email, mine_open: Faker::Boolean.boolean(true_ratio: 1), others_open: Faker::Boolean.boolean(true_ratio: 1), password: 'password', password_confirmation: 'password')
    sleep 0.5
    Chat.create(user_id: 1, room_id: 1, message: :EveryDay_TRailers)
    sleep 0.5
    Good.create(post_id: 1, user_id: 2)
    sleep 0.5
    UserRoom.create(user_id: 1, room_id: 1)
    sleep 0.5
    UserRoom.create(user_id: 2, room_id: 1)
    sleep 0.5
    Notification.create(visited_id: 1, visiter_id: 2, post_id: 1, action: "Chat", checked: false)
    sleep 0.5
    Notification.create(visited_id: 1, visiter_id: 2, post_id: 1, action: "Goods", checked: false)
    sleep 0.5
    visit notifications_path
    find(".fa-box-heart")
    expect(page).to have_content "From【Locomotive】"
    find(".fa-comment-captions")
    expect(page).to have_content "Arrived_Locomotive"
  end
end
