class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms
  
  validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
end
