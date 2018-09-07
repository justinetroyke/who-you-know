class UserCard < ApplicationRecord
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  validates_presence_of :difficulty
  belongs_to :user
  belongs_to :card

  def self.sort_deck
    UserCard.where(difficulty: 'unsorted').take(30)
  end
end
