module SigninSupport
  def google_oauth_mock
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
      provider: 'google',
      uid: rand(100000000..999999999),
      info: {
        :name => Faker::Lorem.characters(number: 10),
        :email => Faker::Internet.email
      },
      credentials: {
        token: 'token'
      }
    )
  end
  def twitter_oauth_mock
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: rand(100000000..999999999),
      info: {
        :name => Faker::Lorem.characters(number: 10),
        :email => Faker::Internet.email
      },
      credentials: {
        token: 'token'
      }
    )
  end
end