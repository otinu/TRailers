require "selenium-webdriver"
require "rails_helper"
require 'spec_helper'

describe "jQueryのテスト" do
  let!(:user) { FactoryBot.build(:user, :first) }
  let!(:post) { FactoryBot.build(:post) }

  before do
    sign_up_as(user) # SignupSupportモジュールから呼び出し
  end

  it "ヘッダーの確認", type: :system do
    find('.navbar-toggler').click
    find(".fa-signs-post")
    find(".fa-user-pilot")
    find(".fa-hand-wave")
    find("#keyword")
    expect(page).to have_button '検索'
  end

  it "投稿詳細画面", type: :system do
    new_post(post)
    sleep 1
    find(".fa-magnifying-glass").click
    page.evaluate_script('$(".fa-magnifying-glass").removeClass("fa-solid fa-magnifying-glass fa-2x ml-5 enlarge-it")')
    find(".fa-magnifying-glass").click
    find(".fa-circle-xmark")
  end

  it "ユーザー詳細画面", type: :system do
    visit user_path(user)
    find('.fa-display-slash').hover
    expect(page).to have_content "あなたのGoods数を非公開にします"
    find(".fa-eye-slash").hover
    expect(page).to have_content "みんなのGoods数を非表示にします"
  end
end
