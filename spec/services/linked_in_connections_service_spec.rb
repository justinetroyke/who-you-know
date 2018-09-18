require "rails_helper"

describe "saves connections from linkedin to database" do
  it 'saves connections as cards' do
    user = User.create!(username: "rfdberg", id_token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IlJqYzNNRVUzTXpSRFFUY3lSamxDT0RZek16YzVNe
lkzUkVFNVFqVTFSa1U1TkROQlFqZ3dSQSJ9.eyJpc3MiOiJodHRwczovL3doby15b3Uta25vdy1mZS5hdXRoMC5jb20vIiwic3ViIjoibGlua2VkaW58V2dNelZjb0ZYTCIsImF1ZCI6InBJ
bUhPS3YzN0pSRW9rSHd2MmtoUWhWaXZ1BUy9r0DzjrThRhA1O5fzkp6xWkDqL1MOhQG9RiMYEXUB98TmLt8sttYO5d842n4pA")
    user_id = user.id
    username = "rfdberg@gmail.com"
    password = "YaYouKnowMe1803"

    cards = Card.all
    expect(cards.count).to eq(0)

    service = LinkedInConnectionsService.new(username, password, user_id)
    service.import_connections

    user_cards = User.find_by(id: user_id).cards
    expect(cards.count).to eq(6)
    expect(cards.first[:first_last_name]).to eq("Haley Mesander")
    binding.pry
    expect(user_cards.count).to eq(6)
  end
end
