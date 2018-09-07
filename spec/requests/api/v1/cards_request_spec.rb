require 'rails_helper'

describe "Cards API" do
  it "returns a list of 30 cards without a difficulty level" do
    create_list(:card, 35)

    get '/api/v1/cards'

    expect(response).to be_successful
    cards = JSON.parse(response.body)

    expect(cards.count).to eq(30)
  end
end
