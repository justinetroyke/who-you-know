class Api::V1::CardsController < ApplicationController
  def index
    deck = Deck.new(params[:difficulty] ||= "unsorted").get_cards
    if deck.empty?
      render status: 400, json: { message: "User has sorted all their cards." }
    else
      render json: deck
    end
  end
end
