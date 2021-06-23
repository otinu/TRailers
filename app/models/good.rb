class Good < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.it_destroy(user, post_id)
    favorite = user.goods.find_by(post_id: post_id)
    favorite.destroy
  end
end
