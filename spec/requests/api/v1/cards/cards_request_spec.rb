require 'rails_helper'

describe "Cards API" do
  describe "User has at least 30 unsorted, 8 easy, 8 medium and 8 hard cards" do
    before :each do
      @user = create(:user)
      card = create(:card)

      35.times do |num|
        UserCard.create!(user_id: @user.id, card_id: card.id)
      end

      10.times do |num|
        UserCard.create!(user_id: @user.id, card_id: card.id, difficulty: 1)
      end

      10.times do |num|
        UserCard.create!(user_id: @user.id, card_id: card.id, difficulty: 2)
      end

      10.times do |num|
        UserCard.create!(user_id: @user.id, card_id: card.id, difficulty: 3)
      end
    end

    context 'User requests unsorted cards' do
      it "returns a list of 30 cards without a difficulty level" do
        get "/api/v1/users/#{@user.id}/cards"

        expect(response).to have_http_status(200)
        cards = JSON.parse(response.body)
        user_card_1 = UserCard.find_by(card_id: cards.first["id"])

        expect(cards.count).to eq(30)
        expect(user_card_1['difficulty']).to eq("unsorted")
        expect(user_card_1['user_id']).to eq(@user.id)
      end
    end

    context "User requests cards with a difficulty level" do
      it "returns a list of 12 cards" do
        get '/api/v1/cards?difficulty=easy'

        expect(response).to have_http_status(200)
        cards = JSON.parse(response.body)
        expect(cards.count).to eq(12)
      end
    end
  end

  describe "User has less than 30 unsorted cards" do
    context 'User requests unsorted cards' do
      it "returns the remaining unsorted cards" do
        user = create(:user)
        card = create(:card)

        20.times do |num|
          UserCard.create!(user_id: user.id, card_id: card.id)
        end

        get '/api/v1/cards'

        expect(response).to have_http_status(200)
        cards = JSON.parse(response.body)
        user_card_1 = UserCard.find_by(card_id: cards.first["id"])

        expect(cards.count).to eq(20)
        expect(user_card_1['difficulty']).to eq("unsorted")
      end
    end
  end

  describe "User has 0 unsorted cards" do
    context 'User requests unsorted cards' do
      it "returns a 400 status and message" do
        get '/api/v1/cards'

        expect(response).to have_http_status(400)
        returned = JSON.parse(response.body)

        expect(returned["message"]).to eq("User has sorted all their cards.")
      end
    end
  end

  describe "User has less than 8 easy cards" do
    context 'User requests an easy deck' do
      it "returns 400 status and message" do
        user = create(:user)
        card = create(:card)

        20.times do |num|
          UserCard.create!(user_id: user.id, card_id: card.id)
        end

        5.times do |num|
          UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 1)
        end

        10.times do |num|
          UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 2)
        end

        10.times do |num|
          UserCard.create!(user_id: user.id, card_id: card.id, difficulty: 3)
        end

        get '/api/v1/cards?difficulty=easy'

        expect(response).to have_http_status(400)
        returned = JSON.parse(response.body)

        expect(returned["message"]).to eq("User must sort more cards.")
      end
    end
  end
end
