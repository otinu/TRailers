require "rails_helper"

describe "SNS認証のテスト" do
  
  context "Googleでログイン" do
    let!(:user) { FactoryBot.build(:user, :third) }
    before do
      OmniAuth.config.mock_auth[:google] = nil
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] 
      Rails.application.env_config['omniauth.auth'] = google_oauth_mock()
    end
    it "responds successfully" do
      visit new_user_session_path
      find(".google-icon").click
      expect(current_path).to match (/posts/)
    end
  end
end