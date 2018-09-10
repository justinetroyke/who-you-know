class Api::V1::CardsController < ApplicationController
  def index
    deck = Deck.new(params[:difficulty] ||= "unsorted").get_cards
    render json: deck
  end
end
