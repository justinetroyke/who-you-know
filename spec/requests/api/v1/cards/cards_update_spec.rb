require 'rails_helper'

describe "Cards API" do
  context "Required parameters are given" do
    it "updates a card's difficulty level" do
      user = create(:user)
      card = create(:card)
      user_card = UserCard.create!(user_id: user.id, card_id: card.id)

      expect(user_card.unsorted?).to be true

      put "/api/v1/users/#{user.id}/cards/#{card.id}?difficulty=medium"

      user_card = JSON.parse(response.body)

      expect(user_card[0]["difficulty"]).to_not eq("unsorted")
      expect(user_card[0]["difficulty"]).to eq("medium")

      expect(response).to have_http_status(200)
    end
  end

  context "Required parameters are not given" do
    it "returns a 400 not found status" do
      user = create(:user)
      card = create(:card)
      user_card = UserCard.create!(user_id: user.id, card_id: card.id)

      put "/api/v1/users/#{user.id}/cards/#{card.id}"

      expect(response).to have_http_status(400)
    end
  end
end
