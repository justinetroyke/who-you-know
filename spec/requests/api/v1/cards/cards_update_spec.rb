require 'rails_helper'

describe "Cards API" do
  it "updates a card's difficulty level" do
    user = create(:user)
    card = create(:card)
    user_card = UserCard.create!(user: user, card: card)

    expect(user_card.unsorted?).to be true

    put "/api/v1/cards/#{user_card.id}?difficulty=medium"

    expect(user_card.unsorted?).to be false
    expect(user_card.medium?).to be true

    expect(response).to have_http_status(200)
  end
end
