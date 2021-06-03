class Post < ApplicationRecord
  belongs_to :user
    has_many :goods, dependent: :destroy

  #validates :title, presence: true, length: { maximum: 20, minimum: 2 }, uniqueness: true
  #validates :explanation, presence: true, length:  { maximum: 1000 }

  has_one_attached :post_file #ActiveStrage

  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end
end
