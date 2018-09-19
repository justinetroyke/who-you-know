require 'rails_helper'

describe 'LinkedIn Service' do
  describe '#get_linkedin_id' do
    it "returns a user's unique linkedin id" do
      user = create(:user)

      stub_request(:get, "https://api.linkedin.com/v2/me/").
          with(
            headers: {
                     'Host': 'api.linkedin.com',
                     'Connection'=>'Keep-Alive',
                     'Authorization'=>"Bearer #{user.api_key}"
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

      linkedin_service = LinkedInService.new(user)
      actual = linkedin_service.get_linkedin_id

      expect(actual).to eq('yrZCpj2Z12')
    end
  end
end
