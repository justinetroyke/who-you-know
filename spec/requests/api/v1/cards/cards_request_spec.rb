require 'rails_helper'

describe "Cards API" do
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
