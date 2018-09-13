class Api::V1::ScoresController < ApplicationController
  def create
    score = Score.new(score_params)
    if score.save
      render status: 201, json: { message: "Score successfully recorded." }
    else
      render status: 400, json: { message: "Some required score parameters are missing." }
    end
  end

  def index
    scores = Score.averages(score_params[:user_id])
    render status: 200, json: scores.to_json
  end

  private
    def score_params
      params.permit(:user_id, :difficulty, :num_played, :num_correct)
    end
end
