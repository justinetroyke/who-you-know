class User < ApplicationRecord
  validates_presence_of :username, :api_key
  has_many :scores
  has_many :user_cards
  has_many :cards, through: :user_cards
end
