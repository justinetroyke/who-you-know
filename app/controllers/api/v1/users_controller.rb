class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(username: "nil", api_key: user_params[:api_key], id_token: user_params[:id_token])
    if user.save
      render status: 201, json: { message: "User created successfully."}
    end
  end

  private

    def user_params
      params.permit(:api_key, :id_token)
    end
end
