require 'rails_helper'

describe '【Max Red5】Postモデルのテスト', type: :model do
  before do
    @post = FactoryBot.build(:post)
    @post.user = FactoryBot.build(:user)
    @post.post_file = fixture_file_upload("/lens.jpeg")
  end

  it "有効な新規投稿の場合は保存されるか" do
    expect(@post.user).to be_valid
    expect(@post.post_file).to be_valid
    expect(@post).to be_valid
  end

  it "【Red1】タイトルが21文字以上の投稿は保存されないか" do
    @post.title = Faker::Lorem.characters(number: 21)
    expect(@post).to be_valid
  end

  it "【Red2】タイトルが1文字の投稿は保存されないか" do
    @post.title = Faker::Lorem.characters(number: 1)
    expect(@post).to be_valid
  end

  it "【Red3】投稿へのコメントが501文字以上の投稿は保存されないか" do
    @post.explanation = Faker::Lorem.characters(number: 501)
    expect(@post).to be_valid
  end

  it "動画投稿は保存されるか" do
    @post.post_file = fixture_file_upload("/test.mp4")
    expect(@post).to be_valid
  end

  it "PDF投稿は保存されるか" do
    @post.post_file = fixture_file_upload("/test.pdf")
    expect(@post).to be_valid
  end

  it "【Red4】容量オーバーの投稿は保存されないか" do
    @post.post_file = fixture_file_upload("/post_over_test.mp4")
    expect(@post).to be_valid
  end

  it "【Red5】JPEG,GIF,PNG,PDF,MP4以外の投稿は保存されないか" do
    @post.post_file = fixture_file_upload("/test.css")
    expect(@post).to be_valid
  end
end
