class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, length: { maximum: 50, minimum: 1}
end
