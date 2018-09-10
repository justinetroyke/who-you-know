class Card < ApplicationRecord
  validates_presence_of :first_last_name
  validates_presence_of :company
  validates_presence_of :school
  validates_presence_of :job_title
  validates_presence_of :image_url
  validates_presence_of :profile_url
  has_many :user_cards
  has_many :users, through: :user_cards

  def self.retrieve_deck(card_ids)
    card_ids.map { |id| Card.find(id) }
  end

end
