class Api::V1::CardsController < ApplicationController
  def index
    render json: Card.all
  end
end
