require "rails_helper"

describe "SNS認証のテスト" do
  let!(:user) { FactoryBot.build(:user, :third) }

  before "Googleでのログイン準備" do
    OmniAuth.config.mock_auth[:google] = nil
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = google_oauth_mock
  end

  before "Twitterでのログイン準備" do
    OmniAuth.config.mock_auth[:twitter] = nil
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = twitter_oauth_mock
  end

  it "Googleでログイン" do
    visit new_user_session_path
    find(".google-icon").click
    expect(current_path).to match /posts/
  end

  it "Twitterでログイン" do
    visit new_user_session_path
    find(".fa-twitter-square").click
    expect(current_path).to match /posts/
  end
end
