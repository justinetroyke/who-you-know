require 'rails_helper'

RSpec.describe Score, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:difficulty) }
    it { should validate_presence_of(:num_played) }
    it { should validate_presence_of(:num_correct) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'class methods' do
    describe '.averages(user_id)' do
      it 'should return hash of average scores for each difficulty level' do
        user = create(:user)
        user.scores.create!(difficulty: 1, num_played: 10, num_correct: 8)
        user.scores.create!(difficulty: 1, num_played: 10, num_correct: 6)
        user.scores.create!(difficulty: 2, num_played: 10, num_correct: 6)
        user.scores.create!(difficulty: 2, num_played: 10, num_correct: 4)
        user.scores.create!(difficulty: 3, num_played: 10, num_correct: 4)
        user.scores.create!(difficulty: 3, num_played: 10, num_correct: 2)

        scores = Score.averages(user.id)

        expect(scores).to be_a(Hash)
        expect(scores[:easy]).to eq("70.0%")
        expect(scores[:medium]).to eq("50.0%")
        expect(scores[:hard]).to eq("30.0%")
      end
    end

    describe '.calculate_average(level, user_id)' do
      it 'should return average score for a single difficulty level' do
        user = create(:user)
        user.scores.create!(difficulty: 1, num_played: 10, num_correct: 8)
        user.scores.create!(difficulty: 1, num_played: 10, num_correct: 6)

        avg_score= Score.calculate_average("easy", user.id)

        expect(avg_score).to be_a(Float)
        expect(avg_score).to eq(70.0)
      end
    end
  end
end
