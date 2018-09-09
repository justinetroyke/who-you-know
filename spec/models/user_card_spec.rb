require 'rails_helper'

RSpec.describe UserCard, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:difficulty) }
  end

  describe 'relationships' do
    it { should belong_to(:card) }
    it { should belong_to(:user) }
  end

  describe 'methods' do
    describe '.sort_deck(difficulty)' do
      it 'should return a deck of 30 cards to sort' do
        user = create(:user)
        card = create(:card)

        35.times do |num|
          UserCard.create!(user_id: user.id, card_id: card.id)
        end

        deck = UserCard.sort_deck("unsorted")

        expect(deck.count).to eq(30)
        expect(deck.first[:difficulty]).to eq("unsorted")
      end
    end

    describe '.get_deck(difficulty)' do
      it 'should return a deck of 12 cards with correct difficulty' do
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

        deck = UserCard.get_deck("easy")
        expect(deck.count).to eq(12)

        difficulties = deck.map { |card| card["difficulty"] }
        counts = difficulties.inject(Hash.new(0)) { |total, level| total[level] += 1; total}

        expect(counts["easy"]).to eq(8)
        expect(counts["medium"]).to eq(2)
        expect(counts["hard"]).to eq(2)
      end
    end
  end
end
