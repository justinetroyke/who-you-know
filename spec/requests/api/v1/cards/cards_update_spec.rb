require 'rails_helper'

describe "Cards API" do
  it "updates a card's difficulty level" do
    user = create(:user)
    card = create(:card)
    user_card = UserCard.create!(user_id: user.id, card_id: card.id)

    expect(user_card.unsorted?).to be true

    put "/api/v1/user_cards/#{user_card.id}?difficulty=medium"

    user_card = JSON.parse(response.body)

    expect(user_card["difficulty"]).to_not eq("unsorted")
    expect(user_card["difficulty"]).to eq("medium")

    expect(response).to have_http_status(200)
  end
end
