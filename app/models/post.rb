class Post < ApplicationRecord
  belongs_to :user
  has_many :goods, dependent: :destroy
  has_one_attached :post_file # ActiveStrage
  has_many :notifications, dependent: :destroy
  acts_as_taggable_on :tags #タグ(ジャンル)付け

  #==================================================== バリデーション ===================================================
  validates :title, presence: true,
                    length: { maximum: 20, minimum: 2,message: :under_from_2_to_20_characters },
                    uniqueness: true

  validates :explanation, presence: true, length:  { maximum: 500, message: :Please_write_explanation_under_500_characters }
  validates :post_file, presence: true, content_type: { in: %w(image/jpeg image/gif image/png application/pdf video/mp4), message: :Please_upload_other_file },
                        size: { less_than: 3.megabytes, message: :Please_upload_less_than_3MB }

  #====================================================   メソッド   =====================================================

  def is_goods?(user)
    goods.where(user_id: user.id).exists?
  end

  def user_image_resize
    profile_image.variant(resize_to_limit: [500, 500]).processed
  end

  def self.search_for(keyword)
    where(["title like? OR explanation like?", "%#{keyword}%", "%#{keyword}%"]) # WHERE句内でLIKEを使用し、ワイルドカード「%」でキーワードを挟みこむことで部分一致を実行
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
