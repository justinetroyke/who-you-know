class Api::V1::CardsController < ApplicationController
  def index
    render json: UserCard.sort_deck
  end
end
