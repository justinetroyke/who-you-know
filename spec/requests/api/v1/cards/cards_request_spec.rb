require 'rails_helper'

describe "Cards API" do
  context 'User requests unsorted cards' do
    it "returns a list of 30 cards without a difficulty level" do
      user = create(:user)
      card = create(:card)

      35.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id)
      end

      10.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 1)
      end

      get '/api/v1/cards'

      expect(response).to be_successful
      user_cards = JSON.parse(response.body)

      expect(user_cards.count).to eq(30)
      expect(user_cards.first['difficulty']).to eq("unsorted")
    end
  end

  context "User requests cards with easy difficulty level" do
    it "returns a list of 12 cards, 8 easy, 2 medium and 2 hard" do
      user = create(:user)
      card = create(:card)

      35.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id)
      end

      10.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 1)
      end

      10.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 2)
      end

      10.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 3)
      end

      get '/api/v1/cards?difficulty=easy'

      expect(response).to have_http_status(200)
      user_cards = JSON.parse(response.body)
      expect(user_cards.count).to eq(12)

      difficulties = user_cards.map { |card| card["difficulty"] }
      counts = difficulties.inject(Hash.new(0)) { |total, level| total[level] += 1; total}

      expect(counts["easy"]).to eq(8)
      expect(counts["medium"]).to eq(2)
      expect(counts["hard"]).to eq(2)
    end
  end
end
