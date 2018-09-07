class Api::V1::UserCardsController < ApplicationController
  def update
    user_card = UserCard.find(user_card_params[:id])
    if user_card.update(difficulty: user_card_params[:difficulty])
      render json: user_card, status: 200
    else
      render status: 400
    end
  end

  def user_card_params
    params.permit(:difficulty, :id)
  end
end
