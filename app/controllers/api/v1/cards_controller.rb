class Api::V1::CardsController < ApplicationController
  def index
    cards = UserCard.sort_deck(params[:difficulty] ||= "unsorted")
    render json: cards
  end
end
