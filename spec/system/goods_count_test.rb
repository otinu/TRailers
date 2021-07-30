require 'rails_helper'

describe 'Goods数の公開・表示テスト' do
let!(:user1) { FactoryBot.build(:user, :first) }
let!(:user2) { FactoryBot.build(:user, :second) }
let!(:post) { FactoryBot.build(:post) }
let(:rspec_session) { { user_id: 1 } }

  before "2ユーザー間共有の投稿データを生成" do
    post = Post.create(user_id: 1, title: "Get set", tag_list: "Rails", explanation: "テスト用の投稿です")
    post.post_file.attach(io: File.open('app/assets/images/HTML_sample.pdf'), filename: 'HTML_sample.pdf')
    sign_up_as(user1)  # SignupSupportモジュールから呼び出し
  end

  context "自分のGoods数非公開" do
    it "自分のGoods数を非公開に変更" do
      new_post(post)
      visit user_path(user1)
      find('.fa-display-slash').click
      visit posts_path
      expect("div#1").to have_text '1'
      click_on 'Logo'
      sign_up_same_session(user2)
      visit posts_path
      has_no_field?("div#1")
    end
  end
end