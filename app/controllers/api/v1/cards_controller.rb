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

  def update
    user_card = UserCard.where(user_id: params[:user_id], card_id: params[:id])
    if params[:difficulty].nil?
      render status: 400
    elsif user_card.update(difficulty: params[:difficulty])
      render json: user_card, status: 200
    else
      render status: 400
    end
  end
end
