require 'rails_helper'

describe "User API" do
  context "User posts LinkedIn user info with all required parameters" do
    it "returns 201 status and message that user was created successfully" do
      expect(User.all.count).to eq(0)

      payload = {
                  api_key: '839rh0f23hnf0c9frpj3nr2[dc8o9rt',
                  id_token: '2983rhoifb98230porjdnecjbvg]20h9f-3u1ejowd'
                }

      post "/api/v1/users", params: payload
      returned = JSON.parse(response.body)

      expect(User.all.count).to eq(1)
      expect(User.last.username).to eq("nil")
      expect(User.last.api_key).to eq("839rh0f23hnf0c9frpj3nr2[dc8o9rt")
      expect(User.last.id_token).to eq("2983rhoifb98230porjdnecjbvg]20h9f-3u1ejowd")
      expect(response).to have_http_status(201)
      expect(returned["message"]).to eq("User created successfully.")
    end
  end

  context "User posts LinkedIn user info with missing required parameters" do
    it "returns 404 status and message that required parameters are missing" do
      expect(User.all.count).to eq(0)

      payload = { id_token: '2983rhoifb98230porjdnecjbvg]20h9f-3u1ejowd' }

      post "/api/v1/users", params: payload
      returned = JSON.parse(response.body)

      expect(User.all.count).to eq(0)
      expect(response).to have_http_status(400)
      expect(returned["message"]).to eq("Missing required parameters.")
    end
  end
end
