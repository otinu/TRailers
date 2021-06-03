class User < ApplicationRecord

 devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
 has_many :posts
 has_many :goods, dependent: :destroy

 has_many :user_rooms
 has_many :chats
 has_many :all_rooms, through: :user_rooms, source: :room  #N + 1問題に挑戦する場合、この記述では間違いの可能性あり。模範解答のpluckメソッドを使う方法も検証すること。

 has_one_attached :profile_image #ActiveStrage

 #validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
 #validates :introduction, length: { maximum: 50 }
 validates :post_file, content_type: { in: %w[image/jpeg image/gif image/png] },size: { less_than: 7000.kilobytes, message: "should be less than 3MB" }
end
