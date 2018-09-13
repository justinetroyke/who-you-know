require 'rails_helper'

describe "Scores API" do
  context "Required parameters are given" do
    it "adds a deck score to the database and returns 201 status" do
      expect(Score.all.count).to eq(0)

      post "/api/v1/scores?difficulty=medium&num_played=12&num_correct=6"

      expect(response).to have_http_status(201)
      returned = JSON.parse(response.body)

      expect(returned["message"]).to eq("Score successfully recorded.")
      expect(Score.all.count).to eq(1)
    end
  end
end
