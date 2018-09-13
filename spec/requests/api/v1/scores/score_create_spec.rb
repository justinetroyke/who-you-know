require 'rails_helper'

describe "Scores API" do
  context "Required parameters are given" do
    it "adds a score to the database and returns 201 status and message" do
      user = create(:user)

      expect(Score.all.count).to eq(0)
      expect(user.scores.count).to eq(0)

      post "/api/v1/users/#{user.id}/scores?difficulty=medium&num_played=12&num_correct=6"

      expect(response).to have_http_status(201)
      returned = JSON.parse(response.body)

      expect(returned["message"]).to eq("Score successfully recorded.")
      expect(Score.all.count).to eq(1)
      expect(user.scores.count).to eq(1)
    end
  end

  context "Required parameters are missing" do
    it "returns 400 status and message" do
      user = create(:user)

      expect(Score.all.count).to eq(0)
      expect(user.scores.count).to eq(0)

      post "/api/v1/users/#{user.id}/scores?difficulty=medium&num_played=12" # missing num_correct parameter

      expect(response).to have_http_status(400)
      returned = JSON.parse(response.body)

      expect(returned["message"]).to eq("Some required score parameters are missing")
      expect(Score.all.count).to eq(0)
      expect(user.scores.count).to eq(0)
    end
  end
end
