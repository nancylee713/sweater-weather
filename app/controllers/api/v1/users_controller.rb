class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(User.all)
    else
      render json: {
        error: "Invalid request. Please try again.",
        status: 400
      }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
