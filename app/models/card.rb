class Card < ApplicationRecord
  validates_presence_of :first_last_name, :image_url
  has_many :user_cards
  has_many :users, through: :user_cards
end
