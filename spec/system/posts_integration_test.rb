require 'rails_helper'

describe '投稿のテスト' do
  let!(:user) { FactoryBot.build(:user) }
  let!(:post) { FactoryBot.build(:post) }

  before do
    sign_up_as(user)  # SignupSupportモジュールから呼び出し
  end

  context "投稿関連機能を確認" do
    it "新規投稿に成功する" do
      new_post(post)  # PostSupportモジュールから呼び出し
    end
    it "投稿後、投稿一覧を確認" do
      new_post(post)
      expect(page).to have_link "Ruby", href: posts_path(taggings: "Ruby")
      expect(page).to have_selector("img[src$='lens.jpeg']")
      expect(page).to have_content "【ジャンル】Ruby"
      link = find(".goods-create")
      expect(link[:href]).to eq post_goods_path(1)
      link = find(".post-glass")
      expect(link[:href]).to eq post_path(1)
      expect(page).to have_selector 'h1#arrow_top'
    end
    it "新規投稿 -> 投稿一覧 -> 投稿詳細を確認" do
      # 新規投稿
      new_post(post)
      # 投稿一覧
      within "div#1" do
        find('.post-glass').click
      end
      # 投稿詳細
      expect(page).to have_content post.user.name
      expect(page).to have_content post.title
      expect(page).to have_selector("img[src$='lens.jpeg']")
      link = find(".goods-create")
      expect(link[:href]).to eq post_goods_path(1)
      link = find(".post-glass")
      expect(link[:href]).to eq post_path(1)
      expect(page).to have_content post.explanation
      # 自身の投稿には投稿編集と投稿削除ボタンが表示
      link = find(".post-edit")
      expect(link[:href]).to eq edit_post_path(1)
      link = find(".post-destroy")
      expect(link[:href]).to eq post_path(1)
    end
    it "新規投稿 -> 投稿一覧 -> 投稿詳細 -> 投稿編集を確認 -> 編集後、投稿詳細の確認" do
      create_and_skip_show(post) # PostSupportモジュールから呼び出し
      find('.post-edit').click
      # 投稿編集を確認
      expect(page).to have_content "投稿名"
      textarea = find('#post_title')
      expect(textarea.value).to match post.title
      expect(page).to have_selector 'input#post_post_file'
      expect(page).to have_content "投稿へのコメント"
      textarea = find('#post_explanation')
      expect(textarea.value).to match post.explanation
      # 編集する
      fill_in 'post[title]', with: "C61"
      attach_file("post[post_file]", "#{Rails.root}/spec/fixtures/locomotive.png")
      fill_in 'post[explanation]', with: "高崎駅より乗車可能"
      click_button "更新する"
      # 編集後、投稿詳細の確認
      expect(page).to have_content "C61"
      expect(page).to have_selector("img[src$='locomotive.png']")
      expect(page).to have_content "高崎駅より乗車可能"
    end
  end
end
