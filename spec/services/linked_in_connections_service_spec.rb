require "rails_helper"

describe "saves connections from linkedin to database" do
  it 'saves connections as cards' do
    username = "jjtroyke@gmail.com"
    password = "YaYouKnowMe1803"

    cards = Card.all
    expect(cards.count).to eq(0)
# binding.pry
    service = LinkedInConnectionsService.new(username, password)
    service.import_connections

    expect(cards.count).to eq(6)
    expect(cards.first[:first_last_name]).to eq("Ruth Brand")
  end
end
