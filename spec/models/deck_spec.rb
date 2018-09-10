require 'rails_helper'

RSpec.describe Deck, type: :model do
  describe '#get_cards("unsorted")' do
    it 'should return a deck of 30 unsorted cards' do
      user = create(:user)
      card = create(:card)

      35.times do |num|
        UserCard.create!(user_id: user.id, card_id: card.id)
      end

      deck = Deck.new("unsorted")
      cards = deck.get_cards

      expect(cards).to be_a(Array)
      expect(cards.count).to eq(30)
      expect(cards.first).to be_a(Card)
      expect(cards.first.first_last_name).to eq(card.first_last_name)
    end
  end

  describe '#get_cards(difficulty)' do
    it 'should return a deck of 12 cards' do
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

      deck = Deck.new("easy")
      cards = deck.get_cards

      expect(cards).to be_a(Array)
      expect(cards.count).to eq(12)
      expect(cards.first).to be_a(Card)
      expect(cards.first.first_last_name).to eq(card.first_last_name)
    end
  end
end
