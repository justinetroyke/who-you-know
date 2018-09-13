class Api::V1::CardsController < ApplicationController
  def index
    deck = Deck.new(params[:difficulty] ||= "unsorted", params[:user_id] ).get_cards
    if deck.empty?
      render status: 400, json: { message: "User has sorted all their cards." }
    elsif deck.count < 12
      render status: 400, json: { message: "User must sort more cards." }
    else
      render json: deck
    end
  end
end
