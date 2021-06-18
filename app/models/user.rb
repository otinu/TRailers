class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(twitter facebook google)

  has_many :sns_credentials, dependent: :destroy

  has_many :posts
  has_many :goods, dependent: :destroy

  has_many :user_rooms
  has_many :chats
  has_many :all_rooms, through: :user_rooms, source: :room # N + 1問題に挑戦する場合、この記述では間違いの可能性あり。模範解答のpluckメソッドを使う方法も検証すること。

  has_one_attached :profile_image # ActiveStrage

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  #==================================================== バリデーション ===================================================

  validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  validates :profile_image, content_type: { in: %w(image/jpeg image/gif image/png), message: :Please_select_either_jpeg_gif_png }, size: { less_than: 100.kilobytes, message: :Please_upload_less_than_100KB }
  validates :mine_open,acceptance: { message: :need_to_be_agree }, on: :create  #利用規約のチェックボックスには既存のカラムを活用。createのみにすることで、コントローラのcount_view_mineアクションには影響を与えない。

  #====================================================   メソッド   =====================================================

  # プロフィール画像の大きさを調整
  def user_image_resize
    profile_image.variant(resize: '50x50').processed
  end

  # SNS認証
  def self.find_omniauth(auth)
    begin # 例外発生時はuserにnilを格納し、コントローラでのrescue処理へ誘導
      sns_credentials = SnsCredential.find_by(uid: auth.uid, provider: auth.provider)
      if sns_credentials.blank?
        if User.find_by(email: auth.info.email).present? # SNS登録メールアドレスが既にTRailersで登録されているか確認
          user = User.find_by(email: auth.info.email)
          SnsCredential.create!( # 確認できた場合は該当Userと結びつくSnsCredentialのみを生成
            user_id: user.id,
            provider: auth.provider,
            uid: auth.uid,
          )
        #ユーザー名の重複の場合には、/TRailers/app/views/users/omniauth_callbacks下のビューファイルに遷移してしまうため、各エラー用のビューページを作成しました。
        elsif User.find_by(name: auth.info.name).blank? #2つ以上のSNSやTRailersの登録名と重複していないか確認
          temp_pass = Devise.friendly_token[0, 20] # ランダムなパスワードを生成
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
      else # 同じSNSで2回目以降のアクセスの場合
        user = User.find(sns_credentials.user.id) # SnsCredentialに結び付いたUserをローカル変数userに格納
      end
    rescue
      user = nil
    end
    user
  end
end
