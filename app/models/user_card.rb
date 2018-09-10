class UserCard < ApplicationRecord
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  validates_presence_of :difficulty
  belongs_to :user
  belongs_to :card

  def self.sort_deck(difficulty)
    if difficulty == "unsorted"
      deck = UserCard.where(difficulty: "unsorted").take(30)
      ids = deck.map { |card| card.card_id }
    else
      ids = get_card_ids(difficulty)
    end
    Card.retrieve_deck(ids)
  end

  def self.get_card_ids(difficulty)
    levels = ["easy", "medium", "hard"]
    deck = []
    levels.delete(difficulty)
    deck << UserCard.where(difficulty: difficulty).take(8)
    user_cards = levels.each { |level| deck << UserCard.where(difficulty: level).take(2) }
    flat_deck = deck.flatten.shuffle
    flat_deck.map { |card| card.card_id }
  end
end
