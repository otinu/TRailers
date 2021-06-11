class User < ApplicationRecord

 devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: %i[twitter facebook google github]

 has_many :sns_credentials, dependent: :destroy

 has_many :posts
 has_many :goods, dependent: :destroy

 has_many :user_rooms
 has_many :chats
 has_many :all_rooms, through: :user_rooms, source: :room  #N + 1問題に挑戦する場合、この記述では間違いの可能性あり。模範解答のpluckメソッドを使う方法も検証すること。

 has_one_attached :profile_image #ActiveStrage

 has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
 has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

 validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
 #validates :introduction, length: { maximum: 50 }
 validates :profile_image, content_type: { in: %w[image/jpeg image/gif image/png] },size: { less_than: 7000.kilobytes, message: "should be less than 7000KB" }

#プロフィール画像の大きさを調整
 def user_image_resize
    profile_image.variant(gravity: :center, resize:"200x200^", crop:"210x210+0+0").processed
 end

 def self.find_omniauth(auth)
  sns_credentials = SnsCredential.find_by(uid: auth.uid, provider: auth.provider)
   unless sns_credentials.blank?                        #同じSNSで2回目以降のアクセスの場合
    user = User.find(sns_credentials.user.id)           #SnsCredentialに結び付いたUserをローカル変数userに格納
   else
    temp_pass = Devise.friendly_token[0,20]             #ランダムなパスワードを生成
    if User.find_by(email: auth.info.email).present?    #SNS登録メールアドレスが既にTRailersで登録されているか確認
     user = User.find_by(email: auth.info.email)
     SnsCredential.create!(                             #確認できた場合は該当Userと結びつくSnsCredentialのみを生成
      user_id: user.id,
      provider: auth.provider,
      uid: auth.uid,
     )
    else
     user = User.create!(                               #確認できなかった場合はUser、SnsCredentialともに新規で生成
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
    end
   end
   return user
 end

end
