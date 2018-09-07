FactoryBot.define do
  factory :user do
    username Faker::HowIMetYourMother.character
    api_key Faker::Crypto.sha1
  end
end
