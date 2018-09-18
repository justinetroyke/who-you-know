class Api::V1::UsersController < ApplicationController
  def create
    if User.find_by(id_token: user_params[:id_token])
      render status: 200, json: User.find_by(id_token: user_params[:id_token])
    else
      user = User.new(username: "nil", api_key: user_params[:api_key], id_token: user_params[:id_token])
      if user.save
        render status: 201, json: user
      else
        render status: 400, json: { message: "Missing required parameters."}
      end
    end
  end

  private

    def user_params
      params.permit(:api_key, :id_token)
    end
end
