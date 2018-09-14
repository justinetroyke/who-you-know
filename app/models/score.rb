class Score < ApplicationRecord
  validates_presence_of :difficulty, :num_played, :num_correct
  enum difficulty: [ :unsorted, :easy, :medium, :hard ]
  belongs_to :user

  def self.averages(user_id)
    levels = ["easy", "medium", "hard"]
    averages = levels.map { |level| self.calculate_average(level, user_id) }
    scores = { easy: "#{averages[0]}%", medium: "#{averages[1]}%", hard: "#{averages[2]}%"}
    scores.each { |k,v| scores[k] = "No scores recorded." if v == "NaN%" }
  end

  def self.calculate_average(level, user_id)
    scores = self.where(difficulty: level, user_id: user_id)
    total = scores.sum(&:num_played)
    correct = scores.sum(&:num_correct)
    ((correct.to_f/total) * 100).round(1)
  end
end
