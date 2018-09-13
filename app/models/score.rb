class Score < ApplicationRecord
  validates_presence_of :difficulty, :num_played, :num_correct
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  belongs_to :user

  def self.averages(user_id)
    easy = self.where(difficulty: "easy", user_id: user_id)
    easy_total_num = 0
    easy_total_correct = 0
    easy.each do |score|
      easy_total_num += score.num_played
      easy_total_correct += score.num_correct
    end
    easy_average = ((easy_total_correct.to_f/easy_total_num) * 100).round(1)

    medium = self.where(difficulty: "medium", user_id: user_id)
    medium_total_num = 0
    medium_total_correct = 0
    medium.each do |score|
      medium_total_num += score.num_played
      medium_total_correct += score.num_correct
    end
    medium_average = ((medium_total_correct.to_f/medium_total_num) * 100).round(1)

    hard = self.where(difficulty: "hard", user_id: user_id)
    hard_total_num = 0
    hard_total_correct = 0
    hard.each do |score|
      hard_total_num += score.num_played
      hard_total_correct += score.num_correct
    end
    hard_average = ((hard_total_correct.to_f/hard_total_num) * 100).round(1)

    { easy: "#{easy_average}%", medium: "#{medium_average}%", hard: "#{hard_average}%"}
  end
end
