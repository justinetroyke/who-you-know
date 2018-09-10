class Deck
  def initialize(difficulty)
    @difficulty = difficulty
    @cards = []
    @levels = ["easy", "medium", "hard"]
  end

  def get_cards
    if @difficulty == "unsorted"
      unsorted_deck
    else
      sorted_deck
    end
  end

  def unsorted_deck
    user_cards = UserCard.where(difficulty: "unsorted").take(30)
    ids = user_cards.map { |card| card.card_id }
    ids.map { |id| Card.find(id) }
  end

  def sorted_deck
    @cards << UserCard.where(difficulty: @difficulty).take(8)
    @levels.delete(@difficulty)
    @levels.each { |level| @cards << UserCard.where(difficulty: level).take(2) }
    user_cards = @cards.flatten.shuffle
    ids = user_cards.map { |card| card.card_id }
    ids.map { |id| Card.find(id) }
  end
end
