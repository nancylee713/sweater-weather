class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if user_exists?(user_params)
      render_400_email

    elsif valid_input
      @user.update(api_key: generate_api_key)
      render_201

    else
      render_400_invalid
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def valid_input
    @user.email && @user.password
  end

  def render_400_email
    render json: {
      error: 'Sorry, this email has already been taken. Please log in or register with a different email address.',
      status: 400
      }, status: 400
  end

  def render_201
    render json: {
      "api_key": @user.api_key,
      status: 201
    }, status: 201
  end

  def render_400_invalid
    render json: {
      error: "Invalid request. Please try again.",
      status: 400
    }, status: 400
  end
end
