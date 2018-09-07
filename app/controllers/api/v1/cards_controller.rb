class Api::V1::CardsController < ApplicationController
  def index
    render json: Card.sort_deck
  end
end
