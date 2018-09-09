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
end
