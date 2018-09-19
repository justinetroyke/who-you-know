class Api::V1::UsersController < ApplicationController
  def create
    username = LinkedInService.new(user_params[:api_key]).get_linkedin_id
    if User.find_by(username: username)
      render status: 200, json: User.find_by(username: username)
    else
      user = User.new(username: username, api_key: user_params[:api_key], id_token: user_params[:id_token])
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
