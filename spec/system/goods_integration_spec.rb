require 'rails_helper'

describe 'Goodsボタンのテスト' do
  let!(:user) { FactoryBot.build(:user, :first) }
  let!(:post) { FactoryBot.build(:post) }

  before "ログイン後、テスト投稿をする" do
    sign_up_as(user) # SignupSupportモジュールから呼び出し
    new_post(post)
    expect(page).to have_content "【ジャンル】Ruby"
  end

  context "Goodsボタンの動作確認" do
    it "投稿一覧ページ" do
      find('.fa-hand-holding-heart').click
    end
    it "投稿詳細ページ" do
      find('.post-glass').click
      find('.fa-hand-holding-heart').click
      expect("div#1").to have_text '1'
    end
  end
end
