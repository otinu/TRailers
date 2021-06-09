class Post < ApplicationRecord
  belongs_to :user
  has_many :goods, dependent: :destroy
  has_one_attached :post_file #ActiveStrage

  #validates :title, presence: true, length: { maximum: 20, minimum: 2 }, uniqueness: true
  #validates :explanation, presence: true, length:  { maximum: 1000 }
  validates :post_file, content_type: { in: %w[image/jpeg image/gif image/png application/pdf video/mp4], message: "Please update other file" },
                        size: { less_than: 3.megabytes, message: "should be less than 3MB" }

  acts_as_taggable_on :tags

  has_many :notifications, dependent: :destroy

  def is_goods?(user)
   goods.where(user_id: user.id).exists?
  end

 def post_image_resize
    post_file.variant(gravity: :center, resize:"200x200^", crop:"210x210+0+0").processed
 end

 def user_image_resize
    profile_image.variant(resize_to_limit: [500, 500]).processed
 end

  def self.search_for(keyword)
    where(["title like? OR explanation like?", "%#{keyword}%", "%#{keyword}%"]) #WHERE句内でLIKEを使用し、ワイルドカード「%」でキーワードを挟みこむことで部分一致を実行
  end

  def create_notification_goods(user)
      temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ? ", user.id, user_id, id, 'Goods'])
      if temp.blank?
        notification = user.active_notifications.new(post_id: id, visited_id: user_id, action: 'Goods')
        if notification.visiter_id == notification.visited_id # 自分の投稿に対するいいねの場合は、通知済みとする
          notification.checked = true
        end
        notification.save
      end
  end

end
