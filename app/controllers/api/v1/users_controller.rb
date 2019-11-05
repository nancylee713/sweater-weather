class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      render json: {
        "api_key": "jgn983hy48thw9begh98h4539h4",
        status: 201
      }, status: 201

    elsif user_exists?(user_params)
      render json: {
        error: 'Sorry, this email has already been taken. Please log in or register with a different email address.',
        status: 400
      }, status: 400

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
