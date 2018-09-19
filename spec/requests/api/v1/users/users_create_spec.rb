require 'rails_helper'

describe "User API" do
  context "User posts LinkedIn user info with all required parameters" do
    it "returns 201 status and message that user was created successfully" do
      expect(User.all.count).to eq(0)

      payload = {
                  api_key: '839rh0f23hnf0c9frpj3nr2[dc8o9rt',
                  id_token: '2983rhoifb98230porjdnecjbvg]20h9f-3u1ejowd'
                }

      stub_request(:get, "https://api.linkedin.com/v2/me/").
          with(
            headers: {
                     'Host': 'api.linkedin.com',
                     'Connection'=>'Keep-Alive',
                     'Authorization'=>"Bearer 839rh0f23hnf0c9frpj3nr2[dc8o9rt"
                      }).
                    to_return(status: 200,
                              body: '{
                                    "id": "48hfd02w93",
                                    "firstName": {
                                      "localized": {
                                        "en_US": "Bob"
                                      },
                                      "preferredLocale": {
                                        "country": "US",
                                        "language": "en"
                                      }
                                    },
                                    "lastName": {
                                      "localized": {
                                        "en_US": "Smith"
                                      },
                                      "preferredLocale": {
                                        "country": "US",
                                        "language": "en"
                                      }
                                    },
                                    "location": {
                                      "countryCode": "us",
                                      "postalCode": "94101",
                                      "standardizedLocationUrn": "urn:li:standardizedLocationKey:(us,94101)"
                                    },
                                    "positions": {
                                      "660879450": {
                                        "companyName": {
                                          "localized": {
                                            "en_US": "LinkedIn"
                                          },
                                          "preferredLocale": {
                                            "country": "US",
                                            "language": "en"
                                          }
                                        },
                                        "id": 660879450,
                                        "title": {
                                          "localized": {
                                            "en_US": "Staff Software Engineer"
                                          },
                                          "preferredLocale": {
                                            "country": "US",
                                            "language": "en"
                                          }
                                        }
                                      }
                                    },
                                    "headline": {
                                      "localized": {
                                        "en_US": "API Enthusiast at LinkedIn"
                                      },
                                      "preferredLocale": {
                                        "country": "US",
                                        "language": "en"
                                      }
                                    }
                                  }',
                              headers: {}
                             )

      post "/api/v1/users", params: payload
      returned = JSON.parse(response.body)

      expect(User.all.count).to eq(1)
      expect(User.last.username).to eq("48hfd02w93")
      expect(User.last.api_key).to eq("839rh0f23hnf0c9frpj3nr2[dc8o9rt")
      expect(User.last.id_token).to eq("2983rhoifb98230porjdnecjbvg]20h9f-3u1ejowd")
      expect(response).to have_http_status(201)
      expect(returned["id"]).to eq(User.last.id)
    end
  end

  context "User posts LinkedIn user info with missing required parameters" do
    it "returns 404 status and message that required parameters are missing" do
      expect(User.all.count).to eq(0)

      payload = { }

      post "/api/v1/users", params: payload
      returned = JSON.parse(response.body)

      expect(User.all.count).to eq(0)
      expect(response).to have_http_status(400)
      expect(returned["message"]).to eq("Missing required parameters.")
    end
  end

  context "User posts LinkedIn user but user already exists" do
    it "returns correct user id and does not create duplicate user" do
      user1 = create(:user, username: "yrZCpj2Z12")

      expect(User.all.count).to eq(1)

      payload = {
                  api_key: '839rh0f23hnf0c9frpj3nr2[dc8o9rt',
                  id_token: 'if0394jnrvf0r9423okedfri420'
                }

      stub_request(:get, "https://api.linkedin.com/v2/me/").
          with(
            headers: {
                     'Host': 'api.linkedin.com',
                     'Connection'=>'Keep-Alive',
                     'Authorization'=>"Bearer 839rh0f23hnf0c9frpj3nr2[dc8o9rt"
                      }).
                    to_return(status: 200,
                              body: '{
                                    "id": "yrZCpj2Z12",
                                    "firstName": {
                                      "localized": {
                                        "en_US": "Bob"
                                      },
                                      "preferredLocale": {
                                        "country": "US",
                                        "language": "en"
                                      }
                                    },
                                    "lastName": {
                                      "localized": {
                                        "en_US": "Smith"
                                      },
                                      "preferredLocale": {
                                        "country": "US",
                                        "language": "en"
                                      }
                                    },
                                    "location": {
                                      "countryCode": "us",
                                      "postalCode": "94101",
                                      "standardizedLocationUrn": "urn:li:standardizedLocationKey:(us,94101)"
                                    },
                                    "positions": {
                                      "660879450": {
                                        "companyName": {
                                          "localized": {
                                            "en_US": "LinkedIn"
                                          },
                                          "preferredLocale": {
                                            "country": "US",
                                            "language": "en"
                                          }
                                        },
                                        "id": 660879450,
                                        "title": {
                                          "localized": {
                                            "en_US": "Staff Software Engineer"
                                          },
                                          "preferredLocale": {
                                            "country": "US",
                                            "language": "en"
                                          }
                                        }
                                      }
                                    },
                                    "headline": {
                                      "localized": {
                                        "en_US": "API Enthusiast at LinkedIn"
                                      },
                                      "preferredLocale": {
                                        "country": "US",
                                        "language": "en"
                                      }
                                    }
                                  }',
                              headers: {}
                             )

      post "/api/v1/users", params: payload
      returned = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(User.all.count).to eq(1)
      expect(returned["id"]).to eq(user1.id)
    end
  end
end
