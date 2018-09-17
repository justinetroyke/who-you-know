FactoryBot.define do
  factory :card do
    first_last_name { Faker::StarTrek.character }
    company { Faker::HowIMetYourMother.catch_phrase }
    school { Faker::StarTrek.location }
    job_title { Faker::HowIMetYourMother.high_five }
    image_url { "https://images.unsplash.com/photo-1529259646408-5c50deb4cf6a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b0dfd63ba103ae5ca31b1ddf0d85822f&dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb" }
    profile_url { "https://www.linkedin.com/in/justine-troyke/" }
  end
end
