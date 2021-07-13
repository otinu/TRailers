class Post < ApplicationRecord
  belongs_to :user
  has_many :goods, dependent: :destroy
  has_one_attached :post_file
  has_many :notifications, dependent: :destroy
  acts_as_taggable_on :tags

  validates :title, presence: true,
                    length: { maximum: 20, minimum: 2, message: :under_from_2_to_20_characters },
                    uniqueness: true
  validates :explanation, presence: true, length: { maximum: 500, message: :Please_write_explanation_under_500_characters }
  validates :post_file, presence: true, content_type: { in: %w(image/jpeg image/gif image/png application/pdf video/mp4), message: :Please_upload_other_file },
                        size: { less_than: 3.megabytes, message: :Please_upload_less_than_3MB }

  def is_goods?(user)
    goods.where(user_id: user.id).exists?
  end

  def user_image_resize
    profile_image.variant(resize_to_limit: [500, 500]).processed
  end

  def self.search_for(keyword)
    where(["title like? OR explanation like?", "%#{keyword}%", "%#{keyword}%"])
  end

  def create_notification_goods(current_user, post_owner, post)
    temp = Notification.where(visiter_id: current_user.id, visited_id: post_owner, post_id: post, action: "Goods")
    if temp.blank?
      notification = current_user.active_notifications.new(post_id: post, visited_id: post_owner, action: 'Goods')
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save
    end
  end
end
