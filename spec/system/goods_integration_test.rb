require 'rails_helper'

describe 'Goodsボタンのテスト' do
let!(:user) { FactoryBot.build(:user) }
let!(:post) { FactoryBot.build(:post) }

  before "ログイン後、テスト投稿をする" do
    sign_up_as(user)  # SignupSupportモジュールから呼び出し
    new_post(post)
    expect(page).to have_content "【ジャンル】Ruby"
  end
  
  it "投稿一覧ページでのGoodsボタン動作確認" do
    within "div#1" do
      find('.fa-hand-holding-heart').click
      expect("div#1").to have_text '1' 
    end
  end
  it "投稿詳細ページでのGoodsボタン動作確認" do
    within "div#1" do
        find('.post-glass').click
    end
     within "div#1" do
      find('.fa-hand-holding-heart').click
      expect("div#1").to have_text '1' 
    end
  end
end