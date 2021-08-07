require "selenium-webdriver"
require "rails_helper"

describe "jQueryのテスト" do
  let!(:user) { FactoryBot.build(:user, :first) }
  let!(:post) { FactoryBot.build(:post) }
  
  before do
    sign_up_as(user)  # SignupSupportモジュールから呼び出し
  end

  it "ユーザー詳細画面", type: :system do
    visit user_path(user)
    find('.fa-display-slash').hover
    expect(page).to have_content "あなたのGoods数を非公開にします"
    find(".fa-eye-slash").hover
    expect(page).to have_content "みんなのGoods数を非表示にします"
  end
  
end