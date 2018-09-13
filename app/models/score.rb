class Score < ApplicationRecord
  validates_presence_of :difficulty, :num_played, :num_correct
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  belongs_to :user
end
