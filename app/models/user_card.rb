class UserCard < ApplicationRecord
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  validates_presence_of :difficulty
  belongs_to :user
  belongs_to :card
end
