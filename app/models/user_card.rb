class UserCard < ApplicationRecord
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  validates_presence_of :difficulty
  belongs_to :user
  belongs_to :card

  def self.sort_deck(difficulty="unsorted")
    if difficulty == "easy"
      easy_deck
    elsif difficulty == "medium"
      medium_deck
    elsif difficulty == "hard"
      hard_deck
    else
      UserCard.where(difficulty: "unsorted").take(30)
    end
  end

  def self.easy_deck
    deck = []
    deck << UserCard.where(difficulty: "easy").take(8)
    deck << UserCard.where(difficulty: "medium").take(2)
    deck << UserCard.where(difficulty: "hard").take(2)
    deck.flatten.shuffle
  end

  def self.medium_deck
    deck = []
    deck << UserCard.where(difficulty: "easy").take(2)
    deck << UserCard.where(difficulty: "medium").take(8)
    deck << UserCard.where(difficulty: "hard").take(2)
    deck.flatten.shuffle
  end

  def self.hard_deck
    deck = []
    deck << UserCard.where(difficulty: "easy").take(2)
    deck << UserCard.where(difficulty: "medium").take(2)
    deck << UserCard.where(difficulty: "hard").take(8)
    deck.flatten.shuffle
  end
end
