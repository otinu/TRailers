class Notification < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :post, optional: true #nilを許可する

  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
