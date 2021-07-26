require 'rails_helper'

describe 'Goods数の公開・表示テスト' do
let!(:user1) { FactoryBot.build(:user, :first) }
let!(:user2) { FactoryBot.build(:user, :second) }
let!(:post) { FactoryBot.build(:post) }

  context "自分のGoods数非公開" do
    it "自分のGoods数を非公開に変更" do
        sign_up_as(user1)  # SignupSupportモジュールから呼び出し
        new_post(post)
        expect(page).to have_content "【ジャンル】Ruby"
        visit user_path(user1)
        find('.fa-display-slash').click
        visit posts_path
        within "div#1" do
          expect("div#1").to have_text '1'
        end
        click_on 'Logo'
      end
    it "別ユーザーで非公開を確認" do
      sign_up_as(user2)
      visit posts_path
      expect(page).to have_no_css "div#1"
    end
  end
end