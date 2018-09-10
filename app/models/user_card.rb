class UserCard < ApplicationRecord
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  validates_presence_of :difficulty
  belongs_to :user
  belongs_to :card

  def self.sort_deck(difficulty)
    if difficulty == "unsorted"
      UserCard.where(difficulty: "unsorted").take(30)
    else
      get_deck(difficulty)
    end
  end

  def self.get_deck(difficulty)
    levels = ["easy", "medium", "hard"]
    deck = []
    levels.delete(difficulty)
    deck << UserCard.where(difficulty: difficulty).take(8)
    levels.each { |level| deck << UserCard.where(difficulty: level).take(2) }
    deck.flatten.shuffle
  end
end
