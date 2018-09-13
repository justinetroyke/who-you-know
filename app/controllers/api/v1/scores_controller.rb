class Api::V1::ScoresController < ApplicationController
  def create
    score = Score.new(score_params)
    if score.save
      render status: 201, json: { message: "Score successfully recorded." }
    end
  end

  private
    def score_params
      params.permit(:user_id, :difficulty, :num_played, :num_correct)
    end
end
