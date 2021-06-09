class User < ApplicationRecord

 devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
 has_many :posts
 has_many :goods, dependent: :destroy

 has_many :user_rooms
 has_many :chats
 has_many :all_rooms, through: :user_rooms, source: :room  #N + 1問題に挑戦する場合、この記述では間違いの可能性あり。模範解答のpluckメソッドを使う方法も検証すること。

 has_one_attached :profile_image #ActiveStrage

 has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
 has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

 #validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
 #validates :introduction, length: { maximum: 50 }
validates :profile_image, content_type: { in: %w[image/jpeg image/gif image/png] },size: { less_than: 7000.kilobytes, message: "should be less than 3MB" }

#プロフィール画像の大きさを調整
 def user_image_resize
    profile_image.variant(gravity: :center, resize:"200x200^", crop:"210x210+0+0").processed
 end

end
