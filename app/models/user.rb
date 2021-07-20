class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(twitter github google)

  has_many :sns_credentials, dependent: :destroy

  has_many :posts
  has_many :goods, dependent: :destroy

  has_many :user_rooms
  has_many :chats
  has_many :all_rooms, through: :user_rooms, source: :room

  has_one_attached :profile_image

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  validates :profile_image, content_type: { in: %w(image/jpeg image/gif image/png), message: :Please_select_either_jpeg_gif_png }, size: { less_than: 100.kilobytes, message: :Please_upload_less_than_100KB }
  validates :mine_open, acceptance: { message: :need_to_be_agree }, on: :create

  def user_image_resize
    profile_image.variant(resize: '50x50').processed
  end

  def self.find_omniauth(auth)
    begin
      binding.pry
      sns_credentials = SnsCredential.find_by(uid: auth.uid, provider: auth.provider)
      if sns_credentials.blank?
        if User.find_by(email: auth.info.email).present?
          user = User.find_by(email: auth.info.email)
          SnsCredential.create!(
            user_id: user.id,
            provider: auth.provider,
            uid: auth.uid,
          )
        elsif User.find_by(name: auth.info.name).blank?
          temp_pass = Devise.friendly_token[0, 20]
          user = User.create!(
            name: auth.info.name,
            email: auth.info.email,
            password: temp_pass,
            password_confirmation: temp_pass,
          )
          SnsCredential.create!(
            user_id: user.id,
            provider: auth.provider,
            uid: auth.uid,
          )
        else
          user = nil
        end
      else
        user = User.find(sns_credentials.user.id)
      end
    rescue
      user = nil
    end
    user
  end
end
